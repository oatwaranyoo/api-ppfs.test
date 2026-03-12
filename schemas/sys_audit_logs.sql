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

 Date: 12/03/2026 13:53:04
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_audit_logs
-- ----------------------------
DROP TABLE IF EXISTS `sys_audit_logs`;
CREATE TABLE `sys_audit_logs`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `action_type` enum('INSERT','UPDATE','DELETE') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ประเภทการกระทำ',
  `table_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ตารางที่เกิดการเปลี่ยนแปลง',
  `record_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'PK ของเรคคอร์ดที่เปลี่ยน',
  `old_values` json NULL COMMENT 'ข้อมูลเดิมก่อนเปลี่ยน',
  `new_values` json NULL COMMENT 'ข้อมูลใหม่ที่บันทึก',
  `acted_by` int NOT NULL COMMENT 'Reference sys_users.id ผู้กระทำ',
  `acted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'เวลาที่กระทำ',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'ประวัติการแก้ไขข้อมูลสำคัญ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_audit_logs
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
