import { PrismaClient } from "@prisma/client";
import { Router } from "express";

const router = Router();
const prisma = new PrismaClient();

router.post("/register", async (req, res, next) => {
  try {
    const { username, password } = req.body;
    if (!username) {
      throw new Error("Username needed");
    }
    if (!password) {
      throw new Error("Password needed");
    }

    const user = await prisma.user.create({
      data: {
        username,
        password,
      },
    });

    res.json({
      status: "ok",
      data: {
        user,
      },
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
