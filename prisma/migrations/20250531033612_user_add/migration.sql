/*
  Warnings:

  - The primary key for the `user` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `hspId` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `joinDate` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `master` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `password` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `passwordInit` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `pwUpdateDate` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `rank` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `salesmanager` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `salt` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `stockPassword` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `userType` on the `user` table. All the data in the column will be lost.
  - You are about to alter the column `name` on the `user` table. The data in that column could be lost. The data in that column will be cast from `VarChar(65)` to `VarChar(25)`.
  - You are about to drop the `acCategory` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `admin` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `adminLog` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `adminLoginHistory` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `adminPermission` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `afterCare` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `did` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `didAttached` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `didConnectedOption` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `didLowMsg` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `doctors` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `healthInfo` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `hospital` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `hospitalPayment` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `latestNews` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `mainHighestBanner` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `mainSectionSequence` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `mhbFirstData` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `patient` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `reservation` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `userHistory` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `userLoginHistory` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `userPayment` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `userPermission` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `userRefreshToken` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `youtube` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `youtubeHistory` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `updatedAt` to the `user` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `user` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `adminLoginHistory` DROP FOREIGN KEY `adminLoginHistory_adminId_fkey`;

-- DropForeignKey
ALTER TABLE `adminPermission` DROP FOREIGN KEY `adminPermission_adminId_fkey`;

-- DropForeignKey
ALTER TABLE `did` DROP FOREIGN KEY `did_hspId_fkey`;

-- DropForeignKey
ALTER TABLE `didAttached` DROP FOREIGN KEY `didAttached_didId_fkey`;

-- DropForeignKey
ALTER TABLE `didLowMsg` DROP FOREIGN KEY `didLowMsg_didId_fkey`;

-- DropForeignKey
ALTER TABLE `hospitalPayment` DROP FOREIGN KEY `hospitalPayment_hspId_fkey`;

-- DropForeignKey
ALTER TABLE `latestNews` DROP FOREIGN KEY `latestNews_userId_fkey`;

-- DropForeignKey
ALTER TABLE `reservation` DROP FOREIGN KEY `reservation_patiId_fkey`;

-- DropForeignKey
ALTER TABLE `user` DROP FOREIGN KEY `user_hspId_fkey`;

-- DropForeignKey
ALTER TABLE `userHistory` DROP FOREIGN KEY `userHistory_userId_fkey`;

-- DropForeignKey
ALTER TABLE `userLoginHistory` DROP FOREIGN KEY `userLoginHistory_userId_fkey`;

-- DropForeignKey
ALTER TABLE `userPayment` DROP FOREIGN KEY `userPayment_patiId_fkey`;

-- DropForeignKey
ALTER TABLE `userPayment` DROP FOREIGN KEY `userPayment_resId_fkey`;

-- DropForeignKey
ALTER TABLE `userPermission` DROP FOREIGN KEY `userPermission_userId_fkey`;

-- DropForeignKey
ALTER TABLE `userRefreshToken` DROP FOREIGN KEY `userRefreshToken_userId_fkey`;

-- DropIndex
DROP INDEX `user_email_key` ON `user`;

-- DropIndex
DROP INDEX `user_hspId_fkey` ON `user`;

-- AlterTable
ALTER TABLE `user` DROP PRIMARY KEY,
    DROP COLUMN `hspId`,
    DROP COLUMN `joinDate`,
    DROP COLUMN `master`,
    DROP COLUMN `password`,
    DROP COLUMN `passwordInit`,
    DROP COLUMN `pwUpdateDate`,
    DROP COLUMN `rank`,
    DROP COLUMN `salesmanager`,
    DROP COLUMN `salt`,
    DROP COLUMN `stockPassword`,
    DROP COLUMN `userId`,
    DROP COLUMN `userType`,
    ADD COLUMN `cellphone` VARCHAR(25) NOT NULL DEFAULT '',
    ADD COLUMN `updatedAt` DATETIME(3) NOT NULL,
    ADD COLUMN `user_id` INTEGER NOT NULL AUTO_INCREMENT,
    MODIFY `email` VARCHAR(100) NOT NULL DEFAULT '',
    MODIFY `name` VARCHAR(25) NOT NULL DEFAULT '',
    ADD PRIMARY KEY (`user_id`);

-- DropTable
DROP TABLE `acCategory`;

-- DropTable
DROP TABLE `admin`;

-- DropTable
DROP TABLE `adminLog`;

-- DropTable
DROP TABLE `adminLoginHistory`;

-- DropTable
DROP TABLE `adminPermission`;

-- DropTable
DROP TABLE `afterCare`;

-- DropTable
DROP TABLE `did`;

-- DropTable
DROP TABLE `didAttached`;

-- DropTable
DROP TABLE `didConnectedOption`;

-- DropTable
DROP TABLE `didLowMsg`;

-- DropTable
DROP TABLE `doctors`;

-- DropTable
DROP TABLE `healthInfo`;

-- DropTable
DROP TABLE `hospital`;

-- DropTable
DROP TABLE `hospitalPayment`;

-- DropTable
DROP TABLE `latestNews`;

-- DropTable
DROP TABLE `mainHighestBanner`;

-- DropTable
DROP TABLE `mainSectionSequence`;

-- DropTable
DROP TABLE `mhbFirstData`;

-- DropTable
DROP TABLE `patient`;

-- DropTable
DROP TABLE `reservation`;

-- DropTable
DROP TABLE `userHistory`;

-- DropTable
DROP TABLE `userLoginHistory`;

-- DropTable
DROP TABLE `userPayment`;

-- DropTable
DROP TABLE `userPermission`;

-- DropTable
DROP TABLE `userRefreshToken`;

-- DropTable
DROP TABLE `youtube`;

-- DropTable
DROP TABLE `youtubeHistory`;
