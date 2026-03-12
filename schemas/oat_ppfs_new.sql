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

 Date: 12/03/2026 14:33:28
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

-- ----------------------------
-- Table structure for mst_amphur
-- ----------------------------
DROP TABLE IF EXISTS `mst_amphur`;
CREATE TABLE `mst_amphur`  (
  `amphur_code` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รหัสอำเภอ',
  `amphur_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ชื่ออำเภอ',
  PRIMARY KEY (`amphur_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'ข้อมูลอำเภอ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mst_amphur
-- ----------------------------
INSERT INTO `mst_amphur` VALUES ('4601', 'เมืองกาฬสินธุ์');
INSERT INTO `mst_amphur` VALUES ('4602', 'นามน');
INSERT INTO `mst_amphur` VALUES ('4603', 'กมลาไสย');
INSERT INTO `mst_amphur` VALUES ('4604', 'ร่องคำ');
INSERT INTO `mst_amphur` VALUES ('4605', 'กุฉินารายณ์');
INSERT INTO `mst_amphur` VALUES ('4606', 'เขาวง');
INSERT INTO `mst_amphur` VALUES ('4607', 'ยางตลาด');
INSERT INTO `mst_amphur` VALUES ('4608', 'ห้วยเม็ก');
INSERT INTO `mst_amphur` VALUES ('4609', 'สหัสขันธ์');
INSERT INTO `mst_amphur` VALUES ('4610', 'คำม่วง');
INSERT INTO `mst_amphur` VALUES ('4611', 'ท่าคันโท');
INSERT INTO `mst_amphur` VALUES ('4612', 'หนองกุงศรี');
INSERT INTO `mst_amphur` VALUES ('4613', 'สมเด็จ');
INSERT INTO `mst_amphur` VALUES ('4614', 'ห้วยผึ้ง');
INSERT INTO `mst_amphur` VALUES ('4615', 'สามชัย');
INSERT INTO `mst_amphur` VALUES ('4616', 'นาคู');
INSERT INTO `mst_amphur` VALUES ('4617', 'ดอนจาน');
INSERT INTO `mst_amphur` VALUES ('4618', 'ฆ้องชัย');

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

-- ----------------------------
-- Table structure for mst_hospitals
-- ----------------------------
DROP TABLE IF EXISTS `mst_hospitals`;
CREATE TABLE `mst_hospitals`  (
  `hoscode` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รหัสหน่วยบริการ 5 หลัก',
  `hosname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ชื่อหน่วยบริการ',
  `hostype_code` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'รหัสประเภทหน่วยบริการ (FK)',
  `amphur_code` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รหัสอำเภอ (FK)',
  `sangkad_code` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รหัสสังกัด (FK)',
  `is_active` tinyint(1) NULL DEFAULT 1 COMMENT '1=ใช้งาน, 0=ยกเลิก/ซ่อนจาก Dropdown',
  PRIMARY KEY (`hoscode`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'ข้อมูลหน่วยบริการทั้งหมด' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mst_hospitals
-- ----------------------------
INSERT INTO `mst_hospitals` VALUES ('05291', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านต้อน', '18', '4601', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05292', 'โรงพยาบาลส่งเสริมสุขภาพตำบลโนนสว่าง', '18', '4601', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05293', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองโพน', '18', '4601', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05294', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองสอ', '18', '4601', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05295', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านสะอาดนาทม', '18', '4601', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05296', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านฝายแตก', '18', '4601', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05297', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านโนนแพง', '18', '4601', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05298', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านเชียงเครือ', '18', '4601', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05299', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านแกเปะ', '18', '4601', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05300', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านท่าไคร้', '18', '4601', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05301', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านดงสว่าง', '18', '4601', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05302', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองแวงใหญ่', '18', '4601', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05303', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านเหล่าหลวง', '18', '4601', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05304', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านคำไผ่', '18', '4601', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05305', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านเหล่ากลาง', '18', '4601', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05306', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านน้ำบุ่น', '18', '4601', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05307', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองแวงใต้', '18', '4601', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05308', 'โรงพยาบาลส่งเสริมสุขภาพตำบลโนนชัย', '18', '4601', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05309', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านโพนทอง', '18', '4601', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05310', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านนาจารย์', '18', '4601', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05311', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านโนนศรีสวัสดิ์', '18', '4602', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05312', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านยอดแกง', '18', '4602', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05313', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหัวงัว', '18', '4602', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05314', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านสงเปลือย', '18', '4602', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05315', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านอุทัยวรรณ', '18', '4602', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05316', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองบัวใน', '18', '4602', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05317', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านข้าวหลาม', '18', '4603', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05318', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านบึง', '18', '4603', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05319', 'สถานีอนามัยเฉลิมพระเกียรติ 60 พรรษา นวมินทราชินี บ้านโพนงาม', '18', '4603', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05320', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านสีถาน', '18', '4603', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05321', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านบ่อ', '18', '4603', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05322', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านโนนเขวา', '18', '4618', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05323', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านโนนทัน', '18', '4618', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05324', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านท่าเยื่ยม', '18', '4618', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05325', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านโนนแดง', '18', '4618', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05326', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองแปน', '18', '4603', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05327', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองบัว', '18', '4618', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05328', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านโคกประสิทธิ์', '18', '4618', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05329', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านท่าเพลิง', '18', '4603', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05330', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองบัว', '18', '4603', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05331', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านนามล', '18', '4603', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05332', 'โรงพยาบาลส่งเสริมสุขภาพตำบลโนนศิลาเลิง', '18', '4618', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05333', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านนาเรียง', '18', '4604', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05334', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านค้อพัฒนา', '18', '4604', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05335', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านแจนแลน', '18', '4605', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05336', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านกุดฝั่งแดง', '18', '4605', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05337', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านเหล่าใหญ่', '18', '4605', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05338', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านสันติสุข', '18', '4605', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05339', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านนาสีนวล', '18', '4605', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05340', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านเหล่าไฮงาม', '18', '4605', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05341', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านสวนผึ้ง', '18', '4605', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05342', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านนาไคร้', '18', '4605', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05343', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านกุดหว้า', '18', '4605', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05344', 'โรงพยาบาลส่งเสริมสุขภาพตำบลหนองแวงศรี ตำบลสามขา', '18', '4605', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05345', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านคุย', '18', '4605', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05346', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านโนนฟองแก้ว', '18', '4605', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05347', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านโนนสวาง', '18', '4605', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05348', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองห้าง', '18', '4605', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05349', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านนาโก', '18', '4605', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05350', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองบัวทอง', '18', '4605', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05351', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านกุดค้าว ตำบลกุดค้าว', '18', '4605', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05352', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านกุดบอด', '18', '4606', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05353', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านนาตาหลิ่ว', '18', '4606', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05354', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองผือ', '18', '4606', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05355', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านโพนสวาง', '18', '4606', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05356', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านโนนสะอาด', '18', '4606', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05357', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านเสียว', '18', '4607', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05358', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านโคกศรี', '18', '4607', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05359', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านตูม', '18', '4607', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05360', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านโคกใหญ่', '18', '4607', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05361', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านห้วยเตย', '18', '4607', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05362', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านแก', '18', '4607', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05363', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหัวนาคำ ตำบลหัวนาคำ', '18', '4607', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05364', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านดงบัง', '18', '4607', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05365', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองอิเฒ่า', '18', '4607', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05366', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านดอนยานาง', '18', '4607', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05367', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านนาเชือก', '18', '4607', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05368', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านขาม', '18', '4607', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05369', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านโคกสี', '18', '4607', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05370', 'โรงพยาบาลส่งเสริมสุขภาพตำบลพุทธรักษา', '18', '4607', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05371', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านปอแดง', '18', '4607', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05372', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านโนนสูง', '18', '4607', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05373', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองตอกแป้น', '18', '4607', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05374', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านคำใหญ่', '18', '4608', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05375', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านกุดโดน', '18', '4608', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05376', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองบัว', '18', '4608', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05377', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านห้วยมะทอ', '18', '4608', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05378', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านพิมูล', '18', '4608', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05379', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านคำเหมือดแก้ว', '18', '4608', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05380', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านโนนขี้ควง', '18', '4608', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05381', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านทรายทอง', '18', '4608', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05382', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านคำลือชา', '18', '4609', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05383', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านโนนสมบูรณ์', '18', '4609', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05384', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านนามะเขือ', '18', '4609', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05385', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านโคกก่อง', '18', '4609', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05386', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านม่วงกุญชร', '18', '4609', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05387', 'โรงพยาบาลส่งเสริมสุขภาพตำบลตาดดงเค็ง', '18', '4609', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05388', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านโนนแหลมทอง', '18', '4609', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05389', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านโนนน้ำเกลี้ยง', '18', '4609', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05390', 'สถานีอนามัยบ้านเก่าเดื่อ', '18', '4610', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05391', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านโพน', '18', '4610', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05392', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านดินจี่', '18', '4610', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05393', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านนาบอน', '18', '4610', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05394', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านนาตาล', '18', '4610', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05395', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านดงสวนพัฒนา', '18', '4610', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05396', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านสูงเนิน', '18', '4610', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05397', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านกุงเก่า', '18', '4611', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05398', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านยางอู้ม', '18', '4611', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05399', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านกุดจิก', '18', '4611', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05400', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านแสนสุข', '18', '4611', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05401', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองแซง', '18', '4611', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05402', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านดงกลาง', '18', '4611', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05403', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านดงสมบูรณ์', '18', '4611', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05404', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านคำไฮ', '18', '4612', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05405', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองบัว', '18', '4612', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05406', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านห้วยยางดง', '18', '4612', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05407', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองสรวง', '18', '4612', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05408', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองไผ่', '18', '4612', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05409', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองชุมแสง', '18', '4612', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05410', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านภูฮัง', '18', '4612', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05411', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองกุงเผือก', '18', '4612', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05412', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองหิน', '18', '4612', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05413', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองบัวโดน', '18', '4613', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05414', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านสร้างแก้ว', '18', '4613', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05415', 'โรงพยาบาลส่งเสริมสุขภาพตำบลแซงบาดาล', '18', '4613', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05416', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านมหาไชย', '18', '4613', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05417', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหมูม่น ตำบลหมูม่น', '18', '4613', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05418', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านกอก', '18', '4613', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05419', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านขมิ้น', '18', '4613', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05420', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองแสง', '18', '4613', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05421', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านบอน ตำบลลำห้วยหลัว', '18', '4613', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05422', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านคำบง', '18', '4614', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05423', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านคงอุดม', '18', '4614', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05424', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านไค้นุ่น', '18', '4614', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05425', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองอีบุตร', '18', '4614', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05426', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองแซง', '18', '4615', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05427', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองแสง', '18', '4615', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05428', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองกุงน้อย', '18', '4615', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05429', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านคำสร้างเที่ยง', '18', '4615', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('05430', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหนองช้าง', '18', '4615', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05431', 'โรงพยาบาลส่งเสริมสุขภาพตำบลนาคู', '18', '4616', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05432', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านจอมศรี', '18', '4616', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05433', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านากระเดา', '18', '4616', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05434', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านโนนนาจาน', '18', '4616', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05435', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านนางาม', '18', '4616', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05436', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหว้านพัฒนา', '18', '4616', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05437', 'โรงพยาบาลส่งเสริมสุขภาพตำบลภูแล่นช้าง', '18', '4616', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05438', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านกุดครอง', '18', '4617', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05439', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านสะอาดไชยศรี', '18', '4617', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05440', 'โรงพยาบาลส่งเสริมสุขภาพตำบลดงเจริญ ตำบลดงพยุง', '18', '4617', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05441', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านม่วงนา', '18', '4617', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('05442', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านนาจำปา', '18', '4617', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('10709', 'โรงพยาบาลกาฬสินธุ์', '06', '4601', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('11077', 'โรงพยาบาลนามน', '07', '4602', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('11078', 'โรงพยาบาลกมลาไสย', '07', '4603', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('11079', 'โรงพยาบาลร่องคำ', '07', '4604', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('11080', 'โรงพยาบาลเขาวง', '07', '4606', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('11081', 'โรงพยาบาลยางตลาด', '07', '4607', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('11082', 'โรงพยาบาลห้วยเม็ก', '07', '4608', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('11083', 'โรงพยาบาลสหัสขันธ์', '07', '4609', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('11084', 'โรงพยาบาลคำม่วง', '07', '4610', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('11085', 'โรงพยาบาลท่าคันโท', '07', '4611', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('11086', 'โรงพยาบาลหนองกุงศรี', '07', '4612', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('11087', 'โรงพยาบาลสมเด็จ', '07', '4613', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('11088', 'โรงพยาบาลห้วยผึ้ง', '07', '4614', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('11449', 'โรงพยาบาลสมเด็จพระยุพราชกุฉินารายณ์', '06', '4605', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('11965', 'โรงพยาบาลธีรวัฒน์', '15', '4601', '90000', 1);
INSERT INTO `mst_hospitals` VALUES ('13963', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านดงเมือง', '18', '4601', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('13964', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านสวนโคก', '18', '4603', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('13966', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านเหล่าสีแก้ว', '18', '4614', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('14284', 'โรงพยาบาลส่งเสริมสุขภาพตำบลบ้านหาดทรายมูล', '18', '4608', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('14347', 'โรงพยาบาลส่งเสริมสุขภาพเทศบาลเมืองกาฬสินธุ์ แห่งที่ 1 (ซอยน้ำทิพย์)', '21', '4601', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('23219', 'โรงพยาบาลส่งเสริมสุขภาพตำบลหนองแวงแสน', '18', '4617', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('24743', 'โรงพยาบาลส่งเสริมสุขภาพเทศบาลเมืองกาฬสินธุ์ แห่งที่ 2 (ดงปอ)', '21', '4601', '75000', 1);
INSERT INTO `mst_hospitals` VALUES ('28017', 'โรงพยาบาลนาคู', '07', '4616', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('28789', 'โรงพยาบาลฆ้องชัย', '07', '4618', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('28790', 'โรงพยาบาลดอนจาน', '07', '4617', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('28791', 'โรงพยาบาลสามชัย', '07', '4615', '21000', 1);
INSERT INTO `mst_hospitals` VALUES ('77738', 'ศูนย์สุขภาพชุมชนเมืองโรงพยาบาลกาฬสินธุ์', '08', '4601', '21000', 1);

-- ----------------------------
-- Table structure for mst_hostypes
-- ----------------------------
DROP TABLE IF EXISTS `mst_hostypes`;
CREATE TABLE `mst_hostypes`  (
  `hostype_code` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รหัสประเภทหน่วยบริการ',
  `hostype_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ชื่อประเภทหน่วยบริการ',
  PRIMARY KEY (`hostype_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'ข้อมูลประเภทของหน่วยบริการ (เช่น รพท., รพช., รพ.สต.)' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mst_hostypes
-- ----------------------------
INSERT INTO `mst_hostypes` VALUES ('01', 'สำนักงานสาธารณสุขจังหวัด');
INSERT INTO `mst_hostypes` VALUES ('02', 'สำนักงานสาธารณสุขอำเภอ');
INSERT INTO `mst_hostypes` VALUES ('04', 'สถานบริการสาธารณสุขชุมชน');
INSERT INTO `mst_hostypes` VALUES ('05', 'โรงพยาบาลศูนย์');
INSERT INTO `mst_hostypes` VALUES ('06', 'โรงพยาบาลทั่วไป');
INSERT INTO `mst_hostypes` VALUES ('07', 'โรงพยาบาลชุมชน');
INSERT INTO `mst_hostypes` VALUES ('08', 'ศูนย์สุขภาพชุมชนโรงพยาบาล');
INSERT INTO `mst_hostypes` VALUES ('10', 'กรมควบคุมโรค');
INSERT INTO `mst_hostypes` VALUES ('11', 'โรงพยาบาลเลิดสิน');
INSERT INTO `mst_hostypes` VALUES ('12', 'ศูนย์การแพทย์ธรรมศาสตร์');
INSERT INTO `mst_hostypes` VALUES ('13', 'ศูนย์บริการพยาบาลชุมชนอบอุ่น มรภ.อุบล');
INSERT INTO `mst_hostypes` VALUES ('15', 'โรงพยาบาลเอกชน');
INSERT INTO `mst_hostypes` VALUES ('16', 'คลินิกการพยาบาลและผดุงครรภ์');
INSERT INTO `mst_hostypes` VALUES ('17', 'ศูนย์การแพทย์แผนไทยและการแพทย์ทางเลือก');
INSERT INTO `mst_hostypes` VALUES ('18', 'โรงพยาบาลส่งเสริมสุขภาพตำบล');
INSERT INTO `mst_hostypes` VALUES ('20', 'ศูนย์บริการด้านการแพทย์และสาธารณสุข');
INSERT INTO `mst_hostypes` VALUES ('21', 'ศูนย์บริการสาธารณสุขเทศบาล');

-- ----------------------------
-- Table structure for mst_main_activities
-- ----------------------------
DROP TABLE IF EXISTS `mst_main_activities`;
CREATE TABLE `mst_main_activities`  (
  `fiscal_year` int NOT NULL COMMENT 'ปีงบประมาณ',
  `main_activity_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รหัสกิจกรรมหลัก',
  `main_activity_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ชื่อกิจกรรมหลัก',
  PRIMARY KEY (`main_activity_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'ข้อมูลหมวดหมู่กิจกรรมหลัก' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mst_main_activities
-- ----------------------------
INSERT INTO `mst_main_activities` VALUES (2568, '256801', 'บริการฝากครรภ์');
INSERT INTO `mst_main_activities` VALUES (2568, '256802', 'บริการป้องกันโรคโลหิตจางธาลัสซีเมียในหญิงตั้งครรภ์');
INSERT INTO `mst_main_activities` VALUES (2568, '256803', 'บริการป้องกันและควบคุมกลุ่มอาการดาวน์ในหญิงตั้งครรภ์');
INSERT INTO `mst_main_activities` VALUES (2568, '256804', 'บริการป้องกันการยุติการตั้งครรภ์ที่ไม่ปลอดภัย');
INSERT INTO `mst_main_activities` VALUES (2568, '256805', 'การตรวจหลังคลอด');
INSERT INTO `mst_main_activities` VALUES (2568, '256806', 'บริการป้องกันและควบคุมภาวะพร่องฮอร์โมนไทรอยด์ (TSH)');
INSERT INTO `mst_main_activities` VALUES (2568, '256807', 'บริการตรวจคัดกรองผู้ป่วยโรคพันธุกรรมเมตาบอลิกด้วยเครื่องTandem mass spectrometry (TMS) ในเด็กแรกเกิด');
INSERT INTO `mst_main_activities` VALUES (2568, '256808', 'บริการแว่นตาเด็กที่มีสายตาผิดปกติ');
INSERT INTO `mst_main_activities` VALUES (2568, '256809', 'บริการวางแผนครอบครัวและการป้องกันการตั้งครรภ์ไม่พึงประสงค์');
INSERT INTO `mst_main_activities` VALUES (2568, '256810', 'บริการเคลือบฟลูออไรด์ (กลุ่มเสี่ยง)');
INSERT INTO `mst_main_activities` VALUES (2568, '256811', 'บริการคัดกรองธาลัสซีเมียและซิฟิลิสในสามีหรือคู่ของหญิงตั้งครรภ์');
INSERT INTO `mst_main_activities` VALUES (2568, '256812', 'บริการคัดกรองรอยโรคเสี่ยงมะเร็งและมะเร็งช่องปาก (CA Oral Screening)');
INSERT INTO `mst_main_activities` VALUES (2568, '256813', 'บริการตรวจคัดกรองมะเร็งลำไส้ใหญ่และลำไส้ตรง (Fit test)');
INSERT INTO `mst_main_activities` VALUES (2568, '256814', 'บริการการตรวจคัดกรองมะเร็งปากมดลูก');
INSERT INTO `mst_main_activities` VALUES (2568, '256815', 'บริการตรวจคัดกรองมะเร็งเต้านมด้วยเครื่องแมมโมแกรมและอัลตราซาวด์');
INSERT INTO `mst_main_activities` VALUES (2568, '256816', 'บริการตรวจยีน BRCA1/BRCA2 ในกลุ่มผู้ป่วยมะเร็งเต้านมที่มีความเสี่ยงสูงและญาติสายตรงที่มีประวัติครอบครัวตรวจพบยีนกลายพันธุ์');
INSERT INTO `mst_main_activities` VALUES (2568, '256817', 'บริการตรวจคัดกรองพยาธิใบไม้ในตับด้วยการตรวจปัสสาวะ');
INSERT INTO `mst_main_activities` VALUES (2568, '256818', 'บริการตรวจคัดกรองและค้นหาวัณโรคในกลุ่มเสี่ยงสูง');
INSERT INTO `mst_main_activities` VALUES (2568, '256819', 'การตรวจคัดกรองโรคไวรัสตับอักเสบ บี');
INSERT INTO `mst_main_activities` VALUES (2568, '256820', 'การตรวจคัดกรองโรคไวรัสตับอักเสบ ซี');
INSERT INTO `mst_main_activities` VALUES (2568, '256821', 'บริการคัดกรองเบาหวานและไขมันในเลือด');
INSERT INTO `mst_main_activities` VALUES (2568, '256822', 'การทดสอบการตั้งครรภ์');
INSERT INTO `mst_main_activities` VALUES (2568, '256823', 'บริการคัดกรองโลหิตจางจากการขาดธาตุเหล็ก');
INSERT INTO `mst_main_activities` VALUES (2568, '256824', 'บริการยาเม็ดเสริมธาตุเหล็ก');
INSERT INTO `mst_main_activities` VALUES (2568, '256825', 'บริการให้วัคซีนป้องกันโรค');
INSERT INTO `mst_main_activities` VALUES (2569, '256901', 'บริการฝากครรภ์');
INSERT INTO `mst_main_activities` VALUES (2569, '256902', 'บริการป้องกันโรคโลหิตจางธาลัสซีเมียในหญิงตั้งครรภ์');
INSERT INTO `mst_main_activities` VALUES (2569, '256903', 'บริการคัดกรองธาลัสซีเมียและซิฟิลิสในคู่ของหญิงตั้งครรภ์');
INSERT INTO `mst_main_activities` VALUES (2569, '256904', 'บริการป้องกันกลุ่มอาการดาวน์ในหญิงตั้งครรภ์');
INSERT INTO `mst_main_activities` VALUES (2569, '256905', 'การตรวจหลังคลอด');
INSERT INTO `mst_main_activities` VALUES (2569, '256906', 'การทดสอบการตั้งครรภ์');
INSERT INTO `mst_main_activities` VALUES (2569, '256907', 'บริการป้องกันและควบคมภาวะพร่องฮอร์โมนไทรอยด์ (TSH)');
INSERT INTO `mst_main_activities` VALUES (2569, '256908', 'บริการตรวจคัดกรองผู้ป่วยโรคพันธุกรรมเมตาบอลิกด้วยเครื่อง Tandem mass spectrometry (TMS) ในเด็กแรกเกิด');
INSERT INTO `mst_main_activities` VALUES (2569, '256909', 'บริการแว่นตาเด็กที่มีสายตาผิดปกติ');
INSERT INTO `mst_main_activities` VALUES (2569, '256910', 'บริการคัดกรองรอยโรคเสี่ยงมะเร็งและมะเร็งช่องปาก (CA Oral Screening)');
INSERT INTO `mst_main_activities` VALUES (2569, '256911', 'บริการการตรวจคัดกรองมะเร็งปากมดลูก');
INSERT INTO `mst_main_activities` VALUES (2569, '256912', 'บริการตรวจยีน BRCA1/BRCA2 ในกลุ่มผู้ป่วยมะเร็งเต้านมที่มีความเสี่ยงสูงและญาติสายตรงที่มีประวัติครอบครัวตรวจพบยีนกลายพันธุ์');
INSERT INTO `mst_main_activities` VALUES (2569, '256913', 'บริการตรวจคัดกรองมะเร็งลำไส้ใหญ่และลำไส้ตรง (Fit test)');
INSERT INTO `mst_main_activities` VALUES (2569, '256914', 'บริการคัดกรองโลหิตจางจากการขาดธาตุเหล็ก');
INSERT INTO `mst_main_activities` VALUES (2569, '256915', 'บริการยาเม็ดเสริมธาตุเหล็ก');
INSERT INTO `mst_main_activities` VALUES (2569, '256916', 'บริการเคลือบฟลูออไรด์ (กลุ่มเสี่ยง)');
INSERT INTO `mst_main_activities` VALUES (2569, '256917', 'ป้องกันการยุติการตั้งครรภ์ที่ไม่ปลอดภัย');
INSERT INTO `mst_main_activities` VALUES (2569, '256918', 'บริการตรวจคัดกรองและค้นหาวัณโรคในกลุ่มเสี่ยงสูง');
INSERT INTO `mst_main_activities` VALUES (2569, '256919', 'การตรวจคัดกรองโรคไวรัสตับอักเสบ บี');
INSERT INTO `mst_main_activities` VALUES (2569, '256920', 'การตรวจคัดกรองโรคไวรัสตับอักเสบ ซี');
INSERT INTO `mst_main_activities` VALUES (2569, '256921', 'บริการวางแผนครอบครัวและการป้องกันการตั้งครรภ์ไม่พึงประสงค์');
INSERT INTO `mst_main_activities` VALUES (2569, '256922', 'บริการตรวจคัดกรองพยาธิใบไม้ในตับด้วยการตรวจปัสสาวะ');
INSERT INTO `mst_main_activities` VALUES (2569, '256923', 'บริการตรวจคัดกรองมะเร็งเต้านมด้วยเครื่องแมมโมแกรมและอัลตราซาวด์');
INSERT INTO `mst_main_activities` VALUES (2569, '256924', 'บริการคัดกรองเบาหวานและไขมันในเลือด');
INSERT INTO `mst_main_activities` VALUES (2569, '256925', 'บริการให้วัคซีนป้องกันโรค');
INSERT INTO `mst_main_activities` VALUES (2569, '256926', 'บริการคัดกรองวัณโรคระยะแฝง (Latent TB Infection)');
INSERT INTO `mst_main_activities` VALUES (2569, '256927', 'บริการคัดกรองภาวะโลหิตจางจากการขาดธาตุเหล็ก');
INSERT INTO `mst_main_activities` VALUES (2569, '256928', 'บริการยาเสริมธาตุเหล็กเพื่อป้องกันโลหิตจางจาการขาดธาตุเหล็ก');

-- ----------------------------
-- Table structure for mst_sangkad
-- ----------------------------
DROP TABLE IF EXISTS `mst_sangkad`;
CREATE TABLE `mst_sangkad`  (
  `sangkad_code` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รหัสสังกัด',
  `sangkad_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ชื่อสังกัด',
  PRIMARY KEY (`sangkad_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'ข้อมูลต้นสังกัดของหน่วยบริการ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mst_sangkad
-- ----------------------------
INSERT INTO `mst_sangkad` VALUES ('21000', 'กระทรวงสาธารณสุข');
INSERT INTO `mst_sangkad` VALUES ('75000', 'องค์กรปกครองส่วนท้องถิ่น');
INSERT INTO `mst_sangkad` VALUES ('90000', 'เอกชน');

-- ----------------------------
-- Table structure for mst_sub_activities
-- ----------------------------
DROP TABLE IF EXISTS `mst_sub_activities`;
CREATE TABLE `mst_sub_activities`  (
  `fiscal_year` int NOT NULL COMMENT 'ปีงบประมาณ',
  `sub_activity_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รหัสกิจกรรมย่อย',
  `main_activity_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รหัสกิจกรรมหลัก (FK)',
  `sub_activity_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ชื่อกิจกรรมย่อย',
  `base_rate` decimal(15, 4) NULL DEFAULT 0.0000 COMMENT 'อัตราชดเชยพื้นฐาน (บาท)',
  `allowed_hostypes` json NULL COMMENT 'ประเภท รพ. ที่ทำได้ (Array)',
  `is_active` tinyint(1) NULL DEFAULT 1 COMMENT '1=ใช้งาน, 0=ยกเลิก/ซ่อนจาก Dropdown',
  PRIMARY KEY (`sub_activity_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'ข้อมูลกิจกรรมย่อยและอัตราชดเชย' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mst_sub_activities
-- ----------------------------
INSERT INTO `mst_sub_activities` VALUES (2568, '25680101', '256801', 'ค่าบริการดูแลการฝากครรภ์', 360.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680102', '256801', 'การตรวจ VDRL, HIV Antibody, HBs Ag, CBC + MCV และ/หรือ DCIP และ Blood group (ครบทุกรายการ)', 600.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680103', '256801', 'การตรวจ VDRL และ HIV', 190.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680104', '256801', 'ค่าบริการตรวจอัลตราซาวด์', 400.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680105', '256801', 'ค่าตรวจสุขภาพช่องปากและขัดทำความสะอาดฟัน', 500.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680201', '256802', 'Hb typing (วินิจฉัยยืนยัน)', 270.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680202', '256802', 'Alpha-thalassemia 1 (PCR) ในหญิงตั้งครรภ์', 800.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680203', '256802', 'Alpha-thalassemia 1 (PCR) ในสามีหรือคู่ของหญิงตั้งครรภ์', 800.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680204', '256802', 'Beta-thalassemia (Mutation analysis)', 3000.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680205', '256802', 'ค่าหัตถการเพื่อวินิจฉัยทารกในครรภ์', 2500.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680206', '256802', 'DNA Based Analysis (สิ่งส่งตรวจทารก)', 3000.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680207', '256802', 'Hemoglobin typing (สิ่งส่งตรวจทารก)', 270.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680301', '256803', 'การเจาะเลือดปั่นซีรั่ม', 100.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680302', '256803', 'การเจาะเลือดปั่นซีรั่มและจัดบริการส่งเลือด', 200.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680303', '256803', 'การตรวจ Quadruple test', 1200.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680304', '256803', 'การตรวจ Quadruple test และจัดบริการไปรับเลือด', 1300.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680305', '256803', 'ค่าทำหัตถการเพื่อตรวจวินิจฉัยทารกในครรภ์', 2500.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680306', '256803', 'ค่าตรวจทางห้องปฏิบัติการยืนยันโครโมโซมทารก', 2500.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680307', '256803', 'การยุติการตั้งครรภ์บริการตรวจคัดกรองดาวน์ซินโดรม', 3000.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680308', '256803', 'ค่าตรวจทางห้องปฏิบัติการ CBC + MCV และ/หรือ DCIP/Hb E screening', 120.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680309', '256803', 'ค่าตรวจ VDRL', 50.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680310', '256803', 'ค่าตรวจ TPHA กรณีผลการตรวจ VDRL ผิดปกติ', 100.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680401', '256804', 'ค่าบริการยุติการตั้งครรภ์ (โดยใช้ยา หรือ ศัลยกรรม)', 3000.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680501', '256805', 'ค่าบริการตรวจหลังคลอด(ไม่เกิน3ครั้งต่อการคลอด)', 150.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680502', '256805', 'ค่ายาเสริม ธาตุเหล็ก กรดโฟลิก ไอโอดีน (ไม่เกิน 2 ครั้งต่อการคลอด)', 135.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680601', '256806', 'ค่าตรวจคัดกรองภาวะพร่องฮอร์โมนไทรอยด์ (TSH)', 135.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680602', '256806', 'ค่าบริการติดตามและค่าตรวจทางห้องปฏิบัติการยืนยันภาวะพร่องฮอร์โมนไทรอยด์ (TSH)', 350.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680701', '256807', 'ค่าตรวจคัดกรองด้วยเครื่อง TMS รวมค่าขนส่ง', 500.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680801', '256808', 'เลนส์สายตาผิดปกติทั่วไป (Stock lens)', 800.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680802', '256808', 'เลนส์สายตาผิดปกติที่ต้องสั่งตัดพิเศษ (Lens lab)', 1000.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680901', '256809', 'ค่าบริการยาเม็ดคุมกำเนิดชนิดรับประทาน (ฮอร์โมนรวม)', 40.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680902', '256809', 'ค่าบริการยาเม็ดคุมกำเนิดชนิดรับประทาน (ฮอร์โมนเดี่ยว)', 80.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680903', '256809', 'ค่าบริการยาฉีดคุมกำเนิด', 60.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680904', '256809', 'ค่าบริการยาเม็ดคุมกำเนิดฉุกเฉิน', 50.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680905', '256809', 'ค่าบริการใส่ห่วงอนามัย', 800.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680906', '256809', 'ค่าบริการจ่ายถุงยางอนามัยและให้คำปรึกษา', 10.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680907', '256809', 'ค่าบริการฝังยาคุมกำเนิด', 2150.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25680908', '256809', 'ค่าบริการถอดยาฝังคุมกำเนิด', 350.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681001', '256810', 'ค่าบริการบริการเคลือบฟลูออไรด์ชนิดเข้มข้นสูงเฉพาะที่ (ไม่เกิน 2 ครั้งต่อปี)', 100.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681101', '256811', 'คัดกรองธาลัสซีเมีย (CBC + MCV และ/หรือ DCIP)', 120.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681102', '256811', 'ค่าตรวจ VDRL', 50.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681103', '256811', 'ค่าตรวจ TPHA กรณีผล VDRL ผิดปกติ', 100.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681201', '256812', 'ค่าบริการตัดและตรวจชิ้นเนื้อ (Biopsy + Patho)', 600.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681301', '256813', 'ค่าตรวจ FIT Test และให้คำปรึกษา', 60.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681401', '256814', 'วิธี pap smear', 250.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681402', '256814', 'วิธี VIA', 250.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681403', '256814', 'HPV DNA Test: ค่าเก็บตัวอย่าง', 50.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681404', '256814', 'HPV DNA Test: น้ำยาตรวจ HPV 16,18', 280.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681405', '256814', 'HPV DNA Test: น้ำยาตรวจ HPV 14 high risk', 370.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681406', '256814', 'ตรวจด้วยวิธี Liquid based cytology', 250.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681407', '256814', 'ตรวจยืนยันด้วย Colposcope รวมการตัดชิ้นเนื้อ (Biopsy หรือ LEEP) และตรวจทางพยาธิวิทยา', 900.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681501', '256815', 'ค่าบริการตรวจคัดกรองมะเร็งเต้านม ด้วยเครื่องแมมโมแกรมและอัลตราซาวด์', 2400.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681601', '256816', 'ค่าบริการประเมินความเสี่ยงและจัดส่งตัวอย่าง', 500.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681602', '256816', 'ตรวจยีน BRCA1/BRCA2 ในกลุ่มผู้ป่วยเสี่ยงสูง', 10000.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681603', '256816', 'ตรวจยีน BRCA1/BRCA2 ในกลุ่มญาติสายตรง', 2500.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681701', '256817', 'ค่าบริการตรวจคัดกรองโรคพยาธิใบไม้ตับ ด้วยการตรวจปัสสาวะ (Urine OV Rapid Diagnosis Test ; OV-RDT)', 150.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681801', '256818', 'ถ่ายภาพรังสีทรวงอก (Chest-X-ray)', 100.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681802', '256818', 'ตรวจยืนยัน First line: TB-LAMP', 200.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681803', '256818', 'ตรวจยืนยัน First line: Real-time PCR (500.-)', 500.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681804', '256818', 'ตรวจยืนยัน First line: Real-time PCR (600.-)', 600.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681805', '256818', 'ตรวจยืนยัน First line: Line Probe Assay (LPA)', 600.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681806', '256818', 'ตรวจด้วยวิธี AFB', 20.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681807', '256818', 'เพาะเลี้ยงเชื้อ Culture (Solid media)', 200.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681808', '256818', 'เพาะเลี้ยงเชื้อ Culture (Liquid media)', 300.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681809', '256818', 'ตรวจดื้อยา Second line: SL-LPA', 700.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681810', '256818', 'ตรวจดื้อยา Second line: Real-time PCR MTB/XDR', 700.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25681901', '256819', 'ค่าตรวจคัดกรองไวรัสตับอักเสบ บี', 50.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25682001', '256820', 'บริการตรวจคัดกรองไวรัสตับอักเสบซี  (Anti-HCV Screening test)', 50.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25682002', '256820', 'ตรวจยืนยันผลเป็นบวก ด้วยวิธี HCV core antigen', 400.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25682003', '256820', 'ตรวจยืนยันผลเป็นบวก ด้วยวิธี HCVRNA (qualitative method)', 1690.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25682101', '256821', 'เจาะเลือด FPG สำหรับกลุ่มเสี่ยง', 40.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25682102', '256821', 'เจาะเลือด Total Cholesterol และ HDL', 160.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25682201', '256822', 'ค่าตรวจปัสสาวะทดสอบการตั้งครรภ์ (ไม่เกิน 4 ครั้งต่อคนต่อปี)', 75.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25682301', '256823', 'ค่าบริการเจาะเลือดตรวจ CBC', 65.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25682401', '256824', 'ค่าบริการยาเม็ดและคำแนะนำ ติดตาม', 80.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25682501', '256825', 'บริการฉีดวัคซีนพื้นฐาน (EPI)', 20.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25682502', '256825', 'ค่าบริการฉีดวัคซีนป้องกันโรคไข้หวัดใหญ่', 20.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25682503', '256825', 'ค่าบริการฉีดวัคซีน dT ในผู้ใหญ่', 20.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2568, '25682504', '256825', 'บริการฉีดวัคซีนป้องกันโรคไอกรนชนิดไร้เซลล์ (aP) และวัคซีน dT ในหญิงตั้งครรภ์', 20.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690101', '256901', 'ค่าบริการดูแลการฝากครรภ์ (รวมยาเสริมธาตุเหล็ก กรดโฟลิก ไอโอดีน)', 360.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690102', '256901', 'การตรวจ VDRL, HIV Antibody, HBs Ag, CBC + MCV และ/หรือ DCIP และ Blood group (ครบทุกรายการ)', 600.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690103', '256901', 'การตรวจ VDRL และ HIV', 190.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690104', '256901', 'ค่าบริการตรวจอัลตราซาวด์', 400.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690105', '256901', 'ค่าตรวจสุขภาพช่องปากและขัดทำความสะอาดฟัน', 500.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690201', '256902', 'Hb typing (วินิจฉัยยืนยัน)', 270.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690202', '256902', 'Alpha-thalassemia 1 (PCR) ในหญิงตั้งครรภ์', 800.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690203', '256902', 'Alpha-thalassemia 1 (PCR) ในสามีหรือคู่ของหญิงตั้งครรภ์', 800.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690204', '256902', 'Beta-thalassemia (Mutation analysis)', 3000.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690205', '256902', 'ค่าหัตถการเพื่อวินิจฉัยทารกในครรภ์', 2500.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690206', '256902', 'DNA Based Analysis (สิ่งส่งตรวจทารก)', 3000.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690207', '256902', 'Hemoglobin typing (สิ่งส่งตรวจทารก)', 270.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690301', '256903', 'คัดกรองธาลัสซีเมีย (CBC + MCV และ/หรือ DCIP)', 120.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690302', '256903', 'ค่าตรวจ VDRL', 50.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690303', '256903', 'ค่าตรวจ TPHA กรณีผล VDRL ผิดปกติ', 100.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690401', '256904', 'การเจาะเลือดปั่นซีรั่ม', 100.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690402', '256904', 'การเจาะเลือดปั่นซีรั่มและจัดบริการส่งเลือด', 200.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690403', '256904', 'การตรวจด้วยวิธีไม่รุกล้ำ (non-invasive prenatal test: NIPT)', 2500.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690404', '256904', 'การตรวจด้วยวิธีไม่รุกล้ำ (non-invasive prenatal test: NIPT) และการจัดบริการไปรับเลือด', 2600.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690405', '256904', 'การตรวจ Quadruple test', 1200.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690406', '256904', 'การตรวจ Quadruple test และจัดบริการไปรับเลือด', 1300.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690407', '256904', 'ค่าทำหัตถการเพื่อตรวจวินิจฉัยทารกในครรภ์', 2500.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690408', '256904', 'ค่าตรวจทางห้องปฏิบัติการยืนยันโครโมโซมทารก', 2500.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690409', '256904', 'ยุติการตั้งครรภ์', 3000.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690501', '256905', 'ค่าบริการตรวจหลังคลอด', 150.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690502', '256905', 'ค่ายาเสริมธาตุเหล็ก กรดโฟลิก ไอโอดีน', 135.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690601', '256906', 'ค่าตรวจปัสสาวะทดสอบการตั้งครรภ์', 75.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690701', '256907', 'ค่าตรวจคัดกรองภาวะพร่องฮอร์โมนไทรอยด์ (TSH)', 135.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690702', '256907', 'ค่าบริการติดตามและค่าตรวจทางห้องปฏิบัติการยืนยันภาวะพร่องฮอร์โมนไทรอยด์ (TSH)', 350.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690801', '256908', 'ค่าตรวจคัดกรองด้วยเครื่อง TMS รวมค่าขนส่ง', 500.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690901', '256909', 'เลนส์สายตาผิดปกติทั่วไป (Stock lens)', 800.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25690902', '256909', 'เลนส์สายตาผิดปกติที่ต้องสั่งตัดพิเศษ (Lens lab)', 1000.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691001', '256910', 'ค่าบริการตัดและตรวจชิ้นเนื้อ (Biopsy + Patho)', 600.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691101', '256911', 'วิธี pap smear', 250.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691102', '256911', 'วิธี VIA', 250.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691103', '256911', 'HPV DNA Test: ค่าเก็บตัวอย่าง', 50.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691104', '256911', 'HPV DNA Test: น้ำยาตรวจ HPV 16,18', 280.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691105', '256911', 'HPV DNA Test: น้ำยาตรวจ HPV 14 high risk', 370.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691106', '256911', 'ตรวจด้วยวิธี Liquid based cytology', 250.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691107', '256911', 'ตรวจยืนยันด้วย Colposcope รวมการตัดชิ้นเนื้อ (Biopsy หรือ LEEP) และตรวจทางพยาธิวิทยา', 900.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691201', '256912', 'ค่าบริการประเมินความเสี่ยงและจัดส่งตัวอย่าง', 500.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691202', '256912', 'ตรวจยีน BRCA1/BRCA2 ในกลุ่มผู้ป่วยเสี่ยงสูง', 10000.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691203', '256912', 'ตรวจยีน BRCA1/BRCA2 ในกลุ่มญาติสายตรง', 2500.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691301', '256913', 'ค่าตรวจ FIT Test และให้คำปรึกษา', 60.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691401', '256914', 'ค่าบริการเจาะเลือดตรวจ CBC', 65.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691501', '256915', 'ค่าบริการยาเม็ดและคำแนะนำ ติดตาม', 80.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691601', '256916', 'ค่าบริการเคลือบฟลูออไรด์ชนิดเข้มข้นสูง', 100.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691701', '256917', 'ค่าบริการยุติการตั้งครรภ์ (โดยใช้ยา หรือ ศัลยกรรม)', 3000.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691801', '256918', 'ถ่ายภาพรังสีทรวงอก (Chest-X-ray)', 100.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691802', '256918', 'ตรวจยืนยัน First line: TB-LAMP', 200.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691803', '256918', 'ตรวจยืนยัน First line: Real-time PCR (500.-)', 500.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691804', '256918', 'ตรวจยืนยัน First line: Real-time PCR (600.-)', 600.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691805', '256918', 'ตรวจยืนยัน First line: Line Probe Assay (LPA)', 600.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691806', '256918', 'ตรวจด้วยวิธี AFB', 20.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691807', '256918', 'เพาะเลี้ยงเชื้อ Culture (Solid media)', 200.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691808', '256918', 'เพาะเลี้ยงเชื้อ Culture (Liquid media)', 300.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691809', '256918', 'ตรวจดื้อยา Second line: SL-LPA', 700.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691810', '256918', 'ตรวจดื้อยา Second line: Real-time PCR MTB/XDR', 700.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25691901', '256919', 'ค่าตรวจคัดกรองไวรัสตับอักเสบ บี', 50.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692001', '256920', 'บริการตรวจคัดกรองไวรัสตับอักเสบซี  (Anti-HCV Screening test)', 50.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692002', '256920', 'ตรวจยืนยันผลเป็นบวก ด้วยวิธี HCV core antigen', 400.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692003', '256920', 'ตรวจยืนยันผลเป็นบวก ด้วยวิธี HCVRNA (qualitative method)', 1690.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692101', '256921', 'ค่าบริการยาเม็ดคุมกำเนิดชนิดรับประทาน (ฮอร์โมนรวม)', 40.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692102', '256921', 'ค่าบริการยาเม็ดคุมกำเนิดชนิดรับประทาน (ฮอร์โมนเดี่ยว)', 80.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692103', '256921', 'ค่าบริการยาเม็ดคุมกำเนิดฉุกเฉิน', 50.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692104', '256921', 'ค่าบริการจ่ายถุงยางอนามัยและให้คำปรึกษา', 10.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692105', '256921', 'ค่าบริการยาฉีดคุมกำเนิด', 60.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692106', '256921', 'ค่าบริการใส่ห่วงอนามัย', 800.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692107', '256921', 'ค่าบริการฝังยาคุมกำเนิด', 2150.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692108', '256921', 'ค่าบริการถอดยาฝังคุมกำเนิด', 350.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692201', '256922', 'ค่าบริการตรวจคัดกรองโรคพยาธิใบไม้ตับ ด้วยการตรวจปัสสาวะ (Urine OV Rapid Diagnosis Test ; OV-RDT)', 150.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692301', '256923', 'ค่าบริการตรวจคัดกรองมะเร็งเต้านม ด้วยเครื่องแมมโมแกรมและอัลตราซาวด์', 2400.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692401', '256924', 'เจาะเลือด FPG สำหรับกลุ่มเสี่ยง', 40.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692402', '256924', 'เจาะเลือด Total Cholesterol และ HDL', 160.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692501', '256925', 'วัคซีนพื้นฐาน (EPI)', 20.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692502', '256925', 'วัคซีนคอตีบ-บาดทะยัก (dT) ในผู้ใหญ่', 20.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692503', '256925', 'วัคซีนป้องกันโรคไข้หวัดใหญ่ตามฤดูกาล', 20.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692504', '256925', 'วัคซีนป้องกันโรคไอกรนชนิดไร้เซลล์ (aP vaccine) ในหญิงตั้งครรภ์', 20.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692505', '256925', 'วัคซีนป้องกันโรคคอตีบ-บาดทะยัก (dT) ในหญิงตั้งครรภ์', 20.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692601', '256926', 'ค่าเจาะเลือดและให้คำปรึกษา', 100.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692602', '256926', 'ค่าจัดส่ง', 100.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692603', '256926', 'ค่าตรวจทางห้องปฏิบัติการตรวจคัดกรองวัณโรคระยะแฝง ด้วย Interferon gamma release assays (IGRAs)', 650.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692701', '256927', 'การตรวจความเข้มข้นของเม็ดเลือด Hb/Hct', 30.0000, '[]', 1);
INSERT INTO `mst_sub_activities` VALUES (2569, '25692801', '256928', 'บริการให้ยาเสริมธาตุเหล็ก', 50.0000, '[]', 1);

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

-- ----------------------------
-- Table structure for trn_hdc_performance
-- ----------------------------
DROP TABLE IF EXISTS `trn_hdc_performance`;
CREATE TABLE `trn_hdc_performance`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fiscal_year` int NOT NULL COMMENT 'ปีงบประมาณ',
  `month_no` int NOT NULL COMMENT '1=ต.ค. - 12=ก.ย.',
  `hoscode` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รหัสหน่วยบริการ',
  `sub_activity_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รหัสกิจกรรมย่อย',
  `actual_people` int NOT NULL DEFAULT 0 COMMENT 'ผลงานจำนวนคน',
  `actual_visit` int NOT NULL DEFAULT 0 COMMENT 'ผลงานจำนวนครั้ง',
  `audit_loss_flag` tinyint(1) NULL DEFAULT 0 COMMENT '1=ทำเกินศักยภาพ (โดนตัดออก), 0=ปกติ',
  `batch_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'UUID สำหรับ Track รอบการนำเข้า',
  `is_valid` tinyint(1) NULL DEFAULT 0 COMMENT '0=รอ Finalize, 1=ใช้งานจริง',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_perf_safe`(`fiscal_year` ASC, `month_no` ASC, `hoscode` ASC, `sub_activity_id` ASC, `batch_id` ASC) USING BTREE,
  INDEX `idx_perf_query`(`fiscal_year` ASC, `hoscode` ASC) USING BTREE,
  INDEX `idx_perf_month`(`month_no` ASC) USING BTREE,
  INDEX `idx_batch`(`batch_id` ASC) USING BTREE,
  INDEX `idx_audit_perf`(`fiscal_year` ASC, `audit_loss_flag` ASC, `hoscode` ASC) USING BTREE,
  INDEX `idx_finalize`(`fiscal_year` ASC, `month_no` ASC, `hoscode` ASC, `sub_activity_id` ASC, `batch_id` ASC) USING BTREE,
  INDEX `idx_valid`(`is_valid` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'ข้อมูลผลงานสะสม (Performance)' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of trn_hdc_performance
-- ----------------------------

-- ----------------------------
-- Table structure for trn_hdc_targets
-- ----------------------------
DROP TABLE IF EXISTS `trn_hdc_targets`;
CREATE TABLE `trn_hdc_targets`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fiscal_year` int NOT NULL COMMENT 'ปีงบประมาณ',
  `hoscode` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รหัสหน่วยบริการ',
  `sub_activity_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รหัสกิจกรรมย่อย',
  `target_people` int NOT NULL DEFAULT 0 COMMENT 'เป้าหมายจำนวนคน',
  `batch_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'UUID สำหรับ Track รอบการนำเข้า',
  `is_valid` tinyint(1) NULL DEFAULT 0 COMMENT '0=รอ Finalize, 1=ใช้งานจริง',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_target`(`fiscal_year` ASC, `hoscode` ASC, `sub_activity_id` ASC, `batch_id` ASC) USING BTREE,
  INDEX `idx_target_query`(`fiscal_year` ASC, `hoscode` ASC) USING BTREE,
  INDEX `idx_batch`(`batch_id` ASC) USING BTREE,
  INDEX `idx_finalize`(`fiscal_year` ASC, `hoscode` ASC, `sub_activity_id` ASC, `batch_id` ASC) USING BTREE,
  INDEX `idx_valid`(`is_valid` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'ข้อมูลเป้าหมายผลงาน (Target)' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of trn_hdc_targets
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
