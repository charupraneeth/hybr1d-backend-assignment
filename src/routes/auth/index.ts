import { Router } from "express";

const router = Router();

router.post("/register", (req, res, next) => {
  try {
    const { username, password } = req.body;
    if (!username) {
      throw new Error("Username needed");
    }
    if (!password) {
      throw new Error("Password needed");
    }

    res.json({
      username,
      password,
    });
  } catch (error) {
    next(error);
  }
});

router.post("/login", (req, res) => {
  res.json({
    message: "In login route",
  });
});
export default router;
