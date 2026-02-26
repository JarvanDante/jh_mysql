/*
 Navicat MySQL Data Transfer

 Source Server         : 888--本地数据库
 Source Server Type    : MySQL
 Source Server Version : 80032
 Source Host           : localhost:3306
 Source Schema         : jh_manage

 Target Server Type    : MySQL
 Target Server Version : 80032
 File Encoding         : 65001

 Date: 26/02/2026 21:47:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(128) NOT NULL COMMENT '模板名称',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '模板编码(全局唯一)',
  `activity_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '活动类型(如 invite, rebate, mission)',
  `description` varchar(255) DEFAULT NULL COMMENT '模板描述',
  `start_time` timestamp NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '结束时间',
  `fixed_params` json NOT NULL COMMENT '固定参数(JSON)',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态: 0=禁用,1=启用',
  `uri` varchar(100) NOT NULL DEFAULT '' COMMENT '活动uri地址',
  `table` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '表名定义不同属性',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_template_code` (`code`),
  KEY `idx_activity_type` (`activity_type`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='总后台活动模板表';

-- ----------------------------
-- Records of activity
-- ----------------------------
BEGIN;
INSERT INTO `activity` VALUES (1, 'Invite Friends', 'INVITE', '10', '邀请朋友活动，规则：XXX', '2025-12-26 16:00:00', '2026-11-25 16:00:00', '{\"reward_type\": 1, \"trigger_event\": 1, \"min_recharge_amount\": 80, \"inviter_reward_amount\": 10}', 0, '/invite_activity', 'activity_invite_bonus', '2026-02-05 22:50:05', '2026-02-20 15:33:47');
INSERT INTO `activity` VALUES (3, 'REGISTER BONUS', 'REGISTER', '5', '注册送活动，规则：XXX', '2026-01-29 08:00:00', '2027-01-29 08:00:00', '{\"limit_ip\": 1, \"limit_device\": 1, \"reward_amount\": 20}', 1, '/register_activity', 'activity_register_bonus', '2026-02-05 23:01:51', '2026-02-10 06:59:07');
INSERT INTO `activity` VALUES (4, 'DEPOSIT BONUS', 'DEPOSIT', '6', '充值送活动，规则：XXX', '2026-01-27 16:00:00', '2027-01-27 16:00:00', '{\"reward_type\": 1, \"reward_amount\": 70, \"trigger_event\": 1, \"min_recharge_amount\": 550}', 1, '/deposit_activity', 'activity_deposit_bonus', '2026-02-05 23:03:11', '2026-02-10 06:58:25');
INSERT INTO `activity` VALUES (6, 'DAILY CHECK-IN', 'SIGNIN', '8', '每日签到活动，规则：XXX', '2026-01-28 08:00:00', '2027-01-28 08:00:00', '{}', 1, '/signin_activity', 'activity_signin_bonus', '2026-02-05 23:06:00', '2026-02-10 07:02:29');
INSERT INTO `activity` VALUES (7, 'LUCKY SPIN', 'LUCKY', '9', '大转盘活动，规则：XXX', '2026-01-28 08:00:00', '2027-01-28 08:00:00', '{}', 1, '/lucky_activity', 'activity_wheel_bonus', '2026-02-05 23:07:33', '2026-02-10 06:56:43');
COMMIT;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_role_id` int NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `switch_google2fa` tinyint(1) NOT NULL DEFAULT '0' COMMENT '二次验证开关。1=打开；0=关闭',
  `google2fa_secret` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '二次验证密钥',
  `remember_token` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `last_login_ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_login_time` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='总后台员工表';

-- ----------------------------
-- Records of admin
-- ----------------------------
BEGIN;
INSERT INTO `admin` VALUES (1, 'zhuluoji', '超管', '$2a$10$PDxQEQXjVcD8XOdB96yofuEW5rw.xZw.Rj1ztMBaW9lfrkAVYDc6y', 1, 1, 1, 'OF5TNWUM6LCNHHCMYYWLEO5QGMVJMDRE', '1P6V798HHHfZ3Lx1tQZm3ZZxWGJiztKBpEhVmRs71UMPnepzWFVIkiiOP0Qi', '172.19.0.5', '2026-02-26 08:28:38', '2018-07-22 20:44:04', '2026-02-26 08:28:38');
COMMIT;

-- ----------------------------
-- Table structure for admin_log
-- ----------------------------
DROP TABLE IF EXISTS `admin_log`;
CREATE TABLE `admin_log` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` int NOT NULL,
  `admin_username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='后台员工日志表';

-- ----------------------------
-- Table structure for admin_permission
-- ----------------------------
DROP TABLE IF EXISTS `admin_permission`;
CREATE TABLE `admin_permission` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int NOT NULL DEFAULT '0' COMMENT '父级id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `route_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '路由url',
  `is_menu` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否设置为菜单 1=是 0=否',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态。1=可用；0=禁用',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序。值越小，越靠前',
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '图标',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='权限';

-- ----------------------------
-- Records of admin_permission
-- ----------------------------
BEGIN;
INSERT INTO `admin_permission` VALUES (1, 0, '商户', 'customerManage', 1, 1, 0, 'users', NULL, NULL);
INSERT INTO `admin_permission` VALUES (2, 1, '商户列表', 'customerManage/customer', 1, 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (3, 1, '商户详情', 'customerManage/customerDetail', 0, 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (4, 0, '域名', 'domainManage', 1, 1, 0, 'globe', NULL, NULL);
INSERT INTO `admin_permission` VALUES (5, 4, '域名列表', 'domainManage/domain', 1, 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (6, 0, '游戏', 'gameManage', 1, 1, 0, 'gamepad-2', NULL, NULL);
INSERT INTO `admin_permission` VALUES (7, 6, '游戏列表', 'gameManage/game', 1, 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (8, 0, '注单', 'betManage', 1, 1, 0, 'list', NULL, NULL);
INSERT INTO `admin_permission` VALUES (9, 8, '投注补单', 'betManage/betLog', 1, 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (10, 8, '拉取状态', 'betManage/betTask', 1, 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (11, 0, '支付', 'paymentManage', 1, 1, 0, 'wallet', NULL, NULL);
INSERT INTO `admin_permission` VALUES (12, 11, '支付列表', 'paymentManage/payment', 1, 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (13, 0, '提现', 'withdrawManage', 1, 1, 0, 'credit-card', NULL, NULL);
INSERT INTO `admin_permission` VALUES (14, 13, '提现列表', 'withdrawManage/withdraw', 1, 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (15, 0, '活动', 'activityManage', 1, 1, 0, 'trophy', NULL, NULL);
INSERT INTO `admin_permission` VALUES (16, 15, '活动列表', 'activityManage/activity', 1, 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (17, 0, '运营', 'operationsManage', 1, 1, 0, 'gift', NULL, NULL);
INSERT INTO `admin_permission` VALUES (18, 17, '全局报表', 'operationsManage/operations', 1, 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (19, 0, '员工', 'adminManage', 1, 1, 0, 'settings', NULL, NULL);
INSERT INTO `admin_permission` VALUES (20, 19, '员工列表', 'adminManage/admin', 1, 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (21, 19, '角色列表', 'adminManage/role', 1, 1, 0, '', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for admin_role
-- ----------------------------
DROP TABLE IF EXISTS `admin_role`;
CREATE TABLE `admin_role` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态。1=可用；0=禁用',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `permissions` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '权限列表。格式：权限id以,隔开',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色';

-- ----------------------------
-- Records of admin_role
-- ----------------------------
BEGIN;
INSERT INTO `admin_role` VALUES (1, '超级管理员', 1, '2018-07-22 20:44:04', '2018-07-22 20:44:04', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160');
COMMIT;

-- ----------------------------
-- Table structure for game
-- ----------------------------
DROP TABLE IF EXISTS `game`;
CREATE TABLE `game` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint NOT NULL COMMENT '类型。1=体育；2=彩票；3=真人；4=电子游戏',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '游戏名称',
  `platform` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '平台标识',
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '游戏标识',
  `image_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片标识',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态。1=启用；0=禁用',
  `db_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '数据表名称',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `api_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'API_ID',
  `api_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'API_KEY',
  `api_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'API_URL',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='游戏表';

-- ----------------------------
-- Records of game
-- ----------------------------
BEGIN;
INSERT INTO `game` VALUES (1, 1, 'IM体育', 'IM', 'IM_SPORTS', 'im', 1, 'im_sports', '', '', '', '', '2018-07-22 20:44:04', '2026-01-29 11:10:20');
INSERT INTO `game` VALUES (2, 1, '沙巴体育', 'SB', 'SB_SPORTS', 'sb', 0, 'sb_sports', '', '', '', '', '2018-07-22 20:44:04', '2018-07-22 20:44:04');
INSERT INTO `game` VALUES (5, 1, 'BB体育', 'BBIN', 'BBIN_SPORTS', 'bbin', 0, 'bbin_sports', '', '', '', '', '2018-07-22 20:44:04', '2018-07-22 20:44:04');
INSERT INTO `game` VALUES (6, 1, 'NEW BB体育', 'BBIN', 'BBIN_NEW_SPORTS', 'bbinnew', 0, 'new_sports', '', '', '', '', '2018-07-22 20:44:04', '2018-07-22 20:44:04');
INSERT INTO `game` VALUES (7, 2, '幸运彩票', 'PG', 'PG_LOTTERY', 'pglk', 0, 'pg_lottery', '', '', '', '', '2018-07-22 20:44:04', '2018-07-22 20:44:04');
INSERT INTO `game` VALUES (8, 2, 'BBIN彩票', 'BBIN', 'BBIN_LOTTERY', 'bbin', 0, 'bbin_lottery', '', '', '', '', '2018-07-22 20:44:04', '2018-07-22 20:44:04');
INSERT INTO `game` VALUES (9, 2, 'VR彩票', 'VR', 'VR_LOTTERY', 'vr', 0, 'vr_lottery', '', '', '', '', '2018-07-22 20:44:04', '2018-07-22 20:44:04');
INSERT INTO `game` VALUES (10, 3, 'AG国际厅', 'AG', 'AG_VIP_LIVE', 'agvip', 0, 'agin_live', '', '', '', '', '2018-07-22 20:44:04', '2018-07-22 20:44:04');
INSERT INTO `game` VALUES (11, 3, 'BG视讯', 'BG', 'BG_LIVE', 'bg', 0, 'bg_live', '', '', '', '', '2018-07-22 20:44:04', '2018-07-22 20:44:04');
INSERT INTO `game` VALUES (12, 3, 'MG视讯', 'MG', 'MG_LIVE', 'mg', 0, 'mg_live', '', '', '', '', '2018-07-22 20:44:04', '2018-07-22 20:44:04');
INSERT INTO `game` VALUES (13, 3, 'DG视讯', 'DG', 'DG_LIVE', 'dg', 0, 'dg_live', '', '', '', '', '2018-07-22 20:44:04', '2018-07-22 20:44:04');
INSERT INTO `game` VALUES (14, 3, 'GD视讯', 'GD', 'GD_LIVE', 'gd', 0, 'gd_live', '', '', '', '', '2018-07-22 20:44:04', '2018-07-22 20:44:04');
INSERT INTO `game` VALUES (15, 3, 'BBIN视讯', 'BBIN', 'BBIN_LIVE', 'bbin', 0, 'bbin_live', '', '', '', '', '2018-07-22 20:44:04', '2018-07-22 20:44:04');
INSERT INTO `game` VALUES (16, 3, '欧博视讯', 'OB', 'OB_LIVE', 'ob', 0, 'ob_live', '欧博', '', '', '', '2018-07-22 20:44:04', '2018-07-22 20:44:04');
INSERT INTO `game` VALUES (17, 3, 'OG视讯', 'OG', 'OG_LIVE', 'og', 0, 'og_live', '东方', '', '', '', '2018-07-22 20:44:04', '2018-07-22 20:44:04');
INSERT INTO `game` VALUES (18, 4, 'AG电子游戏', 'AG', 'AG_GAME', 'ag', 0, 'xin_game', '', '', '', '', '2018-07-22 20:44:04', '2018-07-22 20:44:04');
INSERT INTO `game` VALUES (19, 4, 'MG电子游戏', 'MG', 'MG_GAME', 'mg', 0, 'mg_game', '', '', '', '', '2018-07-22 20:44:04', '2018-07-22 20:44:04');
INSERT INTO `game` VALUES (20, 4, 'PT电子游戏', 'PT', 'PT_GAME', 'pt', 0, 'pt_game', '', '', '', '', '2018-07-22 20:44:04', '2018-07-22 20:44:04');
INSERT INTO `game` VALUES (21, 4, 'HB电子游戏', 'HB', 'HB_GAME', 'hb', 0, 'hb_game', '', '', '', '', '2018-07-22 20:44:04', '2018-07-22 20:44:04');
INSERT INTO `game` VALUES (22, 4, 'GD电子游戏', 'GD', 'GD_GAME', 'gd', 0, 'gd_game', '', '', '', '', '2018-07-22 20:44:04', '2018-07-22 20:44:04');
INSERT INTO `game` VALUES (23, 4, 'PG电子游戏', 'PG', 'PG_GAME', 'pg', 0, 'pg_game', '', '', '', '', '2018-07-22 20:44:04', '2018-07-22 20:44:04');
INSERT INTO `game` VALUES (24, 4, 'BBIN电子游戏', 'BBIN', 'BBIN_GAME', 'bbin', 0, 'bbin_game', '', '', '', '', '2018-07-22 20:44:04', '2018-07-22 20:44:04');
INSERT INTO `game` VALUES (25, 4, '捕鱼王', 'AG', 'AG_HUNTER_GAME', 'ag', 0, 'hunter_game', '', '', '', '', '2018-07-22 20:44:04', '2018-07-22 20:44:04');
INSERT INTO `game` VALUES (26, 4, 'ONE游戏', 'ONE', 'ONE_GAME', 'one', 1, 'one_api_game', 'ONE游戏-集成', 'a6cd074ecc4ec450090ab0288484e909616d6f17493ecba588bf9c2eb7e35864', '22db26bd9dbb5a707a4df7446010a8fa589d564c602e3dfec190e0c46bbe8523', 'https://stg.gasea168.com', '2026-01-19 13:48:14', '2026-01-19 17:36:08');
INSERT INTO `game` VALUES (27, 4, 'IG_JILI游戏', 'IG_JILI', 'IG_JILI_GAME', 'jili', 1, 'ig_jili_game', 'IG_JILI游戏-独立', 'FJ999Trans_MMK', '0af14f1b1301355ea98eb9fda7ad61853005aefe', 'https://uat-wb-api-2.kijl788du.com/api1', '2026-01-19 17:37:31', '2026-01-22 20:44:24');
COMMIT;

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `gateway` tinyint NOT NULL COMMENT '支付网关1在线支付2银行',
  `api_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '支付请求地址',
  `merchant_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商户号',
  `md5_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'MD5密钥',
  `each_min` decimal(15,4) NOT NULL DEFAULT '10.0000' COMMENT '单笔最低。默认10',
  `each_max` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '单笔最高。如果为0，表示没有限制。',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序。值越小排名越靠前',
  `moneyList` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '可选的金额数组，is_int =1 的时候必填',
  `is_input` tinyint NOT NULL DEFAULT '0' COMMENT '是否输入金额0不支持1支持',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '描述',
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'logo地址',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='支付渠道';

-- ----------------------------
-- Records of payment
-- ----------------------------
BEGIN;
INSERT INTO `payment` VALUES (1, 'GCash1', 'upay', 1, 'http://54.179.50.129:8961/api/merchant/order', '1098715', 'CPDZMLGK2BON4RP2W3AZ6TRMTAO7MBFX', 100.0000, 50000.0000, 0, '100,300,500,1000,2000,5000,10000,30000,50000', 1, '', 'http://logo1213.com', 1, '2019-05-21 11:17:47', '2026-01-30 20:48:22');
INSERT INTO `payment` VALUES (2, 'Maya1', 'Zhongbao', 1, 'http://66.179.50.129:8961/api/merchant/order', '2098715', 'RXYFUP4J64VRPJDUVSKLFR6XEYOB52IL', 100.0000, 50000.0000, 1, '100,300,500,1000,2000,5000,10000,30000,50000', 1, '', '', 1, '2019-05-31 09:14:22', '2026-01-30 20:48:31');
INSERT INTO `payment` VALUES (5, 'GCash2', 'wzf', 1, 'http://gbtobyk.gt/qymj', '12312312', 'fdsalkfjds', 10.0000, 50000.0000, 1, '50,100,500,600', 1, 'Lorem ipsum minim', 'Excepteur nostrud ipsum magna sint', 1, '2026-01-29 10:55:18', '2026-02-06 17:19:37');
INSERT INTO `payment` VALUES (6, 'GCache3', 'tpay', 2, 'http://api.com', '123123123', 'fdskafljdlska', 10.0000, 50000.0000, 1, '1,2,3,4,5,6', 0, '', 'http://123123123.com', 1, '2026-01-29 11:06:50', '2026-01-30 20:48:50');
COMMIT;

-- ----------------------------
-- Table structure for site
-- ----------------------------
DROP TABLE IF EXISTS `site`;
CREATE TABLE `site` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商户标识',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商户名称',
  `timezone` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '时区',
  `currency` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '币种',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态。1=正常；0=禁用',
  `kv_config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'KV配置详情',
  `db_link_site` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'site数据库连接',
  `db_link_balance` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'balance数据库连接',
  `db_link_game` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'game数据库连接',
  `is_sync` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否发布同步。1=发布同步；0=未发布同步',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='站点表';

-- ----------------------------
-- Records of site
-- ----------------------------
BEGIN;
INSERT INTO `site` VALUES (1, 'jh', '极好', 'UTC', 'MMK(K)', 1, '{\"name\":\"jarven\"}', 'mysql:root:654321@tcp(172.19.0.4:3306)/jh_site?parseTime=true&loc=Local', 'mysql:root:654321@tcp(172.19.0.4:3306)/jh_balance?parseTime=true&loc=Local', 'mysql:root:654321@tcp(172.19.0.4:3306)/jh_game?parseTime=true&loc=Local', 0, '2022-05-21 11:15:24', '2026-01-20 14:22:24');
INSERT INTO `site` VALUES (2, 'ym', '亚美', 'UTC+4', 'USD', 1, '{\"name\":\"jay\"}', 'mysql:root:654321@tcp(172.19.0.4:3306)/ym_site?parseTime=true&loc=Local', 'mysql:root:654321@tcp(172.19.0.4:3306)/ym_balance?parseTime=true&loc=Local', 'mysql:root:654321@tcp(172.19.0.4:3306)/ym_game?parseTime=true&loc=Local', 0, '2025-05-21 11:15:24', '2026-01-13 20:09:03');
COMMIT;

-- ----------------------------
-- Table structure for site_activity
-- ----------------------------
DROP TABLE IF EXISTS `site_activity`;
CREATE TABLE `site_activity` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '站点ID',
  `activity_id` int NOT NULL COMMENT '活动ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '活动渠道名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '活动是否打开或者或者关闭。1=打开；0=关闭',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_activity_site_code_activity_id_uindex` (`site_code`,`activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='站点提现表';

-- ----------------------------
-- Records of site_activity
-- ----------------------------
BEGIN;
INSERT INTO `site_activity` VALUES (56, 'jh', 7, '大转盘活动流水', 1, 0, '2026-02-05 23:36:53', '2026-02-05 23:36:53');
INSERT INTO `site_activity` VALUES (57, 'jh', 6, '每日签到活动流水', 1, 0, '2026-02-05 23:36:53', '2026-02-05 23:36:53');
INSERT INTO `site_activity` VALUES (59, 'jh', 4, '充值送活动流水', 1, 0, '2026-02-05 23:36:54', '2026-02-05 23:36:54');
INSERT INTO `site_activity` VALUES (60, 'jh', 3, '注册送活动流水', 1, 0, '2026-02-05 23:36:55', '2026-02-05 23:36:55');
INSERT INTO `site_activity` VALUES (61, 'jh', 1, '邀请朋友活动', 1, 0, '2026-02-05 23:36:56', '2026-02-05 23:36:56');
COMMIT;

-- ----------------------------
-- Table structure for site_config_publish_log
-- ----------------------------
DROP TABLE IF EXISTS `site_config_publish_log`;
CREATE TABLE `site_config_publish_log` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `site_code` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '站点唯一标识',
  `version` bigint unsigned NOT NULL COMMENT '本次发布生成的配置版本号',
  `publish_type` tinyint NOT NULL COMMENT '发布类型: 1=正常发布 2=回滚',
  `rollback_from` bigint unsigned DEFAULT NULL COMMENT '回滚来源版本(仅回滚时有)',
  `operator_id` bigint unsigned NOT NULL COMMENT '操作人ID',
  `operator_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作人名称(冗余,便于审计)',
  `comment` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '发布说明/备注',
  `published_at` datetime NOT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_site_version` (`site_code`,`version`),
  KEY `idx_site_code` (`site_code`),
  KEY `idx_published_at` (`published_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='站点配置发布记录表';

-- ----------------------------
-- Table structure for site_config_snapshot
-- ----------------------------
DROP TABLE IF EXISTS `site_config_snapshot`;
CREATE TABLE `site_config_snapshot` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `site_code` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '站点唯一标识',
  `version` bigint unsigned NOT NULL COMMENT '配置版本号',
  `config_json` json NOT NULL COMMENT '完整站点配置快照(JSON)',
  `created_at` datetime NOT NULL COMMENT '快照生成时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_site_version` (`site_code`,`version`),
  KEY `idx_site_code` (`site_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='站点配置快照表（用于回滚）';

-- ----------------------------
-- Table structure for site_config_version
-- ----------------------------
DROP TABLE IF EXISTS `site_config_version`;
CREATE TABLE `site_config_version` (
  `site_code` varchar(32) COLLATE utf8mb4_general_ci NOT NULL COMMENT '站点唯一标识',
  `current_version` bigint unsigned NOT NULL COMMENT '当前配置版本号',
  `updated_at` datetime NOT NULL COMMENT '最后一次版本变更时间',
  PRIMARY KEY (`site_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='站点配置版本控制表';

-- ----------------------------
-- Table structure for site_domain
-- ----------------------------
DROP TABLE IF EXISTS `site_domain`;
CREATE TABLE `site_domain` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `site_code` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  `domain` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `domain_type` varchar(16) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'api/h5/admin/callback',
  `status` tinyint DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_domain` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='域名与站点绑定';

-- ----------------------------
-- Records of site_domain
-- ----------------------------
BEGIN;
INSERT INTO `site_domain` VALUES (1, 'jh', '*.jhh5.com', '2', 1, '2026-01-13 20:13:07', '2026-02-19 07:26:46');
INSERT INTO `site_domain` VALUES (2, 'ym', 'ym.com', '2', 1, '2026-01-13 21:54:29', '2026-01-14 15:12:01');
INSERT INTO `site_domain` VALUES (3, 'jh', 'jh.com', '2', 1, '2026-01-14 15:11:49', '2026-01-14 15:11:49');
INSERT INTO `site_domain` VALUES (4, 'jh', 'jh1.com', '1', 1, '2026-01-14 18:21:45', '2026-01-14 18:21:45');
INSERT INTO `site_domain` VALUES (5, 'jh', 'FDSAF.com', '4', 1, '2026-01-14 20:39:40', '2026-01-14 20:39:40');
INSERT INTO `site_domain` VALUES (6, 'jh', 'admin123.com', '3', 1, '2026-01-15 08:43:42', '2026-01-15 08:43:42');
INSERT INTO `site_domain` VALUES (7, 'ym', 'ad.com', '4', 1, '2026-01-19 15:59:04', '2026-01-25 12:49:16');
INSERT INTO `site_domain` VALUES (8, 'jh', 'i.jhbackend.com', '3', 1, '2026-02-19 13:21:35', '2026-02-19 13:37:37');
COMMIT;

-- ----------------------------
-- Table structure for site_game
-- ----------------------------
DROP TABLE IF EXISTS `site_game`;
CREATE TABLE `site_game` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '站点ID',
  `type` tinyint NOT NULL COMMENT '游戏类型。1=体育；2=彩票；3=真人；4=电子游戏',
  `game_id` int NOT NULL COMMENT '游戏ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '游戏名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '游戏是否打开或者或者关闭。1=打开；0=关闭',
  `sort` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='站点游戏表';

-- ----------------------------
-- Records of site_game
-- ----------------------------
BEGIN;
INSERT INTO `site_game` VALUES (22, 'jh', 4, 26, 'ONE游戏', 1, 0, '2026-01-19 20:11:25', '2026-01-19 20:11:25');
INSERT INTO `site_game` VALUES (24, 'jh', 4, 27, 'IG_JILI游戏', 1, 0, '2026-01-22 06:41:16', '2026-01-22 06:41:16');
COMMIT;

-- ----------------------------
-- Table structure for site_payment
-- ----------------------------
DROP TABLE IF EXISTS `site_payment`;
CREATE TABLE `site_payment` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '站点ID',
  `payment_id` int NOT NULL COMMENT '支付ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '支付名称名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '支付是否打开或者或者关闭。1=打开；0=关闭',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='站点支付表';

-- ----------------------------
-- Records of site_payment
-- ----------------------------
BEGIN;
INSERT INTO `site_payment` VALUES (30, 'ym', 1, 'GCash-优支付', 1, 0, '2026-01-29 11:27:27', '2026-01-29 11:27:27');
INSERT INTO `site_payment` VALUES (31, 'ym', 6, 'GCache-T支付', 1, 0, '2026-01-29 11:27:28', '2026-01-29 11:27:28');
INSERT INTO `site_payment` VALUES (32, 'ym', 2, 'Maya-众宝支付', 1, 0, '2026-01-29 11:27:28', '2026-01-29 11:27:28');
INSERT INTO `site_payment` VALUES (33, 'ym', 5, 'GCash-好', 1, 0, '2026-01-29 11:27:30', '2026-01-29 11:27:30');
INSERT INTO `site_payment` VALUES (40, 'jh', 1, 'GCash-优支付', 1, 0, '2026-01-30 10:45:07', '2026-01-30 10:45:07');
INSERT INTO `site_payment` VALUES (41, 'jh', 2, 'Maya-众宝支付', 1, 0, '2026-01-30 10:45:08', '2026-01-30 10:45:08');
INSERT INTO `site_payment` VALUES (43, 'jh', 6, 'GCache-T支付', 1, 0, '2026-01-30 10:46:23', '2026-01-30 10:46:23');
INSERT INTO `site_payment` VALUES (44, 'jh', 5, 'GCash-好', 1, 0, '2026-01-30 19:29:50', '2026-01-30 19:29:50');
COMMIT;

-- ----------------------------
-- Table structure for site_withdraw
-- ----------------------------
DROP TABLE IF EXISTS `site_withdraw`;
CREATE TABLE `site_withdraw` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '站点ID',
  `withdraw_id` int NOT NULL COMMENT '提现ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '提现渠道名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '提现是否打开或者或者关闭。1=打开；0=关闭',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='站点提现表';

-- ----------------------------
-- Records of site_withdraw
-- ----------------------------
BEGIN;
INSERT INTO `site_withdraw` VALUES (42, 'jh', 7, 'GCash-t支付', 1, 0, '2026-01-29 17:15:06', '2026-01-29 17:15:06');
INSERT INTO `site_withdraw` VALUES (43, 'ym', 8, 'May-f支付', 1, 0, '2026-01-29 17:16:41', '2026-01-29 17:16:41');
INSERT INTO `site_withdraw` VALUES (44, 'jh', 8, 'May-f支付', 1, 0, '2026-01-30 11:25:22', '2026-01-30 11:25:22');
COMMIT;

-- ----------------------------
-- Table structure for withdraw
-- ----------------------------
DROP TABLE IF EXISTS `withdraw`;
CREATE TABLE `withdraw` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `gateway` tinyint NOT NULL COMMENT '提现网关1在线支付2银行',
  `api_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '提现请求',
  `merchant_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商户号',
  `md5_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'MD5密钥',
  `each_min` decimal(15,4) NOT NULL DEFAULT '10.0000' COMMENT '单笔最低。默认10',
  `each_max` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '单笔最高。如果为0，表示没有限制。',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序。值越小排名越靠前',
  `moneyList` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '可选的金额数组，is_int =1 的时候必填',
  `is_input` tinyint NOT NULL DEFAULT '0' COMMENT '是否输入金额0不支持1支持',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '描述',
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'logo地址',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='提现渠道';

-- ----------------------------
-- Records of withdraw
-- ----------------------------
BEGIN;
INSERT INTO `withdraw` VALUES (7, 'GCash', 'txian', 1, 'http://56123123.com', '123123', 'xkdfjlkdsjlkfsdf', 10.0000, 50000.0000, 1, '100,200,300,5000', 1, 'fffffff', 'http://logo.com', 1, '2026-01-29 16:44:32', '2026-01-30 20:49:12');
INSERT INTO `withdraw` VALUES (8, 'Maya', 'fzhifu', 1, 'http://1231233888.com', '123123', 'ffdsfdsjfkladjf', 10.0000, 50000.0000, 0, '100,200,300,5000', 1, 'fffffff', 'http://12333logo.com', 1, '2026-01-29 16:45:35', '2026-01-30 20:49:04');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
