-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_logging" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "date" TEXT NOT NULL,
    "startTime" TEXT NOT NULL,
    "endTime" TEXT NOT NULL,
    "task" TEXT NOT NULL,
    "description" TEXT,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "logging_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_logging" ("date", "description", "endTime", "id", "startTime", "task", "userId") SELECT "date", "description", "endTime", "id", "startTime", "task", "userId" FROM "logging";
DROP TABLE "logging";
ALTER TABLE "new_logging" RENAME TO "logging";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
