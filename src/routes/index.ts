import { Router } from "express";

const router = Router();

router.get("/", (req, res) => {
  console.log("in index route");
  res.json({
    msg: "in index route",
  });
});

export default router;
