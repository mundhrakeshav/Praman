const db = {
    master:
      "mongodb+srv://prateek:prateek@12@cluster0-ho73t.mongodb.net/Praman?retryWrites=true&w=majority",
    options: {
      useNewUrlParser: true,
      auto_reconnect: true,
      reconnectTries: Number.MAX_SAFE_INTEGER,
      connectTimeoutMS: 9000000,
    },
  };
  module.exports = db;
  