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

 Date: 16/03/2026 22:35:50
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_users
-- ----------------------------
DROP TABLE IF EXISTS `sys_users`;
CREATE TABLE `sys_users`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ชื่อผู้ใช้งานสำหรับ Login',
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รหัสผ่านที่ถูก Hash แล้ว',
  `first_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ชื่อจริง',
  `last_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'นามสกุล',
  `position` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'ตำแหน่ง',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'เบอร์โทรศัพท์',
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'อีเมล',
  `department_id` int NOT NULL COMMENT 'รหัสกลุ่มงาน (FK -> mst_departments)',
  `role` enum('admin','uploader') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ระดับสิทธิ์การใช้งาน',
  `status` enum('active','suspended') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'active' COMMENT 'สถานะการใช้งาน (ปกติ/ระงับ)',
  `failed_attempts` int NULL DEFAULT 0 COMMENT 'จำนวนครั้งที่ล็อกอินผิด (Anti-Brute Force)',
  `locked_until` timestamp NULL DEFAULT NULL COMMENT 'เวลาที่ปลดล็อคหากผิดเกินกำหนด',
  `token_version` int NULL DEFAULT 1 COMMENT 'เวอร์ชันของ JWT (รัน +1 เมื่อ Logout เพื่อทำลาย Token เก่า)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'วันที่สร้างบัญชี',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'ข้อมูลผู้ใช้งานและระบบจัดการสิทธิ์' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_users
-- ----------------------------
INSERT INTO `sys_users` VALUES (1, 'admin', '$2y$10$IHrOyfDH31G3R0Y1EZi1FOXvPruN3UV85E.k.zOd33bezoTpINon2', 'System', 'Admin', 'ผู้ดูแลระบบ', NULL, 'admin@example.com', 1, 'admin', 'active', 0, NULL, 1, '2026-03-11 15:04:46');

SET FOREIGN_KEY_CHECKS = 1;
