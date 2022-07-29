import { PrismaClient } from "@prisma/client";
import { Router } from "express";
import { z } from "zod";

const router = Router();
const prisma = new PrismaClient();

const ProductSchema = z.object({
  name: z.string().min(3),
  price: z.number({
    required_error: "Price is required",
    invalid_type_error: "Price must be a number",
  }),
});

const ProductsSchema = z.object({
  products: z.array(ProductSchema),
});

router.post("/create-catalog", async (req, res, next) => {
  try {
    const { products } = ProductsSchema.parse(req.body);

    // @ts-ignore
    const userId = req["user"].id as number;
    const response = await prisma.user.update({
      where: {
        id: userId,
      },
      data: {
        catalog: {
          deleteMany: {
            sellerId: userId,
          },
          create: products,
        },
      },
      include: {
        catalog: true,
      },
    });
    res.json({
      status: "ok",
      data: {
        response,
      },
      error: "",
    });
  } catch (error) {
    next(error);
  }
});

router.get("/orders", async (req, res, next) => {
  try {
    // @ts-ignore
    const userId = req["user"].id as number;

    const orders = await prisma.order.findMany({
      where: {
        sellerId: userId,
      },
      include: {
        products: true,
        buyer: {
          select: {
            username: true,
            id: true,
          },
        },
      },
    });
    res.json({
      status: "ok",
      data: {
        orders,
      },
      error: "",
    });
  } catch (error) {
    next(error);
  }
});

export default router;
