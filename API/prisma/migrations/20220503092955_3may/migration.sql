/*
  Warnings:

  - Added the required column `userId` to the `exerciseData` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `exerciseData` ADD COLUMN `userId` INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE `exerciseData` ADD CONSTRAINT `workoutexercise_ibfk_3` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
