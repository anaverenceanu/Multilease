-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 16, 2024 at 12:19 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `multilease`
--

-- --------------------------------------------------------

--
-- Table structure for table `Audits`
--

CREATE TABLE `Audits` (
  `DateofChange` date NOT NULL,
  `ChangedFields` varchar(20) NOT NULL,
  `OldValue` int(30) NOT NULL,
  `NewValue` int(30) NOT NULL,
  `LeaseID` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `CarTypes`
--

CREATE TABLE `CarTypes` (
  `TypeID` int(3) NOT NULL,
  `Type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `CarTypes`
--

INSERT INTO `CarTypes` (`TypeID`, `Type`) VALUES
(1, '2dr Coupe'),
(2, '4dr Sedan'),
(3, 'Truck'),
(4, 'SUV'),
(5, 'Van');

-- --------------------------------------------------------

--
-- Table structure for table `Colours`
--

CREATE TABLE `Colours` (
  `ColourID` int(3) NOT NULL,
  `Colour` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Colours`
--

INSERT INTO `Colours` (`ColourID`, `Colour`) VALUES
(1, 'Deep Blue'),
(2, 'Racey Red'),
(3, 'Lemon Yellow'),
(4, 'Lime Green'),
(5, 'Silver Grey');

-- --------------------------------------------------------

--
-- Table structure for table `Customers`
--

CREATE TABLE `Customers` (
  `CustomerID` int(100) NOT NULL,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `Address` varchar(200) NOT NULL,
  `City` varchar(50) NOT NULL,
  `Province` varchar(2) NOT NULL,
  `PostalCode` varchar(10) NOT NULL,
  `PhoneNumber` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Customers`
--

INSERT INTO `Customers` (`CustomerID`, `FirstName`, `LastName`, `Address`, `City`, `Province`, `PostalCode`, `PhoneNumber`) VALUES
(1, 'Candie', 'Wrapper', '1000 Lollipop Lane', 'Halifax', 'NS', 'B1X 1X1', '(902) 123-4567'),
(2, 'Scalli', 'Wag', '80 Plank Walk', 'Halifax', 'NS', 'B2L 1L1', '(902) 812-4567'),
(3, 'Inna', 'Chambers', '2 Politician Street', 'Halifax', 'NS', 'B3M 1M1', '(902) 341-4212'),
(4, 'MultiLease', 'Corp.', '1200 Motor Way', 'Halifax', 'NS', 'B5A 1K1', '(902) 821-4319');

-- --------------------------------------------------------

--
-- Table structure for table `Leases`
--

CREATE TABLE `Leases` (
  `LeaseID` int(100) NOT NULL,
  `DateLeaseContract` varchar(30) NOT NULL,
  `FirstPaymentDate` varchar(30) NOT NULL,
  `AmountPerMonth` int(30) NOT NULL,
  `NumberMonth` int(4) NOT NULL,
  `VehiculeVIN` varchar(50) NOT NULL,
  `CustomerID` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Leases`
--

INSERT INTO `Leases` (`LeaseID`, `DateLeaseContract`, `FirstPaymentDate`, `AmountPerMonth`, `NumberMonth`, `VehiculeVIN`, `CustomerID`) VALUES
(1, '2004-01-15', '2004-02-15', 650, 36, '3W9T1-2Q10D-12D0P-2E1R2', 1),
(2, '2004-03-16', '2004-04-16', 350, 12, '7D901-9W120-Z0029-021P2', 2),
(3, '2004-04-01', '2002-05-01', 600, 24, 'Z1221-X129A-KO212-9021J', 3),
(4, '2002-02-20', '2002-03-01', 450, 48, 'M21L1-3129S-V1292-L12X1', 1),
(5, '2004-07-01', '2004-07-15', 300, 12, 'M21L1-3129S-V1292-L12X1', 3);

--
-- Triggers `Leases`
--
DELIMITER $$
CREATE TRIGGER `TriggerAudit` BEFORE UPDATE ON `Leases` FOR EACH ROW INSERT INTO Audits VALUES (Leases.LeaseID, Leases.DateLeaseContract, Leases.FirstPaymentDate, Leases.AmountPerMonth, Leases.NumberMonth, Leases.VehiculeVIN, Leases.CustomerID)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `LeaseTearmsLookUp`
--

CREATE TABLE `LeaseTearmsLookUp` (
  `LeaseChoice` int(2) NOT NULL,
  `TermYears` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `LeaseTearmsLookUp`
--

INSERT INTO `LeaseTearmsLookUp` (`LeaseChoice`, `TermYears`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

-- --------------------------------------------------------

--
-- Table structure for table `LeaseTerms`
--

CREATE TABLE `LeaseTerms` (
  `LeaseID` int(50) NOT NULL,
  `LeaseChoice` int(10) NOT NULL,
  `MaxKm` int(15) NOT NULL,
  `Extra(cents/km)` decimal(4,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `LeaseTerms`
--

INSERT INTO `LeaseTerms` (`LeaseID`, `LeaseChoice`, `MaxKm`, `Extra(cents/km)`) VALUES
(1, 3, 120000, 0.25),
(2, 1, 85000, 0.20),
(3, 2, 150000, 0.20),
(4, 4, 130000, 0.15),
(5, 1, 150000, 0.35);

-- --------------------------------------------------------

--
-- Table structure for table `Models`
--

CREATE TABLE `Models` (
  `ModelID` int(2) NOT NULL,
  `ModelName` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Models`
--

INSERT INTO `Models` (`ModelID`, `ModelName`) VALUES
(1, 'SC-430'),
(2, 'Pirate'),
(3, 'Expensive'),
(4, 'Rock'),
(5, 'Speedy');

-- --------------------------------------------------------

--
-- Table structure for table `Payments`
--

CREATE TABLE `Payments` (
  `PaymentID` bigint(20) UNSIGNED NOT NULL,
  `Date` date NOT NULL,
  `Amount` int(20) NOT NULL,
  `LeaseID` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Payments`
--

INSERT INTO `Payments` (`PaymentID`, `Date`, `Amount`, `LeaseID`) VALUES
(1, '2004-02-15', 650, 1),
(2, '2004-03-15', 650, 1),
(3, '2004-04-16', 350, 2),
(4, '2004-05-01', 600, 3),
(5, '2004-06-01', 600, 3),
(6, '2002-03-01', 450, 4);

-- --------------------------------------------------------

--
-- Table structure for table `TransmissionType`
--

CREATE TABLE `TransmissionType` (
  `TransmissionID` int(1) NOT NULL,
  `TransmissionType` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `TransmissionType`
--

INSERT INTO `TransmissionType` (`TransmissionID`, `TransmissionType`) VALUES
(0, 'Auto'),
(1, 'Manual');

-- --------------------------------------------------------

--
-- Table structure for table `Vehicules`
--

CREATE TABLE `Vehicules` (
  `VehiculeVIN` varchar(50) NOT NULL,
  `ModelID` int(3) NOT NULL,
  `TypeID` int(3) NOT NULL,
  `ColourID` int(3) DEFAULT NULL,
  `Year` int(10) NOT NULL,
  `BookValue` int(50) NOT NULL,
  `Transmission` tinyint(1) NOT NULL,
  `Air` tinyint(1) NOT NULL,
  `PowerLocks` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Vehicules`
--

INSERT INTO `Vehicules` (`VehiculeVIN`, `ModelID`, `TypeID`, `ColourID`, `Year`, `BookValue`, `Transmission`, `Air`, `PowerLocks`) VALUES
('3W9T1-2Q10D-12D0P-2E1R2', 1, 1, 1, 2003, 90000, 0, 1, 1),
('7D901-9W120-Z0029-021P2', 2, 1, 2, 2000, 45000, 1, 1, 1),
('K2119M-K129P-V12BP-210G4', 5, 1, NULL, 2003, 60000, 1, 1, 1),
('M21L1-3129S-V1292-L12X1', 4, 3, 5, 2001, 85000, 1, 1, 1),
('Z1221-X129A-KO212-9021J', 3, 2, 3, 2003, 70000, 0, 1, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Audits`
--
ALTER TABLE `Audits`
  ADD KEY `LeaseID` (`LeaseID`);

--
-- Indexes for table `CarTypes`
--
ALTER TABLE `CarTypes`
  ADD UNIQUE KEY `TypeID` (`TypeID`);

--
-- Indexes for table `Colours`
--
ALTER TABLE `Colours`
  ADD UNIQUE KEY `ColourID` (`ColourID`);

--
-- Indexes for table `Customers`
--
ALTER TABLE `Customers`
  ADD PRIMARY KEY (`CustomerID`);

--
-- Indexes for table `Leases`
--
ALTER TABLE `Leases`
  ADD PRIMARY KEY (`LeaseID`),
  ADD KEY `CustomerID` (`CustomerID`),
  ADD KEY `Max_Months` (`NumberMonth`) USING BTREE COMMENT 'CHECK (NumberMonth <= 48)',
  ADD KEY `VehiculeVIN` (`VehiculeVIN`);

--
-- Indexes for table `LeaseTearmsLookUp`
--
ALTER TABLE `LeaseTearmsLookUp`
  ADD UNIQUE KEY `LeaseChoice` (`LeaseChoice`);

--
-- Indexes for table `LeaseTerms`
--
ALTER TABLE `LeaseTerms`
  ADD KEY `LeaseID` (`LeaseID`),
  ADD KEY `NumberYears` (`LeaseChoice`) USING BTREE COMMENT 'CHECK (LeaseYears <= 4)',
  ADD KEY `LeaseChoice` (`LeaseChoice`);

--
-- Indexes for table `Models`
--
ALTER TABLE `Models`
  ADD UNIQUE KEY `ModelID` (`ModelID`);

--
-- Indexes for table `Payments`
--
ALTER TABLE `Payments`
  ADD UNIQUE KEY `PaymentID` (`PaymentID`),
  ADD KEY `LeaseID` (`LeaseID`);

--
-- Indexes for table `Vehicules`
--
ALTER TABLE `Vehicules`
  ADD PRIMARY KEY (`VehiculeVIN`),
  ADD KEY `ModelID` (`ModelID`,`TypeID`,`ColourID`),
  ADD KEY `TypeID` (`TypeID`),
  ADD KEY `ColourID` (`ColourID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Payments`
--
ALTER TABLE `Payments`
  MODIFY `PaymentID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Audits`
--
ALTER TABLE `Audits`
  ADD CONSTRAINT `audits_ibfk_1` FOREIGN KEY (`LeaseID`) REFERENCES `Leases` (`LeaseID`);

--
-- Constraints for table `Leases`
--
ALTER TABLE `Leases`
  ADD CONSTRAINT `leases_ibfk_2` FOREIGN KEY (`CustomerID`) REFERENCES `Customers` (`CustomerID`),
  ADD CONSTRAINT `leases_ibfk_3` FOREIGN KEY (`VehiculeVIN`) REFERENCES `Vehicules` (`VehiculeVIN`);

--
-- Constraints for table `LeaseTerms`
--
ALTER TABLE `LeaseTerms`
  ADD CONSTRAINT `leaseterms_ibfk_1` FOREIGN KEY (`LeaseID`) REFERENCES `Leases` (`LeaseID`),
  ADD CONSTRAINT `leaseterms_ibfk_2` FOREIGN KEY (`LeaseChoice`) REFERENCES `LeaseTearmsLookUp` (`LeaseChoice`);

--
-- Constraints for table `Payments`
--
ALTER TABLE `Payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`LeaseID`) REFERENCES `Leases` (`LeaseID`);

--
-- Constraints for table `Vehicules`
--
ALTER TABLE `Vehicules`
  ADD CONSTRAINT `vehicules_ibfk_1` FOREIGN KEY (`TypeID`) REFERENCES `CarTypes` (`TypeID`),
  ADD CONSTRAINT `vehicules_ibfk_2` FOREIGN KEY (`ModelID`) REFERENCES `Models` (`ModelID`),
  ADD CONSTRAINT `vehicules_ibfk_3` FOREIGN KEY (`ColourID`) REFERENCES `Colours` (`ColourID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
