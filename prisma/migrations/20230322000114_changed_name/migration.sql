/*
  Warnings:

  - You are about to drop the `savedLogPresets` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "savedLogPresets";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "logPresets" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "costpool" TEXT NOT NULL,
    "task" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "logPresets_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
