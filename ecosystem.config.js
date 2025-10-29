module.exports = {
  apps: [
    {
      name: "telegram-scrap",
      cwd: "/home/yunus/databreach/telegram-scraper",
      script: "./venv/bin/python3",
      args: "worker.py",
      watch: false,
      env: {
        REDIS_HOST: "localhost",
        REDIS_PORT: "6379"
      }
    }
  ]
};

