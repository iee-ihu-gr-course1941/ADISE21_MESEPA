/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 10.3.31-MariaDB-0+deb10u1-log : Database - quarto_mesepa
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`quarto_mesepa` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `quarto_mesepa`;

/*Table structure for table `board` */

DROP TABLE IF EXISTS `board`;

CREATE TABLE `board` (
  `x` tinyint(1) NOT NULL,
  `y` tinyint(1) NOT NULL,
  `piece_color` enum('W','B') DEFAULT NULL,
  `piece` enum('STS','STH','SLS','SLH','CTS','CTH','CLS','CLH') DEFAULT NULL,
  PRIMARY KEY (`y`,`x`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `board` */

insert  into `board`(`x`,`y`,`piece_color`,`piece`) values 
(1,1,NULL,NULL),
(2,1,NULL,NULL),
(3,1,NULL,NULL),
(4,1,NULL,NULL),
(1,2,NULL,NULL),
(2,2,NULL,NULL),
(3,2,NULL,NULL),
(4,2,NULL,NULL),
(1,3,NULL,NULL),
(2,3,'B','CLS'),
(3,3,NULL,NULL),
(4,3,NULL,NULL),
(1,4,NULL,NULL),
(2,4,NULL,NULL),
(3,4,NULL,NULL),
(4,4,NULL,NULL);

/*Table structure for table `board_empty` */

DROP TABLE IF EXISTS `board_empty`;

CREATE TABLE `board_empty` (
  `x` tinyint(1) NOT NULL,
  `y` tinyint(1) NOT NULL,
  `piece_color` enum('W','B') DEFAULT NULL,
  `piece` enum('STS','STH','SLS','SLH','CTS','CTH','CLS','CLH') DEFAULT NULL,
  PRIMARY KEY (`y`,`x`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `board_empty` */

insert  into `board_empty`(`x`,`y`,`piece_color`,`piece`) values 
(1,1,NULL,NULL),
(2,1,NULL,NULL),
(3,1,NULL,NULL),
(4,1,NULL,NULL),
(1,2,NULL,NULL),
(2,2,NULL,NULL),
(3,2,NULL,NULL),
(4,2,NULL,NULL),
(1,3,NULL,NULL),
(2,3,NULL,NULL),
(3,3,NULL,NULL),
(4,3,NULL,NULL),
(1,4,NULL,NULL),
(2,4,NULL,NULL),
(3,4,NULL,NULL),
(4,4,NULL,NULL);

/*Table structure for table `game_status` */

DROP TABLE IF EXISTS `game_status`;

CREATE TABLE `game_status` (
  `status` enum('not active','initialized','started','ended','aborded') NOT NULL DEFAULT 'not active',
  `p_turn` enum('1','2') DEFAULT NULL,
  `result` enum('1','2','D') DEFAULT NULL,
  `last_change` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `game_status` */

insert  into `game_status`(`status`,`p_turn`,`result`,`last_change`) values 
('not active',NULL,'1','2021-12-14 13:38:20'),
('not active','1','D','2021-12-14 13:41:27');

/*Table structure for table `players` */

DROP TABLE IF EXISTS `players`;

CREATE TABLE `players` (
  `username` varchar(20) DEFAULT NULL,
  `piece_color` enum('B','W') NOT NULL,
  `token` varchar(100) DEFAULT NULL,
  `last_action` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`piece_color`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `players` */

insert  into `players`(`username`,`piece_color`,`token`,`last_action`) values 
(NULL,'B',NULL,NULL),
(NULL,'W',NULL,NULL);

/* Trigger structure for table `game_status` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `game_status_update` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `game_status_update` BEFORE UPDATE ON `game_status` FOR EACH ROW BEGIN
		SET NEW.last_change = NOW();
END */$$


DELIMITER ;

/* Procedure structure for procedure `clean_board` */

/*!50003 DROP PROCEDURE IF EXISTS  `clean_board` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `clean_board`()
BEGIN
	REPLACE INTO board SELECT * FROM board_empty;
	UPDATE `players` SET username=NULL, token=NULL;
    UPDATE `game_status` SET `status`='not active', `p_turn`=NULL, `result`=NULL;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `place_piece` */

/*!50003 DROP PROCEDURE IF EXISTS  `place_piece` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `place_piece`(x1 tinyint,y1 tinyint, p VARCHAR(255),p_c VARCHAR(255))
BEGIN
	
	update board
	set piece=p, piece_color=p_c
	where x=x1 and y=y1;
	 END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
