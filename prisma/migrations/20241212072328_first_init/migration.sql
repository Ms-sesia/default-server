-- CreateTable
CREATE TABLE `admin` (
    `adminId` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `master` BOOLEAN NOT NULL DEFAULT false,
    `userType` INTEGER NOT NULL DEFAULT 1,
    `name` VARCHAR(65) NOT NULL DEFAULT '',
    `email` VARCHAR(65) NOT NULL DEFAULT '',
    `rank` VARCHAR(65) NOT NULL DEFAULT '',
    `cellphone` VARCHAR(65) NOT NULL DEFAULT '',
    `salt` VARCHAR(65) NOT NULL DEFAULT '',
    `password` VARCHAR(250) NOT NULL DEFAULT '',
    `passwordInit` BOOLEAN NOT NULL DEFAULT true,
    `pwUpdateDate` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `admin_doLoginCount` INTEGER NOT NULL DEFAULT 0,
    `admin_loginFailTime` VARCHAR(191) NOT NULL DEFAULT '',

    UNIQUE INDEX `admin_email_key`(`email`),
    PRIMARY KEY (`adminId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `adminPermission` (
    `apId` INTEGER NOT NULL AUTO_INCREMENT,
    `adminId` INTEGER NOT NULL,

    UNIQUE INDEX `adminPermission_adminId_key`(`adminId`),
    PRIMARY KEY (`apId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `adminLoginHistory` (
    `alhId` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `ip` VARCHAR(20) NOT NULL DEFAULT '',
    `os` VARCHAR(20) NOT NULL DEFAULT '',
    `browser` VARCHAR(20) NOT NULL DEFAULT '',
    `status` BOOLEAN NOT NULL DEFAULT false,
    `adminId` INTEGER NULL,

    PRIMARY KEY (`alhId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `adminLog` (
    `alId` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `type` INTEGER NOT NULL DEFAULT 0,
    `tabName` VARCHAR(25) NOT NULL DEFAULT '',
    `text` VARCHAR(250) NOT NULL DEFAULT '',
    `name` VARCHAR(25) NOT NULL DEFAULT '',
    `rank` VARCHAR(25) NOT NULL DEFAULT '',
    `email` VARCHAR(65) NOT NULL DEFAULT '',

    PRIMARY KEY (`alId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hospital` (
    `hspId` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `grade` INTEGER NOT NULL DEFAULT 0,
    `isDelete` BOOLEAN NOT NULL DEFAULT false,
    `deleteDate` DATETIME(3) NULL,
    `directions` VARCHAR(625) NOT NULL DEFAULT '',
    `email` VARCHAR(65) NOT NULL DEFAULT '',
    `img` VARCHAR(265) NOT NULL DEFAULT '',
    `medicalDepartment` VARCHAR(65) NOT NULL DEFAULT '',
    `editorId` INTEGER NOT NULL DEFAULT 0,
    `editorName` VARCHAR(15) NOT NULL DEFAULT '',
    `editorRank` VARCHAR(15) NOT NULL DEFAULT '',
    `used` BOOLEAN NOT NULL DEFAULT false,
    `startDate` DATETIME(3) NULL,
    `endDate` DATETIME(3) NULL,
    `hospId` VARCHAR(65) NOT NULL DEFAULT '',
    `hospCrn` VARCHAR(65) NOT NULL DEFAULT '',
    `hospGb` VARCHAR(65) NOT NULL DEFAULT '',
    `hospNm` VARCHAR(65) NOT NULL DEFAULT '',
    `ceoName` VARCHAR(20) NOT NULL DEFAULT '',
    `ceoEName` VARCHAR(65) NOT NULL DEFAULT '',
    `hospAddr` VARCHAR(65) NOT NULL DEFAULT '',
    `hospAddrDetail` VARCHAR(65) NOT NULL DEFAULT '',
    `hospZipcode` VARCHAR(12) NOT NULL DEFAULT '',
    `hospTel` VARCHAR(25) NOT NULL DEFAULT '',
    `compId` VARCHAR(65) NOT NULL DEFAULT '',
    `hospOpSt` VARCHAR(12) NOT NULL DEFAULT '',
    `hospMemo` VARCHAR(265) NOT NULL DEFAULT '',
    `hospIp` VARCHAR(120) NOT NULL DEFAULT '',
    `hospPort` VARCHAR(12) NOT NULL DEFAULT '',
    `holidayYN` VARCHAR(12) NOT NULL DEFAULT '',
    `holidayName` VARCHAR(265) NOT NULL DEFAULT '',
    `hospOpenTm` VARCHAR(12) NOT NULL DEFAULT '',
    `hospCloseTm` VARCHAR(12) NOT NULL DEFAULT '',
    `lunchYN` VARCHAR(12) NOT NULL DEFAULT '',
    `lunchStm` VARCHAR(12) NOT NULL DEFAULT '',
    `lunchEtm` VARCHAR(12) NOT NULL DEFAULT '',
    `dinnerYN` VARCHAR(12) NOT NULL DEFAULT '',
    `dinnerStm` VARCHAR(12) NOT NULL DEFAULT '',
    `dinnerEtm` VARCHAR(12) NOT NULL DEFAULT '',
    `rsvTerm` VARCHAR(12) NOT NULL DEFAULT '',
    `rsvOpenTm` VARCHAR(12) NOT NULL DEFAULT '',
    `rsvCloseTm` VARCHAR(12) NOT NULL DEFAULT '',
    `usedEmr` INTEGER NOT NULL DEFAULT 0,

    UNIQUE INDEX `hospital_email_key`(`email`),
    INDEX `hospital_grade_idx`(`grade`),
    PRIMARY KEY (`hspId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hospitalPayment` (
    `hpId` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `method` INTEGER NOT NULL DEFAULT 0,
    `paymentDate` DATETIME(3) NOT NULL,
    `productName` INTEGER NOT NULL DEFAULT 0,
    `period` INTEGER NOT NULL DEFAULT 0,
    `amount` INTEGER NOT NULL DEFAULT 0,
    `cardNum` VARCHAR(25) NOT NULL DEFAULT '',
    `cardName` VARCHAR(191) NOT NULL DEFAULT '',
    `approvalNumb` VARCHAR(191) NOT NULL DEFAULT '',
    `status` INTEGER NOT NULL DEFAULT 0,
    `installmentMonth` INTEGER NOT NULL DEFAULT 0,
    `startDate` DATETIME(3) NULL,
    `endDate` DATETIME(3) NULL,
    `hspId` INTEGER NOT NULL,

    PRIMARY KEY (`hpId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user` (
    `userId` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `master` BOOLEAN NOT NULL DEFAULT false,
    `userType` INTEGER NOT NULL DEFAULT 0,
    `salesmanager` BOOLEAN NOT NULL DEFAULT false,
    `email` VARCHAR(65) NOT NULL DEFAULT '',
    `joinDate` DATETIME(3) NULL,
    `name` VARCHAR(65) NOT NULL DEFAULT '',
    `rank` VARCHAR(65) NOT NULL DEFAULT '',
    `salt` VARCHAR(65) NOT NULL DEFAULT '',
    `password` VARCHAR(265) NOT NULL DEFAULT '',
    `passwordInit` BOOLEAN NOT NULL DEFAULT true,
    `pwUpdateDate` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `stockPassword` VARCHAR(25) NOT NULL DEFAULT '',
    `hspId` INTEGER NULL,

    UNIQUE INDEX `user_email_key`(`email`),
    PRIMARY KEY (`userId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `userPermission` (
    `hapId` INTEGER NOT NULL AUTO_INCREMENT,
    `mainSection` BOOLEAN NOT NULL DEFAULT false,
    `reservation` BOOLEAN NOT NULL DEFAULT false,
    `did` BOOLEAN NOT NULL DEFAULT false,
    `userId` INTEGER NOT NULL,

    UNIQUE INDEX `userPermission_userId_key`(`userId`),
    PRIMARY KEY (`hapId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `userRefreshToken` (
    `urtId` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `refreshToken` VARCHAR(265) NOT NULL DEFAULT '',
    `ip` VARCHAR(25) NOT NULL DEFAULT '',
    `os` VARCHAR(25) NOT NULL DEFAULT '',
    `browser` VARCHAR(125) NOT NULL DEFAULT '',
    `privAuth` BOOLEAN NOT NULL DEFAULT false,
    `privAuthTime` DOUBLE NOT NULL DEFAULT 0,
    `userId` INTEGER NULL,

    PRIMARY KEY (`urtId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `userLoginHistory` (
    `ulhId` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `ip` VARCHAR(25) NOT NULL DEFAULT '',
    `os` VARCHAR(25) NOT NULL DEFAULT '',
    `browser` VARCHAR(125) NOT NULL DEFAULT '',
    `location` VARCHAR(65) NOT NULL DEFAULT '',
    `successable` BOOLEAN NOT NULL DEFAULT false,
    `status` BOOLEAN NOT NULL DEFAULT false,
    `userId` INTEGER NULL,

    PRIMARY KEY (`ulhId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `userHistory` (
    `hahId` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `type` INTEGER NOT NULL DEFAULT 0,
    `text` VARCHAR(265) NOT NULL DEFAULT '',
    `userId` INTEGER NULL,

    PRIMARY KEY (`hahId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mainHighestBanner` (
    `mhbId` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `sequence` INTEGER NOT NULL DEFAULT 0,
    `openStartDate` DATETIME(3) NOT NULL,
    `openEndDate` DATETIME(3) NOT NULL,
    `title` VARCHAR(65) NOT NULL DEFAULT '',
    `subTitle` VARCHAR(65) NOT NULL DEFAULT '',
    `img` VARCHAR(265) NOT NULL DEFAULT '',
    `open` INTEGER NOT NULL DEFAULT 0,
    `editorId` INTEGER NOT NULL DEFAULT 0,
    `editorName` VARCHAR(15) NOT NULL DEFAULT '',
    `editorRank` VARCHAR(15) NOT NULL DEFAULT '',

    PRIMARY KEY (`mhbId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mhbFirstData` (
    `mhbfdId` INTEGER NOT NULL AUTO_INCREMENT,
    `mhbId` INTEGER NOT NULL DEFAULT 0,
    `orgEndDate` DATETIME(3) NULL,

    PRIMARY KEY (`mhbfdId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mainSectionSequence` (
    `mssId` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `sequence` INTEGER NOT NULL DEFAULT 0,
    `sectionType` INTEGER NOT NULL DEFAULT 0,
    `sectionTitle` VARCHAR(25) NOT NULL DEFAULT '',
    `desc` VARCHAR(125) NOT NULL DEFAULT '',
    `open` BOOLEAN NOT NULL DEFAULT false,
    `editorId` INTEGER NOT NULL DEFAULT 0,
    `editorName` VARCHAR(15) NOT NULL DEFAULT '',
    `editorRank` VARCHAR(15) NOT NULL DEFAULT '',

    PRIMARY KEY (`mssId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `latestNews` (
    `lnId` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `title` VARCHAR(265) NOT NULL DEFAULT '',
    `writerId` INTEGER NOT NULL DEFAULT 0,
    `writerName` VARCHAR(15) NOT NULL DEFAULT '',
    `writerRank` VARCHAR(15) NOT NULL DEFAULT '',
    `text` TEXT NOT NULL,
    `adImg` VARCHAR(265) NOT NULL DEFAULT '',
    `editorId` INTEGER NOT NULL DEFAULT 0,
    `editorName` VARCHAR(15) NOT NULL DEFAULT '',
    `editorRank` VARCHAR(15) NOT NULL DEFAULT '',
    `userId` INTEGER NULL,

    PRIMARY KEY (`lnId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `doctors` (
    `dtId` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `name` VARCHAR(15) NOT NULL DEFAULT '',
    `introduce` VARCHAR(425) NOT NULL DEFAULT '',
    `career` VARCHAR(425) NOT NULL DEFAULT '',
    `img` VARCHAR(265) NOT NULL DEFAULT '',
    `status` INTEGER NOT NULL DEFAULT 0,
    `editorId` INTEGER NOT NULL DEFAULT 0,
    `editorName` VARCHAR(15) NOT NULL DEFAULT '',
    `editorRank` VARCHAR(15) NOT NULL DEFAULT '',

    PRIMARY KEY (`dtId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `youtube` (
    `ytId` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `title` VARCHAR(25) NOT NULL DEFAULT '',
    `url` VARCHAR(265) NOT NULL DEFAULT '',
    `img` VARCHAR(265) NOT NULL DEFAULT '',
    `clickCount` INTEGER NOT NULL DEFAULT 0,
    `editorId` INTEGER NOT NULL DEFAULT 0,
    `editorName` VARCHAR(15) NOT NULL DEFAULT '',
    `editorRank` VARCHAR(15) NOT NULL DEFAULT '',

    PRIMARY KEY (`ytId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `youtubeHistory` (
    `ythId` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `type` INTEGER NOT NULL DEFAULT 0,
    `text` VARCHAR(265) NOT NULL DEFAULT '',

    PRIMARY KEY (`ythId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `afterCare` (
    `acId` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `cateId` INTEGER NOT NULL DEFAULT 0,
    `title` VARCHAR(65) NOT NULL DEFAULT '',
    `img` VARCHAR(265) NOT NULL DEFAULT '',
    `text` TEXT NOT NULL,
    `creatorId` INTEGER NOT NULL DEFAULT 0,
    `creatorName` VARCHAR(15) NOT NULL DEFAULT '',
    `creatorRank` VARCHAR(15) NOT NULL DEFAULT '',

    PRIMARY KEY (`acId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `acCategory` (
    `accId` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `title` VARCHAR(65) NOT NULL DEFAULT '',

    PRIMARY KEY (`accId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `healthInfo` (
    `hiId` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `title` VARCHAR(65) NOT NULL DEFAULT '',
    `option` INTEGER NOT NULL DEFAULT 0,
    `creatorId` INTEGER NOT NULL DEFAULT 0,
    `creatorName` VARCHAR(15) NOT NULL DEFAULT '',
    `creatorRank` VARCHAR(15) NOT NULL DEFAULT '',
    `editorId` INTEGER NOT NULL DEFAULT 0,
    `editorName` VARCHAR(15) NOT NULL DEFAULT '',
    `editorRank` VARCHAR(15) NOT NULL DEFAULT '',

    PRIMARY KEY (`hiId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `patient` (
    `patiId` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `emrPatiId` VARCHAR(125) NOT NULL DEFAULT '',
    `name` VARCHAR(265) NOT NULL DEFAULT '',
    `cellphone` VARCHAR(25) NOT NULL DEFAULT '',
    `medicalHistory` INTEGER NOT NULL DEFAULT 0,
    `visitPath` INTEGER NOT NULL DEFAULT 0,
    `signImg` VARCHAR(265) NOT NULL DEFAULT '',

    PRIMARY KEY (`patiId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `reservation` (
    `resId` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `emrId` INTEGER NOT NULL DEFAULT 0,
    `resDate` DATETIME(3) NOT NULL,
    `resTime` VARCHAR(12) NOT NULL DEFAULT '',
    `status` INTEGER NOT NULL DEFAULT 0,
    `name` VARCHAR(265) NOT NULL DEFAULT '',
    `cellphone` VARCHAR(265) NOT NULL DEFAULT '',
    `chartNumber` VARCHAR(265) NOT NULL DEFAULT '',
    `memo` VARCHAR(265) NOT NULL DEFAULT '',
    `doctorName` VARCHAR(265) NOT NULL DEFAULT '',
    `patiId` INTEGER NULL,

    PRIMARY KEY (`resId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `userPayment` (
    `upId` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `medicalTreat` VARCHAR(125) NOT NULL DEFAULT '',
    `amount` INTEGER NOT NULL DEFAULT 0,
    `card` VARCHAR(125) NOT NULL DEFAULT '',
    `patiId` INTEGER NULL,
    `resId` INTEGER NULL,

    UNIQUE INDEX `userPayment_resId_key`(`resId`),
    PRIMARY KEY (`upId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `didConnectedOption` (
    `dcoId` INTEGER NOT NULL AUTO_INCREMENT,
    `usedCompany` INTEGER NOT NULL DEFAULT 0,

    PRIMARY KEY (`dcoId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `did` (
    `didId` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,
    `uniqueId` VARCHAR(125) NOT NULL DEFAULT '',
    `title` VARCHAR(125) NOT NULL DEFAULT '',
    `mediaType` INTEGER NOT NULL DEFAULT 0,
    `monitorType` INTEGER NOT NULL DEFAULT 0,
    `stbyPsonUsed` BOOLEAN NOT NULL DEFAULT false,
    `stbyPsonTransmitType` INTEGER NOT NULL DEFAULT 0,
    `resInfoLocation` INTEGER NOT NULL DEFAULT 0,
    `monitorRatio` INTEGER NOT NULL DEFAULT 0,
    `calledTextUsed` BOOLEAN NOT NULL DEFAULT false,
    `calledVoiceUsed` BOOLEAN NOT NULL DEFAULT false,
    `lowMsgUsed` BOOLEAN NOT NULL DEFAULT false,
    `saveMode` BOOLEAN NOT NULL DEFAULT false,
    `email` VARCHAR(65) NOT NULL DEFAULT '',
    `doctorRoomExpression` INTEGER NOT NULL DEFAULT 0,
    `stbyPsonExpression` INTEGER NOT NULL DEFAULT 0,
    `stbyPsonFontsize` INTEGER NOT NULL DEFAULT 0,
    `stbyPson1Words` INTEGER NOT NULL DEFAULT 0,
    `stbyPson1Ratio` INTEGER NOT NULL DEFAULT 0,
    `stbyPson2Words` INTEGER NOT NULL DEFAULT 0,
    `stbyPson2Ratio` INTEGER NOT NULL DEFAULT 0,
    `creatorName` VARCHAR(25) NOT NULL DEFAULT '',
    `creatorRank` VARCHAR(25) NOT NULL DEFAULT '',
    `creatorId` INTEGER NOT NULL DEFAULT 0,
    `editorName` VARCHAR(25) NOT NULL DEFAULT '',
    `editorRank` VARCHAR(25) NOT NULL DEFAULT '',
    `editorId` INTEGER NOT NULL DEFAULT 0,
    `hspId` INTEGER NULL,

    UNIQUE INDEX `did_uniqueId_key`(`uniqueId`),
    PRIMARY KEY (`didId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `didAttached` (
    `daId` INTEGER NOT NULL AUTO_INCREMENT,
    `number` INTEGER NOT NULL DEFAULT 0,
    `fileName` VARCHAR(265) NOT NULL DEFAULT '',
    `fileType` VARCHAR(265) NOT NULL DEFAULT '',
    `fileSize` INTEGER NOT NULL DEFAULT 0,
    `didId` INTEGER NOT NULL,

    PRIMARY KEY (`daId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `didLowMsg` (
    `dlmId` INTEGER NOT NULL AUTO_INCREMENT,
    `deleteDate` DATETIME(3) NULL,
    `number` INTEGER NOT NULL DEFAULT 0,
    `text` VARCHAR(565) NOT NULL DEFAULT '',
    `didId` INTEGER NULL,

    PRIMARY KEY (`dlmId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `adminPermission` ADD CONSTRAINT `adminPermission_adminId_fkey` FOREIGN KEY (`adminId`) REFERENCES `admin`(`adminId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `adminLoginHistory` ADD CONSTRAINT `adminLoginHistory_adminId_fkey` FOREIGN KEY (`adminId`) REFERENCES `admin`(`adminId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `hospitalPayment` ADD CONSTRAINT `hospitalPayment_hspId_fkey` FOREIGN KEY (`hspId`) REFERENCES `hospital`(`hspId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `user` ADD CONSTRAINT `user_hspId_fkey` FOREIGN KEY (`hspId`) REFERENCES `hospital`(`hspId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `userPermission` ADD CONSTRAINT `userPermission_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user`(`userId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `userRefreshToken` ADD CONSTRAINT `userRefreshToken_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user`(`userId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `userLoginHistory` ADD CONSTRAINT `userLoginHistory_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user`(`userId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `userHistory` ADD CONSTRAINT `userHistory_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user`(`userId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `latestNews` ADD CONSTRAINT `latestNews_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user`(`userId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `reservation` ADD CONSTRAINT `reservation_patiId_fkey` FOREIGN KEY (`patiId`) REFERENCES `patient`(`patiId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `userPayment` ADD CONSTRAINT `userPayment_patiId_fkey` FOREIGN KEY (`patiId`) REFERENCES `patient`(`patiId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `userPayment` ADD CONSTRAINT `userPayment_resId_fkey` FOREIGN KEY (`resId`) REFERENCES `reservation`(`resId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `did` ADD CONSTRAINT `did_hspId_fkey` FOREIGN KEY (`hspId`) REFERENCES `hospital`(`hspId`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `didAttached` ADD CONSTRAINT `didAttached_didId_fkey` FOREIGN KEY (`didId`) REFERENCES `did`(`didId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `didLowMsg` ADD CONSTRAINT `didLowMsg_didId_fkey` FOREIGN KEY (`didId`) REFERENCES `did`(`didId`) ON DELETE SET NULL ON UPDATE CASCADE;
