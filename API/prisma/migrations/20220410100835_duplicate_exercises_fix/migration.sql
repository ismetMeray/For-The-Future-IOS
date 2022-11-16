/*
  Warnings:

  - A unique constraint covering the columns `[name]` on the table `exercise` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[userName]` on the table `user` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[email]` on the table `user` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `bodyPartId` to the `exercise` table without a default value. This is not possible if the table is not empty.
  - Added the required column `equipmentId` to the `exercise` table without a default value. This is not possible if the table is not empty.
  - Added the required column `gifUrl` to the `exercise` table without a default value. This is not possible if the table is not empty.
  - Added the required column `muscleTargetId` to the `exercise` table without a default value. This is not possible if the table is not empty.
  - Added the required column `email` to the `user` table without a default value. This is not possible if the table is not empty.
  - Added the required column `order` to the `workoutexercise` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `exercise` ADD COLUMN `bodyPartId` INTEGER NOT NULL,
    ADD COLUMN `equipmentId` INTEGER NOT NULL,
    ADD COLUMN `gifUrl` VARCHAR(255) NOT NULL,
    ADD COLUMN `muscleTargetId` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `user` ADD COLUMN `email` VARCHAR(150) NOT NULL;

-- AlterTable
ALTER TABLE `workoutexercise` ADD COLUMN `order` INTEGER NOT NULL;

-- CreateTable
CREATE TABLE `bodyPart` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,

    UNIQUE INDEX `bodyPart_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `muscleTarget` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,

    UNIQUE INDEX `muscleTarget_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `equipment` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,

    UNIQUE INDEX `equipment_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `exercise_name_key` ON `exercise`(`name`);

-- CreateIndex
CREATE UNIQUE INDEX `userName_UNIQUE` ON `user`(`userName`);

-- CreateIndex
CREATE UNIQUE INDEX `email_UNIQUE` ON `user`(`email`);

-- AddForeignKey
ALTER TABLE `exercise` ADD CONSTRAINT `exercise_bodypart_fk` FOREIGN KEY (`bodyPartId`) REFERENCES `bodyPart`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `exercise` ADD CONSTRAINT `exercise_muscleTarget_fk` FOREIGN KEY (`muscleTargetId`) REFERENCES `muscleTarget`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `exercise` ADD CONSTRAINT `exercise_equipment_fk` FOREIGN KEY (`equipmentId`) REFERENCES `equipment`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
