DROP TABLE IF EXISTS `eo_api`;
CREATE TABLE `eo_api` (
  `apiID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `apiName` varchar(255) COLLATE utf8_bin NOT NULL,
  `apiURI` varchar(255) COLLATE utf8_bin NOT NULL,
  `apiProtocol` tinyint(1) unsigned NOT NULL,
  `apiFailureMock` text COLLATE utf8_bin,
  `apiSuccessMock` text COLLATE utf8_bin,
  `apiRequestType` tinyint(1) unsigned NOT NULL,
  `apiSuccessMockType` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `apiFailureMockType` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `apiStatus` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `apiUpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `groupID` int(11) unsigned NOT NULL,
  `projectID` int(11) unsigned NOT NULL,
  `starred` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `removed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `removeTime` timestamp NULL DEFAULT NULL,
  `apiNoteType` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `apiNoteRaw` text COLLATE utf8_bin,
  `apiNote` text COLLATE utf8_bin,
  `apiRequestParamType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `apiRequestRaw` text COLLATE utf8_bin,
  `updateUserID` int(11) NOT NULL DEFAULT '0',
  `mockRule` text COLLATE utf8_bin,
  `mockResult` text COLLATE utf8_bin,
  `mockConfig` text COLLATE utf8_bin,
  `apiSuccessStatusCode` varchar(255) DEFAULT '200',
  `apiFailureStatusCode` varchar(255) DEFAULT '200',
  `beforeInject` text NULL,
  `afterInject` text NULL,
  PRIMARY KEY (`apiID`,`groupID`,`apiURI`),
  KEY `groupID` (`groupID`),
  KEY `apiID` (`apiID`),
  KEY `projectID` (`projectID`)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
DROP TABLE IF EXISTS `eo_api_cache`;
CREATE TABLE `eo_api_cache` (
  `cacheID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `projectID` int(10) unsigned NOT NULL,
  `groupID` int(10) unsigned NOT NULL,
  `apiID` int(10) unsigned NOT NULL,
  `apiJson` longtext NOT NULL,
  `starred` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `updateUserID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cacheID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_api_env`;
CREATE TABLE `eo_api_env` (
  `envID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `envName` varchar(255) NOT NULL,
  `projectID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`envID`,`projectID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_api_env_front_uri`;
CREATE TABLE `eo_api_env_front_uri` (
  `envID` int(10) unsigned NOT NULL,
  `uri` varchar(255) NOT NULL,
  `uriID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `applyProtocol` varchar(4) NOT NULL DEFAULT '-1',
  PRIMARY KEY (`uriID`,`envID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_api_env_header`;
CREATE TABLE `eo_api_env_header` (
  `headerID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `envID` int(11) NOT NULL,
  `applyProtocol` varchar(255) DEFAULT NULL,
  `headerName` varchar(255) NOT NULL,
  `headerValue` text NOT NULL,
  PRIMARY KEY (`headerID`,`envID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_api_env_param`;
CREATE TABLE `eo_api_env_param` (
  `paramID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `envID` int(10) unsigned NOT NULL,
  `paramKey` varchar(255) NOT NULL,
  `paramValue` text NOT NULL,
  PRIMARY KEY (`paramID`,`envID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_api_env_param_additional`;
CREATE TABLE `eo_api_env_param_additional` (
  `paramID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `envID` int(10) unsigned NOT NULL,
  `paramKey` varchar(255) NOT NULL,
  `paramValue` text NOT NULL,
  PRIMARY KEY (`paramID`,`envID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_api_group`;
CREATE TABLE `eo_api_group` (
  `groupID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `groupName` varchar(30) COLLATE utf8_bin NOT NULL,
  `projectID` int(11) unsigned NOT NULL,
  `parentGroupID` int(10) unsigned NOT NULL DEFAULT '0',
  `isChild` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`groupID`,`projectID`),
  KEY `groupID` (`groupID`),
  KEY `projectID` (`projectID`)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
DROP TABLE IF EXISTS `eo_api_group_order`;
CREATE TABLE `eo_api_group_order` (
  `orderID` int(11) NOT NULL AUTO_INCREMENT,
  `projectID` int(11) NOT NULL,
  `orderList` text,
  PRIMARY KEY (`orderID`,`projectID`),
  UNIQUE KEY `projectID` (`projectID`) USING BTREE
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_api_header`;
CREATE TABLE `eo_api_header` (
  `headerID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `headerName` varchar(255) NOT NULL,
  `headerValue` text NOT NULL,
  `apiID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`headerID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_api_request_param`;
CREATE TABLE `eo_api_request_param` (
  `paramID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `paramName` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `paramKey` varchar(255) COLLATE utf8_bin NOT NULL,
  `paramValue` text COLLATE utf8_bin NOT NULL,
  `paramType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `paramLimit` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `apiID` int(10) unsigned NOT NULL,
  `paramNotNull` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`paramID`),
  KEY `apiID` (`apiID`)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
DROP TABLE IF EXISTS `eo_api_request_value`;
CREATE TABLE `eo_api_request_value` (
  `valueID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `value` text DEFAULT NULL,
  `valueDescription` varchar(255) DEFAULT NULL,
  `paramID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`valueID`),
  KEY `paramID` (`paramID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_api_result_param`;
CREATE TABLE `eo_api_result_param` (
  `paramID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `paramName` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `paramKey` varchar(255) COLLATE utf8_bin NOT NULL,
  `apiID` int(11) unsigned NOT NULL,
  `paramNotNull` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`paramID`),
  KEY `apiID` (`apiID`)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
DROP TABLE IF EXISTS `eo_api_result_value`;
CREATE TABLE `eo_api_result_value` (
  `valueID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `value` text COLLATE utf8_bin NOT NULL,
  `valueDescription` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `paramID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`valueID`),
  KEY `resultParamID` (`paramID`)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
DROP TABLE IF EXISTS `eo_api_status_code_group_order`;
CREATE TABLE `eo_api_status_code_group_order` (
  `orderID` int(11) NOT NULL AUTO_INCREMENT,
  `projectID` int(11) NOT NULL,
  `orderList` text NOT NULL,
  PRIMARY KEY (`orderID`,`projectID`),
  UNIQUE KEY `projectID` (`projectID`) USING BTREE
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_api_test_history`;
CREATE TABLE `eo_api_test_history` (
  `testID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `apiID` int(10) unsigned NOT NULL,
  `requestInfo` longtext,
  `resultInfo` longtext,
  `testTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `projectID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`testID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_conn_database`;
CREATE TABLE `eo_conn_database` (
  `connID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dbID` int(10) unsigned NOT NULL,
  `userID` int(10) unsigned NOT NULL,
  `userType` tinyint(1) NOT NULL DEFAULT '0',
  `inviteUserID` int(10) DEFAULT NULL,
  `partnerNickName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`connID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_conn_project`;
CREATE TABLE `eo_conn_project` (
  `connID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `projectID` int(11) unsigned NOT NULL,
  `userID` int(11) unsigned NOT NULL,
  `userType` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `inviteUserID` int(11) DEFAULT NULL,
  `partnerNickName` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`connID`,`projectID`,`userID`),
  KEY `projectID` (`projectID`),
  KEY `eo_conn_ibfk_2` (`userID`)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
DROP TABLE IF EXISTS `eo_database`;
CREATE TABLE `eo_database` (
  `dbID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dbName` varchar(255) NOT NULL,
  `dbVersion` float unsigned NOT NULL,
  `dbUpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `databaseType` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`dbID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_database_table`;
CREATE TABLE `eo_database_table` (
  `dbID` int(10) unsigned NOT NULL,
  `tableID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tableName` varchar(255) NOT NULL,
  `tableDescription` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tableID`,`dbID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_database_table_field`;
CREATE TABLE `eo_database_table_field` (
  `fieldID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fieldName` varchar(255) NOT NULL,
  `fieldType` varchar(10) NOT NULL,
  `fieldLength` varchar(10) NOT NULL,
  `isNotNull` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `isPrimaryKey` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `fieldDescription` varchar(255) DEFAULT NULL,
  `tableID` int(10) unsigned NOT NULL,
  `defaultValue` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`fieldID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_message`;
CREATE TABLE `eo_message` (
  `msgID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `toUserID` int(10) unsigned NOT NULL,
  `fromUserID` int(10) unsigned NOT NULL,
  `msgSendTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `msgType` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `summary` varchar(255) DEFAULT NULL,
  `msg` text NOT NULL,
  `isRead` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `otherMsg` text,
  PRIMARY KEY (`msgID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_project`;
CREATE TABLE `eo_project` (
  `projectID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `projectType` tinyint(1) unsigned NOT NULL,
  `projectName` varchar(255) COLLATE utf8_bin NOT NULL,
  `projectUpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `projectVersion` varchar(6) COLLATE utf8_bin NOT NULL DEFAULT '1.0',
  PRIMARY KEY (`projectID`)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
DROP TABLE IF EXISTS `eo_project_invite`;
CREATE TABLE `eo_project_invite` (
  `projectID` int(11) unsigned NOT NULL,
  `inviteCode` varchar(6) NOT NULL,
  `updateTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`projectID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_project_environment`;
CREATE TABLE `eo_project_environment` (
  `envID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `envName` varchar(255) NOT NULL,
  `envURI` varchar(255) NOT NULL,
  `projectID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`envID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_project_status_code`;
CREATE TABLE `eo_project_status_code` (
  `codeID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `codeDescription` varchar(255) NOT NULL,
  `groupID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`codeID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_project_status_code_group`;
CREATE TABLE `eo_project_status_code_group` (
  `groupID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `projectID` int(10) unsigned NOT NULL,
  `groupName` varchar(255) NOT NULL,
  `parentGroupID` int(10) unsigned NOT NULL DEFAULT '0',
  `isChild` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`groupID`,`projectID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_user`;
CREATE TABLE `eo_user` (
  `userID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userName` varchar(60) NOT NULL,
  `userPassword` varchar(60) NOT NULL,
  `userNickName` varchar(16) NOT NULL DEFAULT '',
  PRIMARY KEY (`userID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_log_project_operation`;
CREATE TABLE `eo_log_project_operation` (
  `opID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `opType` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `opUserID` int(10) unsigned NOT NULL,
  `opDesc` text NOT NULL,
  `opTime` datetime NOT NULL,
  `opProjectID` int(10) unsigned NOT NULL,
  `opTarget` tinyint(3) unsigned NOT NULL,
  `opTargetID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`opID`,`opTargetID`,`opProjectID`,`opUserID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_api_history`;
CREATE TABLE `eo_api_history` (
  `historyID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `projectID` int(10) unsigned NOT NULL,
  `groupID` int(10) unsigned NOT NULL,
  `apiID` int(10) unsigned NOT NULL,
  `historyJson` longtext NOT NULL,
  `updateDesc` varchar(255) NOT NULL,
  `updateUserID` int(10) unsigned NOT NULL,
  `updateTime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isNow` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`historyID`,`apiID`,`updateTime`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_project_document_group_order`;
CREATE TABLE `eo_project_document_group_order` (
  `orderID` int(11) NOT NULL AUTO_INCREMENT,
  `projectID` int(11) NOT NULL,
  `orderList` text NOT NULL,
  PRIMARY KEY (`orderID`,`projectID`),
  UNIQUE KEY `projectID` (`projectID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_project_document_group`;
CREATE TABLE `eo_project_document_group` (
  `groupID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `projectID` int(10) unsigned NOT NULL,
  `groupName` varchar(255) NOT NULL,
  `parentGroupID` int(10) unsigned NOT NULL DEFAULT '0',
  `isChild` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`groupID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_project_document`;
CREATE TABLE `eo_project_document` (
  `documentID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `groupID` int(10) unsigned NOT NULL,
  `projectID` int(10) unsigned NOT NULL,
  `contentType` tinyint(3) unsigned NOT NULL,
  `contentRaw` longtext,
  `content` longtext,
  `title` varchar(255) NOT NULL,
  `updateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `userID` int(10) unsigned NOT NULL,
  PRIMARY KEY (`documentID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_project_test_case_group`;
CREATE TABLE `eo_project_test_case_group` (
  `groupID` int(11) NOT NULL AUTO_INCREMENT COMMENT '??????ID',
  `groupName` varchar(100) NOT NULL COMMENT '??????',
  `projectID` int(11) NOT NULL COMMENT '??????ID',
  `parentGroupID` int(11) NOT NULL DEFAULT '0' COMMENT '?????????',
  `isChild` tinyint(3) NOT NULL DEFAULT '0' COMMENT '???????????????',
  PRIMARY KEY (`groupID`,`projectID`,`parentGroupID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_project_test_case_group_order`;
CREATE TABLE `eo_project_test_case_group_order` (
  `orderID` int(11) NOT NULL AUTO_INCREMENT,
  `projectID` int(11) NOT NULL,
  `orderList` text NOT NULL,
  PRIMARY KEY (`orderID`,`projectID`),
  UNIQUE KEY `projectID` (`projectID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_project_test_case_history`;
CREATE TABLE `eo_project_test_case_history` (
  `testID` int(11) NOT NULL AUTO_INCREMENT COMMENT '??????ID',
  `caseID` int(11) NOT NULL COMMENT '??????ID',
  `result` text COMMENT '????????????',
  `testTime` datetime DEFAULT NULL COMMENT '????????????',
  `status` tinyint(4) DEFAULT NULL COMMENT '0???????????????1????????????',
  PRIMARY KEY (`testID`,`caseID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_project_test_case_single`;
CREATE TABLE `eo_project_test_case_single` (
  `connID` int(11) NOT NULL AUTO_INCREMENT COMMENT '??????ID',
  `caseID` int(11) NOT NULL COMMENT '??????ID',
  `caseData` text COMMENT '??????',
  `caseCode` text COMMENT '????????????',
  `statusCode` varchar(20) DEFAULT NULL,
  `matchType` tinyint(4) DEFAULT NULL,
  `matchRule` text,
  `apiName` varchar(255) NOT NULL COMMENT '????????????',
  `apiURI` varchar(255) NOT NULL COMMENT '????????????',
  `apiRequestType` tinyint(4) DEFAULT '0' COMMENT '??????????????????',
  `orderNumber` int(11),
  PRIMARY KEY (`connID`,`caseID`)
) DEFAULT CHARSET=utf8;
DROP TABLE IF EXISTS `eo_project_test_case`;
CREATE TABLE `eo_project_test_case` (
  `caseID` int(11) NOT NULL AUTO_INCREMENT COMMENT '??????ID',
  `projectID` int(11) NOT NULL COMMENT '??????ID',
  `userID` int(11) NOT NULL COMMENT '??????ID',
  `caseName` varchar(255) NOT NULL COMMENT '????????????',
  `caseDesc` varchar(255) DEFAULT NULL COMMENT '????????????',
  `createTime` datetime NOT NULL COMMENT '????????????',
  `updateTime` datetime NOT NULL COMMENT '????????????',
  `groupID` int(11) NOT NULL COMMENT '??????ID',
  `caseType` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0???????????????1????????????',
  `caseCode` longtext,
  PRIMARY KEY (`caseID`,`projectID`,`userID`)
) DEFAULT CHARSET=utf8;