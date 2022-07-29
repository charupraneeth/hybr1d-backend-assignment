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

router.get("/seller-catalog/:seller_id", async (req, res, next) => {
  try {
    const sellerId = req.params.seller_id;

    const [seller] = await prisma.user.findMany({
      where: {
        id: parseInt(sellerId),
        type: "seller",
      },
      select: {
        id: true,
        username: true,
        catalog: true,
      },
    });

    res.json({
      status: "ok",
      data: {
        seller,
      },
      error: "",
    });
  } catch (error) {
    next(error);
  }
});
export default router;
