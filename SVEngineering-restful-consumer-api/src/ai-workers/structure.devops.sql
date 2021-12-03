/*
  IMPORTANT: this file is for LOCAL schema only. This database exists globally for all environments except local
*/
DROP TABLE IF EXISTS `ec2_workers`;

CREATE TABLE `ec2_workers` (
  `instanceId` varchar(50) NOT NULL DEFAULT '',
  `lastAction` int(11) DEFAULT NULL,
  `idle` tinyint(1) DEFAULT NULL,
  `terminating` tinyint(1) DEFAULT NULL,
  `scheduledGameId` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`instanceId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;