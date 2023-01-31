module.exports = {
  "apps": [
    {
      "name": "mini-pro",
      "cwd": "./",
      "script": "lib/app.js",
      "env": {
        "NODE_ENV": "production",
        "MINI_BREAKPAD_SERVER_POOL_PATH": "/data/mini-breakpad-server/pro",
        "MINI_BREAKPAD_SERVER_PORT": 1127
      },
      "log_date_format": "YYYY-MM-DD_HH:mm Z",
      "merge_logs": true
    }, {
      "name": "mini-dev",
      "cwd": "./",
      "script": "lib/app.js",
      "env": {
        "NODE_ENV": "development",
        "MINI_BREAKPAD_SERVER_POOL_PATH": "/data/mini-breakpad-server/dev",
        "MINI_BREAKPAD_SERVER_PORT": 8080
      },
      "log_date_format": "YYYY-MM-DD_HH:mm Z",
      "merge_logs": true
    }
  ]
};
