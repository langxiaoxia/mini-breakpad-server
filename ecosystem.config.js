module.exports = {
  "apps": [
    {
      "name": "breakpad",
      "cwd": "./",
      "script": "lib/app.js",
      "env": {
        "NODE_ENV": "production",
        "MINI_BREAKPAD_SERVER_POOL_PATH": "/data/mini-breakpad-server/pro"
      },
      "env_dev": {
        "NODE_ENV": "development",
        "MINI_BREAKPAD_SERVER_POOL_PATH": "/data/mini-breakpad-server/dev",
        "MINI_BREAKPAD_SERVER_PORT": 8080
      },
      "log_date_format": "YYYY-MM-DD_HH:mm Z",
      "merge_logs": true
    }
  ]
};
