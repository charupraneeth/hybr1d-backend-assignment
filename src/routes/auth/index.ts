import { PrismaClient } from "@prisma/client";
import { Router } from "express";
import { z } from "zod";

const router = Router();
const prisma = new PrismaClient();

const userSchema = z.object({
  username: z.string().min(3),
  password: z.string().min(10),
});
router.post("/register", async (req, res, next) => {
  try {
    // console.log(userSchema.parse(req.body));
    const parsedUser = userSchema.parse(req.body);

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

router.post("/login", (req, res) => {
  res.json({
    message: "In login route",
  });
});
export default router;
