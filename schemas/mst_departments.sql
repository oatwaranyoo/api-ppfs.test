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

 Date: 16/03/2026 22:36:21
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for mst_departments
-- ----------------------------
DROP TABLE IF EXISTS `mst_departments`;
CREATE TABLE `mst_departments`  (
  `department_id` int NOT NULL AUTO_INCREMENT COMMENT 'รหัสกลุ่มงาน',
  `department_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'รหัสย่อ/รหัสประจำกลุ่มงาน',
  `department_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ชื่อกลุ่มงาน',
  `is_active` tinyint(1) NULL DEFAULT 1 COMMENT '1=ใช้งาน, 0=ระงับ',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'วันเวลาที่สร้างข้อมูล',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'วันเวลาที่แก้ไขข้อมูลล่าสุด',
  PRIMARY KEY (`department_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'ข้อมูลกลุ่มงานของผู้ใช้งาน' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mst_departments
-- ----------------------------
INSERT INTO `mst_departments` VALUES (1, 'ADMIN', 'ผู้ดูแลระบบ (Admin)', 1, '2026-03-11 15:57:39', '2026-03-11 15:57:39');
INSERT INTO `mst_departments` VALUES (2, 'DEP01', 'บริหารทั่วไป', 1, '2026-03-11 15:57:39', '2026-03-11 15:57:39');
INSERT INTO `mst_departments` VALUES (3, 'DEP02', 'พัฒนายุทธศาสตร์สาธารณสุข', 1, '2026-03-11 15:57:39', '2026-03-11 15:57:39');
INSERT INTO `mst_departments` VALUES (4, 'DEP03', 'ประกันสุขภาพ', 1, '2026-03-11 15:57:39', '2026-03-11 15:57:39');
INSERT INTO `mst_departments` VALUES (5, 'DEP04', 'พัฒนาคุณภาพและรูปแบบบริการ', 1, '2026-03-11 15:57:39', '2026-03-11 15:57:39');
INSERT INTO `mst_departments` VALUES (6, 'DEP05', 'ส่งเสริมสุขภาพ', 1, '2026-03-11 15:57:39', '2026-03-11 15:57:39');
INSERT INTO `mst_departments` VALUES (7, 'DEP06', 'ควบคุมโรคติดต่อ', 1, '2026-03-11 15:57:39', '2026-03-11 15:57:39');
INSERT INTO `mst_departments` VALUES (8, 'DEP07', 'การแพทย์แผนไทยและการแพทย์ทางเลือก', 1, '2026-03-11 15:57:39', '2026-03-11 15:57:39');
INSERT INTO `mst_departments` VALUES (9, 'DEP08', 'ควบคุมโรคไม่ติดต่อ ยาเสพติดและสุขภาพจิต', 1, '2026-03-11 15:57:39', '2026-03-11 15:57:39');
INSERT INTO `mst_departments` VALUES (10, 'DEP09', 'คุ้มครองผู้บริโภคและเภสัชสาธารณสุข', 1, '2026-03-11 15:57:39', '2026-03-11 15:57:39');
INSERT INTO `mst_departments` VALUES (11, 'DEP10', 'บริหารทรัพยากรบุคคล', 1, '2026-03-11 15:57:39', '2026-03-11 15:57:39');
INSERT INTO `mst_departments` VALUES (12, 'DEP11', 'กฎหมาย', 1, '2026-03-11 15:57:39', '2026-03-11 15:57:39');
INSERT INTO `mst_departments` VALUES (13, 'DEP12', 'อนามัยสิ่งแวดล้อม', 1, '2026-03-11 15:57:39', '2026-03-11 15:57:39');
INSERT INTO `mst_departments` VALUES (14, 'DEP13', 'ปฐมภูมิและเครือข่ายสุขภาพ', 1, '2026-03-11 15:57:39', '2026-03-11 15:57:39');
INSERT INTO `mst_departments` VALUES (15, 'DEP14', 'ทันตสาธารณสุข', 1, '2026-03-11 15:57:39', '2026-03-11 15:57:39');
INSERT INTO `mst_departments` VALUES (16, 'DEP15', 'สุขภาพดิจิทัล', 1, '2026-03-11 15:57:39', '2026-03-11 15:57:39');

SET FOREIGN_KEY_CHECKS = 1;
