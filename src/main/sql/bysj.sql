/*
Navicat MySQL Data Transfer

Source Server         : javaweb
Source Server Version : 50536
Source Host           : localhost:3306
Source Database       : bysj

Target Server Type    : MYSQL
Target Server Version : 50536
File Encoding         : 65001

Date: 2018-05-22 21:55:43
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for administrator
-- ----------------------------
DROP TABLE IF EXISTS `administrator`;
CREATE TABLE `administrator` (
  `ID` int(12) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `realname` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for animation
-- ----------------------------
DROP TABLE IF EXISTS `animation`;
CREATE TABLE `animation` (
  `ID` int(12) NOT NULL AUTO_INCREMENT,
  `UserID` int(12) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `content` varchar(200) DEFAULT NULL,
  `picture` varchar(200) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `status` int(5) DEFAULT '1',
  `grade` float DEFAULT '0',
  `download` int(11) DEFAULT '0',
  `createtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `category` int(12) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for animationcategory
-- ----------------------------
DROP TABLE IF EXISTS `animationcategory`;
CREATE TABLE `animationcategory` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for animationscore
-- ----------------------------
DROP TABLE IF EXISTS `animationscore`;
CREATE TABLE `animationscore` (
  `ID` int(12) NOT NULL AUTO_INCREMENT,
  `grade` float DEFAULT NULL,
  `AID` int(12) DEFAULT NULL,
  `UserID` int(12) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for animation_review
-- ----------------------------
DROP TABLE IF EXISTS `animation_review`;
CREATE TABLE `animation_review` (
  `ID` int(12) NOT NULL AUTO_INCREMENT,
  `UserID` int(12) DEFAULT NULL,
  `AID` int(12) DEFAULT NULL,
  `content` varchar(200) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for animation_review_second
-- ----------------------------
DROP TABLE IF EXISTS `animation_review_second`;
CREATE TABLE `animation_review_second` (
  `ID` int(12) NOT NULL AUTO_INCREMENT,
  `RID` int(12) NOT NULL,
  `content` varchar(200) DEFAULT NULL,
  `UserID` int(12) DEFAULT NULL,
  `reUserID` int(12) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`,`RID`)
) ENGINE=MyISAM AUTO_INCREMENT=116 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for chat_record
-- ----------------------------
DROP TABLE IF EXISTS `chat_record`;
CREATE TABLE `chat_record` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `chatroom` int(12) DEFAULT NULL,
  `sender` int(12) DEFAULT NULL,
  `record` text,
  `createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for chat_room
-- ----------------------------
DROP TABLE IF EXISTS `chat_room`;
CREATE TABLE `chat_room` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `joiner` varchar(30) DEFAULT NULL,
  `status` int(12) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for forum_category
-- ----------------------------
DROP TABLE IF EXISTS `forum_category`;
CREATE TABLE `forum_category` (
  `ID` int(12) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for forum_reply
-- ----------------------------
DROP TABLE IF EXISTS `forum_reply`;
CREATE TABLE `forum_reply` (
  `ID` int(12) NOT NULL AUTO_INCREMENT,
  `content` text,
  `createtime` datetime DEFAULT NULL,
  `UserID` int(12) DEFAULT NULL,
  `themeID` int(12) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for forum_reply_second
-- ----------------------------
DROP TABLE IF EXISTS `forum_reply_second`;
CREATE TABLE `forum_reply_second` (
  `ID` int(12) NOT NULL AUTO_INCREMENT,
  `content` text,
  `UserID` int(12) DEFAULT NULL,
  `reUserID` int(12) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `layerid` int(12) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for forum_theme
-- ----------------------------
DROP TABLE IF EXISTS `forum_theme`;
CREATE TABLE `forum_theme` (
  `ID` int(12) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `userID` int(12) DEFAULT NULL,
  `category` int(12) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for learning_article
-- ----------------------------
DROP TABLE IF EXISTS `learning_article`;
CREATE TABLE `learning_article` (
  `ID` int(12) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `category` int(12) DEFAULT NULL,
  `picture` varchar(255) DEFAULT NULL,
  `editID` int(12) DEFAULT NULL,
  `content` text,
  `createtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `status` int(10) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for learning_category
-- ----------------------------
DROP TABLE IF EXISTS `learning_category`;
CREATE TABLE `learning_category` (
  `ID` int(12) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for notify
-- ----------------------------
DROP TABLE IF EXISTS `notify`;
CREATE TABLE `notify` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `admin` int(12) DEFAULT NULL,
  `user` int(12) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for pendinganimation
-- ----------------------------
DROP TABLE IF EXISTS `pendinganimation`;
CREATE TABLE `pendinganimation` (
  `ID` int(12) NOT NULL AUTO_INCREMENT,
  `userID` int(12) NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `content` varchar(255) DEFAULT '无',
  `address` varchar(200) DEFAULT NULL,
  `picture` varchar(200) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `category` int(12) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `ID` int(12) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `sex` int(10) DEFAULT '3',
  `email` varchar(100) NOT NULL,
  `emailshow` int(10) DEFAULT '1',
  `phone` varchar(20) DEFAULT NULL,
  `phoneshow` int(10) DEFAULT '0',
  `password` varchar(200) DEFAULT NULL,
  `picture` varchar(200) DEFAULT '/BYSJ/picture/userhead/default.jpg',
  `remarks` varchar(255) DEFAULT NULL,
  `realname` varchar(50) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  `status` int(5) DEFAULT '0' COMMENT '0-未激活，1-激活，2-冻结',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user_operation
-- ----------------------------
DROP TABLE IF EXISTS `user_operation`;
CREATE TABLE `user_operation` (
  `ID` int(12) NOT NULL AUTO_INCREMENT,
  `userid` int(12) DEFAULT NULL,
  `logintime` datetime DEFAULT NULL,
  `checksystem` datetime DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for verifying_mailbox
-- ----------------------------
DROP TABLE IF EXISTS `verifying_mailbox`;
CREATE TABLE `verifying_mailbox` (
  `ID` int(12) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) DEFAULT NULL,
  `checkcode` varchar(200) DEFAULT NULL,
  `status` int(10) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
