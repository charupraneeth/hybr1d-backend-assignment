import express from "express";
import api from "./routes";

const app = express();

app.get("/", (_, res) => {
  res.json({
    message: "API exists in /api route",
  });
});

app.use("/api", api);

export default app;
