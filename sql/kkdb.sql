/*
Navicat MySQL Data Transfer

Source Server         : TEST
Source Server Version : 80023
Source Host           : localhost:3306
Source Database       : kkdb

Target Server Type    : MYSQL
Target Server Version : 80023
File Encoding         : 65001

Date: 2021-08-10 21:23:05
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `authority`
-- ----------------------------
DROP TABLE IF EXISTS `authority`;
CREATE TABLE `authority` (
  `aid` int NOT NULL AUTO_INCREMENT,
  `authorityType` int DEFAULT NULL,
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of authority
-- ----------------------------
INSERT INTO `authority` VALUES ('1', '0');
INSERT INTO `authority` VALUES ('2', '1');
INSERT INTO `authority` VALUES ('3', '2');

-- ----------------------------
-- Table structure for `food`
-- ----------------------------
DROP TABLE IF EXISTS `food`;
CREATE TABLE `food` (
  `fid` int NOT NULL AUTO_INCREMENT,
  `foodName` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `foodDescription` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `foodPrice` double(6,2) DEFAULT NULL,
  `foodImg` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `foodImgPath` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`fid`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of food
-- ----------------------------
INSERT INTO `food` VALUES ('1', '蟹皇堡', '这是一个蟹皇堡', '1.25', 'KrabbyPatty.png', 'images/KrabbyPatty.png');
INSERT INTO `food` VALUES ('10', '健怡可乐', '这是一份健怡可乐', '1.00', 'cola.png', 'images/cola.png');
INSERT INTO `food` VALUES ('11', '海带奶昔', '这是一份海带奶昔', '2.00', 'soda.png', 'images/soda.png');
INSERT INTO `food` VALUES ('12', '薯条', '这是一份薯条', '1.00', 'chips.png', 'images/chips.png');
INSERT INTO `food` VALUES ('13', '土豆泥', '这是一份土豆泥', '2.25', 'mashedpotatoes.png', 'images/mashedpotatoes.png');
INSERT INTO `food` VALUES ('14', '烤玉米', '这是一份烤玉米', '2.50', 'Roastedcorn,png.png', 'images/Roastedcorn,png.png');

-- ----------------------------
-- Table structure for `food_type`
-- ----------------------------
DROP TABLE IF EXISTS `food_type`;
CREATE TABLE `food_type` (
  `ftid` int NOT NULL AUTO_INCREMENT,
  `fid` int DEFAULT NULL,
  `tid` int DEFAULT NULL,
  PRIMARY KEY (`ftid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of food_type
-- ----------------------------
INSERT INTO `food_type` VALUES ('1', '1', '1');
INSERT INTO `food_type` VALUES ('9', '10', '2');
INSERT INTO `food_type` VALUES ('10', '11', '2');
INSERT INTO `food_type` VALUES ('11', '12', '3');
INSERT INTO `food_type` VALUES ('12', '13', '3');
INSERT INTO `food_type` VALUES ('13', '14', '3');

-- ----------------------------
-- Table structure for `order`
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `oid` int NOT NULL AUTO_INCREMENT,
  `uid` int DEFAULT NULL,
  `userName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `totalMoney` double(6,2) DEFAULT NULL,
  PRIMARY KEY (`oid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES ('11', '14', '珊迪', '7.75');
INSERT INTO `order` VALUES ('12', '13', '派大星', '425.00');
INSERT INTO `order` VALUES ('13', '15', '泡芙', '3.25');
INSERT INTO `order` VALUES ('14', '16', '企鹅男孩', '3.25');
INSERT INTO `order` VALUES ('15', '17', '珍珍', '19.75');
INSERT INTO `order` VALUES ('16', '18', '拉瑞', '17.00');
INSERT INTO `order` VALUES ('17', '19', '海超人', '5.75');

-- ----------------------------
-- Table structure for `order_detils`
-- ----------------------------
DROP TABLE IF EXISTS `order_detils`;
CREATE TABLE `order_detils` (
  `odid` int NOT NULL AUTO_INCREMENT,
  `oid` int DEFAULT NULL,
  `fid` int DEFAULT NULL,
  `foodName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `foodPrice` double(6,2) DEFAULT NULL,
  `orderNum` int DEFAULT NULL,
  PRIMARY KEY (`odid`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of order_detils
-- ----------------------------
INSERT INTO `order_detils` VALUES ('13', '11', '1', '蟹皇堡', '1.25', '2');
INSERT INTO `order_detils` VALUES ('14', '11', '11', '海带奶昔', '2.00', '1');
INSERT INTO `order_detils` VALUES ('15', '11', '12', '薯条', '1.00', '1');
INSERT INTO `order_detils` VALUES ('16', '11', '13', '土豆泥', '2.25', '1');
INSERT INTO `order_detils` VALUES ('17', '12', '10', '健怡可乐', '1.00', '10');
INSERT INTO `order_detils` VALUES ('18', '12', '1', '蟹皇堡', '1.25', '100');
INSERT INTO `order_detils` VALUES ('19', '12', '11', '海带奶昔', '2.00', '10');
INSERT INTO `order_detils` VALUES ('20', '12', '12', '薯条', '1.00', '100');
INSERT INTO `order_detils` VALUES ('21', '12', '14', '烤玉米', '2.50', '50');
INSERT INTO `order_detils` VALUES ('22', '12', '13', '土豆泥', '2.25', '20');
INSERT INTO `order_detils` VALUES ('23', '13', '11', '海带奶昔', '2.00', '1');
INSERT INTO `order_detils` VALUES ('24', '13', '1', '蟹皇堡', '1.25', '1');
INSERT INTO `order_detils` VALUES ('25', '14', '12', '薯条', '1.00', '1');
INSERT INTO `order_detils` VALUES ('26', '14', '10', '健怡可乐', '1.00', '1');
INSERT INTO `order_detils` VALUES ('27', '14', '1', '蟹皇堡', '1.25', '1');
INSERT INTO `order_detils` VALUES ('28', '15', '1', '蟹皇堡', '1.25', '5');
INSERT INTO `order_detils` VALUES ('29', '15', '14', '烤玉米', '2.50', '3');
INSERT INTO `order_detils` VALUES ('30', '15', '11', '海带奶昔', '2.00', '3');
INSERT INTO `order_detils` VALUES ('31', '16', '13', '土豆泥', '2.25', '5');
INSERT INTO `order_detils` VALUES ('32', '16', '10', '健怡可乐', '1.00', '2');
INSERT INTO `order_detils` VALUES ('33', '16', '1', '蟹皇堡', '1.25', '3');
INSERT INTO `order_detils` VALUES ('34', '17', '1', '蟹皇堡', '1.25', '1');
INSERT INTO `order_detils` VALUES ('35', '17', '14', '烤玉米', '2.50', '1');
INSERT INTO `order_detils` VALUES ('36', '17', '11', '海带奶昔', '2.00', '1');

-- ----------------------------
-- Table structure for `type`
-- ----------------------------
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type` (
  `tid` int NOT NULL AUTO_INCREMENT,
  `foodType` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of type
-- ----------------------------
INSERT INTO `type` VALUES ('1', '汉堡');
INSERT INTO `type` VALUES ('2', '饮料');
INSERT INTO `type` VALUES ('3', '小食');

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `userName` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `userPsd` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `sex` varchar(24) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `headImg` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `imgPath` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'test1', '123', '男', 'defaultHeadimg.png', 'images/defaultHeadimg.png');
INSERT INTO `user` VALUES ('8', 'new', '123', '男', 'defaultHeadimg.png', 'images/defaultHeadimg.png');
INSERT INTO `user` VALUES ('10', '蟹老板', '123456', '男', 'Krabs.png', 'images/Krabs.png');
INSERT INTO `user` VALUES ('11', '海绵宝宝', '123456', '男', 'Spongebob.png', 'images/Spongebob.png');
INSERT INTO `user` VALUES ('12', '章鱼哥', '123', '男', 'Squidward.png', 'images/Squidward.png');
INSERT INTO `user` VALUES ('13', '派大星', '123', '男', 'PatrickStar.png', 'images/PatrickStar.png');
INSERT INTO `user` VALUES ('14', '珊迪', '123456', '女', 'Sandy.png', 'images/Sandy.png');
INSERT INTO `user` VALUES ('15', '泡芙', '123', '女', 'puff.png', 'images/puff.png');
INSERT INTO `user` VALUES ('16', '企鹅男孩', '123', '男', 'BarnacleBoy.png', 'images/BarnacleBoy.png');
INSERT INTO `user` VALUES ('17', '珍珍', '123456', '女', 'PearlKrabs.png', 'images/PearlKrabs.png');
INSERT INTO `user` VALUES ('18', '拉瑞', '123', '男', 'lary.png', 'images/lary.png');
INSERT INTO `user` VALUES ('19', '海超人', '123', '男', 'MermaidMan.png', 'images/MermaidMan.png');

-- ----------------------------
-- Table structure for `user_authority`
-- ----------------------------
DROP TABLE IF EXISTS `user_authority`;
CREATE TABLE `user_authority` (
  `uaid` int NOT NULL AUTO_INCREMENT,
  `uid` int DEFAULT NULL,
  `aid` int DEFAULT NULL,
  PRIMARY KEY (`uaid`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of user_authority
-- ----------------------------
INSERT INTO `user_authority` VALUES ('1', '1', '1');
INSERT INTO `user_authority` VALUES ('7', '8', '3');
INSERT INTO `user_authority` VALUES ('9', '10', '1');
INSERT INTO `user_authority` VALUES ('10', '11', '2');
INSERT INTO `user_authority` VALUES ('11', '12', '2');
INSERT INTO `user_authority` VALUES ('12', '13', '3');
INSERT INTO `user_authority` VALUES ('13', '14', '3');
INSERT INTO `user_authority` VALUES ('14', '15', '3');
INSERT INTO `user_authority` VALUES ('15', '16', '3');
INSERT INTO `user_authority` VALUES ('16', '17', '3');
INSERT INTO `user_authority` VALUES ('17', '18', '3');
INSERT INTO `user_authority` VALUES ('18', '19', '3');
