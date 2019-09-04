/*
Navicat MySQL Data Transfer

Source Server         : bendi
Source Server Version : 50553
Source Host           : 127.0.0.1:3306
Source Database       : shop

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2019-09-03 14:50:48
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sh_attribute
-- ----------------------------
DROP TABLE IF EXISTS `sh_attribute`;
CREATE TABLE `sh_attribute` (
  `attr_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` tinyint(4) DEFAULT NULL,
  `attr_name` varchar(30) DEFAULT '',
  `attr_type` tinyint(4) DEFAULT '0' COMMENT '0-唯一属性，1-单选属性',
  `attr_input_type` tinyint(4) DEFAULT '0' COMMENT '0-手工输入，1-列表选择',
  `attr_values` varchar(255) DEFAULT '',
  `create_time` int(11) DEFAULT '0',
  `update_time` int(11) DEFAULT '0',
  PRIMARY KEY (`attr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sh_attribute
-- ----------------------------
INSERT INTO `sh_attribute` VALUES ('1', '1', '屏幕尺寸', '0', '0', '', '1545376388', '1545376388');
INSERT INTO `sh_attribute` VALUES ('2', '1', '前置像素', '0', '1', '800px|1500px|3000px', '1545376425', '1545376425');
INSERT INTO `sh_attribute` VALUES ('3', '1', '内存', '1', '0', '', '1545376442', '1545376442');
INSERT INTO `sh_attribute` VALUES ('4', '1', '颜色', '1', '1', '黑色|白色|土豪金', '1545376464', '1545376464');
INSERT INTO `sh_attribute` VALUES ('5', '2', '进行方式', '1', '1', '自然吸气|涡轮增压', '1545376506', '1545376506');
INSERT INTO `sh_attribute` VALUES ('6', '2', '驱动方式', '0', '0', '', '1545376526', '1545376526');

-- ----------------------------
-- Table structure for sh_auth
-- ----------------------------
DROP TABLE IF EXISTS `sh_auth`;
CREATE TABLE `sh_auth` (
  `auth_id` int(11) NOT NULL AUTO_INCREMENT,
  `auth_name` varchar(40) DEFAULT '',
  `auth_c` varchar(40) DEFAULT '',
  `auth_a` varchar(40) DEFAULT '',
  `pid` int(11) DEFAULT '0',
  `create_time` int(11) DEFAULT '0',
  `update_time` int(11) DEFAULT '0',
  PRIMARY KEY (`auth_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sh_auth
-- ----------------------------
INSERT INTO `sh_auth` VALUES ('1', '权限管理', '', '', '0', '1545115628', '1545115628');
INSERT INTO `sh_auth` VALUES ('2', '权限列表', 'auth', 'index', '1', '1545115657', '1545115657');
INSERT INTO `sh_auth` VALUES ('3', '添加权限', 'auth', 'add', '1', '1545115673', '1545115673');
INSERT INTO `sh_auth` VALUES ('4', '用户管理', '', '', '0', '1545115683', '1545115683');
INSERT INTO `sh_auth` VALUES ('5', '添加用户', 'user', 'add', '4', '1545115697', '1545115697');
INSERT INTO `sh_auth` VALUES ('6', '用户列表', 'user', 'index', '4', '1545115714', '1545115714');
INSERT INTO `sh_auth` VALUES ('7', '用户编辑', 'user', 'upd', '6', '1545115737', '1545115737');
INSERT INTO `sh_auth` VALUES ('8', '用户删除', 'user', 'del', '6', '1545115756', '1545115756');
INSERT INTO `sh_auth` VALUES ('9', '权限编辑', 'auth', 'upd', '2', '0', '0');
INSERT INTO `sh_auth` VALUES ('10', '权限删除', 'auth', 'del', '2', '0', '0');
INSERT INTO `sh_auth` VALUES ('11', '类型管理', '', '', '0', '1545287766', '1545287766');
INSERT INTO `sh_auth` VALUES ('12', '类型列表', 'type', 'index', '11', '1545287789', '1545287789');
INSERT INTO `sh_auth` VALUES ('13', '添加类型', 'type', 'add', '11', '1545287810', '1545287810');
INSERT INTO `sh_auth` VALUES ('14', '属性管理', '', '', '0', '1545291190', '1545291190');
INSERT INTO `sh_auth` VALUES ('15', '添加属性', 'attribute', 'add', '14', '1545291237', '1545291237');
INSERT INTO `sh_auth` VALUES ('16', '属性列表', 'attribute', 'index', '14', '1545291259', '1545291259');
INSERT INTO `sh_auth` VALUES ('17', '分类管理', '', '', '0', '1545297522', '1545297597');
INSERT INTO `sh_auth` VALUES ('18', '分类列表', 'category', 'index', '17', '1545297560', '1545297560');
INSERT INTO `sh_auth` VALUES ('19', '添加分类', 'category', 'add', '17', '1545297579', '1545297579');
INSERT INTO `sh_auth` VALUES ('20', '商品管理', '', '', '0', '1545356700', '1545356700');
INSERT INTO `sh_auth` VALUES ('21', '商品列表', 'goods', 'index', '20', '1545356720', '1545356720');
INSERT INTO `sh_auth` VALUES ('22', '添加商品', 'goods', 'add', '20', '1545356735', '1545356735');
INSERT INTO `sh_auth` VALUES ('23', '订单管理', '', '', '0', '1545882226', '1545882226');
INSERT INTO `sh_auth` VALUES ('24', '订单列表', 'Order', 'index', '23', '1545882244', '1545882244');
INSERT INTO `sh_auth` VALUES ('25', '商品回收站', 'goods', 'recycle', '20', '1545900293', '1545900293');

-- ----------------------------
-- Table structure for sh_cart
-- ----------------------------
DROP TABLE IF EXISTS `sh_cart`;
CREATE TABLE `sh_cart` (
  `cart_id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) DEFAULT '0',
  `goods_attr_ids` varchar(80) DEFAULT '',
  `goods_number` int(11) DEFAULT '0',
  `member_id` int(11) DEFAULT '0',
  PRIMARY KEY (`cart_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sh_cart
-- ----------------------------

-- ----------------------------
-- Table structure for sh_category
-- ----------------------------
DROP TABLE IF EXISTS `sh_category`;
CREATE TABLE `sh_category` (
  `cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `cat_name` varchar(40) DEFAULT '',
  `pid` smallint(6) DEFAULT '0',
  `is_show` tinyint(4) DEFAULT '1' COMMENT '1-显示 0-不显示',
  `create_time` int(11) DEFAULT '0',
  `update_time` int(11) DEFAULT '0',
  PRIMARY KEY (`cat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sh_category
-- ----------------------------
INSERT INTO `sh_category` VALUES ('1', '国产手机', '0', '1', '1545298236', '1545298236');
INSERT INTO `sh_category` VALUES ('2', '国外手机', '0', '1', '1545298286', '1545298286');
INSERT INTO `sh_category` VALUES ('3', '小米', '1', '1', '1545298296', '1545298296');
INSERT INTO `sh_category` VALUES ('4', '华为', '1', '1', '1545298315', '1545298315');
INSERT INTO `sh_category` VALUES ('5', '苹果', '2', '1', '1545298326', '1545298326');
INSERT INTO `sh_category` VALUES ('6', '三星', '2', '0', '1545298942', '1545298942');
INSERT INTO `sh_category` VALUES ('7', '红米', '3', '1', '1545528814', '1545528814');
INSERT INTO `sh_category` VALUES ('8', '黑米', '3', '1', '1545528825', '1545528825');
INSERT INTO `sh_category` VALUES ('9', '手机配件', '0', '1', '1545528841', '1545528841');
INSERT INTO `sh_category` VALUES ('10', '玩具乐器', '0', '1', '1545528871', '1545528871');

-- ----------------------------
-- Table structure for sh_goods
-- ----------------------------
DROP TABLE IF EXISTS `sh_goods`;
CREATE TABLE `sh_goods` (
  `goods_id` int(11) NOT NULL AUTO_INCREMENT,
  `goods_name` varchar(40) DEFAULT '',
  `goods_sn` varchar(150) DEFAULT '',
  `goods_price` decimal(10,2) DEFAULT NULL COMMENT 'decimal(10,2)',
  `goods_number` int(11) DEFAULT '0',
  `type_id` smallint(6) DEFAULT '0',
  `cat_id` smallint(6) DEFAULT '0',
  `goods_img` text,
  `goods_middle` text,
  `goods_thumb` text,
  `is_delete` tinyint(4) DEFAULT '0' COMMENT '是否在回站 0-不在回收站 1-在回收站',
  `is_sale` tinyint(4) DEFAULT '1' COMMENT '默认为1： 0-未上架 1-已上架',
  `is_new` tinyint(4) DEFAULT '1' COMMENT '默认为1： 0-不是新品 1-是新品',
  `is_best` tinyint(4) DEFAULT '1' COMMENT '默认为1： 0-不是推荐 1-是推荐',
  `is_hot` tinyint(4) DEFAULT '1' COMMENT '默认为1： 0-不是热卖 1-是热卖商品',
  `goods_desc` text,
  `create_time` int(11) DEFAULT '0',
  `update_time` int(11) DEFAULT '0',
  PRIMARY KEY (`goods_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sh_goods
-- ----------------------------
INSERT INTO `sh_goods` VALUES ('1', 'iphonexxxxxxx', 'sn_15453831125c1cacc859c9f', '9999.00', '6726659', '1', '5', '[\"20181221\\/e68ef4df4b32e6edf99cc4bc5b23c1fb.jpg\",\"20190106\\/5e8846fb009525450286cb0bad09329e.jpg\",\"20190106\\/cbc59e21db53e6b918d44772f5d15800.jpg\"]', '[\"20190106\\/middle_5e8846fb009525450286cb0bad09329e.jpg\",\"20190106\\/middle_cbc59e21db53e6b918d44772f5d15800.jpg\",\"20181221\\/middle_e68ef4df4b32e6edf99cc4bc5b23c1fb.jpg\"]', '[\"20190106\\/thumb_5e8846fb009525450286cb0bad09329e.jpg\",\"20190106\\/thumb_cbc59e21db53e6b918d44772f5d15800.jpg\",\"20181221\\/thumb_e68ef4df4b32e6edf99cc4bc5b23c1fb.jpg\"]', '0', '1', '0', '1', '1', '<ul id=\"parameter-brand\" class=\"p-parameter-list list-paddingleft-2\" style=\"list-style-type: none;\"><li><p>品牌：&nbsp;<a href=\"https://list.jd.com/list.html?cat=9987,653,655&ev=exbrand_14026\" clstag=\"shangpin|keycount|product|pinpai_1\" target=\"_blank\" style=\"margin: 0px; padding: 0px; color: rgb(94, 105, 173); text-decoration-line: none;\">Apple</a></p></li><li><p>商品名称：AppleiPhone X</p></li><li><p>商品编号：16580068432</p></li><li><p>店铺：&nbsp;<a href=\"https://xslsj.jd.com/\" target=\"_blank\" style=\"margin: 0px; padding: 0px; color: rgb(94, 105, 173); text-decoration-line: none;\">新松联手机旗舰店</a></p></li><li><p>商品毛重：500.00g</p></li><li><p>多卡支持：单卡单待</p></li><li><p>屏幕配置：异形屏</p></li><li><p>拍照特点：后置双摄像头</p></li><li><p>后置摄像头像素：1200万-1999万</p></li><li><p>网络制式：4G LTE全网通</p></li><li><p>电池容量：2000mAh-2999mAh</p></li><li><p>前置摄像头像素：500万-799万</p></li><li><p>4G LTE网络特性：其他</p></li></ul><p class=\"more-par\" style=\"margin-top: -5px; margin-bottom: 0px; padding: 0px 20px 0px 0px; text-align: right;\"><a href=\"https://item.jd.com/16580068432.html?jd_pop=fa22a311-6c01-434a-b1d2-108604906aad&abt=0#product-detail\" class=\"J-more-param\" style=\"margin: 0px; padding: 0px; color: rgb(0, 90, 160); text-decoration-line: none;\">更多参数<span class=\"txt-arr\">&gt;&gt;</span></a></p><p style=\"margin-top: 0px; margin-bottom: 0px; padding: 0px;\"><img src=\"/ueditor/php/upload/image/20181221/1545383098333281.jpg\" width=\"990\" height=\"2352\" usemap=\"#Map3\" style=\"margin: 0px; padding: 0px; border: 0px; vertical-align: middle;\"/></p><p><br/></p>', '1545383112', '1546767819');
INSERT INTO `sh_goods` VALUES ('2', '华为p20', 'sn_15453832255c1cad39a5f40', '4500.00', '522', '1', '4', '[\"20181221\\/1d9c898977a54b40dff15580f816352c.jpg\",\"20181221\\/6adf8f0cbd86692260b214e3a6928432.jpg\",\"20181221\\/a17a4e486d0dd3d3e1d5fb5d30b43f45.jpg\"]', '[\"20181221\\/middle_1d9c898977a54b40dff15580f816352c.jpg\",\"20181221\\/middle_6adf8f0cbd86692260b214e3a6928432.jpg\",\"20181221\\/middle_a17a4e486d0dd3d3e1d5fb5d30b43f45.jpg\"]', '[\"20181221\\/thumb_1d9c898977a54b40dff15580f816352c.jpg\",\"20181221\\/thumb_6adf8f0cbd86692260b214e3a6928432.jpg\",\"20181221\\/thumb_a17a4e486d0dd3d3e1d5fb5d30b43f45.jpg\"]', '0', '1', '1', '1', '1', '<ul class=\"parameter2 p-parameter-list list-paddingleft-2\" style=\"list-style-type: none;\"><li><p>商品名称：华为P20</p></li><li><p>商品编号：7321794</p></li><li><p>商品毛重：480.00g</p></li><li><p>商品产地：中国大陆</p></li><li><p>多卡支持：双卡双待单4G</p></li><li><p>机身厚度：薄（7mm-8.5mm）</p></li><li><p>拍照特点：智能拍照</p></li><li><p>电池容量：3000mAh-3999mAh</p></li><li><p>热点：人工智能，人脸识别，快速充电</p></li><li><p>运行内存：6GB</p></li><li><p>网络制式：4G LTE全网通</p></li><li><p>游戏配置：游戏模式</p></li><li><p>屏幕配置：符合全面屏比例</p></li><li><p>后置摄像头像素：2000万及以上</p></li><li><p>机身内存：64GB</p></li><li><p>系统：安卓（Android）</p></li></ul><p class=\"more-par\" style=\"margin-top: -5px; margin-bottom: 0px; padding: 0px 20px 0px 0px; text-align: right;\"><a href=\"https://item.jd.com/7321794.html#product-detail\" class=\"J-more-param\" style=\"margin: 0px; padding: 0px; color: rgb(0, 90, 160); text-decoration-line: none;\">更多参数<span class=\"txt-arr\">&gt;&gt;</span></a></p><p><img width=\"750\" height=\"223\" usemap=\"#Mapabcdgtb\" border=\"0\" alt=\"\" class=\"\" src=\"/ueditor/php/upload/image/20181221/1545383215224625.jpg\" style=\"margin: 0px; padding: 0px; border: 0px; vertical-align: middle;\"/><map name=\"Mapabcdgtb\"><area shape=\"rect\" coords=\"6,6,372,125\" href=\"https://shouji.jd.com/\" target=\"_blank\"/><area shape=\"rect\" coords=\"378,7,746,122\" href=\"https://sale.jd.com/act/WX2fhkEvletpdM.html\" target=\"_blank\"/><area shape=\"rect\" coords=\"5,128,188,218\" href=\"https://sale.jd.com/act/oMHT5c7gAznJ.html\" target=\"_blank\"/><area shape=\"rect\" coords=\"192,128,373,220\" href=\"https://phone.jd.com/\" target=\"_blank\"/><area shape=\"rect\" coords=\"379,128,563,220\" href=\"https://wt.jd.com/\" target=\"_blank\"/><area shape=\"rect\" coords=\"566,129,745,219\" href=\"https://sale.jd.com/act/7lAdi60QwSbs.html\" target=\"_blank\"/></map></p><p><br/><img alt=\"\" width=\"750\" height=\"332\" border=\"0\" usemap=\"#Map\" class=\"\" src=\"/ueditor/php/upload/image/20181221/1545383216124366.jpg\" style=\"margin: 0px; padding: 0px; border: 0px; vertical-align: middle;\"/><map name=\"Map\"><area shape=\"rect\" coords=\"5,4,743,324\" href=\"https://item.jd.com/100001048716.html\" target=\"_new\"/></map><img alt=\"\" usemap=\"#Map12212121\" border=\"0\" class=\"\" src=\"/ueditor/php/upload/image/20181221/1545383217121577.jpg\" style=\"margin: 0px; padding: 0px; border: 0px; vertical-align: middle;\"/></p><p><br/></p>', '1545383225', '1545383225');
INSERT INTO `sh_goods` VALUES ('3', 'vivo9', 'sn_15455537265c1f473e90019', '64654.00', '129', '1', '1', '[\"20181223\\/6c8b1b2c89ef29d027b7e7efa7dd10ea.jpg\",\"20181223\\/7c90f584ffbc59302a3714cd81ef90e7.jpg\",\"20181223\\/874ff6f65f020a621bb1ff5401438047.jpg\"]', '[\"20181223\\/middle_6c8b1b2c89ef29d027b7e7efa7dd10ea.jpg\",\"20181223\\/middle_7c90f584ffbc59302a3714cd81ef90e7.jpg\",\"20181223\\/middle_874ff6f65f020a621bb1ff5401438047.jpg\"]', '[\"20181223\\/thumb_6c8b1b2c89ef29d027b7e7efa7dd10ea.jpg\",\"20181223\\/thumb_7c90f584ffbc59302a3714cd81ef90e7.jpg\",\"20181223\\/thumb_874ff6f65f020a621bb1ff5401438047.jpg\"]', '0', '1', '1', '1', '1', '<h1 label=\"标题居中\" style=\"font-size: 32px; font-weight: bold; border-bottom: 2px solid rgb(204, 204, 204); padding: 0px 4px 0px 0px; text-align: center; margin: 0px 0px 20px;\">vivo9</h1>', '1545553726', '1545553726');
INSERT INTO `sh_goods` VALUES ('4', 'ceshi ', '', null, '0', '0', '0', null, null, null, '1', '1', '1', '1', '1', null, '0', '0');
INSERT INTO `sh_goods` VALUES ('5', '1111', '', null, '0', '0', '0', null, null, null, '1', '1', '1', '1', '1', null, '0', '0');
INSERT INTO `sh_goods` VALUES ('6', '22222', '', null, '0', '0', '0', null, null, null, '0', '1', '1', '1', '1', null, '0', '0');

-- ----------------------------
-- Table structure for sh_goods_attr
-- ----------------------------
DROP TABLE IF EXISTS `sh_goods_attr`;
CREATE TABLE `sh_goods_attr` (
  `goods_attr_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` int(10) unsigned NOT NULL,
  `attr_id` smallint(5) unsigned NOT NULL,
  `attr_value` varchar(255) DEFAULT '',
  `attr_price` decimal(10,2) DEFAULT NULL,
  `create_time` int(11) DEFAULT '0',
  `update_time` int(11) DEFAULT '0',
  PRIMARY KEY (`goods_attr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sh_goods_attr
-- ----------------------------
INSERT INTO `sh_goods_attr` VALUES ('9', '2', '1', '5.5寸', null, '1545383225', '1545383225');
INSERT INTO `sh_goods_attr` VALUES ('10', '2', '2', '1500px', null, '1545383225', '1545383225');
INSERT INTO `sh_goods_attr` VALUES ('11', '2', '3', '16G', '160.00', '1545383225', '1545383225');
INSERT INTO `sh_goods_attr` VALUES ('12', '2', '3', '256G', '2560.00', '1545383225', '1545383225');
INSERT INTO `sh_goods_attr` VALUES ('13', '2', '4', '黑色', '200.00', '1545383225', '1545383225');
INSERT INTO `sh_goods_attr` VALUES ('14', '2', '4', '白色', '300.00', '1545383225', '1545383225');
INSERT INTO `sh_goods_attr` VALUES ('15', '3', '1', '5.5寸', null, '1545553726', '1545553726');
INSERT INTO `sh_goods_attr` VALUES ('16', '3', '2', '1500px', null, '1545553726', '1545553726');
INSERT INTO `sh_goods_attr` VALUES ('17', '3', '3', '16G', '160.00', '1545553726', '1545553726');
INSERT INTO `sh_goods_attr` VALUES ('18', '3', '3', '32G', '320.00', '1545553726', '1545553726');
INSERT INTO `sh_goods_attr` VALUES ('19', '3', '4', '黑色', '100.00', '1545553726', '1545553726');
INSERT INTO `sh_goods_attr` VALUES ('20', '3', '4', '白色', '200.00', '1545553726', '1545553726');
INSERT INTO `sh_goods_attr` VALUES ('21', '3', '4', '土豪金', '300.00', '1545553726', '1545553726');
INSERT INTO `sh_goods_attr` VALUES ('86', '1', '1', '6.9寸', null, '1546767819', '1546767819');
INSERT INTO `sh_goods_attr` VALUES ('87', '1', '2', '3000px', null, '1546767819', '1546767819');
INSERT INTO `sh_goods_attr` VALUES ('88', '1', '3', '13G', '130.00', '1546767819', '1546767819');
INSERT INTO `sh_goods_attr` VALUES ('89', '1', '3', '88G', '888.00', '1546767819', '1546767819');
INSERT INTO `sh_goods_attr` VALUES ('90', '1', '3', '256G', '560.00', '1546767819', '1546767819');
INSERT INTO `sh_goods_attr` VALUES ('91', '1', '4', '黑色', '150.00', '1546767819', '1546767819');
INSERT INTO `sh_goods_attr` VALUES ('92', '1', '4', '白色', '200.00', '1546767819', '1546767819');
INSERT INTO `sh_goods_attr` VALUES ('93', '1', '4', '土豪金', '1000.00', '1546767819', '1546767819');

-- ----------------------------
-- Table structure for sh_member
-- ----------------------------
DROP TABLE IF EXISTS `sh_member`;
CREATE TABLE `sh_member` (
  `member_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) DEFAULT '',
  `password` char(32) DEFAULT '',
  `email` varchar(50) DEFAULT '',
  `phone` char(15) DEFAULT NULL,
  `nickname` varchar(50) DEFAULT '' COMMENT '显示qq的昵称',
  `openid` varchar(50) DEFAULT '',
  `create_time` int(11) DEFAULT '0',
  `update_time` int(11) DEFAULT '0',
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sh_member
-- ----------------------------
INSERT INTO `sh_member` VALUES ('1', 'dachui', 'bc97546f43653a63d15ccebdedd82fcd', '1259481020@qq.com', '13455556666', '', '', '1545549245', '1545549245');
INSERT INTO `sh_member` VALUES ('2', 'xiaochui', '1103ce8cea149eb3e651413bcd6d9bc2', 'xiaochui@qq.com', '15815740415', '', '', '1545549503', '1545549503');
INSERT INTO `sh_member` VALUES ('3', 'xiaolan', 'bc97546f43653a63d15ccebdedd82fcd', 'sdgsdfgd@qq.com', '18948727439', '', '', '1545624391', '1545624391');
INSERT INTO `sh_member` VALUES ('5', '', '', '', null, '追赶的人儿', '5A08E4BCB8DB2E6F67BA9AC155F1FF36', '1546137462', '1546137462');

-- ----------------------------
-- Table structure for sh_order
-- ----------------------------
DROP TABLE IF EXISTS `sh_order`;
CREATE TABLE `sh_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(80) DEFAULT NULL,
  `receiver` varchar(30) DEFAULT NULL,
  `address` varchar(80) DEFAULT '',
  `phone` char(15) DEFAULT NULL,
  `zcode` varchar(6) DEFAULT NULL COMMENT '邮编',
  `total_price` decimal(10,2) DEFAULT NULL,
  `member_id` int(11) DEFAULT NULL,
  `pay_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0-未付款 ,1-已付款',
  `send_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT ' 0-未发货 ， 1-已发货 ，2-已收货 ,3-退货中 4-退货成功',
  `ali_order_id` varchar(255) NOT NULL DEFAULT '' COMMENT '支付成功支付宝返回的订单号',
  `company` varchar(255) DEFAULT '',
  `number` varchar(100) DEFAULT '',
  `create_time` int(11) DEFAULT '0',
  `update_time` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sh_order
-- ----------------------------
INSERT INTO `sh_order` VALUES ('1', '1812271545878958', '江小白', '广州吉山大学101号房', '1356666777', '666777', '97200.00', '2', '0', '0', '', '', '', '1545878958', '1545878958');
INSERT INTO `sh_order` VALUES ('2', '1812271545880030', '老王', '吉山幼儿园大班', '15666667777', '454545', '50695.00', '2', '0', '0', '', '', '', '1545880030', '1545880030');
INSERT INTO `sh_order` VALUES ('3', '1812271545880928', '老李', '广州吉山中学', '13411112222', '123456', '48600.00', '2', '1', '1', '2018122722001452420500560803', 'yuantong', '887671643851404196', '1545880928', '1545894259');
INSERT INTO `sh_order` VALUES ('4', '1812271545896487', '蘑菇头', '北京广场', '13455556666', '123444', '4860.00', '2', '1', '0', '2018122722001452420500561180', '', '', '1545896487', '1545896487');
INSERT INTO `sh_order` VALUES ('5', '1812301546131812', '老李', '广州吉山幼儿园', '1882222333', '547889', '64914.00', '2', '0', '0', '', '', '', '1546131812', '1546131812');
INSERT INTO `sh_order` VALUES ('16', '1901241548334873', 'bbb', 'ffffff', 'errrrrrrrr', 'ssssss', '259656.00', '5', '0', '0', '', '', '', '1548334874', '1548334874');

-- ----------------------------
-- Table structure for sh_order_goods
-- ----------------------------
DROP TABLE IF EXISTS `sh_order_goods`;
CREATE TABLE `sh_order_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` varchar(100) DEFAULT NULL,
  `goods_id` int(11) DEFAULT NULL,
  `goods_attr_ids` varchar(30) DEFAULT NULL,
  `goods_number` int(5) DEFAULT NULL,
  `goods_price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sh_order_goods
-- ----------------------------
INSERT INTO `sh_order_goods` VALUES ('1', '1812271545878958', '2', '11,13', '20', '97200.00');
INSERT INTO `sh_order_goods` VALUES ('2', '1812271545880030', '1', '4,8', '5', '50695.00');
INSERT INTO `sh_order_goods` VALUES ('3', '1812271545880928', '2', '11,13', '10', '48600.00');
INSERT INTO `sh_order_goods` VALUES ('4', '1812271545896487', '2', '11,13', '1', '4860.00');
INSERT INTO `sh_order_goods` VALUES ('5', '1812301546131812', '3', '17,19', '1', '64914.00');
INSERT INTO `sh_order_goods` VALUES ('6', '1901241548330263', '1', '88,91', '1', '10279.00');
INSERT INTO `sh_order_goods` VALUES ('7', '1901241548333311', '2', '11,13', '1', '4860.00');
INSERT INTO `sh_order_goods` VALUES ('8', '1901241548333898', '1', '88,91', '1', '10279.00');
INSERT INTO `sh_order_goods` VALUES ('9', '1901241548334011', '1', '88,91', '1', '10279.00');
INSERT INTO `sh_order_goods` VALUES ('10', '1901241548334351', '1', '88,91', '1', '10279.00');
INSERT INTO `sh_order_goods` VALUES ('11', '1901241548334404', '1', '88,92', '3', '30987.00');
INSERT INTO `sh_order_goods` VALUES ('12', '1901241548334873', '3', '17,19', '4', '259656.00');

-- ----------------------------
-- Table structure for sh_role
-- ----------------------------
DROP TABLE IF EXISTS `sh_role`;
CREATE TABLE `sh_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(40) DEFAULT '',
  `auth_ids_list` varchar(100) DEFAULT '',
  `create_time` int(11) DEFAULT '0',
  `update_time` int(11) DEFAULT '0',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sh_role
-- ----------------------------
INSERT INTO `sh_role` VALUES ('1', '超级管理员', '*', '0', '0');
INSERT INTO `sh_role` VALUES ('3', '经理', '1,2,9,10,3,4', '1545121798', '1545126144');
INSERT INTO `sh_role` VALUES ('4', '主管', '1,2,9,10,3', '1545270324', '1545270324');

-- ----------------------------
-- Table structure for sh_type
-- ----------------------------
DROP TABLE IF EXISTS `sh_type`;
CREATE TABLE `sh_type` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(40) DEFAULT '',
  `mark` text,
  `create_time` int(11) DEFAULT '0',
  `update_time` int(11) DEFAULT '0',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sh_type
-- ----------------------------
INSERT INTO `sh_type` VALUES ('1', '手机类型', '手机类型手机类型手机类型手机类型手机类型', '1545376341', '1545376341');
INSERT INTO `sh_type` VALUES ('2', '汽车类型', '汽车类型汽车类型汽车类型', '1545376353', '1545376353');

-- ----------------------------
-- Table structure for sh_user
-- ----------------------------
DROP TABLE IF EXISTS `sh_user`;
CREATE TABLE `sh_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(40) DEFAULT '',
  `password` char(32) DEFAULT '',
  `role_id` tinyint(4) DEFAULT '0',
  `create_time` int(11) DEFAULT '0',
  `update_time` int(11) DEFAULT '0',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sh_user
-- ----------------------------
INSERT INTO `sh_user` VALUES ('1', 'admin', 'bc97546f43653a63d15ccebdedd82fcd', '1', '1545017778', '1545017778');
INSERT INTO `sh_user` VALUES ('5', 'dachui', 'bc97546f43653a63d15ccebdedd82fcd', '4', '1545270340', '1545276370');
