/*
  Warnings:

  - You are about to drop the `logPresets` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "logPresets";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "userCostpoolPresets" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "costpool" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "userCostpoolPresets_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "userTaskPresets" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "task" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "userTaskPresets_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
