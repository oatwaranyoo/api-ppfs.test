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

 Date: 17/03/2026 11:04:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for trn_budget_allocation
-- ----------------------------
DROP TABLE IF EXISTS `trn_budget_allocation`;
CREATE TABLE `trn_budget_allocation`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fiscal_year` int NOT NULL COMMENT 'ปีงบประมาณ',
  `month_count` int NOT NULL DEFAULT 12 COMMENT 'จำนวนเดือนที่ใช้หารเฉลี่ย',
  `hoscode` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รหัสหน่วยบริการ',
  `sub_activity_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รหัสกิจกรรมย่อย',
  `visit_count` int NOT NULL DEFAULT 0 COMMENT 'จำนวนครั้งที่จัดสรร',
  `allocated_budget` decimal(15, 4) NOT NULL DEFAULT 0.0000 COMMENT 'จำนวนเงินจัดสรร',
  `batch_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'UUID สำหรับ Track รอบการนำเข้า',
  `is_valid` tinyint(1) NULL DEFAULT 0 COMMENT '0=รอ Finalize, 1=ใช้งานจริงแสดงผลบนบอร์ด (Shadow Publishing)',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int NULL DEFAULT NULL COMMENT 'ผู้ที่อัปโหลด (Reference sys_users.id)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_budget`(`fiscal_year` ASC, `hoscode` ASC, `sub_activity_id` ASC, `batch_id` ASC) USING BTREE,
  INDEX `idx_budget_query`(`fiscal_year` ASC, `hoscode` ASC) USING BTREE,
  INDEX `idx_batch`(`batch_id` ASC) USING BTREE,
  INDEX `idx_finalize`(`fiscal_year` ASC, `hoscode` ASC, `sub_activity_id` ASC, `batch_id` ASC) USING BTREE,
  INDEX `idx_valid`(`is_valid` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'ข้อมูลเงินและเป้าหมายจัดสรรเริ่มต้น' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of trn_budget_allocation
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
