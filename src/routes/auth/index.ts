import { Router } from "express";

const router = Router();

router.post("/register", (req, res) => {
  res.json({
    message: "In register route",
  });
});
export default router;
