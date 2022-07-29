/*
  Warnings:

  - You are about to drop the column `buyerId` on the `Order` table. All the data in the column will be lost.
  - Added the required column `sellerId` to the `Order` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Order" DROP CONSTRAINT "Order_buyerId_fkey";

-- AlterTable
ALTER TABLE "Order" DROP COLUMN "buyerId",
ADD COLUMN     "sellerId" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "Order" ADD CONSTRAINT "Order_sellerId_fkey" FOREIGN KEY ("sellerId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
