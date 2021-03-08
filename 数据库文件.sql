-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        5.7.32 - MySQL Community Server (GPL)
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- 导出 ssmbuild 的数据库结构
CREATE DATABASE IF NOT EXISTS `ssmbuild` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `ssmbuild`;

-- 导出  表 ssmbuild.books 结构
CREATE TABLE IF NOT EXISTS `books` (
  `bookID` int(10) NOT NULL AUTO_INCREMENT COMMENT '书id',
  `bookName` varchar(100) NOT NULL COMMENT '书名',
  `bookCounts` int(11) NOT NULL COMMENT '数量',
  `detail` varchar(200) NOT NULL COMMENT '描述',
  KEY `bookID` (`bookID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- 正在导出表  ssmbuild.books 的数据：~6 rows (大约)
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
REPLACE INTO `books` (`bookID`, `bookName`, `bookCounts`, `detail`) VALUES
	(1, 'Java', 2, '真不错'),
	(2, 'MySQL', 12, '你说呢'),
	(3, 'Linux', 5, '从进门到进牢'),
	(4, 'Oracle', 10, '测试下'),
	(5, '如果觉得不错', 100, '能不能点个star'),
	(6, '或者点个fork', 100, '谢谢啦');
/*!40000 ALTER TABLE `books` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
