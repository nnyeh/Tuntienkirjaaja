/*
  Warnings:

  - You are about to drop the `userCostpoolPresets` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "userCostpoolPresets";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "userCostPoolPresets" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "costpool" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "userCostPoolPresets_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
