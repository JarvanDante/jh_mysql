/*
 Navicat MySQL Data Transfer

 Source Server         : 888--本地数据库
 Source Server Type    : MySQL
 Source Server Version : 80032
 Source Host           : localhost:3306
 Source Schema         : jh_site

 Target Server Type    : MySQL
 Target Server Version : 80032
 File Encoding         : 65001

 Date: 26/02/2026 21:06:01
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for activity_deposit_bonus
-- ----------------------------
DROP TABLE IF EXISTS `activity_deposit_bonus`;
CREATE TABLE `activity_deposit_bonus` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '站点CODE',
  `activity_id` int NOT NULL COMMENT '活动ID',
  `trigger_event` tinyint(1) NOT NULL DEFAULT '1' COMMENT '发放触发:1=充值总和,2=首充',
  `reward_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '奖励类型:1=固定,2=比例',
  `min_recharge_amount` decimal(12,2) NOT NULL COMMENT '触发最小充值金额',
  `reward_amount` decimal(12,2) NOT NULL COMMENT '奖励金额/比例值',
  `created_at` timestamp NULL DEFAULT (now()),
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `activity_deposit_bonus__index` (`site_code`,`activity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='充值送活动参数配置';

-- ----------------------------
-- Table structure for activity_invite_bonus
-- ----------------------------
DROP TABLE IF EXISTS `activity_invite_bonus`;
CREATE TABLE `activity_invite_bonus` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '站点CODE',
  `activity_id` int NOT NULL COMMENT '活动ID',
  `trigger_event` tinyint(1) NOT NULL DEFAULT '1' COMMENT '发放触发:1充值总和2首充',
  `reward_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '奖励类型:1=固定,2=比例',
  `min_recharge_amount` decimal(12,2) NOT NULL COMMENT '触发最小计算金额',
  `inviter_reward_amount` decimal(12,2) NOT NULL COMMENT '邀请人奖励金额',
  `created_at` timestamp NULL DEFAULT (now()),
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `activity_invite_bonus__index` (`site_code`,`activity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='邀请朋友活动参数配置';

-- ----------------------------
-- Table structure for activity_register_bonus
-- ----------------------------
DROP TABLE IF EXISTS `activity_register_bonus`;
CREATE TABLE `activity_register_bonus` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '站点CODE',
  `activity_id` int NOT NULL COMMENT '活动ID',
  `reward_amount` decimal(12,2) NOT NULL COMMENT '注册奖励金额',
  `limit_ip` tinyint NOT NULL DEFAULT '1' COMMENT '同IP注册限制次数',
  `limit_device` tinyint DEFAULT '1' COMMENT '同设备注册限制次数',
  `created_at` timestamp NULL DEFAULT (now()),
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `activity_register_bonus__index` (`site_code`,`activity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='注册送活动参数配置';

-- ----------------------------
-- Table structure for activity_signin_bonus
-- ----------------------------
DROP TABLE IF EXISTS `activity_signin_bonus`;
CREATE TABLE `activity_signin_bonus` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '站点CODE',
  `activity_id` int NOT NULL COMMENT '活动ID',
  `day_no` tinyint NOT NULL COMMENT '日号(1-31)',
  `reward_amount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '当日固定金额',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_site_activity_day` (`site_code`,`activity_id`,`day_no`),
  KEY `idx_site` (`site_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='签到每日金额配置';

-- ----------------------------
-- Table structure for activity_wheel_bonus
-- ----------------------------
DROP TABLE IF EXISTS `activity_wheel_bonus`;
CREATE TABLE `activity_wheel_bonus` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '站点CODE',
  `activity_id` int NOT NULL COMMENT '活动ID',
  `segment_no` tinyint unsigned NOT NULL COMMENT '转盘扇区序号(1~12)',
  `prize_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '奖项名称',
  `reward_amount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '奖金额(谢谢参与填0)',
  `weight` int unsigned NOT NULL DEFAULT '0' COMMENT '抽中权重(越大概率越高)',
  `user_daily_win_limit` int unsigned NOT NULL DEFAULT '0' COMMENT '单用户每日可中次数(0不限)',
  `min_vip_level` int unsigned NOT NULL DEFAULT '0' COMMENT '最低VIP等级(0不限)',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '奖项图标',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_site_activity_segment` (`site_code`,`activity_id`,`segment_no`),
  KEY `idx_site_activity_weight` (`site_code`,`activity_id`,`segment_no`,`weight`,`user_daily_win_limit`,`min_vip_level`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='大转盘-奖项参数配置';

-- ----------------------------
-- Records of activity_wheel_bonus
-- ----------------------------
BEGIN;
INSERT INTO `activity_wheel_bonus` VALUES (1, 'jh', 7, 1, 'thanks', 0.00, 35, 0, 0, '🙈', '2026-02-09 08:40:44', '2026-02-10 15:10:04');
INSERT INTO `activity_wheel_bonus` VALUES (2, 'jh', 7, 2, '₱2', 2.00, 25, 0, 0, '💵', '2026-02-09 08:40:44', '2026-02-10 15:10:04');
INSERT INTO `activity_wheel_bonus` VALUES (3, 'jh', 7, 3, '₱5', 5.00, 18, 0, 0, '🎁', '2026-02-09 08:40:44', '2026-02-10 15:10:04');
INSERT INTO `activity_wheel_bonus` VALUES (4, 'jh', 7, 4, '₱8', 8.00, 10, 0, 0, '💎', '2026-02-09 08:40:44', '2026-02-10 15:10:04');
INSERT INTO `activity_wheel_bonus` VALUES (5, 'jh', 7, 5, '₱10', 10.00, 6, 0, 1, '💰', '2026-02-09 08:40:44', '2026-02-10 15:10:04');
INSERT INTO `activity_wheel_bonus` VALUES (6, 'jh', 7, 6, '20', 20.00, 3, 2, 2, '🏆', '2026-02-09 08:40:44', '2026-02-10 15:10:04');
INSERT INTO `activity_wheel_bonus` VALUES (7, 'jh', 7, 7, '₱50', 50.00, 2, 1, 4, '👑', '2026-02-09 08:40:44', '2026-02-10 15:10:04');
INSERT INTO `activity_wheel_bonus` VALUES (8, 'jh', 7, 8, '₱188', 188.00, 1, 1, 6, '🚀', '2026-02-09 08:40:44', '2026-02-10 15:10:04');
COMMIT;

-- ----------------------------
-- Table structure for ad
-- ----------------------------
DROP TABLE IF EXISTS `ad`;
CREATE TABLE `ad` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL,
  `type` tinyint NOT NULL DEFAULT '1',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `expired_time` timestamp NULL DEFAULT NULL,
  `sort` int NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `before_login` tinyint(1) NOT NULL DEFAULT '1',
  `position` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'banner图位置',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='广告';

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_role_id` int NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `switch_google2fa` tinyint(1) NOT NULL DEFAULT '0' COMMENT '二次验证开关。1=打开；0=关闭',
  `google2fa_secret` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '二次验证密钥',
  `transfer_audit_sound` tinyint(1) NOT NULL DEFAULT '1' COMMENT '转账.审核提示声音控制。0=关闭 1=播放一次；2=循环播放',
  `sound_loop_time` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '60' COMMENT '声音循环时间 单位秒',
  `payment_sound` tinyint(1) NOT NULL DEFAULT '0' COMMENT '第三方支付提示声音控制。0=关闭 1=播放一次',
  `last_login_ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_login_time` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `delete_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_site_id_index` (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='后台员工表';

-- ----------------------------
-- Records of admin
-- ----------------------------
BEGIN;
INSERT INTO `admin` VALUES (1, 1, 'admin', '超管', '$2a$10$Vb7kNiv0h3cZuDiRU5CwiuKHlrUN3KQA8lPKbC/lqXJkFqi62Wqp2', 1, 1, 1, 'SJX5ALIGCHJAHVGUIMBEANKJ62WKRZEK', 1, '6', 1, '127.0.0.1', '2026-02-26 16:24:08', '2017-11-04 17:22:28', '2026-02-26 16:24:08', NULL);
COMMIT;

-- ----------------------------
-- Table structure for admin_log
-- ----------------------------
DROP TABLE IF EXISTS `admin_log`;
CREATE TABLE `admin_log` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL,
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
  `type` tinyint NOT NULL COMMENT '权限类型；1=菜单；2=操作权限',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '权限名称',
  `backend_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '后端url',
  `frontend_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '前端url',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态。1=可用；0=禁用',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序。值越小，越靠前',
  `icon` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '菜单图标',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='权限表';

-- ----------------------------
-- Records of admin_permission
-- ----------------------------
BEGIN;
INSERT INTO `admin_permission` VALUES (1, 0, 1, '系统', NULL, 'sysSetting', 1, 0, 'settings', NULL, NULL);
INSERT INTO `admin_permission` VALUES (2, 1, 1, '全局设置', NULL, 'sysSetting/basicSetting', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (3, 2, 1, '基本信息', NULL, 'sysSetting/basicSetting/sysBasicSet', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (4, 1, 1, '员工账号', NULL, 'sysSetting/sysAdmins', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (5, 4, 1, '员工管理', NULL, 'sysSetting/sysAdmins/admin', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (6, 4, 1, '角色管理', NULL, 'sysSetting/sysAdmins/role', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (7, 1, 1, '后台日志', NULL, 'sysSetting/adminLog', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (9, 0, 1, '会员', NULL, 'userManage', 1, 0, 'users', NULL, NULL);
INSERT INTO `admin_permission` VALUES (10, 9, 1, '会员列表', NULL, 'userManage/user', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (11, 9, 1, '会员等级', NULL, 'userManage/userGrade', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (12, 9, 1, '会员日志', NULL, 'userManage/userLog', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (13, 0, 1, '财务', NULL, 'balanceManage', 1, 0, 'dollar-sign', NULL, NULL);
INSERT INTO `admin_permission` VALUES (14, 13, 1, '账变记录', NULL, 'balanceManage/balanceChange', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (15, 13, 1, '充值记录', NULL, 'balanceManage/depositHistory', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (16, 13, 1, '提现记录', NULL, 'balanceManage/withdrawalHistory', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (17, 13, 1, '加扣款', NULL, 'balanceManage/balanceOperate', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (18, 13, 1, '接口设置', NULL, 'balanceManage/apiSetting', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (19, 18, 1, '充值渠道', NULL, 'balanceManage/apiSetting/apiSettingPayment', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (20, 18, 1, '提现渠道', NULL, 'balanceManage/apiSetting/apiSettingWithdraw', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (22, 0, 1, '游戏', NULL, 'gameManage', 1, 0, 'gamepad-2', NULL, NULL);
INSERT INTO `admin_permission` VALUES (23, 22, 1, '游戏种类', NULL, 'gameManage/gameClass', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (24, 22, 1, '游戏列表', NULL, 'gameManage/game', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (25, 22, 1, '游戏记录', NULL, 'gameManage/gameRecord', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (26, 0, 1, '运营', NULL, 'operations', 1, 0, 'gift', NULL, NULL);
INSERT INTO `admin_permission` VALUES (27, 26, 1, '广告管理', NULL, 'operations/ads', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (28, 26, 1, '公告管理', NULL, 'operations/notices', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (29, 26, 1, '消息管理', NULL, 'operations/messages', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (30, 26, 1, '活动管理', NULL, 'operations/activities', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (31, 15, 1, '在线充值', NULL, 'balanceManage/depositHistory/depositHistoryOnline', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (32, 15, 1, '后台充值', NULL, 'balanceManage/depositHistory/depositHistorySystem', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (33, 16, 1, '在线提现', NULL, 'balanceManage/withdrawalHistory/withdrawalHistoryOnline', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (34, 16, 1, '后台提现', NULL, 'balanceManage/withdrawalHistory/withdrawalHistorySystem', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (35, 13, 1, '流水配置', NULL, 'balanceManage/flow', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (36, 35, 1, '流水规则', NULL, 'balanceManage/flow/flowRule', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (37, 35, 1, '流水记录', NULL, 'balanceManage/flow/flowRequirements', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (38, 30, 1, '活动配置', NULL, 'operations/activities/activitiesSetting', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (39, 30, 1, '大转盘记录', NULL, 'operations/activities/activitiesLucky', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (40, 30, 1, '充值送记录', NULL, 'operations/activities/activitiesDeposit', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (41, 30, 1, '注册送记录', NULL, 'operations/activities/activitiesRegister', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (42, 30, 1, '邀请送记录', NULL, 'operations/activities/activitiesInvite', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (43, 30, 1, '签到送记录', NULL, 'operations/activities/activitiesSignin', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (44, 26, 1, '全局报表', NULL, 'operations/report', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (45, 0, 1, '代理', NULL, 'agent', 1, 0, 'home', NULL, NULL);
INSERT INTO `admin_permission` VALUES (46, 45, 1, '代理设置', NULL, 'agent/agentSetting', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (47, 45, 1, '代理域名', NULL, 'agent/agentDomain', 1, 0, '', NULL, NULL);
INSERT INTO `admin_permission` VALUES (48, 45, 1, '代理结算', NULL, 'agent/agentSettle', 1, 0, '', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for admin_role
-- ----------------------------
DROP TABLE IF EXISTS `admin_role`;
CREATE TABLE `admin_role` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态。1=可用；0=禁用',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `permissions` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '权限列表。格式：权限id以,隔开',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色表';

-- ----------------------------
-- Records of admin_role
-- ----------------------------
BEGIN;
INSERT INTO `admin_role` VALUES (1, 1, '管理员', 1, '2017-11-06 09:40:26', '2019-06-10 17:21:32', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,185');
COMMIT;

-- ----------------------------
-- Table structure for agent
-- ----------------------------
DROP TABLE IF EXISTS `agent`;
CREATE TABLE `agent` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `site_id` bigint NOT NULL COMMENT '站点ID',
  `parent_id` bigint NOT NULL DEFAULT '0' COMMENT '上级代理ID，0=顶级',
  `agent_code` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '代理编码(站点内唯一)',
  `agent_name` varchar(128) COLLATE utf8mb4_general_ci NOT NULL COMMENT '代理名称',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '1启用 0禁用',
  `settle_type` tinyint NOT NULL DEFAULT '1' COMMENT '1亏损分成 2流水分成',
  `rate` decimal(8,4) NOT NULL DEFAULT '0.0000' COMMENT '默认佣金比例',
  `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '备注',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_site_agent_code` (`site_id`,`agent_code`),
  KEY `idx_site_parent` (`site_id`,`parent_id`),
  KEY `idx_site_status` (`site_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='站点代理主表';

-- ----------------------------
-- Table structure for agent_domain
-- ----------------------------
DROP TABLE IF EXISTS `agent_domain`;
CREATE TABLE `agent_domain` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `site_id` bigint NOT NULL,
  `agent_id` bigint NOT NULL,
  `domain` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '代理域名/子域名',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '1启用 0禁用',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_site_domain` (`site_id`,`domain`),
  KEY `idx_agent` (`site_id`,`agent_id`),
  KEY `idx_site_status` (`site_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='站点代理域名绑定';

-- ----------------------------
-- Table structure for agent_settlement_daily
-- ----------------------------
DROP TABLE IF EXISTS `agent_settlement_daily`;
CREATE TABLE `agent_settlement_daily` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `site_id` bigint NOT NULL,
  `agent_id` bigint NOT NULL,
  `stat_date` date NOT NULL,
  `bet_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `valid_bet_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `win_loss` decimal(18,2) NOT NULL DEFAULT '0.00',
  `commission_amount` decimal(18,2) NOT NULL DEFAULT '0.00',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '0待结算 1已结算',
  `settled_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_site_agent_date` (`site_id`,`agent_id`,`stat_date`),
  KEY `idx_site_date` (`site_id`,`stat_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='代理每日结算';

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL COMMENT '站点ID',
  `admin_id` int NOT NULL COMMENT '员工ID',
  `event_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '业务触发编码',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '消息标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '消息内容',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态0=关闭，1=启用',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `message_site_id_event_code_uindex` (`site_id`,`event_code`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='消息模板';

-- ----------------------------
-- Records of message
-- ----------------------------
BEGIN;
INSERT INTO `message` VALUES (1, 1, 1, 'REGISTER_SYSTEM', '🎉 Registration Successful', 'Welcome aboard 🎊 Great promotions are waiting for you!', 1, '2026-02-10 02:19:12', '2026-02-10 02:52:00');
INSERT INTO `message` VALUES (2, 1, 1, 'DEPOSIT_SYSTEM', '💰 Deposit Successful', '{{amount}} has been credited ✅✨ Good luck and have fun!\n', 1, '2026-02-10 02:20:05', '2026-02-10 02:51:40');
INSERT INTO `message` VALUES (3, 1, 1, 'VIP_SYSTEM', '👑 VIP Upgrade Successful', 'Congrats! You are now {{grade_name}} 💎✨ Unlock more perks and rewards!\n', 1, '2026-02-10 02:20:51', '2026-02-10 02:51:21');
INSERT INTO `message` VALUES (4, 1, 1, 'WITHDRAW_SYSTEM', '🏧 Withdrawal Successful', '{{amount}} has been transferred ✅✨ Thank you for your support!', 1, '2026-02-10 02:21:26', '2026-02-10 02:51:01');
INSERT INTO `message` VALUES (5, 1, 1, 'REGISTER_ACTIVITY', '🎁 Registration Bonus Released', 'Your welcome bonus {{amount}} is here 💰✨ Start playing and win more!\n\n\n\n', 1, '2026-02-10 02:25:11', '2026-02-10 02:50:38');
INSERT INTO `message` VALUES (6, 1, 1, 'DEPOSIT_ACTIVITY', '🔥 Deposit Bonus Credited', 'Your bonus {{amount}} has been added 💎✨ The more you deposit, the more you earn!', 1, '2026-02-10 02:26:40', '2026-02-10 02:50:23');
INSERT INTO `message` VALUES (7, 1, 1, 'LUCKY_ACTIVITY', '🎯 Spin Prize Credited', 'Congrats! You won {{amount}} 🎉💰 Spin again and keep the luck going!\n', 1, '2026-02-10 02:28:04', '2026-02-10 02:50:06');
INSERT INTO `message` VALUES (8, 1, 1, 'SIGNIN_ACTIVITY', '✅ Sign-in Bonus Credited', 'Your sign-in reward {{amount}} is here 🎁✨ Keep signing in for bigger rewards!\n', 1, '2026-02-10 02:29:07', '2026-02-10 02:49:48');
INSERT INTO `message` VALUES (9, 1, 1, 'INVITE_ACTIVITY', '🎉 Invite Bonus Released', 'Your friend completed registration and deposit. {{amount}} has been credited 💰✨ Invite more, win more!', 1, '2026-02-10 02:29:44', '2026-02-10 02:49:31');
COMMIT;

-- ----------------------------
-- Table structure for mq_outbox
-- ----------------------------
DROP TABLE IF EXISTS `mq_outbox`;
CREATE TABLE `mq_outbox` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `event_type` varchar(64) NOT NULL COMMENT '事件类型，如 user_created / balance_transfer',
  `aggregate_type` varchar(64) NOT NULL COMMENT '聚合根类型，如 user / balance',
  `aggregate_id` varchar(64) NOT NULL COMMENT '聚合根ID，如 user_id / trade_no',
  `site_code` varchar(32) NOT NULL DEFAULT '' COMMENT '站点代码',
  `exchange` varchar(128) NOT NULL COMMENT 'MQ exchange',
  `routing_key` varchar(128) NOT NULL COMMENT 'MQ routing key',
  `payload` json NOT NULL COMMENT '发送到 MQ 的消息体',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态: 0=待发送, 1=已发送, 2=发送失败',
  `retry_count` int NOT NULL DEFAULT '0' COMMENT '重试次数',
  `next_retry_at` datetime DEFAULT NULL COMMENT '下次重试时间',
  `last_error` varchar(255) DEFAULT NULL COMMENT '最后一次发送错误信息',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_status_retry` (`status`,`next_retry_at`),
  KEY `idx_event` (`event_type`),
  KEY `idx_aggregate` (`aggregate_type`,`aggregate_id`),
  KEY `idx_site_code` (`site_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='MQ Outbox 表（可靠消息）';

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL,
  `type` tinyint NOT NULL DEFAULT '1',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `expired_time` timestamp NULL DEFAULT NULL,
  `sort` int NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `platform` tinyint NOT NULL DEFAULT '0',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='公告';

-- ----------------------------
-- Table structure for site
-- ----------------------------
DROP TABLE IF EXISTS `site`;
CREATE TABLE `site` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '站点标识',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '站点名称',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态。1=正常；0=禁用',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='站点表';

-- ----------------------------
-- Records of site
-- ----------------------------
BEGIN;
INSERT INTO `site` VALUES (1, 'jh', '极好', 1, '2019-05-21 11:15:24', '2019-06-01 10:59:25', NULL);
COMMIT;

-- ----------------------------
-- Table structure for site_activity
-- ----------------------------
DROP TABLE IF EXISTS `site_activity`;
CREATE TABLE `site_activity` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '站点CODE',
  `activity_id` int NOT NULL COMMENT '活动ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '活动名称',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '活动编码(全局唯一)',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '活动描述',
  `start_time` timestamp NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '结束时间',
  `fixed_params` json NOT NULL COMMENT '固定参数(JSON)',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '活动是否打开或者或者关闭。1=打开；0=关闭',
  `uri` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '活动uri地址',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `table` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '表名定义不同属性',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `site_activity_site_code_activity_id_uindex` (`site_code`,`activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='站点绑定活动表';

-- ----------------------------
-- Records of site_activity
-- ----------------------------
BEGIN;
INSERT INTO `site_activity` VALUES (1, 'jh', 7, 'LUCKY SPIN', 'LUCKY', 'Spin the wheel for free! Get 1 spin on register, 1 per deposit, and 1 per VIP upgrade. Prizes credited instantly!', '2026-01-31 16:00:00', '2027-01-31 16:00:00', '{\"segment_1_icon\": \"🙈\", \"segment_2_icon\": \"💵\", \"segment_3_icon\": \"🎁\", \"segment_4_icon\": \"💎\", \"segment_5_icon\": \"💰\", \"segment_6_icon\": \"🏆\", \"segment_7_icon\": \"👑\", \"segment_8_icon\": \"🚀\", \"segment_1_weight\": 35, \"segment_2_weight\": 25, \"segment_3_weight\": 18, \"segment_4_weight\": 10, \"segment_5_weight\": 6, \"segment_6_weight\": 3, \"segment_7_weight\": 2, \"segment_8_weight\": 1, \"segment_1_prize_name\": \"thanks\", \"segment_2_prize_name\": \"₱2\", \"segment_3_prize_name\": \"₱5\", \"segment_4_prize_name\": \"₱8\", \"segment_5_prize_name\": \"₱10\", \"segment_6_prize_name\": \"20\", \"segment_7_prize_name\": \"₱50\", \"segment_8_prize_name\": \"₱188\", \"segment_1_min_vip_level\": 0, \"segment_1_reward_amount\": 0, \"segment_2_min_vip_level\": 0, \"segment_2_reward_amount\": 2, \"segment_3_min_vip_level\": 0, \"segment_3_reward_amount\": 5, \"segment_4_min_vip_level\": 0, \"segment_4_reward_amount\": 8, \"segment_5_min_vip_level\": 1, \"segment_5_reward_amount\": 10, \"segment_6_min_vip_level\": 2, \"segment_6_reward_amount\": 20, \"segment_7_min_vip_level\": 4, \"segment_7_reward_amount\": 50, \"segment_8_min_vip_level\": 6, \"segment_8_reward_amount\": 188, \"segment_1_user_daily_win_limit\": 0, \"segment_2_user_daily_win_limit\": 0, \"segment_3_user_daily_win_limit\": 0, \"segment_4_user_daily_win_limit\": 0, \"segment_5_user_daily_win_limit\": 0, \"segment_6_user_daily_win_limit\": 2, \"segment_7_user_daily_win_limit\": 1, \"segment_8_user_daily_win_limit\": 1}', 1, '/lucky_activity', 0, 'activity_wheel_bonus', '2026-02-06 07:59:39', '2026-02-26 18:35:01');
INSERT INTO `site_activity` VALUES (2, 'jh', 6, 'DAILY CHECK-IN', 'SIGNIN', 'Check in every day to collect increasing rewards! Don\'t break your streak for bigger bonuses.', '2026-01-31 16:00:00', '2027-01-31 16:00:00', '{\"day_1\": 0, \"day_2\": 2, \"day_3\": 3, \"day_4\": 4, \"day_5\": 5, \"day_6\": 6, \"day_7\": 7, \"day_8\": 12, \"day_9\": 9, \"day_10\": 10, \"day_11\": 11, \"day_12\": 12, \"day_13\": 13, \"day_14\": 14, \"day_15\": 15, \"day_16\": 16, \"day_17\": 17, \"day_18\": 18, \"day_19\": 19, \"day_20\": 20, \"day_21\": 21, \"day_22\": 22, \"day_23\": 23, \"day_24\": 24, \"day_25\": 25, \"day_26\": 26, \"day_27\": 27, \"day_28\": 28, \"day_29\": 29, \"day_30\": 30, \"day_31\": 31, \"min_recharge_amount\": 100, \"min_valid_bet_amount\": 0}', 1, '/signin_activity', 1, 'activity_signin_bonus', '2026-02-06 07:59:39', '2026-02-26 18:35:01');
INSERT INTO `site_activity` VALUES (4, 'jh', 4, 'DEPOSIT BONUS', 'DEPOSIT', 'Get extra bonus on every deposit! The more you deposit, the bigger the reward.', '2026-01-31 00:00:00', '2027-01-01 00:00:00', '{\"reward_type\": 1, \"reward_amount\": 10, \"trigger_event\": 1, \"min_recharge_amount\": 200}', 1, '/deposit_activity', 0, 'activity_deposit_bonus', '2026-02-06 07:59:39', '2026-02-26 18:35:01');
INSERT INTO `site_activity` VALUES (5, 'jh', 3, 'REGISTER BONUS', 'REGISTER', 'New members get a free welcome bonus just for signing up! No deposit required.', '2026-01-31 16:00:00', '2027-01-31 16:00:00', '{\"limit_ip\": 100, \"limit_device\": 1, \"reward_amount\": 50}', 1, '/register_activity', 0, 'activity_register_bonus', '2026-02-06 07:59:39', '2026-02-26 18:35:01');
INSERT INTO `site_activity` VALUES (6, 'jh', 1, 'Invite Friends', 'INVITE', 'Invite your friends and earn rewards together! Get commission for every active referral.', '2025-12-28 08:00:00', '2026-11-27 08:00:00', '{\"reward_type\": 1, \"trigger_event\": 1, \"min_recharge_amount\": 500, \"inviter_reward_amount\": 20}', 0, '/invite_activity', 0, 'activity_invite_bonus', '2026-02-06 07:59:39', '2026-02-26 18:35:01');
COMMIT;

-- ----------------------------
-- Table structure for site_config
-- ----------------------------
DROP TABLE IF EXISTS `site_config`;
CREATE TABLE `site_config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL COMMENT '站点ID',
  `switch_register` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否开放注册。1=开放;0=关闭',
  `switch_grade` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否开放会员等级。1=开放;0=关闭',
  `register_time_interval` int NOT NULL DEFAULT '0' COMMENT '同一IP重复注册。设定时间内，同一IP将无法进行多次注册。0或留空表示不限制',
  `default_grade_id` int NOT NULL DEFAULT '0' COMMENT '默认用户等级ID',
  `default_level_id` int NOT NULL DEFAULT '0' COMMENT '默认用户层级ID',
  `default_agent_id` int NOT NULL DEFAULT '0' COMMENT '默认代理ID',
  `is_close` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否关站。1=是；0=否',
  `mobile_logo` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '手机端logo',
  `min_withdraw` int NOT NULL DEFAULT '1' COMMENT '单笔最低提现金额',
  `max_withdraw` int NOT NULL DEFAULT '9999999' COMMENT '单笔最高提现金额',
  `close_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '关站原因',
  `url_service` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客服链接',
  `url_tg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'telegram链接',
  `url_mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机域名',
  `web_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '网站主域名',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `switch_sign` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='站点配置';

-- ----------------------------
-- Records of site_config
-- ----------------------------
BEGIN;
INSERT INTO `site_config` VALUES (1, 1, 1, 1, 360, 1, 1, 0, 0, 'http://localhost:19000/uploads/jh/2026/02/71_1771946350.png', 1500, 2000, '红明安也政级平复把从队再转任。', '//localhost:8086', 'https://t.me/EdisonWang5566', '18164607455', 'PANALOW.CC', '2017-11-04 17:22:27', '2026-02-24 23:19:12', '0');
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL,
  `grade_id` int NOT NULL COMMENT '等级id',
  `agent_id` int NOT NULL COMMENT '代理id',
  `inviter_id` int DEFAULT '0' COMMENT '邀请人ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pay_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `register_ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `register_time` timestamp NULL DEFAULT NULL,
  `register_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '注册来源',
  `last_login_ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '最后登录ip',
  `last_login_time` timestamp NULL DEFAULT NULL COMMENT '最后登录时间',
  `last_login_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '最后登录地址',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `birthday` date DEFAULT NULL,
  `is_online` tinyint(1) NOT NULL DEFAULT '0',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '备注',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `pay_times` int NOT NULL DEFAULT '0' COMMENT '充值次数',
  `has_pass` tinyint NOT NULL DEFAULT '1' COMMENT '是否设置密码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_site_id_index` (`site_id`),
  KEY `idx_inviter_id` (`inviter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员表';

-- ----------------------------
-- Table structure for user_grade
-- ----------------------------
DROP TABLE IF EXISTS `user_grade`;
CREATE TABLE `user_grade` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL COMMENT '站点ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '会员等级名称',
  `rebate_percent_sports` decimal(5,4) NOT NULL DEFAULT '0.0000' COMMENT '额外返水比例: 体育',
  `rebate_percent_lottery` decimal(5,4) NOT NULL DEFAULT '0.0000' COMMENT '额外返水比例: 彩票',
  `rebate_percent_live` decimal(5,4) NOT NULL DEFAULT '0.0000' COMMENT '额外返水比例: 真人视讯',
  `rebate_percent_egame` decimal(5,4) NOT NULL DEFAULT '0.0000' COMMENT '额外返水比例: 电子游戏',
  `rebate_percent_poker` decimal(5,4) NOT NULL DEFAULT '0.0000' COMMENT '额外返水比例：棋牌',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态.1=可用；0=禁用',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `payment_limit` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '充值要求',
  `bet_limit` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '投注要求',
  `money_limit` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '升级送',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员等级表';

-- ----------------------------
-- Table structure for user_login_log
-- ----------------------------
DROP TABLE IF EXISTS `user_login_log`;
CREATE TABLE `user_login_log` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL,
  `user_id` int NOT NULL COMMENT '会员ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '会员用户名',
  `referer_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '来源网址',
  `login_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '登录网址',
  `login_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '登录时间',
  `login_ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '登录IP',
  `login_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '登录地址',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '操作系统',
  `network` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '网络',
  `screen` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '分辨率',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '浏览器',
  `device` tinyint NOT NULL DEFAULT '1' COMMENT '终端。1=电脑；2=手机；3=平板',
  `is_robot` tinyint(1) NOT NULL DEFAULT '0' COMMENT '判断是否是机器人登录。1=是；0=否',
  `created_at` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `user_login_log_username_index` (`username`),
  KEY `user_login_log_login_ip_index` (`login_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for user_message
-- ----------------------------
DROP TABLE IF EXISTS `user_message`;
CREATE TABLE `user_message` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL COMMENT '站点ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `message_id` int NOT NULL COMMENT '消息模板ID',
  `event_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '业务触发编码(冗余，便于查询)',
  `biz_id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '业务流水号(充值单号/升级记录等)',
  `amount` decimal(15,4) DEFAULT NULL COMMENT '涉及的金额',
  `grade_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '会员等级名称',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '消息标题(快照)',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '消息内容(快照)',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '0=未读 1=已读',
  `read_at` timestamp NULL DEFAULT NULL COMMENT '阅读时间',
  `delete_at` timestamp NULL DEFAULT NULL COMMENT '删除时间(软删)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_site_user_event_biz` (`site_id`,`user_id`,`event_code`,`biz_id`),
  KEY `idx_site_user_status` (`site_id`,`user_id`,`status`),
  KEY `idx_site_user_created` (`site_id`,`user_id`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户消息实例';

SET FOREIGN_KEY_CHECKS = 1;
