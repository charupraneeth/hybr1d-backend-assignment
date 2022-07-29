import express from "express";
import api from "./routes";
import { errorHandler, notFound } from "./middlewares";

const app = express();

app.use(express.json());

app.get("/", (_, res) => {
  res.json({
    message: "API exists in /api route",
  });
});

app.use("/api", api);

app.use(notFound);

app.use(errorHandler);

export default app;
