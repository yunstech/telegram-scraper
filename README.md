# Telegram Channel Scraper 📱

A powerful Python script that allows you to scrape messages and media from Telegram channels using the Telethon library. Features include real-time continuous scraping, media downloading, and data export capabilities.

```
___________________  _________
\__    ___/  _____/ /   _____/
  |    | /   \  ___ \_____  \ 
  |    | \    \_\  \/        \
  |____|  \______  /_______  /
                 \/        \/
```

## What's New in v3.0 🎉

**QR Code Authentication:**
- **No phone number required** - Login with QR code scanning (still need API credentials)
- **Faster authentication** - Just scan with your phone after API setup
- **Secure login** - Recommended authentication method
- **2FA support** for both QR and phone methods

**Enhanced User Experience:**
- **Numbered channel selection** - Use 1,2,3 instead of full channel IDs
- **Multi-channel operations** - Add, remove, and scrape multiple channels at once
- **Streamlined menu** - Cleaner interface with fewer redundant options
- **Progress bars** for media downloads with visual feedback

**Media Download Improvements:**
- **Fixed file overwriting** - Unique naming prevents media files from being overwritten
- **5x concurrent downloads** - Increased from 3 to 5 for faster media processing
- **Better error handling** - Improved retry logic and recovery

**Performance & Stability:**
- **Database optimizations** - WAL mode and faster operations
- **Hidden warnings** - Cleaner output without technical messages
- **Better error recovery** - More robust handling of network issues

## Features 🚀

- **QR Code & Phone Authentication** - Choose your preferred login method
- Scrape messages from multiple Telegram channels
- Download media files with parallel processing and unique naming
- Real-time continuous scraping
- Export data to JSON and CSV formats
- SQLite database storage with optimized performance
- Resume capability (saves progress)
- Interactive menu with numbered channel selection
- Progress tracking with visual progress bars

## Prerequisites 📋

Before running the script, you'll need:

- Python 3.7 or higher
- Telegram account
- API credentials from Telegram

### Required Python packages

```
pip install -r requirements.txt
```

## Getting Telegram API Credentials 🔑

1. Visit https://my.telegram.org/auth
2. Log in with your phone number
3. Click on "API development tools"
4. Fill in the form:
   - App title: Your app name
   - Short name: Your app short name
   - Platform: Can be left as "Desktop"
   - Description: Brief description of your app
5. Click "Create application"
6. You'll receive:
   - `api_id`: A number
   - `api_hash`: A string of letters and numbers
   
Keep these credentials safe, you'll need them to run the script!

## Setup and Running 🔧

1. Clone the repository:
```bash
git clone https://github.com/unnohwn/telegram-scraper.git
cd telegram-scraper
```

2. Install requirements:
```bash
pip install -r requirements.txt
```

3. Run the script:
```bash
python telegram-scraper.py
```

4. On first run, you'll be prompted to enter:
   - Your API ID (from my.telegram.org)
   - Your API Hash (from my.telegram.org)
   - **Choose authentication method:**
     - **QR Code** (Recommended) - Scan with your phone (no phone number needed)
     - **Phone Number** - Traditional SMS verification

## Usage 📝

The script provides a clean interactive menu:

```
========================================
           TELEGRAM SCRAPER
========================================
[S] Scrape channels
[C] Continuous scraping  
[M] Media scraping: ON
[L] List & add channels
[R] Remove channels
[E] Export data
[T] Rescrape media
[Q] Quit
========================================
```

### Channel Selection Made Easy 🔢

Instead of typing long channel IDs, use numbers:

**Adding Channels:**
```
[1] The News (Chat) (id: -1002116176890)
[2] Python Channel (id: -1001597139842)
[3] The Corner (id: -1002274713954)

Enter: 1,3 (adds channels 1 and 3)
```

**Scraping Channels:**
- Single: `1`
- Multiple: `1,3,5` 
- All: `all`
- Mix formats: `1,-1001597139842,3`

## Data Storage 💾

### Database Structure

Data is stored in SQLite databases, one per channel:
- Location: `./channelname/channelname.db`
- Optimized with indexes for fast queries
- WAL mode for better performance

### Media Storage 📁

Media files are stored with unique naming:
- Location: `./channelname/media/`
- Format: `{message_id}-{unique_id}-{original_name}.ext`
- **No more file overwrites** - Each file gets a unique name

### Exported Data 📊

Export formats:
1. **CSV**: `./channelname/channelname.csv`
2. **JSON**: `./channelname/channelname.json`

## Performance Features ⚙️

- **5 concurrent downloads** for faster media processing
- **Batch database operations** for optimal speed
- **Progress bars** with real-time feedback
- **Resume capability** - Continue where you left off
- **Memory-efficient** exports for large datasets

## Error Handling 🛠️

- Automatic retry with exponential backoff
- Rate limit compliance
- Network error recovery
- State preservation during interruptions

## Limitations ⚠️

- Respects Telegram's rate limits
- Can only access public channels or channels you're a member of
- Media download size limits apply as per Telegram's restrictions

## License 📄

This project is licensed under the MIT License - see the LICENSE file for details.

## Disclaimer ⚖️

This tool is for educational purposes only. Make sure to:
- Respect Telegram's Terms of Service
- Obtain necessary permissions before scraping
- Use responsibly and ethically
- Comply with data protection regulations
