import { PrismaClient } from "@prisma/client";
import { Router } from "express";
import { z } from "zod";
import bcrypt from "bcrypt";

const SALT_ROUNDS = 10;
const router = Router();
const prisma = new PrismaClient();

const userSchema = z.object({
  username: z.string().min(3),
  password: z.string().min(8),
});
router.post("/register", async (req, res, next) => {
  try {
    // console.log(userSchema.parse(req.body));
    const parsedUser = userSchema.parse(req.body);

    const hashedPassword = await bcrypt.hash(parsedUser.password, SALT_ROUNDS);
    parsedUser.password = hashedPassword;

    const user = await prisma.user.create({
      data: parsedUser,
      select: {
        username: true,
      },
    });

    res.json({
      status: "ok",
      data: {
        user,
      },
      error: "",
    });
  } catch (error) {
    next(error);
  }
});

router.post("/login", async (req, res, next) => {
  try {
    const parsedUser = userSchema.parse(req.body);

    const user = await prisma.user.findUniqueOrThrow({
      where: {
        username: parsedUser.username,
      },
    });

    const isMatched = await bcrypt.compare(parsedUser.password, user.password);

    if (!isMatched) {
      throw new Error("Incorrect username/password");
    }

    user.password = "";

    res.json({
      status: "ok",
      data: {
        user,
      },
      error: "",
    });
  } catch (error) {
    next(error);
  }
});
export default router;
