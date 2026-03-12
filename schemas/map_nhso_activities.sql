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

 Date: 12/03/2026 14:51:13
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for map_nhso_activities
-- ----------------------------
DROP TABLE IF EXISTS `map_nhso_activities`;
CREATE TABLE `map_nhso_activities`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `fiscal_year` int NOT NULL COMMENT 'ปีงบประมาณ',
  `sub_activity_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รหัสกิจกรรมย่อยที่ผูกด้วย (FK)',
  `mapping_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รายละเอียด Mapping',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_map`(`fiscal_year` ASC, `mapping_desc` ASC, `sub_activity_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 109 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'ตารางเชื่อมโยงข้อมูลรหัส สปสช กับกิจกรรมย่อยในระบบ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of map_nhso_activities
-- ----------------------------
INSERT INTO `map_nhso_activities` VALUES (41, 2568, '25681801', '01 บริการถ่ายภาพรังสีทรวงอก CXR เพื่อวินิจฉัยวัณโรค ');
INSERT INTO `map_nhso_activities` VALUES (6, 2568, '25680201', '01_ Hb typing');
INSERT INTO `map_nhso_activities` VALUES (30, 2568, '25681301', '01_Fit Test');
INSERT INTO `map_nhso_activities` VALUES (17, 2568, '25680501', '01_การตรวจหลังคลอด');
INSERT INTO `map_nhso_activities` VALUES (51, 2568, '25682201', '01_การทดสอบการตั้งครรภ์ (Pregnancy test)');
INSERT INTO `map_nhso_activities` VALUES (9, 2568, '25680301', '01_การเจาะเลือดปั่นซีรั่ม');
INSERT INTO `map_nhso_activities` VALUES (31, 2568, '25681401', '01_คัดกรองมะเร็งปากมดลูกด้วยวิธี pap smear');
INSERT INTO `map_nhso_activities` VALUES (47, 2568, '25682001', '01_คัดกรองโรคไวรัสตับอักเสบ ซี');
INSERT INTO `map_nhso_activities` VALUES (46, 2568, '25681901', '01_คัดกรองไวรัสตับอักเสบ บี');
INSERT INTO `map_nhso_activities` VALUES (1, 2568, '25680101', '01_บริการดูแลการฝากครรภ์');
INSERT INTO `map_nhso_activities` VALUES (29, 2568, '25681201', '01_บริการตัดและตรวจชิ้นเนื้อ ซึ่งประกอบด้วยค่า biopsy และค่าตรวจทางพยาธิวิทยา');
INSERT INTO `map_nhso_activities` VALUES (28, 2568, '25681001', '01_บริการเคลือบฟลูออไรด์ (กลุ่มเสี่ยง)');
INSERT INTO `map_nhso_activities` VALUES (52, 2568, '25682301', '01_บริการเจาะเลือดและตรวจนับเม็ดเลือดอย่างสมบูรณ์ (CBC)');
INSERT INTO `map_nhso_activities` VALUES (40, 2568, '25681601', '01_ประเมินความเสี่ยงทางพันธุกรรม');
INSERT INTO `map_nhso_activities` VALUES (16, 2568, '25680401', '01_ยา Medabon');
INSERT INTO `map_nhso_activities` VALUES (53, 2568, '25682401', '01_ยาเม็ดเสริมธาตุเหล็ก (Ferrofolic)');
INSERT INTO `map_nhso_activities` VALUES (25, 2568, '25680905', '01_ห่วงอนามัยคุมกำเนิด');
INSERT INTO `map_nhso_activities` VALUES (19, 2568, '25680801', '01_แว่นตาเลนส์สายตาผิดปกติทั่วไป (Stock lens)');
INSERT INTO `map_nhso_activities` VALUES (45, 2568, '25681806', '02_1 บริการตรวจเสมหะ AFB');
INSERT INTO `map_nhso_activities` VALUES (7, 2568, '25680202', '02_Alpha–thalassemia 1 (PCR)');
INSERT INTO `map_nhso_activities` VALUES (2, 2568, '25680102', '02_Lab 7 รายการ');
INSERT INTO `map_nhso_activities` VALUES (39, 2568, '25681501', '02_Mammogram (bilateral) ดิจิทัล with ultrasound of breasts');
INSERT INTO `map_nhso_activities` VALUES (33, 2568, '25681402', '02_คัดกรองมะเร็งปากมดลูกด้วยวิธี VIA');
INSERT INTO `map_nhso_activities` VALUES (14, 2568, '25680309', '02_ค่าตรวจ VDRL การคัดกรองซิฟิลิส (สามี)');
INSERT INTO `map_nhso_activities` VALUES (26, 2568, '25680907', '02_ยาฝังคุมกำเนิด');
INSERT INTO `map_nhso_activities` VALUES (18, 2568, '25680502', '02_ยาเสริมธาตุเหล็กหลังคลอด');
INSERT INTO `map_nhso_activities` VALUES (10, 2568, '25680302', '02_เจาะเลือดและส่งตรวจ');
INSERT INTO `map_nhso_activities` VALUES (20, 2568, '25680802', '02_แว่นตาเลนส์สายตาผิดปกติทีต้องสั่งตัดพิเศษ (Lab lens)');
INSERT INTO `map_nhso_activities` VALUES (44, 2568, '25681804', '03_3 บริการตรวจ Molecular assay วิธี Real-time PCR MDR เพื่อวินิจฉัยวัณโรคในกลุ่มเสี่ยงสูง');
INSERT INTO `map_nhso_activities` VALUES (42, 2568, '25681802', '03_4 บริการตรวจ TB LAMP เพื่อวินิจฉัยวัณโรคในกลุ่มเสี่ยงสูง ');
INSERT INTO `map_nhso_activities` VALUES (3, 2568, '25680103', '03_Lab 2 รายการ');
INSERT INTO `map_nhso_activities` VALUES (34, 2568, '25681403', '03_คัดกรองมะเร็งปากมดลูกด้วยวิธี HPV DNA Test');
INSERT INTO `map_nhso_activities` VALUES (15, 2568, '25680310', '03_ค่าตรวจ TPHA การคัดกรองซิฟิลิส (สามี)');
INSERT INTO `map_nhso_activities` VALUES (48, 2568, '25682003', '03_ตรวจยืนยัน HCV RNA');
INSERT INTO `map_nhso_activities` VALUES (21, 2568, '25680901', '03_ยาเม็ดคุมกำเนิด COC');
INSERT INTO `map_nhso_activities` VALUES (49, 2568, '25682101', '03_เจาะเลือด ส่งตรวจวัดระดับน้ำตาล (FPG)');
INSERT INTO `map_nhso_activities` VALUES (32, 2568, '25681402', '031_บริการเก็บตัวอย่าง');
INSERT INTO `map_nhso_activities` VALUES (35, 2568, '25681404', '0321_น้ำยาตรวจHPV 16,18 and other types');
INSERT INTO `map_nhso_activities` VALUES (36, 2568, '25681405', '0322_น้ำยาตรวจ HPV 14 high risk types');
INSERT INTO `map_nhso_activities` VALUES (37, 2568, '25681406', '0323_บริการตรวจทางเซลล์วิทยาด้วย วิธี Liquid based cytology');
INSERT INTO `map_nhso_activities` VALUES (43, 2568, '25681803', '04_2 บริการตรวจ Molecular assay ด้วยวิธี Xpert MTB/RIF ');
INSERT INTO `map_nhso_activities` VALUES (11, 2568, '25680305', '04_PND');
INSERT INTO `map_nhso_activities` VALUES (8, 2568, '25680205', '04_การทำหัตถการเพื่อวินิจฉัยทารกในครรภ์ (PND)');
INSERT INTO `map_nhso_activities` VALUES (38, 2568, '25681407', '04_ตรวจยืนยันด้วยวิธี Colposcope');
INSERT INTO `map_nhso_activities` VALUES (4, 2568, '25680104', '04_บริการตรวจอัลตราซาวด์');
INSERT INTO `map_nhso_activities` VALUES (22, 2568, '25680902', '04_ยาเม็ดคุมกำเนิด POP');
INSERT INTO `map_nhso_activities` VALUES (50, 2568, '25682102', '04_เจาะเลือดTotal Cholesterol หรือ HDL');
INSERT INTO `map_nhso_activities` VALUES (12, 2568, '25680306', '05_Karyotyping');
INSERT INTO `map_nhso_activities` VALUES (5, 2568, '25680105', '05_บริการตรวจสุขภาพช่องปากและบริการขัดทำความสะอาดฟัน');
INSERT INTO `map_nhso_activities` VALUES (23, 2568, '25680903', '05_ยาฉีดคุมกำเนิด');
INSERT INTO `map_nhso_activities` VALUES (13, 2568, '25680307', '06_การยุติการตั้งครรภ์บริการตรวจคัดกรองดาวน์ซินโดรม');
INSERT INTO `map_nhso_activities` VALUES (24, 2568, '25680904', '06_ยาเม็ดคุมกำเนิดฉุกเฉิน');
INSERT INTO `map_nhso_activities` VALUES (27, 2568, '25680908', '08_ถอดยาฝังคุมกำเนิด');
INSERT INTO `map_nhso_activities` VALUES (56, 2568, '25682503', 'dT (คอตีบ-บาดทะยัก)');
INSERT INTO `map_nhso_activities` VALUES (54, 2568, '25682501', 'ค่าบริการฉีดวัคซีนขั้นพื้นฐาน (EPI)');
INSERT INTO `map_nhso_activities` VALUES (55, 2568, '25682502', 'วัคซีนป้องกันโรคไข้หวัดใหญ่');
INSERT INTO `map_nhso_activities` VALUES (90, 2569, '25691801', '01 บริการถ่ายภาพรังสีทรวงอก CXR เพื่อวินิจฉัยวัณโรค ');
INSERT INTO `map_nhso_activities` VALUES (62, 2569, '25690201', '01_ Hb typing');
INSERT INTO `map_nhso_activities` VALUES (85, 2569, '25691301', '01_Fit Test');
INSERT INTO `map_nhso_activities` VALUES (63, 2569, '25690301', '01_การคัดกรองธาลัสซีเมีย');
INSERT INTO `map_nhso_activities` VALUES (71, 2569, '25690501', '01_การตรวจหลังคลอด');
INSERT INTO `map_nhso_activities` VALUES (73, 2569, '25690601', '01_การทดสอบการตั้งครรภ์ (Pregnancy test)');
INSERT INTO `map_nhso_activities` VALUES (66, 2569, '25690401', '01_การเจาะเลือดปั่นซีรั่ม');
INSERT INTO `map_nhso_activities` VALUES (77, 2569, '25691101', '01_คัดกรองมะเร็งปากมดลูกด้วยวิธี pap smear');
INSERT INTO `map_nhso_activities` VALUES (95, 2569, '25691901', '01_คัดกรองโรคไวรัสตับอักเสบ ซี');
INSERT INTO `map_nhso_activities` VALUES (94, 2569, '25691810', '01_คัดกรองไวรัสตับอักเสบ บี');
INSERT INTO `map_nhso_activities` VALUES (57, 2569, '25690101', '01_บริการดูแลการฝากครรภ์');
INSERT INTO `map_nhso_activities` VALUES (76, 2569, '25691001', '01_บริการตัดและตรวจชิ้นเนื้อ ซึ่งประกอบด้วยค่า biopsy และค่าตรวจทางพยาธิวิทยา');
INSERT INTO `map_nhso_activities` VALUES (88, 2569, '25691601', '01_บริการเคลือบฟลูออไรด์ (กลุ่มเสี่ยง)');
INSERT INTO `map_nhso_activities` VALUES (86, 2569, '25691401', '01_บริการเจาะเลือดและตรวจนับเม็ดเลือดอย่างสมบูรณ์ (CBC)');
INSERT INTO `map_nhso_activities` VALUES (89, 2569, '25691701', '01_ยา Medabon');
INSERT INTO `map_nhso_activities` VALUES (87, 2569, '25691501', '01_ยาเม็ดเสริมธาตุเหล็ก (Ferrofolic)');
INSERT INTO `map_nhso_activities` VALUES (101, 2569, '25692106', '01_ห่วงอนามัยคุมกำเนิด');
INSERT INTO `map_nhso_activities` VALUES (74, 2569, '25690901', '01_แว่นตาเลนส์สายตาผิดปกติทั่วไป (Stock lens)');
INSERT INTO `map_nhso_activities` VALUES (93, 2569, '25691806', '02_1 บริการตรวจเสมหะ AFB');
INSERT INTO `map_nhso_activities` VALUES (58, 2569, '25690102', '02_Lab 7 รายการ');
INSERT INTO `map_nhso_activities` VALUES (78, 2569, '25691102', '02_คัดกรองมะเร็งปากมดลูกด้วยวิธี VIA');
INSERT INTO `map_nhso_activities` VALUES (64, 2569, '25690302', '02_ค่าตรวจ VDRL การคัดกรองซิฟิลิส (สามี)');
INSERT INTO `map_nhso_activities` VALUES (102, 2569, '25692107', '02_ยาฝังคุมกำเนิด');
INSERT INTO `map_nhso_activities` VALUES (72, 2569, '25690502', '02_ยาเสริมธาตุเหล็กหลังคลอด');
INSERT INTO `map_nhso_activities` VALUES (67, 2569, '25690402', '02_เจาะเลือดและส่งตรวจ');
INSERT INTO `map_nhso_activities` VALUES (75, 2569, '25690902', '02_แว่นตาเลนส์สายตาผิดปกติทีต้องสั่งตัดพิเศษ (Lab lens)');
INSERT INTO `map_nhso_activities` VALUES (92, 2569, '25691804', '03_4 บริการตรวจ TB LAMP เพื่อวินิจฉัยวัณโรคในกลุ่มเสี่ยงสูง ');
INSERT INTO `map_nhso_activities` VALUES (59, 2569, '25690103', '03_Lab 2 รายการ');
INSERT INTO `map_nhso_activities` VALUES (81, 2569, '25691105', '03_คัดกรองมะเร็งปากมดลูกด้วยวิธี HPV DNA Test');
INSERT INTO `map_nhso_activities` VALUES (65, 2569, '25690303', '03_ค่าตรวจ TPHA การคัดกรองซิฟิลิส (สามี)');
INSERT INTO `map_nhso_activities` VALUES (96, 2569, '25692003', '03_ตรวจยืนยัน HCV RNA');
INSERT INTO `map_nhso_activities` VALUES (97, 2569, '25692102', '03_ยาเม็ดคุมกำเนิด COC');
INSERT INTO `map_nhso_activities` VALUES (104, 2569, '25692401', '03_เจาะเลือด ส่งตรวจวัดระดับน้ำตาล (FPG)');
INSERT INTO `map_nhso_activities` VALUES (79, 2569, '25691103', '031_บริการเก็บตัวอย่าง');
INSERT INTO `map_nhso_activities` VALUES (80, 2569, '25691104', '0321_น้ำยาตรวจHPV 16,18 and other types');
INSERT INTO `map_nhso_activities` VALUES (82, 2569, '25691105', '0322_น้ำยาตรวจ HPV 14 high risk types');
INSERT INTO `map_nhso_activities` VALUES (83, 2569, '25691106', '0323_บริการตรวจทางเซลล์วิทยาด้วย วิธี Liquid based cytology');
INSERT INTO `map_nhso_activities` VALUES (91, 2569, '25691803', '04_2 บริการตรวจ Molecular assay ด้วยวิธี Xpert MTB/RIF ');
INSERT INTO `map_nhso_activities` VALUES (68, 2569, '25690407', '04_PND');
INSERT INTO `map_nhso_activities` VALUES (84, 2569, '25691107', '04_ตรวจยืนยันด้วยวิธี Colposcope');
INSERT INTO `map_nhso_activities` VALUES (60, 2569, '25690104', '04_บริการตรวจอัลตราซาวด์');
INSERT INTO `map_nhso_activities` VALUES (98, 2569, '25692102', '04_ยาเม็ดคุมกำเนิด POP');
INSERT INTO `map_nhso_activities` VALUES (105, 2569, '25692402', '04_เจาะเลือดTotal Cholesterol หรือ HDL');
INSERT INTO `map_nhso_activities` VALUES (69, 2569, '25690408', '05_Karyotyping');
INSERT INTO `map_nhso_activities` VALUES (61, 2569, '25690105', '05_บริการตรวจสุขภาพช่องปากและบริการขัดทำความสะอาดฟัน');
INSERT INTO `map_nhso_activities` VALUES (100, 2569, '25692105', '05_ยาฉีดคุมกำเนิด');
INSERT INTO `map_nhso_activities` VALUES (70, 2569, '25690409', '06_การยุติการตั้งครรภ์บริการตรวจคัดกรองดาวน์ซินโดรม');
INSERT INTO `map_nhso_activities` VALUES (99, 2569, '25692103', '06_ยาเม็ดคุมกำเนิดฉุกเฉิน');
INSERT INTO `map_nhso_activities` VALUES (103, 2569, '25692108', '08_ถอดยาฝังคุมกำเนิด');
INSERT INTO `map_nhso_activities` VALUES (107, 2569, '25692502', 'dT (คอตีบ-บาดทะยัก)');
INSERT INTO `map_nhso_activities` VALUES (106, 2569, '25692501', 'ค่าบริการฉีดวัคซีนขั้นพื้นฐาน (EPI)');
INSERT INTO `map_nhso_activities` VALUES (108, 2569, '25692503', 'วัคซีนป้องกันโรคไข้หวัดใหญ่');

SET FOREIGN_KEY_CHECKS = 1;
