-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 18, 2023 at 07:37 PM
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
(14, 'Tuyến số  11', 16, 10, 'BX Khách Tỉnh', 'Mỹ Phước 23', '00:01:00', 233, 150003, 70003, NULL, '32321332133', 1),
(15, 'Tuyến số 2', 12, 6, 'BX Khách Tỉnh Bình Dương', 'Bệnh viện Đa khoa Tỉnh Bình Phước', '05:00:00', 30, 15000, 7000, NULL, '', 1),
(17, 'Tuyến số 4', 14, 8, 'Đại Học Thủ Dầu Một', 'Xa Lộ Đại Hàn', '11:00:00', 60, 15000, 7500, NULL, '', 1),
(20, '3123', 14, 9, '3312', '331', '14:06:00', 312, 311323, 12313, NULL, '312', 1);

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
  `NgayDi` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `datve`
--

INSERT INTO `datve` (`MaVe`, `MaChuyen`, `MaKhachHang`, `NgayDat`, `TrangThai`, `NgayDi`) VALUES
(26, 14, 5, '2022-07-05 08:33:40', 1, '2022-07-14'),
(27, 17, 7, '2022-07-05 10:38:38', 1, '2022-07-06');

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
(780, 17, '10F', 60, 0);

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
  `CMND` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `khachhang`
--

INSERT INTO `khachhang` (`MaKhachHang`, `MaNguoiDung`, `HoVaTenKhachHang`, `DiaChi`, `SoDienThoai`, `CMND`) VALUES
(5, 23, 'Lê Huỳnh Đức', 'Bình Dương', '0344118081', '0123'),
(10, 40, 'Lê Huỳnh Nam11', 'Bình Dương111', '0344118081111', '0123111111');

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
  `NgayDat` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `lichsudatghe`
--

INSERT INTO `lichsudatghe` (`id`, `MaChuyen`, `MaNguoiDung`, `IDGhe`, `NgayDat`) VALUES
(45, 14, 23, '9E', '2022-07-14');

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
(40, 'BX Khách Tỉ', '00:00:00', 15, 0, NULL, NULL),
(41, 'Đại Lộ Bình', '12:18:00', 15, 1, NULL, NULL),
(42, 'Ngã Tư Sở S', '12:30:00', 15, 2, NULL, NULL),
(43, 'ĐT 741', '12:45:00', 15, 3, NULL, NULL),
(44, 'Cổng Xanh', '12:50:00', 15, 4, NULL, NULL),
(45, 'Bệnh viện Đ', '13:00:00', 15, 5, NULL, NULL),
(52, 'Đại Học Thủ', '11:00:00', 17, 0, NULL, NULL),
(53, 'Đại Lộ 13', '11:15:00', 17, 1, NULL, NULL),
(54, 'Đường Cách ', '11:30:00', 17, 2, NULL, NULL),
(55, 'Mỹ Phước', '11:45:00', 17, 3, NULL, NULL),
(56, 'Xa Lộ Đại H', '00:00:00', 17, 4, NULL, NULL),
(68, '3312', '14:06:00', 20, 0, NULL, NULL),
(69, '312312', '15:06:00', 20, 1, NULL, NULL),
(70, '3123', '14:06:00', 20, 2, NULL, NULL),
(71, '331', '14:06:00', 20, 3, NULL, NULL),
(243, 'BX Khách Tỉnh', '10:00:00', 14, 0, NULL, NULL),
(244, 'Cách mạng t', '09:15:00', 14, 1, NULL, NULL),
(245, 'Cầu Ông Đàn', '10:30:00', 14, 2, NULL, NULL),
(246, 'Chợ Cây Dừa3', '11:00:00', 14, 3, NULL, NULL),
(247, 'Mũi Tàu', '11:20:00', 14, 4, NULL, NULL),
(248, 'Quốc lộ 133', '11:41:00', 14, 5, NULL, NULL),
(249, '312321', '02:12:00', 14, 6, NULL, NULL),
(250, 'Mỹ Phước 23', '11:21:00', 14, 7, NULL, NULL);

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
(14, 'z22@g.com333', '1231111z', '31231555', 1, '2022-07-02', 1),
(15, '123@admin.com', '123', '31231', 1, '2022-07-02', 3),
(16, '3333', '1313', '3333', 1, '2022-07-02', 1),
(17, '1213131', '123', '1213131', 1, '2022-07-03', 1),
(21, '123123', '123', '123123', 1, '2022-07-04', 1),
(23, '0344118081', '123', '0344118081', 1, '2022-07-04', 0),
(24, '0857822083', '123', '0857822083', 1, '2022-07-04', 1),
(25, '0344118081', '123', '0344118081', 1, '2022-07-04', 1),
(26, '03441456565', '123', '03441456565', 1, '2022-07-04', 1),
(28, '0123456789', '123', '0123456789', 1, '2022-07-05', 1),
(29, '012345678', '123', '012345678', 1, '2022-07-05', 1),
(30, '023456789', '123', '023456789', 1, '2022-07-05', 1),
(33, '1', '1', '1', 1, '2023-10-18', 1),
(34, '{}', '112', '+84843067467', 1, '2023-10-18', 1),
(40, 's2kirbys2@gmail.com1111', '123111', '0344118081111', 1, '2022-06-16', 0);

-- --------------------------------------------------------

--
-- Table structure for table `phuongthucthanhtoan`
--

CREATE TABLE `phuongthucthanhtoan` (
  `id` int(11) NOT NULL,
  `MaKhachHang` int(11) DEFAULT NULL,
  `MaVe` int(11) DEFAULT NULL,
  `PhuongThucThanhToan` varchar(45) DEFAULT NULL,
  `TrangThai` tinyint(4) DEFAULT NULL,
  `SoTien` int(11) DEFAULT NULL,
  `NgayThanhToan` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `phuongthucthanhtoan`
--

INSERT INTO `phuongthucthanhtoan` (`id`, `MaKhachHang`, `MaVe`, `PhuongThucThanhToan`, `TrangThai`, `SoTien`, `NgayThanhToan`) VALUES
(23, 5, 26, '0', 0, 15000, NULL);

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
(10, '023456789', 'Phạm Anh Duy', '4', 30, 2);

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
(17, '1111', '11111', '{}', 11111, 2);

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
-- Indexes for table `ghexebus`
--
ALTER TABLE `ghexebus`
  ADD PRIMARY KEY (`MaGheXe`),
  ADD KEY `fk_GheXeBus_XeBus1_idx` (`MaXeBus`);

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
-- Indexes for table `phuongthucthanhtoan`
--
ALTER TABLE `phuongthucthanhtoan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_PhuongThucThanhToan_DatVe1_idx` (`MaVe`),
  ADD KEY `fk_PhuongThucThanhToan_KhachHang1_idx` (`MaKhachHang`);

--
-- Indexes for table `taixe`
--
ALTER TABLE `taixe`
  ADD PRIMARY KEY (`MaTaiXe`),
  ADD KEY `fk_TaiXe_NguoiDung1_idx` (`MaNguoiDung`);

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
  MODIFY `MaChuyen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `datve`
--
ALTER TABLE `datve`
  MODIFY `MaVe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `ghexebus`
--
ALTER TABLE `ghexebus`
  MODIFY `MaGheXe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=841;

--
-- AUTO_INCREMENT for table `khachhang`
--
ALTER TABLE `khachhang`
  MODIFY `MaKhachHang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `lichlaixe`
--
ALTER TABLE `lichlaixe`
  MODIFY `MaLichLai` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lichsudatghe`
--
ALTER TABLE `lichsudatghe`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `lotrinh`
--
ALTER TABLE `lotrinh`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=251;

--
-- AUTO_INCREMENT for table `nguoidung`
--
ALTER TABLE `nguoidung`
  MODIFY `MaNguoiDung` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `phuongthucthanhtoan`
--
ALTER TABLE `phuongthucthanhtoan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `taixe`
--
ALTER TABLE `taixe`
  MODIFY `MaTaiXe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `xebus`
--
ALTER TABLE `xebus`
  MODIFY `MaXeBus` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

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
-- Constraints for table `ghexebus`
--
ALTER TABLE `ghexebus`
  ADD CONSTRAINT `fk_GheXeBus_XeBus1` FOREIGN KEY (`MaXeBus`) REFERENCES `xebus` (`MaXeBus`) ON DELETE CASCADE ON UPDATE NO ACTION;

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
-- Constraints for table `lotrinh`
--
ALTER TABLE `lotrinh`
  ADD CONSTRAINT `pk_chuyen` FOREIGN KEY (`MaChuyen`) REFERENCES `chuyenxe` (`MaChuyen`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `phuongthucthanhtoan`
--
ALTER TABLE `phuongthucthanhtoan`
  ADD CONSTRAINT `fk_PhuongThucThanhToan_DatVe1` FOREIGN KEY (`MaVe`) REFERENCES `datve` (`MaVe`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_PhuongThucThanhToan_KhachHang1` FOREIGN KEY (`MaKhachHang`) REFERENCES `khachhang` (`MaKhachHang`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `taixe`
--
ALTER TABLE `taixe`
  ADD CONSTRAINT `fk_TaiXe_NguoiDung1` FOREIGN KEY (`MaNguoiDung`) REFERENCES `nguoidung` (`MaNguoiDung`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
