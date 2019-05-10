/*
 Navicat Premium Data Transfer

 Source Server         : 本机
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : 127.0.0.1:3306
 Source Schema         : ikigai_blog

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 10/05/2019 15:38:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image_id` int(11) NULL DEFAULT NULL,
  `image_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `post_id` int(11) NULL DEFAULT NULL,
  `post_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `sort` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '名称',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 83 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(11) NULL DEFAULT NULL COMMENT '父id',
  `post_id` int(11) NULL DEFAULT NULL COMMENT '帖子id',
  `post_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '帖子标题',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '所属用户id',
  `name` mediumtext CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT '名称',
  `email` mediumtext CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'email',
  `url` mediumtext CHARACTER SET utf8 COLLATE utf8_bin NULL,
  `content` mediumtext CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT '留言内容',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `agent` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '评论者客户端',
  `status` int(1) NULL DEFAULT NULL COMMENT '评论状态，1：发布，2：待审核',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 91 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for image
-- ----------------------------
DROP TABLE IF EXISTS `image`;
CREATE TABLE `image`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for links
-- ----------------------------
DROP TABLE IF EXISTS `links`;
CREATE TABLE `links`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `contact` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `status` int(1) NULL DEFAULT 1 COMMENT '状态，1：审核中，2：发布',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of links
-- ----------------------------
INSERT INTO `links` VALUES (13, '魏石磊博客', 'http://weishilei.top/', 'wsldope@gmail.com', 2, '个人博客', '2019-05-06 13:59:03');

-- ----------------------------
-- Table structure for logs
-- ----------------------------
DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '日志内容',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'ip地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 66 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logs
-- ----------------------------
INSERT INTO `logs` VALUES (2, 'ikigai登录后台', 52, '2019-04-18 10:50:40', '127.0.0.1');
INSERT INTO `logs` VALUES (3, 'ikigai登出后台', 52, '2019-04-18 10:57:50', '127.0.0.1');
INSERT INTO `logs` VALUES (4, 'ikigai登录后台', 52, '2019-04-18 10:57:55', '127.0.0.1');
INSERT INTO `logs` VALUES (6, 'ikigai登出后台', 52, '2019-04-18 10:58:30', '115.158.20.43');
INSERT INTO `logs` VALUES (7, 'ikigai登录后台', 52, '2019-04-18 10:58:32', '115.158.20.43');
INSERT INTO `logs` VALUES (8, 'ikigai登录后台', 52, '2019-04-18 12:38:38', '127.0.0.1');
INSERT INTO `logs` VALUES (10, 'ikigai登录后台', 52, '2019-04-19 11:32:15', '127.0.0.1');
INSERT INTO `logs` VALUES (11, 'ikigai登录后台', 52, '2019-04-19 11:32:15', '127.0.0.1');
INSERT INTO `logs` VALUES (12, 'ikigai登录后台', 52, '2019-04-19 12:54:35', '127.0.0.1');
INSERT INTO `logs` VALUES (13, 'ikigai登出后台', 52, '2019-04-19 12:54:38', '127.0.0.1');
INSERT INTO `logs` VALUES (14, 'ikigai登录后台', 52, '2019-04-19 12:54:49', '127.0.0.1');
INSERT INTO `logs` VALUES (15, 'ikigai登录后台', 52, '2019-04-19 13:32:21', '127.0.0.1');
INSERT INTO `logs` VALUES (16, 'ikigai登录后台', 52, '2019-04-20 16:10:38', '127.0.0.1');
INSERT INTO `logs` VALUES (17, 'ikigai登录后台', 52, '2019-04-20 18:09:27', '127.0.0.1');
INSERT INTO `logs` VALUES (18, 'ikigai登录后台', 52, '2019-04-22 16:53:52', '127.0.0.1');
INSERT INTO `logs` VALUES (19, 'ikigai登出后台', 52, '2019-04-22 16:54:00', '127.0.0.1');
INSERT INTO `logs` VALUES (20, 'ikigai登录后台', 52, '2019-04-22 16:54:03', '127.0.0.1');
INSERT INTO `logs` VALUES (21, 'ikigai登出后台', 52, '2019-04-22 16:55:48', '127.0.0.1');
INSERT INTO `logs` VALUES (22, 'ikigai登录后台', 52, '2019-04-22 16:56:03', '127.0.0.1');
INSERT INTO `logs` VALUES (23, 'ikigai登录后台', 52, '2019-04-22 17:49:04', '127.0.0.1');
INSERT INTO `logs` VALUES (24, 'ikigai登录后台', 52, '2019-04-23 18:17:42', '127.0.0.1');
INSERT INTO `logs` VALUES (25, 'ikigai登录后台', 52, '2019-04-24 14:45:41', '127.0.0.1');
INSERT INTO `logs` VALUES (26, 'ikigai登录后台', 52, '2019-04-25 10:49:50', '127.0.0.1');
INSERT INTO `logs` VALUES (27, 'ikigai登录后台', 52, '2019-04-25 15:26:53', '127.0.0.1');
INSERT INTO `logs` VALUES (28, 'ikigai登录后台', 52, '2019-04-25 17:13:32', '127.0.0.1');
INSERT INTO `logs` VALUES (29, 'ikigai登录后台', 52, '2019-04-25 17:13:33', '127.0.0.1');
INSERT INTO `logs` VALUES (30, 'ikigai登出后台', 52, '2019-04-25 17:14:19', '127.0.0.1');
INSERT INTO `logs` VALUES (31, 'ikigai登录后台', 52, '2019-04-25 17:14:26', '127.0.0.1');
INSERT INTO `logs` VALUES (32, 'ikigai登录后台', 52, '2019-04-28 14:37:40', '127.0.0.1');
INSERT INTO `logs` VALUES (33, 'ikigai登录后台', 52, '2019-04-28 15:59:21', '127.0.0.1');
INSERT INTO `logs` VALUES (34, 'ikigai登录后台', 52, '2019-04-28 17:18:08', '127.0.0.1');
INSERT INTO `logs` VALUES (35, 'ikigai登录后台', 52, '2019-04-29 09:11:27', '127.0.0.1');
INSERT INTO `logs` VALUES (36, 'ikigai登录后台', 52, '2019-04-29 14:22:21', '127.0.0.1');
INSERT INTO `logs` VALUES (37, 'ikigai登录后台', 52, '2019-04-29 15:50:59', '127.0.0.1');
INSERT INTO `logs` VALUES (38, 'ikigai登录后台', 52, '2019-04-30 08:38:03', '127.0.0.1');
INSERT INTO `logs` VALUES (39, 'ikigai登录后台', 52, '2019-04-30 09:41:23', '127.0.0.1');
INSERT INTO `logs` VALUES (40, 'ikigai登录后台', 52, '2019-04-30 10:54:35', '127.0.0.1');
INSERT INTO `logs` VALUES (41, 'ikigai登录后台', 52, '2019-04-30 13:11:35', '127.0.0.1');
INSERT INTO `logs` VALUES (42, 'ikigai登录后台', 52, '2019-04-30 16:16:41', '127.0.0.1');
INSERT INTO `logs` VALUES (43, 'ikigai登录后台', 52, '2019-05-05 10:29:54', '127.0.0.1');
INSERT INTO `logs` VALUES (44, 'ikigai登录后台', 52, '2019-05-05 12:48:30', '127.0.0.1');
INSERT INTO `logs` VALUES (45, 'ikigai登录后台', 52, '2019-05-05 14:03:54', '127.0.0.1');
INSERT INTO `logs` VALUES (46, 'ikigai登录后台', 52, '2019-05-05 17:27:24', '127.0.0.1');
INSERT INTO `logs` VALUES (47, 'ikigai登录后台', 52, '2019-05-05 17:40:33', '127.0.0.1');
INSERT INTO `logs` VALUES (48, 'ikigai登录后台', 52, '2019-05-06 09:26:00', '127.0.0.1');
INSERT INTO `logs` VALUES (49, 'ikigai登录后台', 52, '2019-05-06 12:55:03', '127.0.0.1');
INSERT INTO `logs` VALUES (50, 'ikigai登录后台', 52, '2019-05-06 13:38:55', '127.0.0.1');
INSERT INTO `logs` VALUES (51, 'ikigai登录后台', 52, '2019-05-07 10:19:39', '127.0.0.1');
INSERT INTO `logs` VALUES (52, 'ikigai登录后台', 52, '2019-05-07 14:52:22', '127.0.0.1');
INSERT INTO `logs` VALUES (53, 'ikigai登录后台', 52, '2019-05-07 16:30:19', '127.0.0.1');
INSERT INTO `logs` VALUES (54, 'ikigai登录后台', 52, '2019-05-07 17:37:51', '127.0.0.1');
INSERT INTO `logs` VALUES (55, 'ikigai登录后台', 52, '2019-05-08 09:19:35', '127.0.0.1');
INSERT INTO `logs` VALUES (56, 'ikigai登录后台', 52, '2019-05-08 10:01:45', '127.0.0.1');
INSERT INTO `logs` VALUES (57, 'ikigai登录后台', 52, '2019-05-08 16:36:02', '127.0.0.1');
INSERT INTO `logs` VALUES (58, 'ikigai登录后台', 52, '2019-05-09 15:13:22', '127.0.0.1');
INSERT INTO `logs` VALUES (59, 'ikigai登录后台', 52, '2019-05-09 15:23:11', '127.0.0.1');
INSERT INTO `logs` VALUES (60, 'ikigai登录后台', 52, '2019-05-09 17:34:34', '127.0.0.1');
INSERT INTO `logs` VALUES (61, 'ikigai登录后台', 52, '2019-05-10 10:20:20', '127.0.0.1');
INSERT INTO `logs` VALUES (62, 'ikigai登录后台', 52, '2019-05-10 13:43:20', '127.0.0.1');
INSERT INTO `logs` VALUES (63, 'ikigai登录后台', 52, '2019-05-10 14:10:22', '127.0.0.1');
INSERT INTO `logs` VALUES (64, 'ikigai登录后台', 52, '2019-05-10 14:34:51', '127.0.0.1');
INSERT INTO `logs` VALUES (65, 'ikigai登录后台', 52, '2019-05-10 15:37:26', '127.0.0.1');

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '用户id',
  `author` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '作者',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '标题',
  `markDown_content` mediumtext CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'Markdown内容',
  `content` mediumtext CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT '内容',
  `view_count` int(11) NULL DEFAULT 0 COMMENT '浏览次数',
  `comment_count` int(11) NULL DEFAULT 0 COMMENT '评论次数',
  `like_count` int(11) NULL DEFAULT 0 COMMENT '喜欢次数',
  `status` int(1) NULL DEFAULT NULL COMMENT '文章状态，1：发布，2：草稿箱，3：关于我',
  `create_time` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 316 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of post
-- ----------------------------
INSERT INTO `post` VALUES (313, 52, 'ikigai', '关于我', '自己搞着玩玩！', '<p>自己搞着玩玩！</p>\n', 2, 0, 0, 3, '2019-04-30 17:44:00', '2019-04-30 17:47:47');

-- ----------------------------
-- Table structure for post_category
-- ----------------------------
DROP TABLE IF EXISTS `post_category`;
CREATE TABLE `post_category`  (
  `post_id` int(11) NULL DEFAULT NULL COMMENT '帖子id',
  `category_id` int(11) NULL DEFAULT NULL COMMENT '分类id'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for post_tag
-- ----------------------------
DROP TABLE IF EXISTS `post_tag`;
CREATE TABLE `post_tag`  (
  `post_id` int(11) NOT NULL COMMENT '帖子id',
  `tag_id` int(11) NOT NULL COMMENT '标签id'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '名称',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 97 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '密码',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '邮箱',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '网站',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `role` int(1) UNSIGNED ZEROFILL NULL DEFAULT 0 COMMENT '0：普通用户，1：管理员',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 92 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (52, 'ikigai', 'ikigai', 'wsldope@gmail.com', 'http//weishilei.top', '2019-04-12 17:32:52', 1);

-- ----------------------------
-- Table structure for website_config
-- ----------------------------
DROP TABLE IF EXISTS `website_config`;
CREATE TABLE `website_config`  (
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '标题',
  `weibo` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `wechat` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `qq` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `keyword` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'SEO关键字',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '描述',
  `footer` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '页脚'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of website_config
-- ----------------------------
INSERT INTO `website_config` VALUES ('ikigai博客', 'non2587', 'wsldope@gmail.com', 'wsl25872587', '1278809513', '博客', '博客', '© 2019 ikigai');

SET FOREIGN_KEY_CHECKS = 1;
