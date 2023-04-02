const express = require("express");
const app = express();

app.get("/api/v1/test", (req, res) => {
  res.send("Hello World");
});

app.listen(8087, () => console.log("Server started on port 8087"));
