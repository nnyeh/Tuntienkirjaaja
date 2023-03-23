-- CreateTable
CREATE TABLE "savedLogPresets" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "costpool" TEXT NOT NULL,
    "task" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "savedLogPresets_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
