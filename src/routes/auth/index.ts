import { Router } from "express";

const router = Router();

router.post("/register", (req, res) => {
  res.json({
    message: "In register route",
  });
});

router.post("/login", (req, res) => {
  res.json({
    message: "In login route",
  });
});
export default router;
