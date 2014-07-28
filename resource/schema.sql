-- phpMyAdmin SQL Dump
-- version 4.0.6
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 06, 2014 at 12:06 PM
-- Server version: 5.5.33
-- PHP Version: 5.5.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `cdcollection`
--
CREATE DATABASE IF NOT EXISTS `cdcollection` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `cdcollection`;

-- --------------------------------------------------------

--
-- Table structure for table `albums`
--

CREATE TABLE `albums` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `artist_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  `released` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Albums_Genres1_idx` (`genre_id`),
  KEY `fk_albums_artists1_idx` (`artist_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=35 ;

--
-- Dumping data for table `albums`
--

INSERT INTO `albums` (`id`, `title`, `artist_id`, `genre_id`, `released`) VALUES
(1, 'Days to Come', 1, 27, 2006),
(2, 'The North Borders', 1, 52, 2013),
(3, 'Black Sands', 1, 27, 2010),
(4, 'Girls Beware!', 2, 40, 2007),
(5, 'Topless Is More', 2, 40, 2007),
(6, 'John Terra', 2, 40, 2009),
(7, 'Takk...', 3, 20, 2005),
(8, 'Ágætis byrjun', 3, 20, 2001),
(9, 'Kveikur', 3, 20, 2013),
(10, 'Valtari', 3, 20, 2012),
(11, 'Með suð í eyrum við spilum endalaust', 3, 20, 2008),
(12, '( )', 3, 20, 2002),
(13, 'Von', 3, 20, 2010),
(14, 'Hvarf - Heim', 3, 20, 2007),
(15, 'Inni', 3, 20, 2011),
(16, 'Based on a True Story', 4, 12, 2007),
(17, 'Blackbird', 4, 12, 2013),
(18, 'Dr. Boondigga & The Big Bw', 4, 12, 2009),
(19, 'Hope for a generation EP', 4, 12, 2004),
(20, 'Ma Fleur', 5, 12, 2007),
(21, 'Man With a Movie Camera', 5, 12, 2003),
(22, 'Every Day', 5, 12, 2002),
(23, 'Motion', 5, 12, 1999),
(24, 'Late Night Tales: The Cinematic Orchestra', 5, 12, 2010),
(25, 'The Crimson Wing: Mystery of the Flamingos', 5, 24, 2008),
(26, 'Live At The Royal Albert Hall', 5, 12, 2008),
(27, 'SBTRKT', 6, 12, 2011),
(28, 'Transitions', 6, 12, 2014),
(29, '2020', 6, 12, 2010),
(30, 'Ritual Union', 7, 52, 2011),
(31, 'Machine Dreams', 7, 52, 2009),
(32, 'Nabuma Rubberband', 7, 52, 2014),
(33, 'Little Dragon', 7, 52, 2009),
(34, 'An Awesome Wave', 8, 40, 2012);

-- --------------------------------------------------------

--
-- Table structure for table `album_has_tracks`
--

CREATE TABLE `album_has_tracks` (
  `track_id` int(11) NOT NULL,
  `album_id` int(11) NOT NULL,
  `track_nr` int(11) DEFAULT NULL,
  `cdnr` int(11) DEFAULT NULL,
  PRIMARY KEY (`track_id`,`album_id`),
  KEY `fk_Tracks_has_Albums_Albums1_idx` (`album_id`),
  KEY `fk_Tracks_has_Albums_Tracks1_idx` (`track_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `artists`
--

CREATE TABLE `artists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `biography` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `artists`
--

INSERT INTO `artists` (`id`, `title`, `biography`) VALUES
(1, 'Bonobo', 'Simon Green (born 30 March 1976), known by his stage name Bonobo, is a British musician, producer and DJ.'),
(2, 'de portables', 'De portables are a Belgian rock band formed in Ghent in 1996, who are steadily becoming one of the most commercially successful and critically acclaimed acts in the history of popular music. Since their international stardom, the group consists of Jürgen De Blonde (guitar, vocals, keyboards), Bertrand Lafontaine (guitar, bass guitar, vocals), Ingwio “Wio” D’Hespeel (guitar, drums, vocals) and Hans Gruyaert (drums, guitar, vocals). Rooted in postrock and 1990s indierock, the group later started working in many genres ranging from folk rock to psychedelic pop, often incorporating classical and other elements in innovative ways.'),
(3, 'Sigur Rós', 'Sigur Rós are an icelandic post-rock band. The name is derived from the name of lead vocalist Jónsi Birgisson’s little sister, Sigurrós. They hail from the same creative and vibrant Icelandic music scene as múm and Amiina. They released their first ever foray into film-making with their tour documentary, Heima in late 2007. '),
(4, 'Fat Freddy''s Drop', 'Fat Freddy’s Drop is a 7 piece live Dub/Reggae band from Wellington, New Zealand. Founded in 2001, the current lineup consists of DJ Fitchie, Joe Dukie, Toby Chang, HoPepa, Chopper Reedz, Jetlag Johnson, and Dobie Blaze. The name “Fat Freddy’s Drop” is a reference to a piece of blotter art that was circulating in the NZ dance scene in the late 90’s.'),
(5, 'The Cinematic Orchestra', 'The Cinematic Orchestra is a UK-based jazz and electronic outfit, created in 1999 by Jason Swinscoe, which records on the Ninja Tune independent record label. \r\n\r\nOther members include Tom Chant (saxophone), Phil France (double bass), Luke Flowers (drums), Nick Ramm (piano), Stuart McCallum (guitar); former members include Jamie Coleman (trumpet), T. Daniel Howard (drums), Alex James (piano), and Patrick “PC” Carpenter (turntables).'),
(6, 'SBTRKT', 'SBTRKT is Aaron Jerome, a producer based in London. He performs behind a mask every time he plays out. '),
(7, 'Little Dragon', 'Little Dragon is an electronic music group formed in 2006 and based in Gothenburg, Sweden. The band is made up of Yukimi Nagano (vocals), Fredrick Källgren (bass), Håkan Wirenstrand (keyboards) and Erik Bodin (drums). Their new album ‘Nabuma Rubberband’ will be released on May 13, 2014 on Loma Vista. Prior to this, they have released three studio albums: Little Dragon (2007), Machine Dreams (2009) and Ritual Union (2011).'),
(8, '∆', '∆ (pronounced Alt-J) was formed when Gwil Sainsbury (guitarist/bassist) , Joe Newman (guitar/vocals), Gus Unger-Hamilton (keyboards) and Thom Green (drums) met at Leeds, UK University in 2007. The band currently resides in Cambridge.');

-- --------------------------------------------------------

--
-- Table structure for table `genres`
--

CREATE TABLE `genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=123 ;

--
-- Dumping data for table `genres`
--

INSERT INTO `genres` (`id`, `title`) VALUES
(1, 'Classic Rock'),
(2, 'Country'),
(3, 'Dance'),
(4, 'Disco'),
(5, 'Funk'),
(6, 'Grunge'),
(7, 'Hip-Hop'),
(8, 'Jazz'),
(9, 'Metal'),
(10, 'New Age'),
(11, 'Oldies'),
(12, 'Other'),
(13, 'Pop'),
(14, 'R&B'),
(15, 'Rap'),
(16, 'Reggae'),
(17, 'Rock'),
(18, 'Techno'),
(19, 'Industrial'),
(20, 'Alternative'),
(21, 'Ska'),
(22, 'Death Metal'),
(23, 'Pranks'),
(24, 'Soundtrack'),
(25, 'Euro-Techno'),
(26, 'Ambient'),
(27, 'Trip-Hop'),
(28, 'Vocal'),
(29, 'Jazz+Funk'),
(30, 'Fusion'),
(31, 'Trance'),
(32, 'Classical'),
(33, 'Instrumental'),
(34, 'Acid'),
(35, 'House'),
(36, 'Game'),
(37, 'Sound Clip'),
(38, 'Gospel'),
(39, 'Noise'),
(40, 'AlternRock'),
(41, 'Bass'),
(42, 'Soul'),
(43, 'Punk'),
(44, 'Space'),
(45, 'Meditative'),
(46, 'Instrumental Pop'),
(47, 'Instrumental Rock'),
(48, 'Ethnic'),
(49, 'Gothic'),
(50, 'Darkwave'),
(51, 'Techno-Industrial'),
(52, 'Electronic'),
(53, 'Pop-Folk'),
(54, 'Eurodance'),
(55, 'Dream'),
(56, 'Southern Rock'),
(57, 'Comedy'),
(58, 'Cult'),
(59, 'Gangsta'),
(60, 'Top 40'),
(61, 'Christian Rap'),
(62, 'Pop/Funk'),
(63, 'Jungle'),
(64, 'Native American'),
(65, 'Cabaret'),
(66, 'New Wave'),
(67, 'Psychadelic'),
(68, 'Rave'),
(69, 'Showtunes'),
(70, 'Trailer'),
(71, 'Lo-Fi'),
(72, 'Tribal'),
(73, 'Acid Punk'),
(74, 'Acid Jazz'),
(75, 'Polka'),
(76, 'Retro'),
(77, 'Musical'),
(78, 'Rock & Roll'),
(79, 'Hard Rock'),
(80, 'Folk'),
(81, 'Folk-Rock'),
(82, 'National Folk'),
(83, 'Swing'),
(84, 'Fast Fusion'),
(85, 'Bebob'),
(86, 'Latin'),
(87, 'Revival'),
(88, 'Celtic'),
(89, 'Bluegrass'),
(90, 'Avantgarde'),
(91, 'Gothic Rock'),
(92, 'Progressive Rock'),
(93, 'Psychedelic Rock'),
(94, 'Symphonic Rock'),
(95, 'Slow Rock'),
(96, 'Big Band'),
(97, 'Chorus'),
(98, 'Easy Listening'),
(99, 'Acoustic'),
(103, 'Opera'),
(104, 'Chamber Music'),
(105, 'Sonata'),
(106, 'Symphony'),
(107, 'Booty Bass'),
(108, 'Primus'),
(109, 'Porn Groove'),
(110, 'Satire'),
(111, 'Slow Jam'),
(112, 'Club'),
(113, 'Tango'),
(114, 'Samba'),
(115, 'Folklore'),
(116, 'Ballad'),
(117, 'Power Ballad'),
(118, 'Rhythmic Soul'),
(119, 'Freestyle'),
(120, 'Duet'),
(121, 'Punk Rock'),
(122, 'Drum Solo');

-- --------------------------------------------------------

--
-- Table structure for table `tracks`
--

CREATE TABLE `tracks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `artist_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Tracks_Artists_idx` (`artist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
