/*
SQLyog Trial v13.1.8 (64 bit)
MySQL - 10.4.22-MariaDB : Database - quarto_mesepa
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
(2,3,NULL,NULL),
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
  `p_turn` enum('W','B') DEFAULT NULL,
  `result` enum('B','W','D') DEFAULT NULL,
  `last_change` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `game_status` */

insert  into `game_status`(`status`,`p_turn`,`result`,`last_change`) values 
('not active',NULL,NULL,'2021-11-22 20:04:52');

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

/* Procedure structure for procedure `move_piece` */

/*!50003 DROP PROCEDURE IF EXISTS  `move_piece` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `move_piece`(x1 tinyint,y1 tinyint,x2 tinyint,y2 tinyint)
BEGIN
	declare  p, p_color char;
	
	select  piece, piece_color into p, p_color FROM `board` WHERE X=x1 AND Y=y1;
	
	update board
	set piece=p, piece_color=p_color
	where x=x2 and y=y2;
	
	UPDATE board
	SET piece=null,piece_color=null
	WHERE X=x1 AND Y=y1;
	update game_status set p_turn=if(p_color='W','B','W');
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `test_move` */

/*!50003 DROP PROCEDURE IF EXISTS  `test_move` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `test_move`()
BEGIN
SELECT * FROM
board B1 INNER JOIN board B2
WHERE B1.x=2 AND B1.y=2
AND (B2.`piece_color` IS NULL OR B2.`piece_color`<>B1.`piece_color`)
AND B1.x=B2.x AND B1.y<B2.y AND (B2.y-B1.y)<=2 ;
    END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
