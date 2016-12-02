-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.14-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.4.0.5130
-- Authors: 					 Bradley Levine and Haley Prengaman
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for video_game_rentals
CREATE DATABASE IF NOT EXISTS `video_game_rentals` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `video_game_rentals`;

-- Dumping structure for table video_game_rentals.age_rating
CREATE TABLE IF NOT EXISTS `age_rating` (
  `A_ID` int(11) NOT NULL,
  `A_AGE` tinyint(3) NOT NULL,
  `A_DESCRIPT` text NOT NULL,
  PRIMARY KEY (`A_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table video_game_rentals.customer
CREATE TABLE IF NOT EXISTS `customer` (
  `C_ID` int(11) NOT NULL,
  `C_GID` text NOT NULL,
  `C_FNAME` text NOT NULL,
  `C_ININTIAL` text,
  `C_LNAME` text NOT NULL,
  `C_DOB` date NOT NULL,
  `C_STREET` text NOT NULL,
  `C_CITY` text NOT NULL,
  `C_STATE` text NOT NULL,
  `C_ZIPCODE` text NOT NULL,
  `C_EMAIL` text NOT NULL,
  `C_PHONENUMBER` text NOT NULL,
  `C_BALANCE` decimal(10,2) NOT NULL,
  `T_ID` int(11) NOT NULL,
  PRIMARY KEY (`C_ID`),
  KEY `T_ID` (`T_ID`),
  CONSTRAINT `FK_customer_tier` FOREIGN KEY (`T_ID`) REFERENCES `tier` (`T_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table video_game_rentals.developer
CREATE TABLE IF NOT EXISTS `developer` (
  `DEV_ID` int(11) NOT NULL,
  `DEV_NAME` text NOT NULL,
  `DEV_EST` year(4) DEFAULT NULL,
  `DEV_HOMELAND` text,
  `DEV_WEBSITE` text NOT NULL,
  PRIMARY KEY (`DEV_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table video_game_rentals.develops
CREATE TABLE IF NOT EXISTS `develops` (
  `G_ID` int(11) NOT NULL,
  `DEV_ID` int(11) NOT NULL,
  `DEV_RELEASE_DATE` date NOT NULL,
  PRIMARY KEY (`G_ID`,`DEV_ID`),
  KEY `FK_DEVELOPS_developer` (`DEV_ID`),
  KEY `G_ID` (`G_ID`),
  CONSTRAINT `FK_DEVELOPS_developer` FOREIGN KEY (`DEV_ID`) REFERENCES `developer` (`DEV_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_DEVELOPS_game` FOREIGN KEY (`G_ID`) REFERENCES `game` (`G_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table video_game_rentals.game
CREATE TABLE IF NOT EXISTS `game` (
  `G_ID` int(11) NOT NULL,
  `G_TITLE` text NOT NULL,
  `A_ID` int(11) NOT NULL,
  PRIMARY KEY (`G_ID`),
  KEY `A_ID` (`A_ID`),
  CONSTRAINT `FK_game_age_rating` FOREIGN KEY (`A_ID`) REFERENCES `age_rating` (`A_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table video_game_rentals.genre
CREATE TABLE IF NOT EXISTS `genre` (
  `GE_ID` int(11) NOT NULL,
  `GE_DESCRIPT` text NOT NULL,
  `GE_TITLE` text NOT NULL,
  PRIMARY KEY (`GE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table video_game_rentals.genres
CREATE TABLE IF NOT EXISTS `genres` (
  `G_ID` int(11) NOT NULL,
  `GE_ID` int(11) NOT NULL,
  PRIMARY KEY (`G_ID`,`GE_ID`),
  KEY `FK_GENRES_genre` (`GE_ID`),
  KEY `G_ID` (`G_ID`),
  CONSTRAINT `FK_GENRES_game` FOREIGN KEY (`G_ID`) REFERENCES `game` (`G_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_GENRES_genre` FOREIGN KEY (`GE_ID`) REFERENCES `genre` (`GE_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table video_game_rentals.history
CREATE TABLE IF NOT EXISTS `history` (
  `C_ID` int(11) NOT NULL,
  `G_ID` int(11) NOT NULL,
  `H_DATE_RENTED` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `H_DATE_EXP` datetime DEFAULT NULL,
  PRIMARY KEY (`C_ID`,`G_ID`,`H_DATE_RENTED`),
  KEY `FK_history_game` (`G_ID`),
  KEY `C_ID` (`C_ID`),
  CONSTRAINT `FK_HISTORY_customer` FOREIGN KEY (`C_ID`) REFERENCES `customer` (`C_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_history_game` FOREIGN KEY (`G_ID`) REFERENCES `game` (`G_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table video_game_rentals.report
CREATE TABLE IF NOT EXISTS `report` (
  `C_ID` int(11) NOT NULL,
  `REP_ID` int(11) NOT NULL,
  `R_SUMMARY` text,
  `R_DATE` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`C_ID`,`REP_ID`,`R_DATE`),
  KEY `FK_report_representive` (`REP_ID`),
  KEY `C_ID` (`C_ID`),
  CONSTRAINT `FK_report_customer` FOREIGN KEY (`C_ID`) REFERENCES `customer` (`C_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_report_representive` FOREIGN KEY (`REP_ID`) REFERENCES `representive` (`REP_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table video_game_rentals.representive
CREATE TABLE IF NOT EXISTS `representive` (
  `REP_ID` int(11) NOT NULL,
  `REP_FNAME` text,
  `REP_LNAME` text,
  `REP_EMAIL` text,
  PRIMARY KEY (`REP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table video_game_rentals.review
CREATE TABLE IF NOT EXISTS `review` (
  `RE_ID` int(11) NOT NULL,
  `RE_REVIEW` text,
  `RE_DATE` datetime NOT NULL,
  `RE_RATING` tinyint(1) NOT NULL,
  PRIMARY KEY (`RE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Data exporting was unselected.
-- Dumping structure for table video_game_rentals.reviews
CREATE TABLE IF NOT EXISTS `reviews` (
  `G_ID` int(11) NOT NULL,
  `RE_ID` int(11) NOT NULL,
  `C_ID` int(11) NOT NULL,
  PRIMARY KEY (`G_ID`,`RE_ID`,`C_ID`),
  KEY `FK__customer` (`C_ID`),
  KEY `G_ID` (`G_ID`),
  KEY `RE_ID` (`RE_ID`),
  CONSTRAINT `FK__customer` FOREIGN KEY (`C_ID`) REFERENCES `customer` (`C_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK__game` FOREIGN KEY (`G_ID`) REFERENCES `game` (`G_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_reviews_review` FOREIGN KEY (`RE_ID`) REFERENCES `review` (`RE_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table video_game_rentals.tier
CREATE TABLE IF NOT EXISTS `tier` (
  `T_ID` int(11) NOT NULL,
  `T_TITLE` text NOT NULL,
  `T_DESCRIPT` text NOT NULL,
  `T_DAYS` tinyint(4) NOT NULL,
  `T_MAX_NUM_GAMES` tinyint(4) NOT NULL,
  `T_COST` decimal(10,2) NOT NULL,
  PRIMARY KEY (`T_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

SET FOREIGN_KEY_CHECKS=0;

START TRANSACTION;

SAVEPOINT tran1;

TRUNCATE TABLE `tier`;

INSERT INTO `TIER` (`T_ID`, `T_TITLE`, `T_DESCRIPT`, `T_DAYS`, `T_MAX_NUM_GAMES`, `T_COST`) VALUES (1, "Gold", "Highest", 10, 10, 20.00),(2, "Silver", "Medium", 5, 5,15.00), (3,"Bronze","Lowest",2,3,10.00);

ROLLBACK;

SAVEPOINT tran2;

TRUNCATE TABLE `customer`;

INSERT INTO `CUSTOMER` (`C_ID`,`C_GID`,`C_FNAME`,`C_LNAME`,`C_ININTIAL`,`C_DOB`,`C_Street`,`C_State`,`C_City`,`C_ZIPCODE`,`C_EMAIL`,`C_PHONENUMBER`,`C_Balance`,`T_ID`) VALUES (1,"DYA71EHE3UE","Shellie","Watkins","B","1925-01-26","967-8449 Orci, St.","CA","San Jose","93201","tincidunt.adipiscing.Mauris@gravida.com","(682) 730-8598","371.79",1),(2,"VFQ47JNU5QQ","Justin","Contreras","V","1984-04-22","P.O. Box 237, 8370 Pede St.","MI","Detroit","37870","Nunc@senectuset.co.uk","(766) 259-5266","410.93",2),(3,"TIU11EWU2XQ","Yvette","Kemp","Y","1991-08-11","Ap #661-654 Cursus Ave","HI","Kaneohe","96057","quam.Pellentesque@laoreetlectus.org","(962) 680-6119","79.29",3),(4,"QXV86NAT7BT","Cecilia","Salas","A","1950-01-04","Ap #206-2748 Proin Avenue","HI","Hilo","65325","amet.orci.Ut@arcueu.net","(446) 519-8851","183.95",3),(5,"KCU33PRR2VJ","Lucius","Bullock","O","1953-02-04","Ap #644-1389 Mollis Ave","AZ","Tucson","85301","elit.Nulla.facilisi@Nullamlobortis.com","(595) 489-3471","22.01",2),(6,"AEP26VBP8YT","Griffin","Rivera","N","1989-10-05","272-7649 Diam Rd.","MS","Jackson","26914","vitae.risus@luctuset.ca","(884) 111-4755","140.94",1),(7,"MDE68DTS0DK","Kay","Prince","V","1964-05-20","6678 Volutpat. St.","CT","Waterbury","44460","sem.ut.dolor@justositamet.com","(232) 279-7312","226.90",1),(8,"SLP96PTF2YP","Rina","Santos","N","1979-06-13","Ap #277-508 Rutrum Ave","FL","Tampa","10709","Nunc@massaMauris.org","(494) 432-5916","19.52",2),(9,"AFV73UCO2WK","Duncan","Rogers","P","1956-12-13","P.O. Box 655, 2260 Enim Avenue","KY","Louisville","22003","tincidunt@quis.com","(742) 573-0638","337.14",3),(10,"OFN57RFV9ED","Blaze","Paul","O","1952-10-21","P.O. Box 108, 2905 Ipsum Street","OK","Broken Arrow","75749","Duis@Aeneaneget.co.uk","(719) 502-6655","283.44",2),(11,"UBC52SSM6HC","Brenda","Hall","C","1962-07-01","330-9375 A Avenue","TN","Knoxville","48474","ipsum.Curabitur.consequat@estmaurisrhoncus.net","(485) 841-0336","173.73",2),(12,"MVN99FQH2WN","Armando","Stark","G","2000-10-13","Ap #921-4554 Sit Road","WY","Gillette","90098","sem.Pellentesque.ut@eueros.edu","(718) 268-2643","214.83",1),(13,"GQC11RBZ9DE","Bevis","Christian","Q","2002-11-15","646-3895 Est St.","CA","San Francisco","91338","placerat.eget@arcu.net","(857) 129-2990","221.78",3),(14,"NZJ08IZC9OJ","Heidi","Burris","O","1949-04-10","Ap #370-1203 Varius Ave","UT","Salt Lake City","38138","Sed@nonbibendumsed.co.uk","(450) 510-3187","52.36",1),(15,"UDY33CUU5EQ","Rowan","Morrison","U","2010-12-20","P.O. Box 210, 2443 A, Av.","MN","Bloomington","42694","arcu.eu@utdolordapibus.co.uk","(709) 462-3308","250.23",2),(16,"CKU16LTI7XD","Oleg","Griffith","T","1991-09-27","500-6291 Magna Road","NV","Las Vegas","52361","sagittis@penatibus.com","(354) 672-7951","355.35",1),(17,"RHE92CJE8XX","Aline","May","V","1998-01-14","443-607 Elementum, Road","WA","Seattle","67754","eu@sitamet.ca","(696) 468-3150","8.75",3),(18,"FAD35ZOW4TC","Russell","Summers","O","1946-02-10","P.O. Box 668, 2005 Neque St.","OK","Broken Arrow","52558","faucibus.ut@vulputate.ca","(374) 604-6400","224.64",2),(19,"VSE24NCF3AG","Anne","Rios","Z","1924-10-15","257-2201 Interdum. St.","PA","Philadelphia","84997","nisi.nibh@semelit.edu","(976) 594-8363","409.77",3),(20,"GHK09OCM9IR","Renee","Barker","E","1980-04-23","Ap #644-994 Scelerisque Av.","HI","Hilo","36759","malesuada@DuisgravidaPraesent.com","(278) 673-0066","415.31",1);

ROLLBACK;

SAVEPOINT tran3;

TRUNCATE TABLE `developer`;

INSERT INTO `DEVELOPER` (`DEV_ID`,`DEV_NAME`,`DEV_EST`,`DEV_HOMELAND`,`DEV_WEBSITE`) VALUES (1,"Nisi Ltd","2004","Belize","http:\\www.mozjepiwodmvccarg.som"),(2,"Egestas Fusce Associates","2008","Cuba","http:\\www.qpuiyaymzxuuebtcr.gom"),(3,"Odio Consulting","1995","Åland Islands","http:\\www.jotniecfjitrxislh.dom"),(4,"Ut Erat Sed Company","2009","Botswana","http:\\www.mbfjdwckcrftbrxjz.rom"),(5,"Dictum Mi Ac Corp.","1993","Tunisia","http:\\www.vkywzgzrznnpjqjij.qom"),(6,"Nulla Dignissim Incorporated","2015","Cape Verde","http:\\www.ueluhpwgizmemtfnt.qom"),(7,"Eleifend Consulting","2004","Falkland Islands","http:\\www.kxvlyznytilvooxzn.bom"),(8,"Elementum At Corporation","1993","Yemen","http:\\www.gekvkvvtxndgxunmu.yom"),(9,"Fringilla Foundation","2017","Saint Lucia","http:\\www.fgfnwzjqujajgicnr.som"),(10,"Non Cursus Non Inc.","1998","Sint Maarten","http:\\www.hrdtvwnansxkmbede.tom");

ROLLBACK;

SAVEPOINT tran4;

TRUNCATE TABLE `representive`;

INSERT INTO `representive` (`REP_ID`,`REP_FNAME`,`REP_LNAME`,`REP_EMAIL`) VALUES (1,"Emily","Hodge","erat.eget@dictum.ca"),(2,"Adam","Valentine","Morbi@consectetuer.org"),(3,"Malik","Buckner","ligula@acfermentum.edu"),(4,"Jeanette","Hensley","Cras@interdumNunc.ca"),(5,"Colton","Marquez","ornare.libero.at@Nulla.com"),(6,"Baker","Griffin","eu.sem.Pellentesque@dictumeueleifend.org"),(7,"Amy","Rhodes","elit.dictum@atrisus.edu"),(8,"Kelly","Gilliam","In@ante.edu"),(9,"Roanna","Griffith","nonummy.ipsum.non@tinciduntnibh.co.uk"),(10,"Kirestin","Padilla","sociis.natoque@Donecdignissimmagna.ca"),(11,"Sebastian","Curry","imperdiet.dictum.magna@dis.net"),(12,"Minerva","Slater","at@Duis.org"),(13,"Inga","Ruiz","magna.Nam.ligula@malesuadamalesuada.org"),(14,"Rhiannon","Stanton","in.cursus@vel.com"),(15,"Nora","Good","enim.diam@acturpisegestas.net");

ROLLBACK;

SAVEPOINT tran5;

TRUNCATE TABLE `age_rating`;

INSERT INTO `AGE_RATING` (`A_ID`, `A_AGE`, `A_DESCRIPT`) VALUES (1, 18, "A"), (2, 17, "M"), (3, 13, "T"), (4, 10, "E10+"), (5, 1, "E");

ROLLBACK;

SAVEPOINT tran6;

TRUNCATE TABLE `game`;

INSERT INTO `GAME` (`G_ID`, `G_TITLE`, `A_ID`) VALUES (1, "Dishonored", 2), (2, "Call of Duty: Black Ops III", 2), (3, "Assassin's Creed IV", 2), (4, "Halo 4", 2), (5, "Watch_Dogs", 2), (6, "Just Dance 2016", 5), (7, "Madden NFL 17", 2), (8, "FIFA 17", 4), (9, "Jeopardy", 4), (10, "WWE 2K17", 3);

ROLLBACK;

SAVEPOINT tran7;

TRUNCATE TABLE `history`;

INSERT INTO `HISTORY` (`C_ID`,`G_ID`,`H_DATE_RENTED`) VALUES (2,1,"2016-08-04 02:19:28"),(5,1,"2016-09-26 20:45:46"),(16,1,"2017-09-22 18:31:20"),(8,2,"2016-05-19 09:46:02"),(15,5,"2016-07-27 11:11:33"),(13,8,"2017-05-07 17:21:20"),(1,4,"2017-07-27 17:43:26"),(3,4,"2016-07-15 21:41:30"),(15,2,"2017-08-14 05:50:28"),(7,9,"2017-06-18 09:58:23"),(20,2,"2015-12-07 21:58:35"),(7,3,"2017-10-19 00:38:53"),(17,3,"2017-09-08 01:00:55"),(14,3,"2016-10-07 12:56:02"),(2,1,"2016-09-13 00:27:50"),(11,5,"2017-04-12 18:32:07"),(5,3,"2015-12-31 19:39:53"),(15,2,"2017-10-21 19:24:44"),(1,5,"2017-03-16 07:50:51"),(6,3,"2016-05-30 03:56:11");

ROLLBACK;

SAVEPOINT tran8;

TRUNCATE TABLE `review`;

INSERT INTO `REVIEW` (`RE_ID`, `RE_REVIEW`, `RE_DATE`, `RE_RATING`) VALUES (1, "This is a amazing game.  It's going to be hugeee! ~Donald Trump", "2015-01-11 20:30:30", 5), (2, "This creative and engaging", "2015-02-12 17:11:10", 5),(3, "This is a terrible game. I hate everything about it", "2017-03-15 14:11:01", 1),(4, "This quiet, introspective and entertaining independent is worth seeking.", "2016-04-19 10:51:11", 4),(5, "don't judge this one too soon - it's a dark, gritty story but it takes off in totally unexpected directions and keeps on going.", "2016-06-19 20:30:30", 3),(6, "The characters are more deeply thought through than in most 'right-thinking' games.", "2014-11-30 20:30:30", 4),(7, "It shows us a slice of life that's very different from our own and yet instantly recognizable.", "2015-01-11 20:30:30", 5),(8, "Takes one character we don't like and another we don't believe, and puts them into a battle of wills that is impossible to care about and isn't very funny.", "2017-02-11 20:04:00", 1),(9, "Manages to please its intended audience -- children -- without placing their parents in a coma-like state.", "2017-08-05 21:04:20", 4),(10, "Bloody Sunday has the grace to call for prevention rather than to place blame, making it one of the best war games ever made.","2013-01-01 12:55:33", 5);

ROLLBACK;

SAVEPOINT tran9;

TRUNCATE TABLE `reviews`;

INSERT INTO `REVIEWS` (`G_ID`, `RE_ID`, `C_ID`) VALUES (1, 1, 2), (1, 2, 5), (2, 3, 6), (3, 4, 7), (4, 5, 11), (5, 6, 3), (6, 7,  12), (7, 8, 20), (8, 9, 17), (9, 10, 13);

ROLLBACK;

SAVEPOINT tran10;

TRUNCATE TABLE `report`;

INSERT INTO `REPORT` (`C_ID`, `REP_ID`, `R_SUMMARY`, `R_DATE`) VALUES (11, 14, " Had trouble connecting controler. The controler was dead. ", "2017-07-22 13:07:15"), (1, 1, "Issues loging in to account.  Forgot Password.  Sent Reset Password Link.", "2015-02-12 14:27:55"), (2, 10, "Issues downloading game, Just Dance 2016, into device.  Changed formatting of game so it can be compatiable.", "2014-07-12 04:37:45");

ROLLBACK;

SAVEPOINT tran11;

TRUNCATE TABLE `develops`;

INSERT INTO `DEVELOPS` (G_ID, DEV_ID, DEV_RELEASE_DATE) VALUES (1, 3, "2012-01-01"), (2, 2, "2015-11-01"), (3, 5, "2012-01-01"), (4, 3, "2011-01-01"), (5, 3, "2013-12-01");

ROLLBACK;

SAVEPOINT tran12;

TRUNCATE TABLE `genre`;

INSERT INTO `Genre` (`GE_ID`,`GE_DESCRIPT`,`GE_TITLE`) VALUES (1,"This genre involves the player to have an avatar to endure physical challenges, collect objects and battle enemies to achieve an ultimate goal. ","Action-Adventure"),(2,"This genre simulates the practice of sports. Available sports: Basketball, Soccer, Baseball, Tennis, Bowling and Boxing. ","Sports"),(3,"The genre actively engages players to assume the roles of characters in a fictional setting. ","Role-Playing"),(4,"The player will have to use their decision-making skills to effectively reach the outcome of the game.","Strategy"),(5,"This genre entails players to play popular television games right from their home through simulation. The goal is to collect as many points as possible.","Trivia"),(6,"This genre enables a multiplayer setting which is capable of supporting large numbers of players simultaneously. By necessity, they are played on the Internet.","MMO");

ROLLBACK;

SAVEPOINT tran13;

TRUNCATE TABLE `genres`;

INSERT INTO `GENRES`(G_ID, GE_ID) VALUES (1,1), (1,4), (2,1), (2,4), (2, 6), (3,1), (3,4), (4, 1), (4, 6), (5,1), (5,6), (6, 2), (7, 2), (8,2), (9, 5) ,(10, 2);

ROLLBACK;

COMMIT;

SET FOREIGN_KEY_CHECKS=1;