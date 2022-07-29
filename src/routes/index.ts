import { Router } from "express";
import { authenticationMiddleware, authorizeBuyer } from "../middlewares";
import authRoutes from "./auth";
import buyerRoutes from "./buyer";

const router = Router();

router.use("/auth", authRoutes);
router.use("/buyer", [authenticationMiddleware, authorizeBuyer], buyerRoutes);

export default router;
