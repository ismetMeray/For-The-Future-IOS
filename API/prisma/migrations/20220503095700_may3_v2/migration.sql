-- DropForeignKey
ALTER TABLE `exerciseData` DROP FOREIGN KEY `workoutexercisedata`;

-- DropForeignKey
ALTER TABLE `exerciseData` DROP FOREIGN KEY `workoutexercise_ibfk_3`;

-- AddForeignKey
ALTER TABLE `exerciseData` ADD CONSTRAINT `workoutexercisedata2` FOREIGN KEY (`exerciseId`) REFERENCES `exercise`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `exerciseData` ADD CONSTRAINT `workoutexercisedata3` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `exerciseData` ADD CONSTRAINT `workoutexercisedata` FOREIGN KEY (`workoutId`) REFERENCES `workoutexercise`(`workoutId`) ON DELETE NO ACTION ON UPDATE NO ACTION;
