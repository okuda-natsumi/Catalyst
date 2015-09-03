-- MySQL dump 10.13  Distrib 5.1.41, for Win32 (ia32)
--
-- Host: localhost    Database: CatalDB
-- ------------------------------------------------------
-- Server version	5.1.41-community

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book` (
  `isbn` varchar(17) NOT NULL,
  `title` varchar(50) NOT NULL,
  `price` int(11) NOT NULL,
  `publish` varchar(50) NOT NULL,
  `published` date NOT NULL,
  PRIMARY KEY (`isbn`),
  UNIQUE KEY `title_key` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES ('978-4-7741-4076-6','3ステップで学ぶ MySQL入門',2604,'技術評論社','2009-12-22'),('978-4-7981-1876-5','10日でおぼえるPHP5入門教室',2940,'翔泳社','2009-12-17'),('978-4-7981-1992-2','MySQLで学ぶデータベース超入門',2310,'翔泳社','2009-07-30'),('978-4-8443-2005-0','改訂新版 基礎PHP ',3129,'インプレス','2004-09-22'),('978-4-8443-2061-6','基礎XML ',2625,'インプレス','2004-12-22'),('978-4-8443-2699-1','基礎Perl',3360,'インプレス','2009-04-03'),('978-4-89100-625-9','文法からはじめるVB入門',2940,'日経BPソフトプレス','2009-04-13'),('978-4-89100-626-6','文法からはじめるVC++入門',2940,'日経BPソフトプレス','2009-03-16');
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `body` text NOT NULL,
  `updated` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,'namidon','テストです。','2010-01-26');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document`
--

DROP TABLE IF EXISTS `document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document` (
  `docid` char(5) NOT NULL,
  `doc` text NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`docid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document`
--

LOCK TABLES `document` WRITE;
/*!40000 ALTER TABLE `document` DISABLE KEYS */;
/*!40000 ALTER TABLE `document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `memo`
--

DROP TABLE IF EXISTS `memo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `memo` (
  `mid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `body` text,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `memo`
--

LOCK TABLES `memo` WRITE;
/*!40000 ALTER TABLE `memo` DISABLE KEYS */;
INSERT INTO `memo` VALUES (2,'WINGS会議 2010年2月','日時：2010年2月15日（月）\r\n場所：WINGS事務所\r\n\r\n配布資料：WINGS2月号','2010-01-31 09:11:18'),(3,'WINGS会議 2010年3月','日時：2010年3月8日（月）10:00\r\n場所：WINGS事務所\r\n\r\n配布資料：WING32月号','2010-02-28 10:12:21'),(4,'WINGS会議 2010年4月','日時：2010年4月12日（月）10:00 \r\n場所：WINGS事務所\r\n\r\n配布資料：WINGS4月号','2010-03-31 09:22:42');
/*!40000 ALTER TABLE `memo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review` (
  `isbn` varchar(17) NOT NULL,
  `uid` varchar(10) NOT NULL,
  `body` text NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`isbn`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES ('978-4-7741-4076-6','nkakeya','初心者向けにやさしく解説してありました。図もたくさん入っていて、わかりやすかったです。','2010-02-21 00:00:00'),('978-4-7741-4076-6','tsuzuki','CD付きでラクに学習できた。練習問題も付いていて、解答が取り外せるのが便利だった。','2009-12-28 00:00:00'),('978-4-7981-1992-2','tsuzuki','通勤時間に電車の中で読破しました。読みやすくわかりやすかったです。','2009-12-26 00:00:00'),('978-4-7981-1992-2','yyamada','見た目はコンパクトだが、中身は充実していて良かった。','2010-01-30 00:00:00'),('978-4-8443-2005-0','nkakeya','学生の頃、教科書として使っていたのですが、社会人になった今でも時々活用しています。','2010-01-20 00:00:00'),('978-4-8443-2005-0','tsuzuki','PHPの基礎から応用まで、この本1冊でたくさん勉強できました。','2010-01-09 00:00:00'),('978-4-8443-2061-6','tsuzuki','何冊かXMLの初心者本を購入しましたが、それらの中でもよく使う本の1つです。','2010-01-10 00:00:00'),('978-4-8443-2061-6','yyamada','本のタイトル通りXMLの基礎について詳しく書かれていて、良い本だと思います。','2009-12-19 00:00:00'),('978-4-8443-2699-1','nkakeya','Perlをこれから学びたい人にはお薦めです。基礎がしっかり解説されていました。','2009-12-28 00:00:00'),('978-4-8443-2699-1','tsuzuki','丁寧に解説してあって、わかりやすかったです。','2010-01-18 00:00:00');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `rid` int(11) NOT NULL,
  `role` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'admin'),(2,'member');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usr`
--

DROP TABLE IF EXISTS `usr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usr` (
  `uid` varchar(10) NOT NULL,
  `passwd` char(32) NOT NULL,
  `unam` varchar(50) DEFAULT NULL,
  `roles` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usr`
--

LOCK TABLES `usr` WRITE;
/*!40000 ALTER TABLE `usr` DISABLE KEYS */;
INSERT INTO `usr` VALUES ('nkakeya','827ccb0eea8a706c4c34a16891f84e7b','掛谷奈美','member'),('tsuzuki','827ccb0eea8a706c4c34a16891f84e7b','鈴木太郎','admin'),('yyamada','827ccb0eea8a706c4c34a16891f84e7b','山田祥寛','admin,member');
/*!40000 ALTER TABLE `usr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usr_role`
--

DROP TABLE IF EXISTS `usr_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usr_role` (
  `uid` varchar(10) NOT NULL,
  `rid` int(11) NOT NULL,
  PRIMARY KEY (`uid`,`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usr_role`
--

LOCK TABLES `usr_role` WRITE;
/*!40000 ALTER TABLE `usr_role` DISABLE KEYS */;
INSERT INTO `usr_role` VALUES ('nkakeya',2),('tsuzuki',1),('yyamada',1),('yyamada',2);
/*!40000 ALTER TABLE `usr_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-02-06 22:52:50
