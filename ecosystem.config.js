module.exports = {
  apps: [
    {
      name: "bash-runner-worker",
      cwd: "/home/ubuntu/SEVIMA/Batman/databreach/bash-queue-api",
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