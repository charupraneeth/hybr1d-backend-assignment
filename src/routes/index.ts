import { Router } from "express";
import {
  authenticationMiddleware,
  authorizeBuyer,
  authorizeSeller,
} from "../middlewares";
import authRoutes from "./auth";
import buyerRoutes from "./buyer";
import sellerRoutes from "./seller";

const router = Router();

router.use("/auth", authRoutes);
router.use("/buyer", [authenticationMiddleware, authorizeBuyer], buyerRoutes);
router.use(
  "/seller",
  [authenticationMiddleware, authorizeSeller],
  sellerRoutes
);

export default router;
