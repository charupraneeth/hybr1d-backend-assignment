import { Router } from "express";
import { authenticationMiddleware, authorizeBuyer } from "../middlewares";
import authRoutes from "./auth";
import buyerRoutes from "./buyer";
import sellerRoutes from "./seller";

const router = Router();

router.use("/auth", authRoutes);
router.use("/buyer", [authenticationMiddleware, authorizeBuyer], buyerRoutes);
router.use("/seller", [authenticationMiddleware], sellerRoutes);

export default router;
