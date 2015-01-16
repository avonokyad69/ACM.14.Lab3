-- phpMyAdmin SQL Dump
-- version 4.2.7
-- http://www.phpmyadmin.net
--
-- Host: localhost:8889
-- Generation Time: Jan 16, 2015 at 08:32 PM
-- Server version: 5.6.17-debug-log
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `db`
--

-- --------------------------------------------------------

--
-- Table structure for table `areas`
--

CREATE TABLE IF NOT EXISTS `areas` (
  `id` int(3) DEFAULT NULL,
  `Region` varchar(20) DEFAULT NULL,
  `Department` varchar(20) DEFAULT NULL,
  `Employee` int(20) DEFAULT NULL,
  `Prpost` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `areas`
--

INSERT INTO `areas` (`id`, `Region`, `Department`, `Employee`, `Prpost`) VALUES
(43982153, 'North America', 'Los Angeles', 56, 1),
(45456265, 'Africa', 'Capetown', 32, 0),
(43539225, 'Middle Europe', 'Budapest', 45, 0),
(43535721, 'Middle East', 'Tehran', 21, 1);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
