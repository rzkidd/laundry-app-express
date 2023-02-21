/*
  Warnings:

  - You are about to drop the column `created_at` on the `histories` table. All the data in the column will be lost.
  - You are about to drop the column `updated_at` on the `histories` table. All the data in the column will be lost.
  - The primary key for the `item_amounts` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `created_at` on the `item_amounts` table. All the data in the column will be lost.
  - You are about to drop the column `history_id` on the `item_amounts` table. All the data in the column will be lost.
  - You are about to drop the column `item_id` on the `item_amounts` table. All the data in the column will be lost.
  - You are about to drop the column `updated_at` on the `item_amounts` table. All the data in the column will be lost.
  - You are about to drop the column `created_at` on the `items` table. All the data in the column will be lost.
  - You are about to drop the column `updated_at` on the `items` table. All the data in the column will be lost.
  - Added the required column `historyId` to the `item_amounts` table without a default value. This is not possible if the table is not empty.
  - Added the required column `itemId` to the `item_amounts` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "item_amounts" DROP CONSTRAINT "item_amounts_history_id_foreign";

-- DropForeignKey
ALTER TABLE "item_amounts" DROP CONSTRAINT "item_amounts_item_id_foreign";

-- AlterTable
ALTER TABLE "histories" DROP COLUMN "created_at",
DROP COLUMN "updated_at",
ADD COLUMN     "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3);

-- AlterTable
ALTER TABLE "item_amounts" DROP CONSTRAINT "item_amounts_pkey",
DROP COLUMN "created_at",
DROP COLUMN "history_id",
DROP COLUMN "item_id",
DROP COLUMN "updated_at",
ADD COLUMN     "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "historyId" INTEGER NOT NULL,
ADD COLUMN     "itemId" INTEGER NOT NULL,
ADD COLUMN     "updatedAt" TIMESTAMP(3),
ADD CONSTRAINT "item_amounts_pkey" PRIMARY KEY ("historyId", "itemId");

-- AlterTable
ALTER TABLE "items" DROP COLUMN "created_at",
DROP COLUMN "updated_at",
ADD COLUMN     "createdAt" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updatedAt" TIMESTAMP(3);

-- AddForeignKey
ALTER TABLE "item_amounts" ADD CONSTRAINT "item_amounts_historyId_foreign" FOREIGN KEY ("historyId") REFERENCES "histories"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "item_amounts" ADD CONSTRAINT "item_amounts_itemId_foreign" FOREIGN KEY ("itemId") REFERENCES "items"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;
