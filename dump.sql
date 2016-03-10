-- MySQL dump 10.13  Distrib 5.6.28, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: ois_test
-- ------------------------------------------------------
-- Server version	5.6.28-0ubuntu0.15.10.1

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
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingredients` (
  `ingredient_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `calories` int(11) NOT NULL,
  PRIMARY KEY (`ingredient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredients`
--

LOCK TABLES `ingredients` WRITE;
/*!40000 ALTER TABLE `ingredients` DISABLE KEYS */;
INSERT INTO `ingredients` VALUES (1,'Tomato',50),(2,'Minced meat',200),(3,'Paprika',50),(4,'Onion',30),(5,'Apple',121),(6,'Cola zero',1),(7,'Cola',133),(8,'Water',0),(9,'Pasta',211),(10,'Cheese',23),(11,'Pasta sheets',211),(12,'Yoghurt',121),(13,'Chicken',143),(14,'Steak',213),(15,'Fries',322),(16,'Milk',32),(17,'Flour',44),(18,'Bread',166),(19,'Choco',23),(20,'Confiture',32);
/*!40000 ALTER TABLE `ingredients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `looses_weight`
--

DROP TABLE IF EXISTS `looses_weight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `looses_weight` (
  `person_id` int(10) unsigned NOT NULL DEFAULT '0',
  `period` int(11) NOT NULL DEFAULT '0',
  `start_date` date NOT NULL DEFAULT '0000-00-00',
  `weight_to_lose` int(11) NOT NULL,
  PRIMARY KEY (`person_id`,`start_date`,`period`),
  CONSTRAINT `looses_weight_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `persons` (`person_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `looses_weight`
--

LOCK TABLES `looses_weight` WRITE;
/*!40000 ALTER TABLE `looses_weight` DISABLE KEYS */;
INSERT INTO `looses_weight` VALUES (3,20,'2016-01-03',8),(7,10,'2016-01-01',5);
/*!40000 ALTER TABLE `looses_weight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person_weighs`
--

DROP TABLE IF EXISTS `person_weighs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person_weighs` (
  `person_id` int(10) unsigned NOT NULL DEFAULT '0',
  `on_date` date NOT NULL DEFAULT '0000-00-00',
  `weight` int(11) NOT NULL,
  PRIMARY KEY (`person_id`,`on_date`),
  CONSTRAINT `person_weighs_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `persons` (`person_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person_weighs`
--

LOCK TABLES `person_weighs` WRITE;
/*!40000 ALTER TABLE `person_weighs` DISABLE KEYS */;
INSERT INTO `person_weighs` VALUES (1,'2015-12-22',85),(1,'2015-12-25',84),(1,'2015-12-28',85),(1,'2016-01-03',88),(1,'2016-01-06',87),(1,'2016-01-08',86),(2,'2016-01-01',59),(2,'2016-01-05',58),(2,'2016-01-25',57),(2,'2016-02-04',56),(2,'2016-02-16',55),(3,'2016-01-16',98),(3,'2016-01-25',99),(3,'2016-02-15',97),(4,'2016-02-15',87),(4,'2016-02-16',87),(4,'2016-02-17',87),(4,'2016-02-18',86),(4,'2016-02-19',86),(4,'2016-02-20',85),(4,'2016-02-21',85),(4,'2016-02-22',85),(5,'2016-03-10',95),(6,'2016-03-10',65),(7,'2016-02-15',85),(7,'2016-02-17',83),(7,'2016-02-18',84),(7,'2016-02-19',84);
/*!40000 ALTER TABLE `person_weighs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persons`
--

DROP TABLE IF EXISTS `persons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persons` (
  `person_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `length` int(3) NOT NULL,
  `gender` varchar(1) NOT NULL,
  `birthdate` date NOT NULL,
  `excercise_level` int(2) NOT NULL,
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`person_id`),
  UNIQUE KEY `uniquePerson` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persons`
--

LOCK TABLES `persons` WRITE;
/*!40000 ALTER TABLE `persons` DISABLE KEYS */;
INSERT INTO `persons` VALUES (1,'Max',187,'m','1987-09-10',2,'maximulius@vub.ac.be'),(2,'July',165,'f','1997-02-21',1,'julysmith@hotmail.com'),(3,'David',175,'m','1972-05-01',3,'davidbush@hotmail.com'),(4,'George',178,'m','1982-10-15',1,'georgenicolson@gmail.com'),(5,'Thomas',203,'m','1989-11-30',2,'thomy89@gmail.com'),(6,'Mary',155,'f','1994-01-04',3,'momary@gmail.com'),(7,'Lisa',160,'f','1984-01-12',1,'lisaaax84@gmail.com');
/*!40000 ALTER TABLE `persons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_ingredient`
--

DROP TABLE IF EXISTS `recipe_ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipe_ingredient` (
  `recipe_id` int(10) unsigned NOT NULL DEFAULT '0',
  `ingredient_id` int(10) unsigned NOT NULL DEFAULT '0',
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`recipe_id`,`ingredient_id`),
  KEY `ingredient_id` (`ingredient_id`),
  CONSTRAINT `recipe_ingredient_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`recipe_id`) ON DELETE CASCADE,
  CONSTRAINT `recipe_ingredient_ibfk_2` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`ingredient_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_ingredient`
--

LOCK TABLES `recipe_ingredient` WRITE;
/*!40000 ALTER TABLE `recipe_ingredient` DISABLE KEYS */;
INSERT INTO `recipe_ingredient` VALUES (1,9,150),(2,11,200),(3,9,150),(4,1,100),(4,2,150),(4,3,20),(4,4,40);
/*!40000 ALTER TABLE `recipe_ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_recipe`
--

DROP TABLE IF EXISTS `recipe_recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipe_recipe` (
  `recipe_part_id` int(10) unsigned NOT NULL DEFAULT '0',
  `recipe_having_id` int(10) unsigned NOT NULL DEFAULT '0',
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`recipe_part_id`,`recipe_having_id`),
  KEY `recipe_having_id` (`recipe_having_id`),
  CONSTRAINT `recipe_recipe_ibfk_1` FOREIGN KEY (`recipe_part_id`) REFERENCES `recipes` (`recipe_id`) ON DELETE CASCADE,
  CONSTRAINT `recipe_recipe_ibfk_2` FOREIGN KEY (`recipe_having_id`) REFERENCES `recipes` (`recipe_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_recipe`
--

LOCK TABLES `recipe_recipe` WRITE;
/*!40000 ALTER TABLE `recipe_recipe` DISABLE KEYS */;
INSERT INTO `recipe_recipe` VALUES (1,4,200),(2,4,150);
/*!40000 ALTER TABLE `recipe_recipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_tag`
--

DROP TABLE IF EXISTS `recipe_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipe_tag` (
  `recipe_id` int(10) unsigned NOT NULL DEFAULT '0',
  `tag_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`recipe_id`,`tag_id`),
  KEY `tag_id` (`tag_id`),
  CONSTRAINT `recipe_tag_ibfk_1` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`recipe_id`) ON DELETE CASCADE,
  CONSTRAINT `recipe_tag_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_tag`
--

LOCK TABLES `recipe_tag` WRITE;
/*!40000 ALTER TABLE `recipe_tag` DISABLE KEYS */;
INSERT INTO `recipe_tag` VALUES (1,2),(4,2),(3,4),(2,5);
/*!40000 ALTER TABLE `recipe_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipes`
--

DROP TABLE IF EXISTS `recipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipes` (
  `recipe_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `calories` int(11) NOT NULL,
  PRIMARY KEY (`recipe_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipes`
--

LOCK TABLES `recipes` WRITE;
/*!40000 ALTER TABLE `recipes` DISABLE KEYS */;
INSERT INTO `recipes` VALUES (1,'Spaghetti Bolo',541),(2,'Lasagna Bolo',541),(3,'Carbonara',99),(4,'Tomato Sauce',330);
/*!40000 ALTER TABLE `recipes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `tag_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'Chinese'),(2,'Italian'),(3,'Breakfast'),(4,'Diner'),(5,'Lunch'),(6,'Snack'),(7,'Greek'),(8,'Japanese'),(9,'Dessert'),(10,'Mediterranean');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-03-09 22:11:26
