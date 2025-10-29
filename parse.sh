#!/bin/bash

OPENSEARCH_URL="http://localhost:9200"
INDEX="databreach"

INPUT_FILE="$1"
shift

UPLOAD=true
KEYWORDS=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --upload)
      UPLOAD=true
      shift
      ;;
    --keywords-file)
      if [[ -f "$2" ]]; then
        while IFS= read -r kw; do
          [[ -n "$kw" ]] && KEYWORDS+=("$kw")
        done < "$2"
      else
        echo "Keyword file not found: $2"
        exit 1
      fi
      shift 2
      ;;
    *)
      KEYWORDS+=("$1")
      shift
      ;;
  esac
done

if [[ -z "$INPUT_FILE" || ${#KEYWORDS[@]} -eq 0 ]]; then
  echo "Usage: $0 <input_file> [keyword1 keyword2 ...] [--keywords-file file] [--upload]"
  exit 1
fi

PATTERN=$(IFS='|'; echo "${KEYWORDS[*]}")

echo "Filtering file: $INPUT_FILE"
echo "Keywords: ${KEYWORDS[*]}"
echo "Mode: $([ "$UPLOAD" = true ] && echo 'UPLOAD' || echo 'DEBUG')"
echo

OUTFILE="payload.ndjson"
> "$OUTFILE"

grep -a -i -E "$PATTERN" "$INPUT_FILE" | while IFS= read -r line; do
  safe_line=$(echo "$line" \
    | tr -d '\r' \
    | tr -d '\000-\010\013\014\016-\037' \
    | sed 's/"/\\"/g')

  match=$(echo "$line" | grep -o -i -E "$PATTERN" | head -n1)

  echo "{ \"index\": { \"_index\": \"$INDEX\" } }" >> "$OUTFILE"
  echo "{ \"line\": \"$safe_line\", \"keyword\": \"$match\" }" >> "$OUTFILE"
done

if [ "$UPLOAD" = true ]; then
  echo "Uploading to OpenSearch..."

  if [ -n "$USER" ]; then
    RESPONSE=$(curl -s -w "%{http_code}" -o /tmp/opensearch_resp.txt \
      -X POST "$OPENSEARCH_URL/_bulk" \
      -u "$USER:$PASS" \
      -H "Content-Type: application/x-ndjson" \
      --data-binary "@$OUTFILE")
  else
    RESPONSE=$(curl -s -w "%{http_code}" -o /tmp/opensearch_resp.txt \
      -X POST "$OPENSEARCH_URL/_bulk" \
      -H "Content-Type: application/x-ndjson" \
      --data-binary "@$OUTFILE")
  fi

  if [ "$RESPONSE" = "200" ]; then
    echo "Upload success"
  else
    echo "Upload failed (HTTP $RESPONSE)"
    cat /tmp/opensearch_resp.txt
  fi
else
  echo "=== DEBUG NDJSON PAYLOAD (first 20 lines) ==="
  head -n 20 "$OUTFILE"
  echo "=== END DEBUG ==="
  echo "Full payload saved to $OUTFILE"
fi