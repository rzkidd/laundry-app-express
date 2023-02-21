/*
  Warnings:

  - You are about to drop the `histories` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `item_amounts` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `items` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "item_amounts" DROP CONSTRAINT "item_amounts_historyId_foreign";

-- DropForeignKey
ALTER TABLE "item_amounts" DROP CONSTRAINT "item_amounts_itemId_foreign";

-- DropTable
DROP TABLE "histories";

-- DropTable
DROP TABLE "item_amounts";

-- DropTable
DROP TABLE "items";

-- CreateTable
CREATE TABLE "History" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "History_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ItemAmount" (
    "historyId" INTEGER NOT NULL,
    "itemId" INTEGER NOT NULL,
    "amount" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "ItemAmount_pkey" PRIMARY KEY ("historyId","itemId")
);

-- CreateTable
CREATE TABLE "Item" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "Item_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "ItemAmount" ADD CONSTRAINT "item_amounts_historyId_foreign" FOREIGN KEY ("historyId") REFERENCES "History"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "ItemAmount" ADD CONSTRAINT "item_amounts_itemId_foreign" FOREIGN KEY ("itemId") REFERENCES "Item"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
