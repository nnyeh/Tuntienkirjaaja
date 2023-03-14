-- CreateTable
CREATE TABLE "logging" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "workStart" DATETIME NOT NULL,
    "workEnd" DATETIME NOT NULL,
    "task" TEXT NOT NULL,
    "details" TEXT,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "logging_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
