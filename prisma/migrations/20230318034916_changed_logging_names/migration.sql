/*
  Warnings:

  - You are about to drop the column `details` on the `logging` table. All the data in the column will be lost.
  - You are about to drop the column `workEnd` on the `logging` table. All the data in the column will be lost.
  - You are about to drop the column `workStart` on the `logging` table. All the data in the column will be lost.
  - Added the required column `date` to the `logging` table without a default value. This is not possible if the table is not empty.
  - Added the required column `endTime` to the `logging` table without a default value. This is not possible if the table is not empty.
  - Added the required column `startTime` to the `logging` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_logging" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "date" DATETIME NOT NULL,
    "startTime" DATETIME NOT NULL,
    "endTime" DATETIME NOT NULL,
    "task" TEXT NOT NULL,
    "description" TEXT,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "logging_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_logging" ("id", "task", "userId") SELECT "id", "task", "userId" FROM "logging";
DROP TABLE "logging";
ALTER TABLE "new_logging" RENAME TO "logging";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
