import { PrismaClient } from "@prisma/client";
import { Router } from "express";

const router = Router();
const prisma = new PrismaClient();

router.get("/list-of-sellers", async (req, res, next) => {
  try {
    const sellers = await prisma.user.findMany({
      where: {
        type: "seller",
      },
      select: {
        id: true,
        username: true,
      },
    });
    res.json({
      status: "ok",
      data: {
        sellers,
      },
      error: "",
    });
  } catch (error) {
    next(error);
  }
});

export default router;
