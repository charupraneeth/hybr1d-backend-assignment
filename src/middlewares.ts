import { PrismaClient, UserType } from "@prisma/client";
import { NextFunction, Request, Response } from "express";
import { z } from "zod";
import jwt from "jsonwebtoken";

const prisma = new PrismaClient();

const tokenSchema = z
  .string({
    required_error: "Auth token is required",
  })
  .startsWith("Bearer ", { message: "Token should start with Bearer " })
  .min(20);

function authenticationMiddleware(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const authString = req.get("Authorization");
    const parsedToken = tokenSchema.parse(authString);
    const [_, token] = parsedToken.split("Bearer ");
    console.log(token);

    jwt.verify(
      token,
      process.env.ACCESS_TOKEN_SECRET as any,
      async function (err: any, decoded: any) {
        if (err) {
          next(err);
        }

        prisma.user
          .findUniqueOrThrow({
            where: {
              username: decoded?.data,
            },
          })
          .then((user) => {
            user.password = "";
            // @ts-ignore
            req["user"] = user;
            next();
          })
          .catch((err) => {
            next(err);
          });
      }
    );
  } catch (error) {
    next(error);
  }
}

function authorizeBuyer(req: Request, res: Response, next: NextFunction) {
  // @ts-ignore
  if (req.user?.type !== "buyer") {
    res.status(400);
    next(new Error("User unauthorized for access"));
  }

  next();
}

function authorizeSeller(req: Request, res: Response, next: NextFunction) {
  // @ts-ignore
  if (req.user?.type !== "seller") {
    res.status(400);
    next(new Error("User unauthorized for access"));
  }

  next();
}

function notFound(req: Request, res: Response, next: NextFunction) {
  res.status(404);
  const error = new Error(`🔍 - Not Found - ${req.originalUrl}`);
  next(error);
}

function errorHandler(
  err: Error,
  _req: Request,
  res: Response,
  _next: NextFunction
) {
  const statusCode = res.statusCode !== 200 ? res.statusCode : 500;
  res.status(statusCode);
  res.json({
    message: err.message,
    stack: process.env.NODE_ENV === "production" ? "🥞" : err.stack,
  });
}

export {
  notFound,
  errorHandler,
  authenticationMiddleware,
  authorizeBuyer,
  authorizeSeller,
};
