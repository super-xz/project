/*
 Navicat Premium Data Transfer

 Source Server         : mydb
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : restaurant

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 22/12/2020 21:18:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `cartId` int(11) NOT NULL COMMENT '购物车id',
  `openid` int(11) NULL DEFAULT NULL COMMENT '微信用户id',
  `foodId` int(11) NULL DEFAULT NULL COMMENT '菜品id',
  `foodNumber` int(11) NULL DEFAULT NULL COMMENT '菜品数量',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格',
  `foodName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜品数量',
  PRIMARY KEY (`cartId`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `cid` int(11) NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类名',
  `storeId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商店id',
  PRIMARY KEY (`cid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '经典美食', '1710111605599569');
INSERT INTO `category` VALUES (2, '特色美食', '1710111605599569');
INSERT INTO `category` VALUES (6, '进店必试', '1710111605599569');
INSERT INTO `category` VALUES (7, '特色小炒', '1710111605599569');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `foodId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '食物id',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '评论内容',
  `comment_time` datetime(0) NULL DEFAULT NULL COMMENT '评论时间',
  `openid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '评论者id',
  `orderId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来自的订单id',
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `storeId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商店id',
  `status` tinyint(255) NULL DEFAULT NULL COMMENT '是否显示',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('17101116055995691606902406', '有弹性很美味哦', '2020-12-15 21:41:57', 'of_g344E3-j0a-wVoJaTXd8IlqR4', '81607855273', 2, '1710111605599569', 1);
INSERT INTO `comment` VALUES ('17101116055995691606902350', '清蒸的很鲜甜', '2020-12-15 21:42:42', 'of_g344E3-j0a-wVoJaTXd8IlqR4', '31607854509', 3, '1710111605599569', 1);
INSERT INTO `comment` VALUES ('17101116055995691607672750', '炸的很香', '2020-12-15 21:45:18', 'of_g344E3-j0a-wVoJaTXd8IlqR4', '21607855991', 4, '1710111605599569', 0);
INSERT INTO `comment` VALUES ('17101116055995691606903181', '黄瓜很脆哦', '2020-12-15 21:48:31', 'of_g344E3-j0a-wVoJaTXd8IlqR4', '21607855991', 5, '1710111605599569', 1);
INSERT INTO `comment` VALUES ('17101116055995691607672750', '炸丸子', '2020-12-15 23:05:27', 'of_g344E3-j0a-wVoJaTXd8IlqR4', '31607854509', 6, '1710111605599569', 1);
INSERT INTO `comment` VALUES ('17101116055995691606902406', 'jkshdkahskdjahksdhaksjhdkajshdkjashdkjashkjdahskjd', '2020-12-16 16:45:17', 'of_g344E3-j0a-wVoJaTXd8IlqR4', '21607855991', 7, '1710111605599569', 2);
INSERT INTO `comment` VALUES ('17101116055995691606902406', '蛮好吃的', '2020-12-16 16:54:41', 'of_g344E3-j0a-wVoJaTXd8IlqR4', '51608108871', 8, '1710111605599569', 1);

-- ----------------------------
-- Table structure for food
-- ----------------------------
DROP TABLE IF EXISTS `food`;
CREATE TABLE `food`  (
  `foodId` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜品id',
  `foodName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜品名称',
  `price` int(10) NULL DEFAULT NULL COMMENT '菜品价格',
  `number` int(11) NULL DEFAULT NULL COMMENT '库存数量',
  `describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述图片url',
  `discount` decimal(5, 2) NULL DEFAULT NULL COMMENT '折扣',
  `cid` int(255) NULL DEFAULT NULL COMMENT '分类',
  `imgurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片',
  `storeId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商店id',
  `sales` int(255) NULL DEFAULT NULL COMMENT '销量',
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜品状态',
  PRIMARY KEY (`foodId`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of food
-- ----------------------------
INSERT INTO `food` VALUES ('17101116055995691606463939', '螺狮粉', 10, 0, '螺蛳粉的味美还因为它有着独特的汤料。汤料由螺蛳、山奈、八角、肉桂、丁香、多种辣椒、等天然香料和味素配制而成。', 0.80, 1, 'http://www.restaurant.com/upload/food_img/20201127/afbfff4f61ec382987a93e3d03d9ad22.jpg', '1710111605599569', 7, '1');
INSERT INTO `food` VALUES ('17101116055995691606464439', '酸菜鱼', 20, 0, '酸菜鱼以草鱼为主料，配以泡菜等食材煮制而成，口味酸辣可口；鱼含丰富优质蛋白，能提供人丰富的蛋白质、矿物质等营养；酸菜中的乳酸可以促进人体对铁元素的吸收，还可以增加人的食欲。', 1.00, 2, 'http://www.restaurant.com/upload/food_img/20201127/897d7169f56af70a90e2f528ba69e5de.jpeg', '1710111605599569', 1, '1');
INSERT INTO `food` VALUES ('17101116055995691606902406', ' 红烧猪脚', 19, 0, '原料：猪脚、姜、干辣椒、豆瓣酱、冰糖粒、盐、生抽、老抽、料酒、胡椒粉、卤料包。', 1.00, 1, 'http://www.restaurant.com/upload/food_img/20201202/501d6b25f57ce21df3907ce912360569.jpg', '1710111605599569', 8, '1');
INSERT INTO `food` VALUES ('17101116055995691606902468', '萝卜酿肉', 15, 0, '原料：白萝卜、猪肉馅、香葱、大葱、白胡椒粉、姜、盐、蚝油、玉米淀粉、清水。', 1.00, 1, 'http://www.restaurant.com/upload/food_img/20201202/36d542a5f41da683ce2ae01e77ca492a.jpg', '1710111605599569', 4, '1');
INSERT INTO `food` VALUES ('17101116055995691606902218', '白灼墨鱼', 25, 0, '原料：墨鱼仔、蒜、辣椒、葱、酱油。', 1.00, 1, 'http://www.restaurant.com/upload/food_img/20201202/5894539b707665f9edcb0edee8c83871.jpg', '1710111605599569', 4, '1');
INSERT INTO `food` VALUES ('17101116055995691606902350', '清蒸鲳鱼', 25, 0, '原料：半干鲳鱼、姜、酱油。', 1.00, 1, 'http://www.restaurant.com/upload/food_img/20201202/0ffe05d13fd53ebe1d2b8e42e3a7f51b.jpg', '1710111605599569', 2, '1');
INSERT INTO `food` VALUES ('17101116055995691606902570', '火麻仁彩椒焖南瓜', 15, 0, '原料：贝贝南瓜、红椒、线椒、黄彩椒、姜末、蒜末、盐、剁椒。', 1.00, 1, 'http://www.restaurant.com/upload/food_img/20201202/cbc12173b283588c079d6102f2fb83b4.jpg', '1710111605599569', 2, '1');
INSERT INTO `food` VALUES ('17101116055995691606902669', '白菜拌乌鸡', 19, 0, '原料：鸡胸肉、白菜、香菜、胡萝卜、红椒、食盐、味精、白糖、生抽、醋、香油、大蒜。', 1.00, 2, 'http://www.restaurant.com/upload/food_img/20201202/c8383d03d17ac6fe2eab44c4d57d4597.jpg', '1710111605599569', 1, '1');
INSERT INTO `food` VALUES ('17101116055995691606902743', '火麻浇汁拌双花', 19, 0, '原料：西兰花、菜花、膳之俭火麻油、火麻仁、木耳、紫皮洋葱、盐、蚝油、生抽、辣椒油。', 1.00, 2, 'http://www.restaurant.com/upload/food_img/20201202/7bf2599c94dbee8a544f6a7be8a5695f.jpg', '1710111605599569', 2, '1');
INSERT INTO `food` VALUES ('17101116055995691606902815', '五彩小麦沙拉', 15, 0, '原料：小麦粒、烤熟的红椒、酸黄瓜、熟玉米粒、小葱、小香菜、莳萝、薄荷叶、橄榄油、浓石榴汁、盐、水果醋、柠檬汁。', 1.00, 2, 'http://www.restaurant.com/upload/food_img/20201202/fd0095e6bea3f4c28fe8070b1ef7cc55.jpg', '1710111605599569', 2, '1');
INSERT INTO `food` VALUES ('17101116055995691606903181', '拌黄瓜花生米', 20, 0, '原料：花生米、黄瓜、胡萝卜、香菜、小米椒、白糖、醋、生抽、盐。', 1.00, 2, 'http://www.restaurant.com/upload/food_img/20201202/31efdcb69d5e897aa609d09df646a4b0.jpg', '1710111605599569', 2, '1');
INSERT INTO `food` VALUES ('17101116055995691607672750', '炸萝卜丸子', 16, 0, '原料：白萝卜、胡萝卜、香菜、大葱、生姜、鸡蛋、面粉、五香粉、胡椒粉、鸡精、盐、玉米油。', 0.90, 6, 'http://www.restaurant.com/upload/food_img/20201211/bb57cd4071e9826ae35dce8e5b49d056.jpg', '1710111605599569', 5, '1');

-- ----------------------------
-- Table structure for lunbo
-- ----------------------------
DROP TABLE IF EXISTS `lunbo`;
CREATE TABLE `lunbo`  (
  `pid` int(11) NOT NULL AUTO_INCREMENT COMMENT '图片id',
  `pic` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片地址',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '跳转链接',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`pid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lunbo
-- ----------------------------
INSERT INTO `lunbo` VALUES (1, 'http://www.wxapp.com/upload/image/20200420/161f862470343552245e581035b02b4b.jpg', '../index/index', '哈哈哈', '1');
INSERT INTO `lunbo` VALUES (2, 'http://www.wxapp.com/upload/image/20200423/2a638b6fef2f44695e3457d8fc9295cb.jpg', '../index/index', '222', '1');

-- ----------------------------
-- Table structure for meal_number
-- ----------------------------
DROP TABLE IF EXISTS `meal_number`;
CREATE TABLE `meal_number`  (
  `storeId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商店id',
  `no` int(11) NULL DEFAULT NULL COMMENT '取餐号',
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日期'
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of meal_number
-- ----------------------------
INSERT INTO `meal_number` VALUES ('1710111605599569', 13, '2020-12-08 00:00:00');
INSERT INTO `meal_number` VALUES ('1710111605599569', 2, '2020-12-09 00:00:00');
INSERT INTO `meal_number` VALUES ('1710111605599569', 5, '2020-12-11 00:00:00');
INSERT INTO `meal_number` VALUES ('1710111605599569', 12, '2020-12-13');
INSERT INTO `meal_number` VALUES ('1710111605599569', 1, '2020-12-15');
INSERT INTO `meal_number` VALUES ('1710111605599569', 1, '2020-12-16');
INSERT INTO `meal_number` VALUES ('1710111605599569', 1, '2020-12-17');
INSERT INTO `meal_number` VALUES ('1710111605599569', 3, '2020-12-21');

-- ----------------------------
-- Table structure for order_main
-- ----------------------------
DROP TABLE IF EXISTS `order_main`;
CREATE TABLE `order_main`  (
  `orderId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单id',
  `sellerId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '卖家id',
  `buyerId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '买家id',
  `time` datetime(0) NOT NULL COMMENT '创建时间',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单状态',
  `total` decimal(10, 2) NULL DEFAULT NULL COMMENT '总金额',
  `No` int(11) NULL DEFAULT NULL COMMENT '取餐号',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注'
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_main
-- ----------------------------
INSERT INTO `order_main` VALUES ('31607854509', '1710111605599569', 'of_g344E3-j0a-wVoJaTXd8IlqR4', '2020-12-13 18:16:43', '2', 39.40, 4, '');
INSERT INTO `order_main` VALUES ('61607854654', '1710111605599569', 'of_g344E3-j0a-wVoJaTXd8IlqR4', '2020-12-13 06:17:34', '2', 19.00, 5, '17');
INSERT INTO `order_main` VALUES ('71607854912', '1710111605599569', 'of_g344E3-j0a-wVoJaTXd8IlqR4', '2020-12-13 06:21:52', '2', 20.00, 6, '');
INSERT INTO `order_main` VALUES ('61607855047', '1710111605599569', 'of_g344E3-j0a-wVoJaTXd8IlqR4', '2020-12-13 06:24:07', '2', 9.00, 7, '');
INSERT INTO `order_main` VALUES ('81607855273', '1710111605599569', 'of_g344E3-j0a-wVoJaTXd8IlqR4', '2020-12-13 06:27:53', '1', 19.00, 8, '');
INSERT INTO `order_main` VALUES ('51607855278', '1710111605599569', 'of_g344E3-j0a-wVoJaTXd8IlqR4', '2020-12-13 06:27:58', '1', 25.00, 9, '');
INSERT INTO `order_main` VALUES ('41607855404', '1710111605599569', 'of_g344E3-j0a-wVoJaTXd8IlqR4', '2020-12-13 06:30:04', '1', 29.40, 10, '');
INSERT INTO `order_main` VALUES ('21607855991', '1710111605599569', 'of_g344E3-j0a-wVoJaTXd8IlqR4', '2020-12-13 06:39:51', '2', 215.40, 11, '');
INSERT INTO `order_main` VALUES ('41607856586', '1710111605599569', 'of_g344E3-j0a-wVoJaTXd8IlqR4', '2020-12-13 18:49:46', '1', 19.00, 12, '');
INSERT INTO `order_main` VALUES ('71608020681', '1710111605599569', 'of_g344E3-j0a-wVoJaTXd8IlqR4', '2020-12-15 16:24:41', '1', 15.00, 1, '12-15');
INSERT INTO `order_main` VALUES ('51608108871', '1710111605599569', 'of_g344E3-j0a-wVoJaTXd8IlqR4', '2020-12-16 16:54:31', '1', 19.00, 1, '再来一单哦');
INSERT INTO `order_main` VALUES ('41608193042', '1710111605599569', 'of_g344E3-j0a-wVoJaTXd8IlqR4', '2020-12-17 16:17:22', '1', 40.00, 1, '');
INSERT INTO `order_main` VALUES ('21608551771', '1710111605599569', 'of_g344E3-j0a-wVoJaTXd8IlqR4', '2020-12-21 19:56:11', '1', 28.00, 1, 'asdas');
INSERT INTO `order_main` VALUES ('71608552199', '1710111605599569', 'of_g344E3-j0a-wVoJaTXd8IlqR4', '2020-12-21 20:03:19', '1', 28.00, 2, '');
INSERT INTO `order_main` VALUES ('11608552419', '1710111605599569', 'of_g344E3-j0a-wVoJaTXd8IlqR4', '2020-12-21 20:06:59', '1', 44.00, 3, '');

-- ----------------------------
-- Table structure for order_vice
-- ----------------------------
DROP TABLE IF EXISTS `order_vice`;
CREATE TABLE `order_vice`  (
  `order_main` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单主表id',
  `foodId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜品id',
  `foodName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜名',
  `foodNumber` int(11) NULL DEFAULT NULL COMMENT '菜品数量',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格',
  `picture` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片url',
  `discount` decimal(5, 2) NULL DEFAULT NULL COMMENT '折扣',
  `comment` tinyint(255) NULL DEFAULT NULL COMMENT '0否1是'
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_vice
-- ----------------------------
INSERT INTO `order_vice` VALUES ('41607856586', '17101116055995691606902406', ' 红烧猪脚', 1, 19.00, 'http://www.restaurant.com/upload/food_img/20201202/501d6b25f57ce21df3907ce912360569.jpg', 1.00, 1);
INSERT INTO `order_vice` VALUES ('21607855991', '17101116055995691607672750', '炸萝卜丸子', 1, 16.00, 'http://www.restaurant.com/upload/food_img/20201211/bb57cd4071e9826ae35dce8e5b49d056.jpg', 0.90, 1);
INSERT INTO `order_vice` VALUES ('21607855991', '17101116055995691606903181', '拌黄瓜花生米', 1, 20.00, 'http://www.restaurant.com/upload/food_img/20201202/31efdcb69d5e897aa609d09df646a4b0.jpg', 1.00, 1);
INSERT INTO `order_vice` VALUES ('21607855991', '17101116055995691606902815', '五彩小麦沙拉', 1, 15.00, 'http://www.restaurant.com/upload/food_img/20201202/fd0095e6bea3f4c28fe8070b1ef7cc55.jpg', 1.00, 0);
INSERT INTO `order_vice` VALUES ('21607855991', '17101116055995691606902743', '火麻浇汁拌双花', 1, 19.00, 'http://www.restaurant.com/upload/food_img/20201202/7bf2599c94dbee8a544f6a7be8a5695f.jpg', 1.00, 0);
INSERT INTO `order_vice` VALUES ('21607855991', '17101116055995691606902669', '白菜拌乌鸡', 1, 19.00, 'http://www.restaurant.com/upload/food_img/20201202/c8383d03d17ac6fe2eab44c4d57d4597.jpg', 1.00, 0);
INSERT INTO `order_vice` VALUES ('21607855991', '17101116055995691606464439', '酸菜鱼', 1, 20.00, 'http://www.restaurant.com/upload/food_img/20201127/897d7169f56af70a90e2f528ba69e5de.jpeg', 1.00, 0);
INSERT INTO `order_vice` VALUES ('21607855991', '17101116055995691606902570', '火麻仁彩椒焖南瓜', 1, 15.00, 'http://www.restaurant.com/upload/food_img/20201202/cbc12173b283588c079d6102f2fb83b4.jpg', 1.00, 0);
INSERT INTO `order_vice` VALUES ('21607855991', '17101116055995691606902350', '清蒸鲳鱼', 1, 25.00, 'http://www.restaurant.com/upload/food_img/20201202/0ffe05d13fd53ebe1d2b8e42e3a7f51b.jpg', 1.00, 0);
INSERT INTO `order_vice` VALUES ('21607855991', '17101116055995691606902218', '白灼墨鱼', 1, 25.00, 'http://www.restaurant.com/upload/food_img/20201202/5894539b707665f9edcb0edee8c83871.jpg', 1.00, 0);
INSERT INTO `order_vice` VALUES ('21607855991', '17101116055995691606902468', '萝卜酿肉', 1, 15.00, 'http://www.restaurant.com/upload/food_img/20201202/36d542a5f41da683ce2ae01e77ca492a.jpg', 1.00, 0);
INSERT INTO `order_vice` VALUES ('21607855991', '17101116055995691606902406', ' 红烧猪脚', 1, 19.00, 'http://www.restaurant.com/upload/food_img/20201202/501d6b25f57ce21df3907ce912360569.jpg', 1.00, 1);
INSERT INTO `order_vice` VALUES ('21607855991', '17101116055995691606463939', '螺狮粉', 1, 9.00, 'http://www.restaurant.com/upload/food_img/20201127/afbfff4f61ec382987a93e3d03d9ad22.jpg', 1.00, 0);
INSERT INTO `order_vice` VALUES ('41607855404', '17101116055995691607672750', '炸萝卜丸子', 1, 16.00, 'http://www.restaurant.com/upload/food_img/20201211/bb57cd4071e9826ae35dce8e5b49d056.jpg', 0.90, 0);
INSERT INTO `order_vice` VALUES ('41607855404', '17101116055995691606902468', '萝卜酿肉', 1, 15.00, 'http://www.restaurant.com/upload/food_img/20201202/36d542a5f41da683ce2ae01e77ca492a.jpg', 1.00, 0);
INSERT INTO `order_vice` VALUES ('51607855278', '17101116055995691606902218', '白灼墨鱼', 1, 25.00, 'http://www.restaurant.com/upload/food_img/20201202/5894539b707665f9edcb0edee8c83871.jpg', 1.00, 0);
INSERT INTO `order_vice` VALUES ('61607854654', '17101116055995691606902743', '火麻浇汁拌双花', 1, 19.00, 'http://www.restaurant.com/upload/food_img/20201202/7bf2599c94dbee8a544f6a7be8a5695f.jpg', 1.00, 0);
INSERT INTO `order_vice` VALUES ('31607854509', '17101116055995691607672750', '炸萝卜丸子', 1, 16.00, 'http://www.restaurant.com/upload/food_img/20201211/bb57cd4071e9826ae35dce8e5b49d056.jpg', 0.90, 1);
INSERT INTO `order_vice` VALUES ('31607854509', '17101116055995691606902350', '清蒸鲳鱼', 1, 25.00, 'http://www.restaurant.com/upload/food_img/20201202/0ffe05d13fd53ebe1d2b8e42e3a7f51b.jpg', 1.00, 1);
INSERT INTO `order_vice` VALUES ('81607855273', '17101116055995691606902406', ' 红烧猪脚', 1, 19.00, 'http://www.restaurant.com/upload/food_img/20201202/501d6b25f57ce21df3907ce912360569.jpg', 1.00, 1);
INSERT INTO `order_vice` VALUES ('71607854912', '17101116055995691606903181', '拌黄瓜花生米', 1, 20.00, 'http://www.restaurant.com/upload/food_img/20201202/31efdcb69d5e897aa609d09df646a4b0.jpg', 1.00, 0);
INSERT INTO `order_vice` VALUES ('61607855047', '17101116055995691606463939', '螺狮粉', 1, 9.00, 'http://www.restaurant.com/upload/food_img/20201127/afbfff4f61ec382987a93e3d03d9ad22.jpg', 1.00, 0);
INSERT INTO `order_vice` VALUES ('71608020681', '17101116055995691606902815', '五彩小麦沙拉', 1, 15.00, 'http://www.restaurant.com/upload/food_img/20201202/fd0095e6bea3f4c28fe8070b1ef7cc55.jpg', 1.00, 0);
INSERT INTO `order_vice` VALUES ('51608108871', '17101116055995691606902406', ' 红烧猪脚', 1, 19.00, 'http://www.restaurant.com/upload/food_img/20201202/501d6b25f57ce21df3907ce912360569.jpg', 1.00, 1);
INSERT INTO `order_vice` VALUES ('41608193042', '17101116055995691606902218', '白灼墨鱼', 1, 25.00, 'http://www.restaurant.com/upload/food_img/20201202/5894539b707665f9edcb0edee8c83871.jpg', 1.00, 0);
INSERT INTO `order_vice` VALUES ('41608193042', '17101116055995691606902468', '萝卜酿肉', 1, 15.00, 'http://www.restaurant.com/upload/food_img/20201202/36d542a5f41da683ce2ae01e77ca492a.jpg', 1.00, 0);
INSERT INTO `order_vice` VALUES ('21608551771', '17101116055995691606463939', '螺狮粉', 1, 9.00, 'http://www.restaurant.com/upload/food_img/20201127/afbfff4f61ec382987a93e3d03d9ad22.jpg', 1.00, 0);
INSERT INTO `order_vice` VALUES ('21608551771', '17101116055995691606902406', ' 红烧猪脚', 1, 19.00, 'http://www.restaurant.com/upload/food_img/20201202/501d6b25f57ce21df3907ce912360569.jpg', 1.00, 0);
INSERT INTO `order_vice` VALUES ('71608552199', '17101116055995691606463939', '螺狮粉', 1, 9.00, 'http://www.restaurant.com/upload/food_img/20201127/afbfff4f61ec382987a93e3d03d9ad22.jpg', 1.00, 0);
INSERT INTO `order_vice` VALUES ('71608552199', '17101116055995691606902406', ' 红烧猪脚', 1, 19.00, 'http://www.restaurant.com/upload/food_img/20201202/501d6b25f57ce21df3907ce912360569.jpg', 1.00, 0);
INSERT INTO `order_vice` VALUES ('11608552419', '17101116055995691606902406', ' 红烧猪脚', 1, 19.00, 'http://www.restaurant.com/upload/food_img/20201202/501d6b25f57ce21df3907ce912360569.jpg', 1.00, 0);
INSERT INTO `order_vice` VALUES ('11608552419', '17101116055995691606902218', '白灼墨鱼', 1, 25.00, 'http://www.restaurant.com/upload/food_img/20201202/5894539b707665f9edcb0edee8c83871.jpg', 1.00, 0);

-- ----------------------------
-- Table structure for store
-- ----------------------------
DROP TABLE IF EXISTS `store`;
CREATE TABLE `store`  (
  `storeId` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商店id',
  `storename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商店名称',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所在城市',
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地理位置',
  `city_j` decimal(65, 5) NULL DEFAULT NULL COMMENT '经度',
  `city_w` decimal(65, 5) NULL DEFAULT NULL COMMENT '维度',
  `store_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '默认店铺头像',
  `store_status` tinyint(255) NULL DEFAULT NULL COMMENT '店铺状态',
  PRIMARY KEY (`storeId`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of store
-- ----------------------------
INSERT INTO `store` VALUES ('1710111605599571', '超级烧仙草3', '广州市', '从化华软店', 113.58660, 23.54835, '', 0);
INSERT INTO `store` VALUES ('1710111605599569', '返寻味', '广州市', '从化华软店', 113.58660, 23.54835, 'http://www.restaurant.com/upload/store_head/20201217/e1a58df29e661ae8b0e1b3fe80393b1f.jpg', 1);
INSERT INTO `store` VALUES ('1710111605599570', '超级烧仙草2', '广州市', '从化华软店', 113.58660, 23.54835, '', 0);

-- ----------------------------
-- Table structure for store_apply
-- ----------------------------
DROP TABLE IF EXISTS `store_apply`;
CREATE TABLE `store_apply`  (
  `applyId` int(11) NOT NULL AUTO_INCREMENT COMMENT '操作id',
  `storeId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商店id',
  `storename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商店名称',
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核状态',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所在城市',
  `city_j` float(255, 0) NULL DEFAULT NULL COMMENT '经度',
  `city_w` float(255, 0) NULL DEFAULT NULL COMMENT '维度',
  `id_card` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身份证号码',
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'xx-xx店',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '申请人账号',
  PRIMARY KEY (`applyId`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of store_apply
-- ----------------------------
INSERT INTO `store_apply` VALUES (1, '1710111605599569', '超级烧仙草', '3', '许震', '13640001474', '广州', 113, 23, '440229199811171011', '从化华软店', 'xuzhen');
INSERT INTO `store_apply` VALUES (2, '1710111605599570', '超级烧仙草', '3', '许雨晨', '13640001474', '广州', 113, 23, '440229199811171011', '从化华软店', 'admin');
INSERT INTO `store_apply` VALUES (3, '1710111605599571', '超级烧仙草', '3', '许雨辰', '13640001474', '广州', 113, 23, '440229199811171011', '从化华软店', 'xuzhen1');
INSERT INTO `store_apply` VALUES (4, '2010251606630749', '桂花坊', '1', '吴锦豪', '12354997866', '广州', 113, 214, '440229199811201025', '从化华软店', 'xuzhen2');

-- ----------------------------
-- Table structure for storeadmin
-- ----------------------------
DROP TABLE IF EXISTS `storeadmin`;
CREATE TABLE `storeadmin`  (
  `storeId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商店id',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '账号',
  `pwd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `id_card` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `limited` int(255) NULL DEFAULT NULL COMMENT '权限'
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of storeadmin
-- ----------------------------
INSERT INTO `storeadmin` VALUES ('1710111605599569', 'xuzhen', '199809', '13640001474', '440229199811171011', 2);
INSERT INTO `storeadmin` VALUES ('1710111605599570', 'admin', '123', NULL, '440229199811171011', 1);
INSERT INTO `storeadmin` VALUES ('1710111605599571', 'xuzhen1', '123', '', '440229199811171011', 2);
INSERT INTO `storeadmin` VALUES (NULL, 'xuzhen2', '123', '13435225899', NULL, NULL);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `openid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `wxname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `head` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('of_g344E3-j0a-wVoJaTXd8IlqR4', 'super. 🐋', 'https://thirdwx.qlogo.cn/mmopen/vi_32/g70JffkvicdF6t0zm1tmNWdkBfib7ibDaFiaEojH3Kiaf5yO7avjB3T05NVu500MwoOrHnEPh4AuCF1cRFeMcmh2DMg/132', NULL);

SET FOREIGN_KEY_CHECKS = 1;
