/*
 Navicat Premium Dump SQL

 Source Server         : laragon (oat)
 Source Server Type    : MySQL
 Source Server Version : 80403 (8.4.3)
 Source Host           : localhost:3306
 Source Schema         : oat_ppfs_new

 Target Server Type    : MySQL
 Target Server Version : 80403 (8.4.3)
 File Encoding         : 65001

 Date: 16/03/2026 11:00:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_upload_locks
-- ----------------------------
DROP TABLE IF EXISTS `sys_upload_locks`;
CREATE TABLE `sys_upload_locks`  (
  `scope_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'เช่น target_2569_10702, perf_2569_10702',
  `batch_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'UUID ของรอบการอัปโหลด',
  `locked_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'เวลาที่ล็อก (Heartbeat)',
  `locked_by` int NOT NULL COMMENT 'ผู้ที่กำลังอัปโหลด (Reference sys_users.id)',
  PRIMARY KEY (`scope_key`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'ระบบจัดการ Lock ป้องกันการอัปโหลดชนกัน' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_upload_locks
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
