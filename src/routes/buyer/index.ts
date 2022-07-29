import { PrismaClient } from "@prisma/client";
import { Router } from "express";
import { z } from "zod";

const router = Router();
const prisma = new PrismaClient();

const productIdsSchema = z.object({
  productIds: z.array(z.number()),
});

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
    const sellerId = req.params?.seller_id;

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

router.post("/create-order/:seller_id", async (req, res, next) => {
  try {
    // @ts-ignore
    const userId = req["user"].id as number;

    const sellerId = req.params?.seller_id;
    const parsedProductIds = productIdsSchema.parse(req.body);

    const [seller] = await prisma.user.findMany({
      where: {
        id: parseInt(sellerId),
        type: "seller",
      },
      select: {
        id: true,
        catalog: true,
      },
    });

    const catalogProducts = new Set(
      seller.catalog.map((product) => product.id)
    );

    for (let id of parsedProductIds.productIds) {
      if (!catalogProducts.has(id)) {
        throw new Error(`Product with id : ${id} not found`);
      }
    }

    const order = await prisma.order.create({
      data: {
        sellerId: seller.id,
        buyerId: userId,
        products: {
          connect: parsedProductIds.productIds.map((id) => {
            return { id };
          }),
        },
      },
    });

    res.json({
      status: "ok",
      data: {
        order,
      },
      error: "",
    });
  } catch (error) {
    next(error);
  }
});

export default router;
