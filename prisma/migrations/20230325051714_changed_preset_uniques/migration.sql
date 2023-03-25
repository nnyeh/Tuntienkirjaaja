/*
  Warnings:

  - The primary key for the `userCostPoolPresets` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `userCostPoolPresets` table. All the data in the column will be lost.
  - The primary key for the `userTaskPresets` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `userTaskPresets` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_userCostPoolPresets" (
    "costpool" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "userCostPoolPresets_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_userCostPoolPresets" ("costpool", "userId") SELECT "costpool", "userId" FROM "userCostPoolPresets";
DROP TABLE "userCostPoolPresets";
ALTER TABLE "new_userCostPoolPresets" RENAME TO "userCostPoolPresets";
CREATE UNIQUE INDEX "userCostPoolPresets_costpool_userId_key" ON "userCostPoolPresets"("costpool", "userId");
CREATE TABLE "new_userTaskPresets" (
    "task" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "userTaskPresets_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_userTaskPresets" ("task", "userId") SELECT "task", "userId" FROM "userTaskPresets";
DROP TABLE "userTaskPresets";
ALTER TABLE "new_userTaskPresets" RENAME TO "userTaskPresets";
CREATE UNIQUE INDEX "userTaskPresets_task_userId_key" ON "userTaskPresets"("task", "userId");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
