/*
  Warnings:

  - You are about to drop the column `productid` on the `orderdetails` table. All the data in the column will be lost.
  - You are about to drop the column `productid` on the `ratings` table. All the data in the column will be lost.
  - You are about to drop the column `time` on the `ratings` table. All the data in the column will be lost.
  - You are about to drop the column `address` on the `suppliers` table. All the data in the column will be lost.
  - You are about to drop the column `city` on the `suppliers` table. All the data in the column will be lost.
  - You are about to drop the column `country` on the `suppliers` table. All the data in the column will be lost.
  - You are about to drop the column `email` on the `suppliers` table. All the data in the column will be lost.
  - You are about to drop the column `phone` on the `suppliers` table. All the data in the column will be lost.
  - You are about to drop the column `postalcode` on the `suppliers` table. All the data in the column will be lost.
  - You are about to drop the column `producttype` on the `suppliers` table. All the data in the column will be lost.
  - You are about to drop the column `productid` on the `wishlistitems` table. All the data in the column will be lost.
  - You are about to drop the `products` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[wishlistid,itemid]` on the table `wishlistitems` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `itemid` to the `wishlistitems` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "itemtype" AS ENUM ('CROSS_COUNTRY', 'BASKETBALL', 'FOOTBALL', 'EVERYDAY', 'TENNIS', 'FOR_FITNESS', 'SKATER', 'FOR_TOURISM');

-- DropForeignKey
ALTER TABLE "orderdetails" DROP CONSTRAINT "orderdetails_productid_fkey";

-- DropForeignKey
ALTER TABLE "products" DROP CONSTRAINT "products_supplierid_fkey";

-- DropForeignKey
ALTER TABLE "ratings" DROP CONSTRAINT "ratings_productid_fkey";

-- DropForeignKey
ALTER TABLE "wishlistitems" DROP CONSTRAINT "wishlistitems_productid_fkey";

-- DropIndex
DROP INDEX "wishlistitems_wishlistid_productid_key";

-- AlterTable
ALTER TABLE "orderdetails" DROP COLUMN "productid",
ADD COLUMN     "itemid" TEXT;

-- AlterTable
ALTER TABLE "ratings" DROP COLUMN "productid",
DROP COLUMN "time",
ADD COLUMN     "itemid" TEXT;

-- AlterTable
ALTER TABLE "suppliers" DROP COLUMN "address",
DROP COLUMN "city",
DROP COLUMN "country",
DROP COLUMN "email",
DROP COLUMN "phone",
DROP COLUMN "postalcode",
DROP COLUMN "producttype",
ADD COLUMN     "itemtype" "itemtype"[];

-- AlterTable
ALTER TABLE "wishlistitems" DROP COLUMN "productid",
ADD COLUMN     "itemid" TEXT NOT NULL;

-- DropTable
DROP TABLE "products";

-- DropEnum
DROP TYPE "devicetype";

-- DropEnum
DROP TYPE "frequencytype";

-- DropEnum
DROP TYPE "memorytype";

-- DropEnum
DROP TYPE "simtype";

-- CreateTable
CREATE TABLE "items" (
    "itemid" TEXT NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "price" INTEGER NOT NULL,
    "instock" BOOLEAN NOT NULL,
    "supplierid" INTEGER,
    "discountavailable" BOOLEAN,
    "discount" INTEGER,
    "itemtype" "itemtype",
    "color" CHAR(7),
    "photo" TEXT[],
    "dateCreated" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "items_pkey" PRIMARY KEY ("itemid")
);

-- CreateIndex
CREATE UNIQUE INDEX "wishlistitems_wishlistid_itemid_key" ON "wishlistitems"("wishlistid", "itemid");

-- AddForeignKey
ALTER TABLE "orderdetails" ADD CONSTRAINT "orderdetails_itemid_fkey" FOREIGN KEY ("itemid") REFERENCES "items"("itemid") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "items" ADD CONSTRAINT "items_supplierid_fkey" FOREIGN KEY ("supplierid") REFERENCES "suppliers"("supplierid") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ratings" ADD CONSTRAINT "ratings_itemid_fkey" FOREIGN KEY ("itemid") REFERENCES "items"("itemid") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "wishlistitems" ADD CONSTRAINT "wishlistitems_itemid_fkey" FOREIGN KEY ("itemid") REFERENCES "items"("itemid") ON DELETE NO ACTION ON UPDATE NO ACTION;
