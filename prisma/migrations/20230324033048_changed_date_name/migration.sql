/*
  Warnings:

  - You are about to drop the column `date` on the `logging` table. All the data in the column will be lost.
  - Added the required column `dateDone` to the `logging` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_logging" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "dateAdded" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateDone" TEXT NOT NULL,
    "startTime" TEXT NOT NULL,
    "endTime" TEXT NOT NULL,
    "costPool" TEXT NOT NULL,
    "task" TEXT NOT NULL,
    "description" TEXT,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "logging_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_logging" ("costPool", "dateAdded", "description", "endTime", "id", "startTime", "task", "userId") SELECT "costPool", "dateAdded", "description", "endTime", "id", "startTime", "task", "userId" FROM "logging";
DROP TABLE "logging";
ALTER TABLE "new_logging" RENAME TO "logging";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
