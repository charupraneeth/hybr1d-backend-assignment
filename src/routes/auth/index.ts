import { PrismaClient } from "@prisma/client";
import { Router } from "express";
import { z } from "zod";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

const SALT_ROUNDS = 10;
const router = Router();
const prisma = new PrismaClient();

const userSchema = z.object({
  username: z.string().min(3),
  password: z.string().min(8),
});

const userRegisterSchema = userSchema.extend({
  type: z.enum(["buyer", "seller"]),
});

router.post("/register", async (req, res, next) => {
  try {
    // console.log(userSchema.parse(req.body));
    const parsedUser = userRegisterSchema.parse(req.body);

    const hashedPassword = await bcrypt.hash(parsedUser.password, SALT_ROUNDS);
    parsedUser.password = hashedPassword;

    const user = await prisma.user.create({
      data: parsedUser,
      select: {
        username: true,
        type: true,
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

    const token = jwt.sign(
      {
        data: user.username,
      },
      process.env.ACCESS_TOKEN_SECRET as any,
      { expiresIn: "1d" }
    );

    user.password = "";

    res.json({
      status: "ok",
      data: {
        user,
        token,
      },
      error: "",
    });
  } catch (error) {
    next(error);
  }
});
export default router;
