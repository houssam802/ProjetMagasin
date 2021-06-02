-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : Dim 11 avr. 2021 à 19:45
-- Version du serveur :  10.4.17-MariaDB
-- Version de PHP : 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `market`
--

-- --------------------------------------------------------

--
-- Structure de la table `articles`
--

CREATE TABLE `articles` (
  `CodeArticle` int(11) NOT NULL,
  `Designation` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Prix` float NOT NULL,
  `Stock` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Categorie` int(11) NOT NULL,
  `Photo` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_bin;

--
-- Déchargement des données de la table `articles`
--

INSERT INTO `articles` (`CodeArticle`, `Designation`, `Prix`, `Stock`, `Categorie`, `Photo`) VALUES
(1, 'Apple Iphone 11 Pro', 10000, 'En Stock', 1, 'Images/appleiphone11pro.png'),
(2, '\r\nHP Laptop 15s-eq1258nb', 8500, 'En Stock', 2, 'Images/hp15s-eq.png'),
(3, 'Microsoft Surface Laptop 3', 12000, 'En Stock', 2, 'Images/laptopsurface3micr.jpg'),
(4, 'OPPO A9 2020', 3000, 'En Stock', 1, 'Images/oppoa92020.jpeg');

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `RefCat` int(11) NOT NULL,
  `Cat` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_bin;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`RefCat`, `Cat`) VALUES
(1, 'Telephone'),
(2, 'PC portable');

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

CREATE TABLE `clients` (
  `id` int(11) NOT NULL,
  `Email` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Nom` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Prenom` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Adresse` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `CodePostal` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Ville` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Tel` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `MotPasse` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_bin;

--
-- Déchargement des données de la table `clients`
--

INSERT INTO `clients` (`id`, `Email`, `Nom`, `Prenom`, `Adresse`, `CodePostal`, `Ville`, `Tel`, `MotPasse`) VALUES
(4, 'wade_debest@live.com', 'sqd', 'housni', 's', 's', 's', '+212 612-354897', '1000:d5523a94a726c44791c2157e19601d76:20594445eff860f7b0ebeda5125007435ea8c4ddca127d436e6878da90f25433bd440e39b058a3a4e2233ab7409cc9b55ff008345b59860d2572ef2d31f2d3f3');

-- --------------------------------------------------------

--
-- Structure de la table `commandes`
--

CREATE TABLE `commandes` (
  `NumCommande` int(11) NOT NULL,
  `CodeClient` int(11) NOT NULL,
  `DateCommande` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_bin;

--
-- Déchargement des données de la table `commandes`
--

INSERT INTO `commandes` (`NumCommande`, `CodeClient`, `DateCommande`) VALUES
(1, 4, '2021-04-11'),
(2, 4, '2021-04-11'),
(3, 4, '2021-04-11'),
(4, 4, '2021-04-11'),
(5, 4, '2021-04-11');

-- --------------------------------------------------------

--
-- Structure de la table `lignescommandes`
--

CREATE TABLE `lignescommandes` (
  `NumCommande` int(11) NOT NULL,
  `CodeArticale` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_bin;

--
-- Déchargement des données de la table `lignescommandes`
--

INSERT INTO `lignescommandes` (`NumCommande`, `CodeArticale`) VALUES
(1, 2),
(2, 3),
(3, 4),
(4, 4),
(4, 1),
(5, 2);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`CodeArticle`),
  ADD KEY `Categorie` (`Categorie`);

--
-- Index pour la table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`RefCat`);

--
-- Index pour la table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`Email`) USING HASH;

--
-- Index pour la table `commandes`
--
ALTER TABLE `commandes`
  ADD PRIMARY KEY (`NumCommande`),
  ADD KEY `CodeClient` (`CodeClient`);

--
-- Index pour la table `lignescommandes`
--
ALTER TABLE `lignescommandes`
  ADD KEY `NumCommande` (`NumCommande`),
  ADD KEY `CodeArticale` (`CodeArticale`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `commandes`
--
ALTER TABLE `commandes`
  MODIFY `NumCommande` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `articles`
--
ALTER TABLE `articles`
  ADD CONSTRAINT `articles_ibfk_1` FOREIGN KEY (`Categorie`) REFERENCES `categories` (`RefCat`);

--
-- Contraintes pour la table `commandes`
--
ALTER TABLE `commandes`
  ADD CONSTRAINT `foreign key` FOREIGN KEY (`CodeClient`) REFERENCES `clients` (`id`);

--
-- Contraintes pour la table `lignescommandes`
--
ALTER TABLE `lignescommandes`
  ADD CONSTRAINT `lignescommandes_ibfk_1` FOREIGN KEY (`NumCommande`) REFERENCES `commandes` (`NumCommande`),
  ADD CONSTRAINT `lignescommandes_ibfk_2` FOREIGN KEY (`CodeArticale`) REFERENCES `articles` (`CodeArticle`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
