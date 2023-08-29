/*
  Warnings:

  - A unique constraint covering the columns `[title]` on the table `Note` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "Note_id_key";

-- CreateIndex
CREATE UNIQUE INDEX "Note_title_key" ON "Note"("title");
