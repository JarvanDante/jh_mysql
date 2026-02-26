/*
 Navicat MySQL Data Transfer

 Source Server         : 888--本地数据库
 Source Server Type    : MySQL
 Source Server Version : 80032
 Source Host           : localhost:3306
 Source Schema         : jh_balance

 Target Server Type    : MySQL
 Target Server Version : 80032
 File Encoding         : 65001

 Date: 26/02/2026 21:13:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for balance_callback_log
-- ----------------------------
DROP TABLE IF EXISTS `balance_callback_log`;
CREATE TABLE `balance_callback_log` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `site_id` int NOT NULL DEFAULT '0' COMMENT '站点ID',
  `callback_type` tinyint NOT NULL DEFAULT '1' COMMENT '回调类型 1=充值 2=提现',
  `order_sn` varchar(64) NOT NULL DEFAULT '' COMMENT '订单号',
  `trade_status` varchar(32) DEFAULT NULL COMMENT '交易状态',
  `actual_amount` decimal(15,4) DEFAULT NULL COMMENT '实际金额',
  `failure_reason` varchar(255) NOT NULL DEFAULT '' COMMENT '失败原因',
  `failure_stage` varchar(64) NOT NULL DEFAULT '' COMMENT '失败阶段',
  `request_data` text COMMENT '请求数据(JSON)',
  `error_message` text COMMENT '错误详情',
  `retry_count` int NOT NULL DEFAULT '0' COMMENT '重试次数',
  `is_resolved` tinyint NOT NULL DEFAULT '0' COMMENT '是否已解决 0=未解决 1=已解决',
  `resolved_at` datetime DEFAULT NULL COMMENT '解决时间',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_order_sn` (`order_sn`),
  KEY `idx_site_callback` (`site_id`,`callback_type`,`created_at`),
  KEY `idx_is_resolved` (`is_resolved`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='支付回调失败日志表';

-- ----------------------------
-- Table structure for balance_change
-- ----------------------------
DROP TABLE IF EXISTS `balance_change`;
CREATE TABLE `balance_change` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL COMMENT '站点ID',
  `trade_type` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '交易类型。1=转入；2=充值；3=红利；4=返水；5=转出；6=提现成功；7=提现返回；8=提现冻结；9=丢失补款；10=多出扣款',
  `user_id` int NOT NULL COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `trade_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '流水号',
  `balance_old` decimal(15,4) NOT NULL COMMENT '旧的可用余额',
  `money` decimal(15,4) NOT NULL COMMENT '变动金额',
  `balance_new` decimal(15,4) NOT NULL COMMENT '新的可用余额',
  `balance_frozen` decimal(15,4) NOT NULL COMMENT '新的冻结余额',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '账变状态0=初始化，1=待处理；2=处理中；3=成功；4=失败',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `balance_change_username_index` (`username`),
  KEY `balance_change_trade_no_index` (`trade_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员账变表';

-- ----------------------------
-- Table structure for balance_deposit_reward
-- ----------------------------
DROP TABLE IF EXISTS `balance_deposit_reward`;
CREATE TABLE `balance_deposit_reward` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL,
  `user_id` int NOT NULL,
  `date` date DEFAULT NULL COMMENT '充值日期年月日',
  `bonus_amount` decimal(12,2) NOT NULL COMMENT '发送金额',
  `trade_no` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '发放流水号/订单号',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_site_user_activity` (`site_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='活动-充值送彩金发放记录';

-- ----------------------------
-- Table structure for balance_flow_consume_retry
-- ----------------------------
DROP TABLE IF EXISTS `balance_flow_consume_retry`;
CREATE TABLE `balance_flow_consume_retry` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL,
  `user_id` bigint NOT NULL,
  `order_no` varchar(64) NOT NULL,
  `valid_amount` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `error_msg` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_site_user` (`site_id`,`user_id`),
  KEY `idx_order_no` (`order_no`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='流水消费失败重试记录';

-- ----------------------------
-- Table structure for balance_flow_consumed_bets
-- ----------------------------
DROP TABLE IF EXISTS `balance_flow_consumed_bets`;
CREATE TABLE `balance_flow_consumed_bets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL,
  `user_id` bigint NOT NULL,
  `order_no` varchar(64) NOT NULL,
  `consumed_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_site_user_order` (`site_id`,`user_id`,`order_no`),
  KEY `idx_consumed_at` (`consumed_at`),
  KEY `idx_site_user` (`site_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='流水消费幂等表（近期）';

-- ----------------------------
-- Table structure for balance_flow_requirement
-- ----------------------------
DROP TABLE IF EXISTS `balance_flow_requirement`;
CREATE TABLE `balance_flow_requirement` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `site_id` int NOT NULL DEFAULT '1' COMMENT '站点ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `username` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `source_type` tinyint NOT NULL DEFAULT '1' COMMENT '来源类型: 1=充值, 2=红利, 3=返水, 4=活动, 5=人工加款',
  `source_id` bigint NOT NULL DEFAULT '0' COMMENT '来源ID（充值订单ID、红利ID等）',
  `trade_no` varchar(64) NOT NULL DEFAULT '' COMMENT '关联交易号',
  `amount` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '触发金额（充值金额、红利金额等）',
  `bonus_amount` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '赠送金额（如果有）',
  `flow_multiple` decimal(10,2) NOT NULL DEFAULT '1.00' COMMENT '流水倍数（如：1倍、3倍、5倍）',
  `required_flow` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '需要完成的流水金额 = (amount + bonus_amount) * flow_multiple',
  `completed_flow` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '已完成的流水金额',
  `remaining_flow` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '剩余流水金额 = required_flow - completed_flow',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态: 1=进行中, 2=已完成, 3=已过期, 4=已取消',
  `progress` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '完成进度百分比（0-100）',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间（NULL表示永久有效）',
  `complete_time` datetime DEFAULT NULL COMMENT '完成时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注说明',
  `admin_id` int NOT NULL DEFAULT '0' COMMENT '操作管理员ID（人工操作时）',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_site_user_status` (`site_id`,`user_id`,`status`),
  KEY `idx_username` (`username`),
  KEY `idx_trade_no` (`trade_no`),
  KEY `idx_status` (`status`),
  KEY `idx_source` (`source_type`,`source_id`),
  KEY `idx_expire_time` (`expire_time`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='流水要求记录表';

-- ----------------------------
-- Table structure for balance_flow_rule
-- ----------------------------
DROP TABLE IF EXISTS `balance_flow_rule`;
CREATE TABLE `balance_flow_rule` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `site_id` int NOT NULL DEFAULT '1' COMMENT '站点ID',
  `rule_name` varchar(100) NOT NULL DEFAULT '' COMMENT '规则名称',
  `rule_type` tinyint NOT NULL DEFAULT '1' COMMENT '规则类型: 1=充值流水, 2=红利流水, 3=活动流水, 4=人工加款流水',
  `flow_multiple` decimal(10,2) NOT NULL DEFAULT '1.00' COMMENT '默认流水倍数',
  `expire_days` int NOT NULL DEFAULT '0' COMMENT '有效天数（0表示永久）',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态: 0=禁用, 1=启用',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注说明',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_site_rule_type` (`site_id`,`rule_type`),
  KEY `idx_site_type` (`site_id`,`rule_type`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='流水规则配置表';

-- ----------------------------
-- Table structure for balance_invite_reward
-- ----------------------------
DROP TABLE IF EXISTS `balance_invite_reward`;
CREATE TABLE `balance_invite_reward` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL DEFAULT '0',
  `inviter_id` int NOT NULL DEFAULT '0',
  `invitee_id` int NOT NULL DEFAULT '0',
  `date` date DEFAULT NULL COMMENT '邀请日期年月日',
  `bonus_amount` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '发送金额',
  `trade_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '最后触发订单号',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_site_invitee` (`site_id`,`invitee_id`),
  KEY `idx_site_inviter` (`site_id`,`inviter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='活动-邀请发彩金记录';

-- ----------------------------
-- Table structure for balance_log
-- ----------------------------
DROP TABLE IF EXISTS `balance_log`;
CREATE TABLE `balance_log` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL COMMENT '站点ID',
  `user_id` int NOT NULL COMMENT '会员ID',
  `trade_type` tinyint NOT NULL COMMENT '交易类型',
  `gateway` tinyint NOT NULL DEFAULT '0' COMMENT '支付相关：支付类型',
  `bank_type` tinyint NOT NULL DEFAULT '0' COMMENT '转账相关：银行类型',
  `game_id` tinyint NOT NULL DEFAULT '0' COMMENT '游戏相关：游戏ID',
  `trade_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '交易流水号',
  `money` decimal(15,4) NOT NULL COMMENT '金额',
  `actual_money` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '实际充值金额',
  `fee` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '手续费',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态0=初始化，1=待处理；2=处理中；3=成功；4=失败',
  `admin_id` int NOT NULL DEFAULT '0' COMMENT '后台员工ID',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `balance_log_site_id_trade_no_uindex` (`site_id`,`trade_no`),
  KEY `balance_log_trade_type_index` (`trade_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员资金总日志表';

-- ----------------------------
-- Table structure for balance_log_bonus
-- ----------------------------
DROP TABLE IF EXISTS `balance_log_bonus`;
CREATE TABLE `balance_log_bonus` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL COMMENT '站点ID',
  `trade_type` tinyint NOT NULL DEFAULT '1' COMMENT '交易类型。1=在线充值红利；2=转账汇款红利；3=生日红利；4=签到红利；',
  `user_id` int NOT NULL COMMENT '会员ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '会员用户名',
  `trade_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '流水号',
  `activity_recharge_id` int NOT NULL DEFAULT '0' COMMENT '充值活动ID',
  `money` decimal(15,4) NOT NULL COMMENT '金额',
  `fee` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '手续费',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态0=初始化，1=待处理；2=处理中；3=成功；4=失败',
  `admin_id` int NOT NULL DEFAULT '0' COMMENT '后台管理员ID。默认为0',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `balance_log_bonus_trade_no_index` (`trade_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员红利总日志表';

-- ----------------------------
-- Table structure for balance_log_game
-- ----------------------------
DROP TABLE IF EXISTS `balance_log_game`;
CREATE TABLE `balance_log_game` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL COMMENT '站点ID',
  `user_id` int NOT NULL COMMENT '会员ID',
  `game_id` int NOT NULL COMMENT '游戏ID',
  `in_or_out` tinyint(1) NOT NULL DEFAULT '0' COMMENT '转入还是转出；0=转出；1=转入',
  `trade_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '流水单号',
  `money` decimal(15,4) NOT NULL COMMENT '操作金额',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态0=初始化，1=待处理；2=处理中；3=成功；4=失败',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `third_party_trade_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '第三方订单号',
  `key` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '第三方游戏key',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员游戏日志表';

-- ----------------------------
-- Table structure for balance_log_manual
-- ----------------------------
DROP TABLE IF EXISTS `balance_log_manual`;
CREATE TABLE `balance_log_manual` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL COMMENT '站点ID',
  `trade_type` tinyint NOT NULL COMMENT '交易类型。1=加款-充值；2=加款-红利；3=加款-返水；4=补款（不入充值记录），5=扣款 - 提现，6=扣款（不入提现记录）7=第三方加款（不入账变）,8=第三方扣款（不入账变）;9=第三方账户 -> 中心账户;10=中心账户 -> 第三方账户',
  `user_id` int NOT NULL COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '会员用户名',
  `game_id` int NOT NULL DEFAULT '0' COMMENT '游戏ID',
  `trade_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '流水号',
  `money` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '金额',
  `fee` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '手续费',
  `water_times` int NOT NULL DEFAULT '0' COMMENT '流水倍数',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态0=初始化，1=待处理；2=处理中；3=成功；4=失败',
  `admin_id` int NOT NULL DEFAULT '0' COMMENT '后台管理员ID',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `balance_log_manual_user_id_index` (`user_id`),
  KEY `balance_log_manual_trade_no_index` (`trade_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员资金手动操作日志表';

-- ----------------------------
-- Table structure for balance_log_payment
-- ----------------------------
DROP TABLE IF EXISTS `balance_log_payment`;
CREATE TABLE `balance_log_payment` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL COMMENT '站点ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '会员用户名',
  `activity_recharge_id` int NOT NULL DEFAULT '0' COMMENT '充值活动ID',
  `gateway` tinyint NOT NULL COMMENT '网关类型',
  `payment_id` int NOT NULL COMMENT '支付ID',
  `payment_account_id` int NOT NULL COMMENT '支付接口账号ID',
  `bank_value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '银行代码',
  `trade_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '流水号',
  `money` decimal(15,4) NOT NULL COMMENT '充值金额',
  `actual_money` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '实际充值金额',
  `fee` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '手续费',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态0=初始化，1=待处理；2=处理中；3=成功；4=失败',
  `admin_id` int NOT NULL DEFAULT '0' COMMENT '后台管理员ID。默认为0',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `balance_log_payment_trade_no_index` (`trade_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员资金在线充值日志表';

-- ----------------------------
-- Table structure for balance_log_rebate
-- ----------------------------
DROP TABLE IF EXISTS `balance_log_rebate`;
CREATE TABLE `balance_log_rebate` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL COMMENT '站点ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '会员用户名',
  `trade_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '流水号',
  `last_bet_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '注单记录游标ID',
  `valid_bet_amount` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '有效投注总金额',
  `money` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '返水金额',
  `fee` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '手续费',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态0=初始化，1=待处理；2=处理中；3=成功；4=失败',
  `admin_id` int NOT NULL DEFAULT '0' COMMENT '后台管理员ID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `balance_log_rebate_trade_no_index` (`trade_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员资金返水日志表';

-- ----------------------------
-- Table structure for balance_log_transfer
-- ----------------------------
DROP TABLE IF EXISTS `balance_log_transfer`;
CREATE TABLE `balance_log_transfer` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL COMMENT '站点ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '会员用户名',
  `activity_recharge_id` int NOT NULL DEFAULT '0' COMMENT '充值活动ID',
  `bank_type` tinyint NOT NULL COMMENT '转账汇款类型',
  `account_id` int NOT NULL COMMENT '转账汇款账号ID',
  `trade_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '流水号',
  `third_trade_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '第三方订单号',
  `money` decimal(15,4) NOT NULL COMMENT '充值金额',
  `fee` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '手续费',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态0=初始化，1=待处理；2=处理中；3=成功；4=失败',
  `transfer_account` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '汇款账户名',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '随机码。其实就是会员用户名',
  `admin_id` int NOT NULL DEFAULT '0' COMMENT '操作人id',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `balance_log_transfer_trade_no_index` (`trade_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员转账汇款日志表';

-- ----------------------------
-- Table structure for balance_log_withdraw
-- ----------------------------
DROP TABLE IF EXISTS `balance_log_withdraw`;
CREATE TABLE `balance_log_withdraw` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL COMMENT '站点ID',
  `user_id` int NOT NULL COMMENT '会员ID',
  `user_level_id` int NOT NULL DEFAULT '0' COMMENT '会员层级ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '会员用户名',
  `trade_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '流水号',
  `money` decimal(15,4) NOT NULL COMMENT '充值金额',
  `fee` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '手续费',
  `bank_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '提现银行',
  `card_account` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '银行户名',
  `card_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '卡号',
  `deposit_bank` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '开户行',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态0=初始化，1=待处理；2=处理中；3=成功；4=失败',
  `admin_id` int NOT NULL DEFAULT '0' COMMENT '后台用户ID',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `balance_log_withdraw_trade_no_index` (`trade_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员提款日志表';

-- ----------------------------
-- Table structure for balance_rebate_history
-- ----------------------------
DROP TABLE IF EXISTS `balance_rebate_history`;
CREATE TABLE `balance_rebate_history` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int unsigned NOT NULL COMMENT '站点ID',
  `rebate_date` date NOT NULL COMMENT '返水日期',
  `user_count` int unsigned NOT NULL DEFAULT '0' COMMENT '返水人数',
  `valid_bet_amount` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '有效投注金额',
  `money` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '返水金额',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `balance_rebate_history_rebate_date_index` (`rebate_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='返水历史表';

-- ----------------------------
-- Table structure for balance_register_reward
-- ----------------------------
DROP TABLE IF EXISTS `balance_register_reward`;
CREATE TABLE `balance_register_reward` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL,
  `user_id` int NOT NULL,
  `date` date DEFAULT NULL COMMENT '注册日期年月日',
  `register_ip` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '注册IP',
  `device_id` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '设备ID',
  `bonus_amount` decimal(12,2) NOT NULL,
  `trade_no` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '发放流水号/订单号',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_site_user` (`site_id`,`user_id`),
  KEY `idx_register_ip` (`site_id`,`register_ip`),
  KEY `idx_device_id` (`site_id`,`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='活动-注册送彩金发放记录';

-- ----------------------------
-- Table structure for balance_signin_reward
-- ----------------------------
DROP TABLE IF EXISTS `balance_signin_reward`;
CREATE TABLE `balance_signin_reward` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL,
  `user_id` int NOT NULL,
  `date` date NOT NULL COMMENT '签到日期年月日',
  `day_no` tinyint NOT NULL COMMENT '日号(1-31)',
  `bonus_amount` decimal(12,2) NOT NULL COMMENT '发送金额',
  `trade_no` varchar(64) COLLATE utf8mb4_general_ci NOT NULL COMMENT '发放流水号/订单号',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_site_user_date` (`site_id`,`user_id`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='活动-签到送彩金发放记录';

-- ----------------------------
-- Table structure for balance_user
-- ----------------------------
DROP TABLE IF EXISTS `balance_user`;
CREATE TABLE `balance_user` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL COMMENT '站点ID',
  `user_id` int NOT NULL COMMENT '会员ID',
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '会员用户名',
  `balance` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '可用金额',
  `balance_frozen` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '冻结金额',
  `balance_debt` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '负债金额。防止账户余额出现负数的情况。例如：注单结算错误，需要扣掉会员账户金额。如果会员账户金额足够，则直接扣除会员账户金额；如果会员账户金额不足，则不扣除会员账户金额，直接存入负债金额。在下次会员有资金变动的时候，先来计算这笔金额',
  `points` int NOT NULL DEFAULT '0' COMMENT '会员积分',
  `balance_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '资金状态。1=正常；0=锁定',
  `currency` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'MMK' COMMENT '币类型',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `balance_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员资金表';

-- ----------------------------
-- Table structure for balance_wheel_reward
-- ----------------------------
DROP TABLE IF EXISTS `balance_wheel_reward`;
CREATE TABLE `balance_wheel_reward` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL COMMENT '站点ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `date` date NOT NULL COMMENT '抽奖日期(yyyy-mm-dd)',
  `segment_no` tinyint unsigned NOT NULL COMMENT '命中扇区(1~12)',
  `prize_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '奖项名称',
  `reward_amount` decimal(12,2) NOT NULL COMMENT '中奖金额',
  `trade_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '发放流水号/订单号',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_site_trade_no` (`site_id`,`trade_no`),
  KEY `idx_site_user_date` (`site_id`,`user_id`,`date`),
  KEY `idx_site_date` (`site_id`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='活动-大转盘中奖记录';

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
-- Table structure for site_payment
-- ----------------------------
DROP TABLE IF EXISTS `site_payment`;
CREATE TABLE `site_payment` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL COMMENT '站点ID',
  `payment_id` int NOT NULL DEFAULT '0' COMMENT '总站里支付ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `gateway` tinyint NOT NULL COMMENT '支付网关1在线支付2银行',
  `api_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '支付域名',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='站点绑定支付';

-- ----------------------------
-- Table structure for site_withdraw
-- ----------------------------
DROP TABLE IF EXISTS `site_withdraw`;
CREATE TABLE `site_withdraw` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL COMMENT '站点ID',
  `withdraw_id` int NOT NULL DEFAULT '0' COMMENT '总站里提现ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `gateway` tinyint NOT NULL COMMENT '提现网关1在线支付2银行',
  `api_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '提现请求地址',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='站点绑定提现';

-- ----------------------------
-- Table structure for user_bank
-- ----------------------------
DROP TABLE IF EXISTS `user_bank`;
CREATE TABLE `user_bank` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `site_id` int NOT NULL COMMENT '站点ID',
  `user_id` int NOT NULL COMMENT '会员ID',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '银行类型1=GCash,2=Maya',
  `card_account` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '银行账户名',
  `card_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '银行卡号',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '默认地址。1=默认，0=非默认',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='会员银行卡表';

-- ----------------------------
-- Table structure for user_report_total
-- ----------------------------
DROP TABLE IF EXISTS `user_report_total`;
CREATE TABLE `user_report_total` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `site_id` int NOT NULL COMMENT '站点ID',
  `user_id` bigint unsigned NOT NULL COMMENT '用户ID',
  `deposit_amount` decimal(18,4) NOT NULL DEFAULT '0.0000' COMMENT '累计充值总额',
  `bet_amount` decimal(18,4) NOT NULL DEFAULT '0.0000' COMMENT '累计有效投注总额',
  `last_deposit_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '充值记录游标ID',
  `last_bet_id` bigint unsigned NOT NULL DEFAULT '0' COMMENT '注单记录游标ID',
  `last_deposit_time` datetime DEFAULT NULL COMMENT '最近累计的充值时间',
  `last_bet_settle_time` datetime DEFAULT NULL COMMENT '最近累计的注单结算时间',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_site_user` (`site_id`,`user_id`),
  KEY `idx_site_updated` (`site_id`,`updated_at`),
  KEY `idx_site_user` (`site_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户累计统计(充值/有效投注)';

SET FOREIGN_KEY_CHECKS = 1;
