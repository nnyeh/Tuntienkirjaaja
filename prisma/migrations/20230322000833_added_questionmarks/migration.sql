-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_logPresets" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "costpool" TEXT,
    "task" TEXT,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "logPresets_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_logPresets" ("costpool", "id", "task", "userId") SELECT "costpool", "id", "task", "userId" FROM "logPresets";
DROP TABLE "logPresets";
ALTER TABLE "new_logPresets" RENAME TO "logPresets";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
