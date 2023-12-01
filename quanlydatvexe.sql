-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 30, 2023 at 05:32 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quanlydatvexe`
--

-- --------------------------------------------------------

--
-- Table structure for table `chuyenxe`
--

CREATE TABLE `chuyenxe` (
  `MaChuyen` int(11) NOT NULL,
  `TenChuyen` varchar(500) NOT NULL,
  `MaXeBus` int(11) DEFAULT NULL,
  `MaTaiXe` int(11) DEFAULT NULL,
  `DiemBatDau` varchar(200) DEFAULT NULL,
  `DiemKetThuc` varchar(200) DEFAULT NULL,
  `GioKhoiHanh` time DEFAULT NULL,
  `UocTinhThoiGian` int(11) DEFAULT NULL,
  `GiaVeNguoiLon` int(11) DEFAULT NULL,
  `GiaVeTreEm` int(11) DEFAULT NULL,
  `GiamGia` int(11) DEFAULT NULL,
  `LuuY` varchar(500) DEFAULT NULL,
  `TrangThai` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `chuyenxe`
--

INSERT INTO `chuyenxe` (`MaChuyen`, `TenChuyen`, `MaXeBus`, `MaTaiXe`, `DiemBatDau`, `DiemKetThuc`, `GioKhoiHanh`, `UocTinhThoiGian`, `GiaVeNguoiLon`, `GiaVeTreEm`, `GiamGia`, `LuuY`, `TrangThai`) VALUES
(32, 'Tuyến ĐH Bình Dương - KCN Visip 1', 19, 18, 'Đại học Bình Dương ', 'Đại học Bình Dương', '07:00:00', 3, 15000, 10000, NULL, 'z', 1),
(33, 'Tuyến đại học Thủ Dầu Một - Bệnh Viện 512', 8, 5, 'Đại học Thủ Dầu Một', 'Đại học Thủ Dầu Một', '13:00:00', 4, 15000, 10000, NULL, 'z', 1);

-- --------------------------------------------------------

--
-- Table structure for table `datve`
--

CREATE TABLE `datve` (
  `MaVe` int(11) NOT NULL,
  `MaChuyen` int(11) DEFAULT NULL,
  `MaKhachHang` int(11) DEFAULT NULL,
  `NgayDat` datetime DEFAULT NULL,
  `TrangThai` tinyint(4) DEFAULT NULL,
  `NgayDi` date DEFAULT NULL,
  `DiemDon` varchar(500) DEFAULT NULL,
  `DiemTra` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `datve`
--

INSERT INTO `datve` (`MaVe`, `MaChuyen`, `MaKhachHang`, `NgayDat`, `TrangThai`, `NgayDi`, `DiemDon`, `DiemTra`) VALUES
(36, 32, 10, '2023-11-08 10:33:14', 2, '2023-11-11', 'Ngã 3 Phong Vũ - 07:15:00', NULL),
(37, 32, 10, '2023-11-08 15:20:03', 0, '2023-11-09', 'KCN Visip 1 - 10:00:00', NULL),
(39, 33, 10, '2023-11-08 20:27:06', 0, '2023-11-11', 'Đại học Bình Dương - 14:00:00', NULL),
(40, 32, 10, '2023-11-08 22:55:36', 2, '2023-11-30', 'Đại học Bình Dương - 07:00:00', NULL),
(41, 32, 10, '2023-11-14 09:36:41', 1, '2023-11-14', 'Đại học Bình Dương - 07:00:00', NULL),
(42, 32, 10, '2023-11-14 09:37:05', 1, '2023-11-14', 'Đại học Bình Dương - 07:00:00', NULL),
(43, 33, 10, '2023-11-14 09:57:53', 1, '2023-11-15', 'Đại học Thủ Dầu Một - 13:00:00', NULL),
(44, 33, 10, '2023-11-14 09:59:21', 1, '2023-11-15', 'Đại học Thủ Dầu Một - 13:00:00', NULL),
(45, 33, 10, '2023-11-14 10:01:12', 1, '2023-11-15', 'Đại học Thủ Dầu Một - 13:00:00', NULL),
(46, 33, 10, '2023-11-29 09:25:11', 0, '2023-12-02', 'Vòng xoay An Phú - 15:30:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `dondangkyvethang`
--

CREATE TABLE `dondangkyvethang` (
  `MaDonDangKy` int(11) NOT NULL,
  `MaKhachHang` int(11) DEFAULT NULL,
  `LoaiVeDangKy` int(11) DEFAULT NULL,
  `DiaChi` varchar(5000) DEFAULT NULL,
  `LoaiDoiTuong` int(11) DEFAULT NULL,
  `AnhThe` varchar(5000) DEFAULT NULL,
  `TrangThai` int(11) DEFAULT NULL,
  `LuuY` varchar(5000) DEFAULT NULL,
  `MaTuyen` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ghexebus`
--

CREATE TABLE `ghexebus` (
  `MaGheXe` int(11) NOT NULL,
  `MaXeBus` int(11) DEFAULT NULL,
  `TenGhe` varchar(45) DEFAULT NULL,
  `SoGhe` int(11) DEFAULT NULL,
  `DaDat` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `ghexebus`
--

INSERT INTO `ghexebus` (`MaGheXe`, `MaXeBus`, `TenGhe`, `SoGhe`, `DaDat`) VALUES
(181, 8, '1A', 1, 0),
(182, 8, '1B', 2, 0),
(183, 8, '1C', 3, 0),
(184, 8, '1D', 4, 0),
(185, 8, '1E', 5, 0),
(186, 8, '1F', 6, 0),
(187, 8, '2A', 7, 0),
(188, 8, '2B', 8, 0),
(189, 8, '2C', 9, 0),
(190, 8, '2D', 10, 0),
(191, 8, '2E', 11, 0),
(192, 8, '2F', 12, 0),
(193, 8, '3A', 13, 0),
(194, 8, '3B', 14, 0),
(195, 8, '3C', 15, 0),
(196, 8, '3D', 16, 0),
(197, 8, '3E', 17, 0),
(198, 8, '3F', 18, 0),
(199, 8, '4A', 19, 0),
(200, 8, '4B', 20, 0),
(201, 8, '4C', 21, 0),
(202, 8, '4D', 22, 0),
(203, 8, '4E', 23, 0),
(204, 8, '4F', 24, 0),
(205, 8, '5A', 25, 0),
(206, 8, '5B', 26, 0),
(207, 8, '5C', 27, 0),
(208, 8, '5D', 28, 0),
(209, 8, '5E', 29, 0),
(210, 8, '5F', 30, 0),
(211, 8, '6A', 31, 0),
(212, 8, '6B', 32, 0),
(213, 8, '6C', 33, 0),
(214, 8, '6D', 34, 0),
(215, 8, '6E', 35, 0),
(216, 8, '6F', 36, 0),
(217, 8, '7A', 37, 0),
(218, 8, '7B', 38, 0),
(219, 8, '7C', 39, 0),
(220, 8, '7D', 40, 0),
(221, 8, '7E', 41, 0),
(222, 8, '7F', 42, 0),
(223, 8, '8A', 43, 0),
(224, 8, '8B', 44, 0),
(225, 8, '8C', 45, 0),
(226, 8, '8D', 46, 0),
(227, 8, '8E', 47, 0),
(228, 8, '8F', 48, 0),
(229, 8, '9A', 49, 0),
(230, 8, '9B', 50, 0),
(231, 8, '9C', 51, 0),
(232, 8, '9D', 52, 0),
(233, 8, '9E', 53, 0),
(234, 8, '9F', 54, 0),
(235, 8, '10A', 55, 0),
(236, 8, '10B', 56, 0),
(237, 8, '10C', 57, 0),
(238, 8, '10D', 58, 0),
(239, 8, '10E', 59, 0),
(240, 8, '10F', 60, 0),
(241, 9, '1A', 1, 0),
(242, 9, '1B', 2, 0),
(243, 9, '1C', 3, 0),
(244, 9, '1D', 4, 0),
(245, 9, '1E', 5, 0),
(246, 9, '1F', 6, 0),
(247, 9, '2A', 7, 0),
(248, 9, '2B', 8, 0),
(249, 9, '2C', 9, 0),
(250, 9, '2D', 10, 0),
(251, 9, '2E', 11, 0),
(252, 9, '2F', 12, 0),
(253, 9, '3A', 13, 0),
(254, 9, '3B', 14, 0),
(255, 9, '3C', 15, 0),
(256, 9, '3D', 16, 0),
(257, 9, '3E', 17, 0),
(258, 9, '3F', 18, 0),
(259, 9, '4A', 19, 0),
(260, 9, '4B', 20, 0),
(261, 9, '4C', 21, 0),
(262, 9, '4D', 22, 0),
(263, 9, '4E', 23, 0),
(264, 9, '4F', 24, 0),
(265, 9, '5A', 25, 0),
(266, 9, '5B', 26, 0),
(267, 9, '5C', 27, 0),
(268, 9, '5D', 28, 0),
(269, 9, '5E', 29, 0),
(270, 9, '5F', 30, 0),
(271, 9, '6A', 31, 0),
(272, 9, '6B', 32, 0),
(273, 9, '6C', 33, 0),
(274, 9, '6D', 34, 0),
(275, 9, '6E', 35, 0),
(276, 9, '6F', 36, 0),
(277, 9, '7A', 37, 0),
(278, 9, '7B', 38, 0),
(279, 9, '7C', 39, 0),
(280, 9, '7D', 40, 0),
(281, 9, '7E', 41, 0),
(282, 9, '7F', 42, 0),
(283, 9, '8A', 43, 0),
(284, 9, '8B', 44, 0),
(285, 9, '8C', 45, 0),
(286, 9, '8D', 46, 0),
(287, 9, '8E', 47, 0),
(288, 9, '8F', 48, 0),
(289, 9, '9A', 49, 0),
(290, 9, '9B', 50, 0),
(291, 9, '9C', 51, 0),
(292, 9, '9D', 52, 0),
(293, 9, '9E', 53, 0),
(294, 9, '9F', 54, 0),
(295, 9, '10A', 55, 0),
(296, 9, '10B', 56, 0),
(297, 9, '10C', 57, 0),
(298, 9, '10D', 58, 0),
(299, 9, '10E', 59, 0),
(300, 9, '10F', 60, 0),
(301, 10, '1A', 1, 0),
(302, 10, '1B', 2, 0),
(303, 10, '1C', 3, 0),
(304, 10, '1D', 4, 0),
(305, 10, '1E', 5, 0),
(306, 10, '1F', 6, 0),
(307, 10, '2A', 7, 0),
(308, 10, '2B', 8, 0),
(309, 10, '2C', 9, 0),
(310, 10, '2D', 10, 0),
(311, 10, '2E', 11, 0),
(312, 10, '2F', 12, 0),
(313, 10, '3A', 13, 0),
(314, 10, '3B', 14, 0),
(315, 10, '3C', 15, 0),
(316, 10, '3D', 16, 0),
(317, 10, '3E', 17, 0),
(318, 10, '3F', 18, 0),
(319, 10, '4A', 19, 0),
(320, 10, '4B', 20, 0),
(321, 10, '4C', 21, 0),
(322, 10, '4D', 22, 0),
(323, 10, '4E', 23, 0),
(324, 10, '4F', 24, 0),
(325, 10, '5A', 25, 0),
(326, 10, '5B', 26, 0),
(327, 10, '5C', 27, 0),
(328, 10, '5D', 28, 0),
(329, 10, '5E', 29, 0),
(330, 10, '5F', 30, 0),
(331, 10, '6A', 31, 0),
(332, 10, '6B', 32, 0),
(333, 10, '6C', 33, 0),
(334, 10, '6D', 34, 0),
(335, 10, '6E', 35, 0),
(336, 10, '6F', 36, 0),
(337, 10, '7A', 37, 0),
(338, 10, '7B', 38, 0),
(339, 10, '7C', 39, 0),
(340, 10, '7D', 40, 0),
(341, 10, '7E', 41, 0),
(342, 10, '7F', 42, 0),
(343, 10, '8A', 43, 0),
(344, 10, '8B', 44, 0),
(345, 10, '8C', 45, 0),
(346, 10, '8D', 46, 0),
(347, 10, '8E', 47, 0),
(348, 10, '8F', 48, 0),
(349, 10, '9A', 49, 0),
(350, 10, '9B', 50, 0),
(351, 10, '9C', 51, 0),
(352, 10, '9D', 52, 0),
(353, 10, '9E', 53, 0),
(354, 10, '9F', 54, 0),
(355, 10, '10A', 55, 0),
(356, 10, '10B', 56, 0),
(357, 10, '10C', 57, 0),
(358, 10, '10D', 58, 0),
(359, 10, '10E', 59, 0),
(360, 10, '10F', 60, 0),
(361, 11, '1A', 1, 0),
(362, 11, '1B', 2, 0),
(363, 11, '1C', 3, 0),
(364, 11, '1D', 4, 0),
(365, 11, '1E', 5, 0),
(366, 11, '1F', 6, 0),
(367, 11, '2A', 7, 0),
(368, 11, '2B', 8, 0),
(369, 11, '2C', 9, 0),
(370, 11, '2D', 10, 0),
(371, 11, '2E', 11, 0),
(372, 11, '2F', 12, 0),
(373, 11, '3A', 13, 0),
(374, 11, '3B', 14, 0),
(375, 11, '3C', 15, 0),
(376, 11, '3D', 16, 0),
(377, 11, '3E', 17, 0),
(378, 11, '3F', 18, 0),
(379, 11, '4A', 19, 0),
(380, 11, '4B', 20, 0),
(381, 11, '4C', 21, 0),
(382, 11, '4D', 22, 0),
(383, 11, '4E', 23, 0),
(384, 11, '4F', 24, 0),
(385, 11, '5A', 25, 0),
(386, 11, '5B', 26, 0),
(387, 11, '5C', 27, 0),
(388, 11, '5D', 28, 0),
(389, 11, '5E', 29, 0),
(390, 11, '5F', 30, 0),
(391, 11, '6A', 31, 0),
(392, 11, '6B', 32, 0),
(393, 11, '6C', 33, 0),
(394, 11, '6D', 34, 0),
(395, 11, '6E', 35, 0),
(396, 11, '6F', 36, 0),
(397, 11, '7A', 37, 0),
(398, 11, '7B', 38, 0),
(399, 11, '7C', 39, 0),
(400, 11, '7D', 40, 0),
(401, 11, '7E', 41, 0),
(402, 11, '7F', 42, 0),
(403, 11, '8A', 43, 0),
(404, 11, '8B', 44, 0),
(405, 11, '8C', 45, 0),
(406, 11, '8D', 46, 0),
(407, 11, '8E', 47, 0),
(408, 11, '8F', 48, 0),
(409, 11, '9A', 49, 0),
(410, 11, '9B', 50, 0),
(411, 11, '9C', 51, 0),
(412, 11, '9D', 52, 0),
(413, 11, '9E', 53, 0),
(414, 11, '9F', 54, 0),
(415, 11, '10A', 55, 0),
(416, 11, '10B', 56, 0),
(417, 11, '10C', 57, 0),
(418, 11, '10D', 58, 0),
(419, 11, '10E', 59, 0),
(420, 11, '10F', 60, 0),
(421, 12, '1A', 60, 0),
(422, 12, '1B', 60, 0),
(423, 12, '1C', 60, 0),
(424, 12, '1D', 60, 0),
(425, 12, '1E', 60, 0),
(426, 12, '1F', 60, 0),
(427, 12, '2A', 60, 0),
(428, 12, '2B', 60, 0),
(429, 12, '2C', 60, 0),
(430, 12, '2D', 60, 0),
(431, 12, '2E', 60, 0),
(432, 12, '2F', 60, 0),
(433, 12, '3A', 60, 0),
(434, 12, '3B', 60, 0),
(435, 12, '3C', 60, 0),
(436, 12, '3D', 60, 0),
(437, 12, '3E', 60, 0),
(438, 12, '3F', 60, 0),
(439, 12, '4A', 60, 0),
(440, 12, '4B', 60, 0),
(441, 12, '4C', 60, 0),
(442, 12, '4D', 60, 0),
(443, 12, '4E', 60, 0),
(444, 12, '4F', 60, 0),
(445, 12, '5A', 60, 0),
(446, 12, '5B', 60, 0),
(447, 12, '5C', 60, 0),
(448, 12, '5D', 60, 0),
(449, 12, '5E', 60, 0),
(450, 12, '5F', 60, 0),
(451, 12, '6A', 60, 0),
(452, 12, '6B', 60, 0),
(453, 12, '6C', 60, 0),
(454, 12, '6D', 60, 0),
(455, 12, '6E', 60, 0),
(456, 12, '6F', 60, 0),
(457, 12, '7A', 60, 0),
(458, 12, '7B', 60, 0),
(459, 12, '7C', 60, 0),
(460, 12, '7D', 60, 0),
(461, 12, '7E', 60, 0),
(462, 12, '7F', 60, 0),
(463, 12, '8A', 60, 0),
(464, 12, '8B', 60, 0),
(465, 12, '8C', 60, 0),
(466, 12, '8D', 60, 0),
(467, 12, '8E', 60, 0),
(468, 12, '8F', 60, 0),
(469, 12, '9A', 60, 0),
(470, 12, '9B', 60, 0),
(471, 12, '9C', 60, 0),
(472, 12, '9D', 60, 0),
(473, 12, '9E', 60, 0),
(474, 12, '9F', 60, 0),
(475, 12, '10A', 60, 0),
(476, 12, '10B', 60, 0),
(477, 12, '10C', 60, 0),
(478, 12, '10D', 60, 0),
(479, 12, '10E', 60, 0),
(480, 12, '10F', 60, 0),
(541, 14, '1A', 60, 0),
(542, 14, '1B', 60, 0),
(543, 14, '1C', 60, 0),
(544, 14, '1D', 60, 0),
(545, 14, '1E', 60, 0),
(546, 14, '1F', 60, 0),
(547, 14, '2A', 60, 0),
(548, 14, '2B', 60, 0),
(549, 14, '2C', 60, 0),
(550, 14, '2D', 60, 0),
(551, 14, '2E', 60, 0),
(552, 14, '2F', 60, 0),
(553, 14, '3A', 60, 0),
(554, 14, '3B', 60, 0),
(555, 14, '3C', 60, 0),
(556, 14, '3D', 60, 0),
(557, 14, '3E', 60, 0),
(558, 14, '3F', 60, 0),
(559, 14, '4A', 60, 0),
(560, 14, '4B', 60, 0),
(561, 14, '4C', 60, 0),
(562, 14, '4D', 60, 0),
(563, 14, '4E', 60, 0),
(564, 14, '4F', 60, 0),
(565, 14, '5A', 60, 0),
(566, 14, '5B', 60, 0),
(567, 14, '5C', 60, 0),
(568, 14, '5D', 60, 0),
(569, 14, '5E', 60, 0),
(570, 14, '5F', 60, 0),
(571, 14, '6A', 60, 0),
(572, 14, '6B', 60, 0),
(573, 14, '6C', 60, 0),
(574, 14, '6D', 60, 0),
(575, 14, '6E', 60, 0),
(576, 14, '6F', 60, 0),
(577, 14, '7A', 60, 0),
(578, 14, '7B', 60, 0),
(579, 14, '7C', 60, 0),
(580, 14, '7D', 60, 0),
(581, 14, '7E', 60, 0),
(582, 14, '7F', 60, 0),
(583, 14, '8A', 60, 0),
(584, 14, '8B', 60, 0),
(585, 14, '8C', 60, 0),
(586, 14, '8D', 60, 0),
(587, 14, '8E', 60, 0),
(588, 14, '8F', 60, 0),
(589, 14, '9A', 60, 0),
(590, 14, '9B', 60, 0),
(591, 14, '9C', 60, 0),
(592, 14, '9D', 60, 0),
(593, 14, '9E', 60, 0),
(594, 14, '9F', 60, 0),
(595, 14, '10A', 60, 0),
(596, 14, '10B', 60, 0),
(597, 14, '10C', 60, 0),
(598, 14, '10D', 60, 0),
(599, 14, '10E', 60, 0),
(600, 14, '10F', 60, 0),
(661, 16, '1A', 60, 0),
(662, 16, '1B', 60, 0),
(663, 16, '1C', 60, 0),
(664, 16, '1D', 60, 0),
(665, 16, '1E', 60, 0),
(666, 16, '1F', 60, 0),
(667, 16, '2A', 60, 0),
(668, 16, '2B', 60, 0),
(669, 16, '2C', 60, 0),
(670, 16, '2D', 60, 0),
(671, 16, '2E', 60, 0),
(672, 16, '2F', 60, 0),
(673, 16, '3A', 60, 0),
(674, 16, '3B', 60, 0),
(675, 16, '3C', 60, 0),
(676, 16, '3D', 60, 0),
(677, 16, '3E', 60, 0),
(678, 16, '3F', 60, 0),
(679, 16, '4A', 60, 0),
(680, 16, '4B', 60, 0),
(681, 16, '4C', 60, 0),
(682, 16, '4D', 60, 0),
(683, 16, '4E', 60, 0),
(684, 16, '4F', 60, 0),
(685, 16, '5A', 60, 0),
(686, 16, '5B', 60, 0),
(687, 16, '5C', 60, 0),
(688, 16, '5D', 60, 0),
(689, 16, '5E', 60, 0),
(690, 16, '5F', 60, 0),
(691, 16, '6A', 60, 0),
(692, 16, '6B', 60, 0),
(693, 16, '6C', 60, 0),
(694, 16, '6D', 60, 0),
(695, 16, '6E', 60, 0),
(696, 16, '6F', 60, 0),
(697, 16, '7A', 60, 0),
(698, 16, '7B', 60, 0),
(699, 16, '7C', 60, 0),
(700, 16, '7D', 60, 0),
(701, 16, '7E', 60, 0),
(702, 16, '7F', 60, 0),
(703, 16, '8A', 60, 0),
(704, 16, '8B', 60, 0),
(705, 16, '8C', 60, 0),
(706, 16, '8D', 60, 0),
(707, 16, '8E', 60, 0),
(708, 16, '8F', 60, 0),
(709, 16, '9A', 60, 0),
(710, 16, '9B', 60, 0),
(711, 16, '9C', 60, 0),
(712, 16, '9D', 60, 0),
(713, 16, '9E', 60, 0),
(714, 16, '9F', 60, 0),
(715, 16, '10A', 60, 0),
(716, 16, '10B', 60, 0),
(717, 16, '10C', 60, 0),
(718, 16, '10D', 60, 0),
(719, 16, '10E', 60, 0),
(720, 16, '10F', 60, 0),
(721, 17, '1A', 60, 0),
(722, 17, '1B', 60, 0),
(723, 17, '1C', 60, 0),
(724, 17, '1D', 60, 0),
(725, 17, '1E', 60, 0),
(726, 17, '1F', 60, 0),
(727, 17, '2A', 60, 0),
(728, 17, '2B', 60, 0),
(729, 17, '2C', 60, 0),
(730, 17, '2D', 60, 0),
(731, 17, '2E', 60, 0),
(732, 17, '2F', 60, 0),
(733, 17, '3A', 60, 0),
(734, 17, '3B', 60, 0),
(735, 17, '3C', 60, 0),
(736, 17, '3D', 60, 0),
(737, 17, '3E', 60, 0),
(738, 17, '3F', 60, 0),
(739, 17, '4A', 60, 0),
(740, 17, '4B', 60, 0),
(741, 17, '4C', 60, 0),
(742, 17, '4D', 60, 0),
(743, 17, '4E', 60, 0),
(744, 17, '4F', 60, 0),
(745, 17, '5A', 60, 0),
(746, 17, '5B', 60, 0),
(747, 17, '5C', 60, 0),
(748, 17, '5D', 60, 0),
(749, 17, '5E', 60, 0),
(750, 17, '5F', 60, 0),
(751, 17, '6A', 60, 0),
(752, 17, '6B', 60, 0),
(753, 17, '6C', 60, 0),
(754, 17, '6D', 60, 0),
(755, 17, '6E', 60, 0),
(756, 17, '6F', 60, 0),
(757, 17, '7A', 60, 0),
(758, 17, '7B', 60, 0),
(759, 17, '7C', 60, 0),
(760, 17, '7D', 60, 0),
(761, 17, '7E', 60, 0),
(762, 17, '7F', 60, 0),
(763, 17, '8A', 60, 0),
(764, 17, '8B', 60, 0),
(765, 17, '8C', 60, 0),
(766, 17, '8D', 60, 0),
(767, 17, '8E', 60, 0),
(768, 17, '8F', 60, 0),
(769, 17, '9A', 60, 0),
(770, 17, '9B', 60, 0),
(771, 17, '9C', 60, 0),
(772, 17, '9D', 60, 0),
(773, 17, '9E', 60, 0),
(774, 17, '9F', 60, 0),
(775, 17, '10A', 60, 0),
(776, 17, '10B', 60, 0),
(777, 17, '10C', 60, 0),
(778, 17, '10D', 60, 0),
(779, 17, '10E', 60, 0),
(780, 17, '10F', 60, 0),
(841, 19, '1A', 60, 0),
(842, 19, '1B', 60, 0),
(843, 19, '1C', 60, 0),
(844, 19, '1D', 60, 0),
(845, 19, '1E', 60, 0),
(846, 19, '1F', 60, 0),
(847, 19, '2A', 60, 0),
(848, 19, '2B', 60, 0),
(849, 19, '2C', 60, 0),
(850, 19, '2D', 60, 0),
(851, 19, '2E', 60, 0),
(852, 19, '2F', 60, 0),
(853, 19, '3A', 60, 0),
(854, 19, '3B', 60, 0),
(855, 19, '3C', 60, 0),
(856, 19, '3D', 60, 0),
(857, 19, '3E', 60, 0),
(858, 19, '3F', 60, 0),
(859, 19, '4A', 60, 0),
(860, 19, '4B', 60, 0),
(861, 19, '4C', 60, 0),
(862, 19, '4D', 60, 0),
(863, 19, '4E', 60, 0),
(864, 19, '4F', 60, 0),
(865, 19, '5A', 60, 0),
(866, 19, '5B', 60, 0),
(867, 19, '5C', 60, 0),
(868, 19, '5D', 60, 0),
(869, 19, '5E', 60, 0),
(870, 19, '5F', 60, 0),
(871, 19, '6A', 60, 0),
(872, 19, '6B', 60, 0),
(873, 19, '6C', 60, 0),
(874, 19, '6D', 60, 0),
(875, 19, '6E', 60, 0),
(876, 19, '6F', 60, 0),
(877, 19, '7A', 60, 0),
(878, 19, '7B', 60, 0),
(879, 19, '7C', 60, 0),
(880, 19, '7D', 60, 0),
(881, 19, '7E', 60, 0),
(882, 19, '7F', 60, 0),
(883, 19, '8A', 60, 0),
(884, 19, '8B', 60, 0),
(885, 19, '8C', 60, 0),
(886, 19, '8D', 60, 0),
(887, 19, '8E', 60, 0),
(888, 19, '8F', 60, 0),
(889, 19, '9A', 60, 0),
(890, 19, '9B', 60, 0),
(891, 19, '9C', 60, 0),
(892, 19, '9D', 60, 0),
(893, 19, '9E', 60, 0),
(894, 19, '9F', 60, 0),
(895, 19, '10A', 60, 0),
(896, 19, '10B', 60, 0),
(897, 19, '10C', 60, 0),
(898, 19, '10D', 60, 0),
(899, 19, '10E', 60, 0),
(900, 19, '10F', 60, 0);

-- --------------------------------------------------------

--
-- Table structure for table `hoadon`
--

CREATE TABLE `hoadon` (
  `MaHoaDon` int(11) NOT NULL,
  `TenDichVu` varchar(5000) DEFAULT NULL,
  `ChiTietDichVu` varchar(5000) DEFAULT NULL,
  `TrangThai` int(11) DEFAULT NULL,
  `SoTien` int(11) DEFAULT NULL,
  `PhuongThucThanhToan` varchar(100) DEFAULT NULL,
  `MaNguoiDung` int(11) DEFAULT NULL,
  `NgayLap` datetime DEFAULT NULL,
  `NgayThanhToan` datetime DEFAULT NULL,
  `LuuY` varchar(5000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hoadon`
--

INSERT INTO `hoadon` (`MaHoaDon`, `TenDichVu`, `ChiTietDichVu`, `TrangThai`, `SoTien`, `PhuongThucThanhToan`, `MaNguoiDung`, `NgayLap`, `NgayThanhToan`, `LuuY`) VALUES
(3, NULL, '[{\"type\": \"B\\u00ecnh th\\u01b0\\u1eddng - li\\u00ean tuy\\u1ebfn (200k/th\\u00e1ng)\", \"description\": \"D\\u1ecbch v\\u1ee5 v\\u00e9 th\\u00e1ng d\\u00e0nh cho ng\\u01b0\\u1eddi b\\u00ecnh th\\u01b0\\u1eddng c\\u00f3 th\\u1ec3 s\\u1eed d\\u1ee5ng cho t\\u1ea5t c\\u1ea3 c\\u00e1c tuy\\u1ebfn hi\\u1ec7n t\\u1ea1i.\", \"quantity\": 2, \"totalPrice\": 400000}, {\"type\": \"Kh\\u00e1c\", \"description\": \"Mua v\\u00e9 m\\u1ed9t tuy\\u1ebfn\", \"quantity\": 2, \"totalPrice\": 15000}, {\"type\": \"\\u01afu ti\\u00ean - m\\u1ed9t tuy\\u1ebfn (55k/th\\u00e1ng)\", \"description\": \"D\\u1ecbch v\\u1ee5 v\\u00e9 th\\u00e1ng \\u01b0u ti\\u00ean d\\u00e0nh cho m\\u1ed9t tuy\\u1ebfn c\\u1ed1 \\u0111\\u1ecbnh.\", \"quantity\": 2, \"totalPrice\": 110000}]', 0, 525000, '1', 40, '2023-11-29 10:35:44', NULL, 'zzzzzzzzzzzzzzzzzzzzzzzzzz'),
(6, NULL, '[{\"type\": \"B\\u00ecnh th\\u01b0\\u1eddng - li\\u00ean tuy\\u1ebfn (200k/th\\u00e1ng)\", \"description\": \"D\\u1ecbch v\\u1ee5 v\\u00e9 th\\u00e1ng d\\u00e0nh cho ng\\u01b0\\u1eddi b\\u00ecnh th\\u01b0\\u1eddng c\\u00f3 th\\u1ec3 s\\u1eed d\\u1ee5ng cho t\\u1ea5t c\\u1ea3 c\\u00e1c tuy\\u1ebfn hi\\u1ec7n t\\u1ea1i.\", \"quantity\": 1, \"totalPrice\": 200000}]', 1, 200000, '0', 48, '2023-11-29 20:08:34', '2023-11-29 20:08:48', '');

-- --------------------------------------------------------

--
-- Table structure for table `khachhang`
--

CREATE TABLE `khachhang` (
  `MaKhachHang` int(11) NOT NULL,
  `MaNguoiDung` int(11) DEFAULT NULL,
  `HoVaTenKhachHang` varchar(100) DEFAULT NULL,
  `DiaChi` varchar(500) DEFAULT NULL,
  `SoDienThoai` varchar(45) DEFAULT NULL,
  `CMND` varchar(20) DEFAULT NULL,
  `AnhDaiDien` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `khachhang`
--

INSERT INTO `khachhang` (`MaKhachHang`, `MaNguoiDung`, `HoVaTenKhachHang`, `DiaChi`, `SoDienThoai`, `CMND`, `AnhDaiDien`) VALUES
(10, 40, 'Lê Huỳnh Nam', 'Bình Dương', '034411808', '1111111111', '20231026000300.jpg'),
(16, 48, 'Nguyễn Zed', 'zzz', '9123333', '323', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lichlaixe`
--

CREATE TABLE `lichlaixe` (
  `MaLichLai` int(11) NOT NULL,
  `MaTaiXe` int(11) DEFAULT NULL,
  `MaXeBus` int(11) DEFAULT NULL,
  `Ngay` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lichsudatghe`
--

CREATE TABLE `lichsudatghe` (
  `id` int(11) NOT NULL,
  `MaChuyen` int(11) NOT NULL,
  `MaNguoiDung` int(11) NOT NULL,
  `IDGhe` varchar(5) NOT NULL,
  `NgayDat` date NOT NULL,
  `MaVe` int(11) DEFAULT NULL,
  `MaXeBus` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `lichsudatghe`
--

INSERT INTO `lichsudatghe` (`id`, `MaChuyen`, `MaNguoiDung`, `IDGhe`, `NgayDat`, `MaVe`, `MaXeBus`) VALUES
(62, 32, 40, '1A', '2023-11-11', 36, NULL),
(63, 32, 40, '2A', '2023-11-11', 36, NULL),
(66, 32, 40, '10C', '2023-11-14', 41, NULL),
(67, 32, 40, '10D', '2023-11-14', 41, NULL),
(68, 32, 40, '9D', '2023-11-14', 42, NULL),
(69, 32, 40, '9E', '2023-11-14', 42, NULL),
(70, 33, 40, '6C', '2023-11-15', 43, NULL),
(71, 33, 40, '7C', '2023-11-15', 43, NULL),
(72, 33, 40, 'slt', '2023-11-15', 43, NULL),
(73, 33, 40, '9D', '2023-11-15', 44, NULL),
(74, 33, 40, '9E', '2023-11-15', 44, NULL),
(75, 33, 40, 'slt', '2023-11-15', 44, NULL),
(76, 33, 40, '8C', '2023-11-15', 45, NULL),
(77, 33, 40, '8D', '2023-11-15', 45, NULL),
(78, 33, 40, '', '2023-11-15', 45, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lichsukhachhang`
--

CREATE TABLE `lichsukhachhang` (
  `MaLichSuKhachHang` int(11) NOT NULL,
  `SuKien` varchar(5000) DEFAULT NULL,
  `Ngay` datetime DEFAULT NULL,
  `MaKhachHang` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lichsuthanhtoan`
--

CREATE TABLE `lichsuthanhtoan` (
  `id` int(11) NOT NULL,
  `MaKhachHang` int(11) DEFAULT NULL,
  `MaVe` int(11) DEFAULT NULL,
  `PhuongThucThanhToan` varchar(45) DEFAULT NULL,
  `TrangThai` tinyint(4) DEFAULT NULL,
  `SoTien` int(11) DEFAULT NULL,
  `NgayThanhToan` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `lichsuthanhtoan`
--

INSERT INTO `lichsuthanhtoan` (`id`, `MaKhachHang`, `MaVe`, `PhuongThucThanhToan`, `TrangThai`, `SoTien`, `NgayThanhToan`) VALUES
(33, 10, 36, '2', 1, 45000, '2023-11-08 20:07:11'),
(34, 10, 37, '0', 0, 30000, NULL),
(36, 10, 39, '0', 0, 30000, NULL),
(37, 10, 40, '1', 1, 30000, '2023-11-08 23:00:10'),
(38, 10, 41, '0', 0, 30000, NULL),
(39, 10, 42, '0', 0, 30000, NULL),
(40, 10, 43, '2', 1, 45000, NULL),
(41, 10, 44, '0', 0, 45000, NULL),
(42, 10, 45, '0', 0, 45000, NULL),
(43, 10, 46, '0', 0, 45000, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lichsuvethang`
--

CREATE TABLE `lichsuvethang` (
  `MaLichSuVeThang` int(11) NOT NULL,
  `MaVeThang` int(11) DEFAULT NULL,
  `SuKien` varchar(5000) DEFAULT NULL,
  `Ngay` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lichsuvethang`
--

INSERT INTO `lichsuvethang` (`MaLichSuVeThang`, `MaVeThang`, `SuKien`, `Ngay`) VALUES
(1, 3, 'Kích hoạt vé tháng', '2023-11-15 23:05:14'),
(2, 3, 'Thay đổi gói vé tháng sang ưu tiên - liên tuyến', '2023-11-15 23:07:14'),
(3, 3, 'Sử dụng vé tháng trên xe bus', '2023-11-16 13:07:08'),
(5, 3, 'Cập nhật ngày kết thúc vé tháng: 2023-12-15', '2023-11-15 23:23:07'),
(6, 3, 'Thay đổi gói vé tháng sang: Ưu tiên - liên tuyến (100k/tháng)', '2023-11-15 23:23:26'),
(7, 3, 'Khóa vé tháng', '2023-11-15 23:23:34'),
(8, 3, 'Kích hoạt vé tháng', '2023-11-15 23:23:38'),
(9, 3, 'Người sử dụng khóa vé tháng', '2023-11-29 23:10:22'),
(10, 3, 'Kích hoạt vé tháng', '2023-11-29 23:10:40'),
(11, 3, 'Gia hạn vé thêm 30 ngày bằng ví cá nhân', '2023-11-29 23:18:45'),
(12, 3, 'Gia hạn vé thêm 30 ngày bằng ví cá nhân', '2023-11-29 23:29:21'),
(13, 3, 'Thay đổi gói vé tháng sang: Ưu tiên - một tuyến (55k/tháng)', '2023-11-29 23:31:21'),
(14, 3, 'Gia hạn vé thêm 30 ngày bằng ví cá nhân', '2023-11-29 23:31:29'),
(15, 3, 'Gia hạn vé thêm 30 ngày bằng ví cá nhân', '2023-11-29 23:31:57'),
(16, 3, 'Sử dụng vé tháng trên xe bus.', '2023-11-30 00:41:08'),
(17, 3, 'Sử dụng vé tháng trên xe bus.', '2023-11-30 00:42:40');

-- --------------------------------------------------------

--
-- Table structure for table `lichsuvi`
--

CREATE TABLE `lichsuvi` (
  `MaLichSuVi` int(11) NOT NULL,
  `MaVi` int(11) DEFAULT NULL,
  `TenGiaoDich` varchar(5000) DEFAULT NULL,
  `NgayGiaoDich` datetime DEFAULT NULL,
  `SoTien` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lichsuvi`
--

INSERT INTO `lichsuvi` (`MaLichSuVi`, `MaVi`, `TenGiaoDich`, `NgayGiaoDich`, `SoTien`) VALUES
(1, 1, 'Hoàn tiền cho việc hủy vé có mã 36', '2023-11-08 20:48:19', 45000),
(2, 1, 'Hoàn tiền cho việc hủy vé có mã 36. +45000đ', '2023-11-08 20:53:55', 45000),
(3, 1, 'Hoàn tiền cho việc hủy vé có mã 36. +45000đ', '2023-11-08 20:55:35', 45000),
(4, 1, 'Thanh toán cho vé có mã 36. -45000đ', '2023-11-08 21:48:17', 45000),
(5, 1, 'Nạp tiền từ VNPAY. +50000.0đ', '2023-11-08 22:23:55', 50000),
(9, 1, 'Nạp tiền từ VNPAY. +50000.0đ', '2023-11-08 22:46:08', 50000),
(10, 1, 'Nạp tiền từ VNPAY. +100000.0đ', '2023-11-08 22:49:06', 100000),
(11, 1, 'Thanh toán cho vé có mã 43. -45000đ', '2023-11-14 09:57:58', 45000),
(12, 1, 'Nạp trực tiếp 5000đ vào số dư từ hệ thống quản lý.', '2023-11-23 16:52:27', 5000),
(13, 1, 'Nạp trực tiếp 5000đ vào số dư từ hệ thống quản lý.', '2023-11-23 16:53:22', -5000),
(14, 1, 'Nạp trực tiếp 10000đ vào số dư từ hệ thống quản lý.', '2023-11-23 16:54:38', -10000),
(15, 1, 'Trừ 11000đ vào số dư tài khoản từ hệ thống quản lý', '2023-11-23 16:55:14', -11000),
(16, 1, 'Gia hạn cho vé tháng. -100000đ', '2023-11-29 23:18:45', 100000),
(17, 1, 'Trừ 274000đ vào số dư tài khoản từ hệ thống quản lý', '2023-11-29 23:20:22', -274000),
(18, 1, 'Nạp trực tiếp 274000đ vào số dư từ hệ thống quản lý.', '2023-11-29 23:20:44', 274000),
(19, 1, 'Gia hạn cho vé tháng. -100000đ', '2023-11-29 23:29:21', -100000),
(20, 1, 'Gia hạn cho vé tháng. -55000đ', '2023-11-29 23:31:29', -55000),
(21, 1, 'Gia hạn cho vé tháng. -55000đ', '2023-11-29 23:31:57', -55000);

-- --------------------------------------------------------

--
-- Table structure for table `lotrinh`
--

CREATE TABLE `lotrinh` (
  `id` int(11) NOT NULL,
  `TenDiem` varchar(500) NOT NULL,
  `Gio` time NOT NULL,
  `MaChuyen` int(11) NOT NULL,
  `ThuTu` int(11) NOT NULL,
  `KinhDo` varchar(45) DEFAULT NULL,
  `ViDo` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `lotrinh`
--

INSERT INTO `lotrinh` (`id`, `TenDiem`, `Gio`, `MaChuyen`, `ThuTu`, `KinhDo`, `ViDo`) VALUES
(251, 'Đại học Bình Dương', '07:00:00', 32, 0, NULL, NULL),
(252, 'Ngã 3 Phong Vũ', '07:15:00', 32, 1, NULL, NULL),
(253, 'Vòng xoay An Phú', '07:45:00', 32, 2, NULL, NULL),
(254, 'Chợ ngã 6', '20:15:00', 32, 3, NULL, NULL),
(255, 'Khu du lịch Đại Nam', '09:00:00', 32, 4, NULL, NULL),
(256, 'KCN Visip 1', '10:00:00', 32, 5, NULL, NULL),
(257, 'Khu du lịch Đại Nam', '10:30:00', 32, 6, NULL, NULL),
(258, 'Chợ ngã 6', '11:15:00', 32, 7, NULL, NULL),
(259, 'Vòng xoay An Phú', '12:20:00', 32, 8, NULL, NULL),
(260, 'Ngã 3 Phong Vũ', '13:00:00', 32, 9, NULL, NULL),
(261, 'Đại học Bình Dương', '13:15:00', 32, 10, NULL, NULL),
(271, 'Đại học Thủ Dầu Một', '13:00:00', 33, 0, NULL, NULL),
(272, 'Vòng xoay An Phú', '13:30:00', 33, 1, NULL, NULL),
(273, 'Ngã 3 Phong Vũ', '13:40:00', 33, 2, NULL, NULL),
(274, 'Đại học Bình Dương', '14:00:00', 33, 3, NULL, NULL),
(275, 'Bệnh viện 512', '14:30:00', 33, 4, NULL, NULL),
(276, 'Đại học Bình Dương', '14:40:00', 33, 5, NULL, NULL),
(277, 'Ngã 3 Phong Vũ', '15:00:00', 33, 6, NULL, NULL),
(278, 'Vòng xoay An Phú', '15:30:00', 33, 7, NULL, NULL),
(279, 'Đại học Thủ Dầu Một', '17:30:00', 33, 8, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `nguoidung`
--

CREATE TABLE `nguoidung` (
  `MaNguoiDung` int(11) NOT NULL,
  `TaiKhoan` varchar(100) DEFAULT NULL,
  `MatKhau` varchar(100) DEFAULT NULL,
  `SoDienThoai` varchar(15) DEFAULT NULL,
  `TrangThai` tinyint(4) DEFAULT NULL,
  `NgayTao` date DEFAULT NULL,
  `VaiTro` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `nguoidung`
--

INSERT INTO `nguoidung` (`MaNguoiDung`, `TaiKhoan`, `MatKhau`, `SoDienThoai`, `TrangThai`, `NgayTao`, `VaiTro`) VALUES
(14, 'driver@g.com', '123', '31231', 1, '2022-07-02', 1),
(15, '123@admin.com', '123', '31231', 1, '2022-07-02', 3),
(16, 'driver1@g.com', '123', '3333', 1, '2022-07-02', 1),
(17, '1213131@z.com', '123', '1213131', 1, '2022-07-03', 1),
(21, '123123@c.com', '123', '123123', 1, '2022-07-04', 1),
(24, '0857822083@gmail.com', '123', '0857822083', 1, '2022-07-04', 1),
(25, '03441128081@z.com', '123', '0344118081', 1, '2022-07-04', 1),
(26, '03441456565@g.com', '123', '03441456565', 1, '2022-07-04', 1),
(28, '0123456789', '123', '0123456789', 1, '2022-07-05', 1),
(29, '012345678', '123', '012345678', 1, '2022-07-05', 1),
(30, '023456789', '123', '023456789', 1, '2022-07-05', 1),
(33, '1', '1', '1', 1, '2023-10-18', 1),
(34, '{}', '112', '+84843067467', 1, '2023-10-18', 1),
(40, 's2kirbys2@gmail.com', '123', '034411808', 1, '2022-06-16', 0),
(46, 'drv1@gmail.com', '123', '0999222111', 1, '2023-11-07', 1),
(48, '123zzz@gmail.com', '123', '9123333', 1, '2023-11-15', 0),
(51, 'cashier@g.com', '123123', '111111', 1, '2023-11-28', 2);

-- --------------------------------------------------------

--
-- Table structure for table `taixe`
--

CREATE TABLE `taixe` (
  `MaTaiXe` int(11) NOT NULL,
  `SoDienThoai` varchar(15) DEFAULT NULL,
  `HoVaTen` varchar(200) DEFAULT NULL,
  `KinhNghiem` varchar(100) DEFAULT NULL,
  `MaNguoiDung` int(11) DEFAULT NULL,
  `TrangThai` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `taixe`
--

INSERT INTO `taixe` (`MaTaiXe`, `SoDienThoai`, `HoVaTen`, `KinhNghiem`, `MaNguoiDung`, `TrangThai`) VALUES
(1, '31231', '12341111z', '3131111z', 14, 2),
(2, '3333', '3123', '333', 16, 2),
(3, '1213131', 'Nguyễn Hoàng Nam', '2 năm', 17, 2),
(4, '123123', '31312', '3 năm', 21, 2),
(5, '0857822083', 'Phạm Anh Phước', '5', 24, 2),
(6, '0344118081', 'Lê Huỳnh Đức', '2', 25, 2),
(7, '03441456565', 'Trần Anh Kiệt', '2', 26, 2),
(8, '0123456789', 'Trần Thị Thu', '3 năm', 28, 2),
(9, '012345678', 'Trần Thị ThuBơ', '3 năm', 29, 0),
(10, '023456789', 'Phạm Anh Duy', '4', 30, 2),
(18, '0999222111', 'Nguyên An Hòa', '3 năm', 46, 2);

-- --------------------------------------------------------

--
-- Table structure for table `vethang`
--

CREATE TABLE `vethang` (
  `MaVeThang` int(11) NOT NULL,
  `MaKhachHang` int(11) DEFAULT NULL,
  `GoiDangKy` varchar(500) DEFAULT NULL,
  `GiaVe` int(11) DEFAULT NULL,
  `TrangThai` int(11) DEFAULT NULL,
  `NgayBatDau` date DEFAULT NULL,
  `NgayKetThuc` date DEFAULT NULL,
  `MaTuyenCoDinh` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vethang`
--

INSERT INTO `vethang` (`MaVeThang`, `MaKhachHang`, `GoiDangKy`, `GiaVe`, `TrangThai`, `NgayBatDau`, `NgayKetThuc`, `MaTuyenCoDinh`) VALUES
(3, 10, 'Ưu tiên - một tuyến (55k/tháng)', 55000, 1, '2023-11-15', '2024-03-01', 32),
(4, 16, 'Ưu tiên - một tuyến (55k/tháng)', 55000, 1, '2023-11-15', '2023-12-15', 32);

-- --------------------------------------------------------

--
-- Table structure for table `vinguoidung`
--

CREATE TABLE `vinguoidung` (
  `MaVi` int(11) NOT NULL,
  `MaNguoiDung` int(11) DEFAULT NULL,
  `SoDu` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vinguoidung`
--

INSERT INTO `vinguoidung` (`MaVi`, `MaNguoiDung`, `SoDu`) VALUES
(1, 40, 64000),
(2, 48, 0);

-- --------------------------------------------------------

--
-- Table structure for table `xebus`
--

CREATE TABLE `xebus` (
  `MaXeBus` int(11) NOT NULL,
  `BienSoXe` varchar(45) DEFAULT NULL,
  `LoaiXe` varchar(45) DEFAULT NULL,
  `SoGhe` varchar(45) DEFAULT NULL,
  `SoXe` int(11) DEFAULT NULL,
  `TinhTrang` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `xebus`
--

INSERT INTO `xebus` (`MaXeBus`, `BienSoXe`, `LoaiXe`, `SoGhe`, `SoXe`, `TinhTrang`) VALUES
(8, '61K-94345', 'Thaco Bus 2013', '{}', 1133, 2),
(9, '61K-21122', 'Thaco Bus 2013', '{}', 2, 2),
(10, '59H-2341', 'TruongHai Bus 2012', '{}', 3, 2),
(11, '59I-8392', 'Thaco Bus 2013', '{}', 4, 2),
(12, '61L-7895', 'Thaco City', '{}', 7, 2),
(14, '67A-5487', 'Thaco City 2020', '{}', 9, 2),
(16, '3123213', '321312', '{}', 312312, 2),
(17, '1111', '11111', '{}', 11111, 2),
(19, '61K-94222', 'Thaco Bus 2013 60', '{}', 12, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chuyenxe`
--
ALTER TABLE `chuyenxe`
  ADD PRIMARY KEY (`MaChuyen`),
  ADD KEY `fk_ChuyenXe_XeBus1_idx` (`MaXeBus`),
  ADD KEY `fk_ChuyenXe_TaiXe1_idx` (`MaTaiXe`);

--
-- Indexes for table `datve`
--
ALTER TABLE `datve`
  ADD PRIMARY KEY (`MaVe`),
  ADD KEY `fk_DatVe_ChuyenXe1_idx` (`MaChuyen`);

--
-- Indexes for table `dondangkyvethang`
--
ALTER TABLE `dondangkyvethang`
  ADD PRIMARY KEY (`MaDonDangKy`),
  ADD KEY `fk_dondangkyvethang_khachhang1_idx` (`MaKhachHang`);

--
-- Indexes for table `ghexebus`
--
ALTER TABLE `ghexebus`
  ADD PRIMARY KEY (`MaGheXe`),
  ADD KEY `fk_GheXeBus_XeBus1_idx` (`MaXeBus`);

--
-- Indexes for table `hoadon`
--
ALTER TABLE `hoadon`
  ADD PRIMARY KEY (`MaHoaDon`),
  ADD KEY `fk_hoadon_nguoidung1_idx` (`MaNguoiDung`);

--
-- Indexes for table `khachhang`
--
ALTER TABLE `khachhang`
  ADD PRIMARY KEY (`MaKhachHang`),
  ADD KEY `fk_KhachHang_NguoiDung` (`MaNguoiDung`);

--
-- Indexes for table `lichlaixe`
--
ALTER TABLE `lichlaixe`
  ADD PRIMARY KEY (`MaLichLai`),
  ADD KEY `fk_LichLaiXe_TaiXe1_idx` (`MaTaiXe`);

--
-- Indexes for table `lichsudatghe`
--
ALTER TABLE `lichsudatghe`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pk_mc` (`MaChuyen`),
  ADD KEY `fk_nd` (`MaNguoiDung`);

--
-- Indexes for table `lichsukhachhang`
--
ALTER TABLE `lichsukhachhang`
  ADD PRIMARY KEY (`MaLichSuKhachHang`),
  ADD KEY `fk_lichsukhachhang_khachhang1_idx` (`MaKhachHang`);

--
-- Indexes for table `lichsuthanhtoan`
--
ALTER TABLE `lichsuthanhtoan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_PhuongThucThanhToan_DatVe1_idx` (`MaVe`),
  ADD KEY `fk_PhuongThucThanhToan_KhachHang1_idx` (`MaKhachHang`);

--
-- Indexes for table `lichsuvethang`
--
ALTER TABLE `lichsuvethang`
  ADD PRIMARY KEY (`MaLichSuVeThang`),
  ADD KEY `fk_lichsuvethang_vethang1_idx` (`MaVeThang`);

--
-- Indexes for table `lichsuvi`
--
ALTER TABLE `lichsuvi`
  ADD PRIMARY KEY (`MaLichSuVi`),
  ADD KEY `fk_lichsuvi_vinguoidung1_idx` (`MaVi`);

--
-- Indexes for table `lotrinh`
--
ALTER TABLE `lotrinh`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pk_chuyen` (`MaChuyen`);

--
-- Indexes for table `nguoidung`
--
ALTER TABLE `nguoidung`
  ADD PRIMARY KEY (`MaNguoiDung`);

--
-- Indexes for table `taixe`
--
ALTER TABLE `taixe`
  ADD PRIMARY KEY (`MaTaiXe`),
  ADD KEY `fk_TaiXe_NguoiDung1_idx` (`MaNguoiDung`);

--
-- Indexes for table `vethang`
--
ALTER TABLE `vethang`
  ADD PRIMARY KEY (`MaVeThang`),
  ADD KEY `fk_vethang_khachhang1_idx` (`MaKhachHang`);

--
-- Indexes for table `vinguoidung`
--
ALTER TABLE `vinguoidung`
  ADD PRIMARY KEY (`MaVi`),
  ADD KEY `fk_vinguoidung_nguoidung1_idx` (`MaNguoiDung`);

--
-- Indexes for table `xebus`
--
ALTER TABLE `xebus`
  ADD PRIMARY KEY (`MaXeBus`),
  ADD UNIQUE KEY `MaXeBus_UNIQUE` (`MaXeBus`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chuyenxe`
--
ALTER TABLE `chuyenxe`
  MODIFY `MaChuyen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `datve`
--
ALTER TABLE `datve`
  MODIFY `MaVe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `dondangkyvethang`
--
ALTER TABLE `dondangkyvethang`
  MODIFY `MaDonDangKy` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ghexebus`
--
ALTER TABLE `ghexebus`
  MODIFY `MaGheXe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=901;

--
-- AUTO_INCREMENT for table `hoadon`
--
ALTER TABLE `hoadon`
  MODIFY `MaHoaDon` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `khachhang`
--
ALTER TABLE `khachhang`
  MODIFY `MaKhachHang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `lichlaixe`
--
ALTER TABLE `lichlaixe`
  MODIFY `MaLichLai` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lichsudatghe`
--
ALTER TABLE `lichsudatghe`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `lichsukhachhang`
--
ALTER TABLE `lichsukhachhang`
  MODIFY `MaLichSuKhachHang` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lichsuthanhtoan`
--
ALTER TABLE `lichsuthanhtoan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `lichsuvethang`
--
ALTER TABLE `lichsuvethang`
  MODIFY `MaLichSuVeThang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `lichsuvi`
--
ALTER TABLE `lichsuvi`
  MODIFY `MaLichSuVi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `lotrinh`
--
ALTER TABLE `lotrinh`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=280;

--
-- AUTO_INCREMENT for table `nguoidung`
--
ALTER TABLE `nguoidung`
  MODIFY `MaNguoiDung` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `taixe`
--
ALTER TABLE `taixe`
  MODIFY `MaTaiXe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `vethang`
--
ALTER TABLE `vethang`
  MODIFY `MaVeThang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `vinguoidung`
--
ALTER TABLE `vinguoidung`
  MODIFY `MaVi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `xebus`
--
ALTER TABLE `xebus`
  MODIFY `MaXeBus` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chuyenxe`
--
ALTER TABLE `chuyenxe`
  ADD CONSTRAINT `fk_ChuyenXe_TaiXe1` FOREIGN KEY (`MaTaiXe`) REFERENCES `taixe` (`MaTaiXe`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ChuyenXe_XeBus1` FOREIGN KEY (`MaXeBus`) REFERENCES `xebus` (`MaXeBus`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `datve`
--
ALTER TABLE `datve`
  ADD CONSTRAINT `fk_DatVe_ChuyenXe1` FOREIGN KEY (`MaChuyen`) REFERENCES `chuyenxe` (`MaChuyen`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `dondangkyvethang`
--
ALTER TABLE `dondangkyvethang`
  ADD CONSTRAINT `fk_dondangkyvethang_khachhang1` FOREIGN KEY (`MaKhachHang`) REFERENCES `khachhang` (`MaKhachHang`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `ghexebus`
--
ALTER TABLE `ghexebus`
  ADD CONSTRAINT `fk_GheXeBus_XeBus1` FOREIGN KEY (`MaXeBus`) REFERENCES `xebus` (`MaXeBus`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `hoadon`
--
ALTER TABLE `hoadon`
  ADD CONSTRAINT `fk_hoadon_nguoidung1` FOREIGN KEY (`MaNguoiDung`) REFERENCES `nguoidung` (`MaNguoiDung`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `khachhang`
--
ALTER TABLE `khachhang`
  ADD CONSTRAINT `fk_KhachHang_NguoiDung` FOREIGN KEY (`MaNguoiDung`) REFERENCES `nguoidung` (`MaNguoiDung`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `lichlaixe`
--
ALTER TABLE `lichlaixe`
  ADD CONSTRAINT `fk_LichLaiXe_TaiXe1` FOREIGN KEY (`MaTaiXe`) REFERENCES `taixe` (`MaTaiXe`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_LichLaiXe_XeBus1` FOREIGN KEY (`MaTaiXe`) REFERENCES `xebus` (`MaXeBus`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `lichsudatghe`
--
ALTER TABLE `lichsudatghe`
  ADD CONSTRAINT `fk_nd` FOREIGN KEY (`MaNguoiDung`) REFERENCES `nguoidung` (`MaNguoiDung`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `pk_mc` FOREIGN KEY (`MaChuyen`) REFERENCES `chuyenxe` (`MaChuyen`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `lichsukhachhang`
--
ALTER TABLE `lichsukhachhang`
  ADD CONSTRAINT `fk_lichsukhachhang_khachhang1` FOREIGN KEY (`MaKhachHang`) REFERENCES `khachhang` (`MaKhachHang`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `lichsuthanhtoan`
--
ALTER TABLE `lichsuthanhtoan`
  ADD CONSTRAINT `fk_PhuongThucThanhToan_DatVe1` FOREIGN KEY (`MaVe`) REFERENCES `datve` (`MaVe`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_PhuongThucThanhToan_KhachHang1` FOREIGN KEY (`MaKhachHang`) REFERENCES `khachhang` (`MaKhachHang`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `lichsuvethang`
--
ALTER TABLE `lichsuvethang`
  ADD CONSTRAINT `fk_lichsuvethang_vethang1` FOREIGN KEY (`MaVeThang`) REFERENCES `vethang` (`MaVeThang`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `lichsuvi`
--
ALTER TABLE `lichsuvi`
  ADD CONSTRAINT `fk_lichsuvi_vinguoidung1` FOREIGN KEY (`MaVi`) REFERENCES `vinguoidung` (`MaVi`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `lotrinh`
--
ALTER TABLE `lotrinh`
  ADD CONSTRAINT `pk_chuyen` FOREIGN KEY (`MaChuyen`) REFERENCES `chuyenxe` (`MaChuyen`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `taixe`
--
ALTER TABLE `taixe`
  ADD CONSTRAINT `fk_TaiXe_NguoiDung1` FOREIGN KEY (`MaNguoiDung`) REFERENCES `nguoidung` (`MaNguoiDung`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `vethang`
--
ALTER TABLE `vethang`
  ADD CONSTRAINT `fk_vethang_khachhang1` FOREIGN KEY (`MaKhachHang`) REFERENCES `khachhang` (`MaKhachHang`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `vinguoidung`
--
ALTER TABLE `vinguoidung`
  ADD CONSTRAINT `fk_vinguoidung_nguoidung1` FOREIGN KEY (`MaNguoiDung`) REFERENCES `nguoidung` (`MaNguoiDung`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
