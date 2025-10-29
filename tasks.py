import subprocess
import shlex

def run_bash_script(file_path: str):
    """
    Run bash script with arguments:
    bash ./parse2.sh <file_path> --keywords-file ./urlsevplat.txt --upload
    """
    command = f"bash ./parse2.sh {shlex.quote(file_path)} --keywords-file ./urlsevplat.txt --upload"

    try:
        result = subprocess.run(
            command,
            shell=True,
            capture_output=True,
            text=True,
            check=True
        )
        return {
            "status": "success",
            "stdout": result.stdout,
            "stderr": result.stderr,
        }
    except subprocess.CalledProcessError as e:
        return {
            "status": "error",
            "stdout": e.stdout,
            "stderr": e.stderr,
            "returncode": e.returncode,
        }
