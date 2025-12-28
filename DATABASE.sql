CREATE DATABASE  IF NOT EXISTS `compliance` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `compliance`;


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


DROP TABLE IF EXISTS `empresas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresas` (
  `id_empresa` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `cnpj` varchar(20) DEFAULT NULL,
  `email_principal` varchar(255) DEFAULT NULL,
  `telefone` varchar(50) DEFAULT NULL,
  `endereco` text,
  `status` enum('ativa','inativa') DEFAULT 'ativa',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_empresa`),
  UNIQUE KEY `cnpj` (`cnpj`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `empresas` WRITE;
/*!40000 ALTER TABLE `empresas` DISABLE KEYS */;
INSERT INTO `empresas` VALUES (1,'teste','123456','italloteste@teste.com','3199999999','teste','ativa','2025-09-13 23:27:16','2025-09-13 23:27:16');
/*!40000 ALTER TABLE `empresas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;



DROP TABLE IF EXISTS `filiais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `filiais` (
  `id_filial` int NOT NULL AUTO_INCREMENT,
  `id_empresa` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `cnpj` varchar(20) DEFAULT NULL,
  `email_filial` varchar(255) DEFAULT NULL,
  `telefone` varchar(50) DEFAULT NULL,
  `endereco` text,
  `status` enum('ativa','inativa') DEFAULT 'ativa',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_filial`),
  KEY `fk_filial_empresa` (`id_empresa`),
  CONSTRAINT `fk_filial_empresa` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filiais`
--

LOCK TABLES `filiais` WRITE;
/*!40000 ALTER TABLE `filiais` DISABLE KEYS */;
/*!40000 ALTER TABLE `filiais` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

DROP TABLE IF EXISTS `denuncias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `denuncias` (
  `id_denuncia` int NOT NULL AUTO_INCREMENT,
  `id_empresa` int NOT NULL,
  `id_filial` int DEFAULT NULL,
  `atos_ilicitos` varchar(40) DEFAULT NULL,
  `conduta` varchar(120) DEFAULT NULL,
  `descumprimento_normas` varchar(30) DEFAULT NULL,
  `tipo_denuncia` varchar(60) DEFAULT NULL,
  `sigilo_informacoes` varchar(60) DEFAULT NULL,
  `onde_ocorreu` text,
  `quando_ocorreu` text,
  `quem_cometeu` text,
  `continua_ocorrendo` text,
  `testemunhas` text,
  `descreva_ocorrido` text,
  `grau_certeza` varchar(120) DEFAULT NULL,
  `protocolo` varchar(120) DEFAULT NULL,
  `termo` tinyint(1) DEFAULT '0',
  `email_notificacao` varchar(255) DEFAULT NULL,
  `status` enum('pendente','em_analise','concluida') DEFAULT 'pendente',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_denuncia`),
  KEY `fk_denuncia_empresa` (`id_empresa`),
  KEY `fk_denuncia_filial` (`id_filial`),
  CONSTRAINT `fk_denuncia_empresa` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_denuncia_filial` FOREIGN KEY (`id_filial`) REFERENCES `filiais` (`id_filial`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `denuncias`
--

LOCK TABLES `denuncias` WRITE;
/*!40000 ALTER TABLE `denuncias` DISABLE KEYS */;
INSERT INTO `denuncias` VALUES (1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-66CFC513',0,NULL,'concluida','2025-09-20 14:28:35','2025-09-20 18:58:23'),(2,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-9317EF2A',0,NULL,'em_analise','2025-09-20 14:37:26','2025-09-20 19:28:34'),(3,1,NULL,'Corrupção','Assédio Sexual','Legislação Trabalhista',NULL,NULL,'Setor Financeiro','2025-09-20 10:30','Gestor de equipe','Sim','João, Maria','Descrição detalhada...','Alta','DN-2025-E1B6846B',0,NULL,'pendente','2025-09-20 15:05:20','2025-09-24 01:02:25'),(4,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-91A0A488',0,NULL,'pendente','2025-09-20 16:21:28','2025-09-20 16:22:39'),(5,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-5AA0EA26',0,NULL,'pendente','2025-09-20 16:24:30','2025-09-20 16:24:30'),(6,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-BB42438C',0,NULL,'pendente','2025-09-20 16:25:03','2025-09-20 16:25:03'),(7,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-768432E4',0,NULL,'pendente','2025-09-20 16:26:11','2025-09-20 16:26:11'),(8,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-CA333EB5',0,NULL,'pendente','2025-09-20 16:28:57','2025-09-20 16:28:57'),(9,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-6A4A3819',0,NULL,'pendente','2025-09-20 16:29:42','2025-09-20 16:29:42'),(10,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-817D7B45',0,NULL,'concluida','2025-09-20 16:30:30','2025-10-06 23:47:24'),(11,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-5ADE60B7',0,NULL,'pendente','2025-09-20 16:31:27','2025-09-20 16:32:11'),(12,1,NULL,'Corrupção',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-18978677',0,NULL,'pendente','2025-09-20 16:45:04','2025-09-20 16:51:36'),(13,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-7D818A4A',0,NULL,'pendente','2025-09-20 16:55:41','2025-09-20 16:55:41'),(14,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-58CA8A43',0,NULL,'pendente','2025-09-20 17:32:04','2025-09-20 17:32:04'),(15,1,NULL,'Fraude',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-8F22018E',0,NULL,'pendente','2025-09-20 17:55:21','2025-09-20 17:55:25'),(16,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-881C6A8B',0,NULL,'pendente','2025-09-20 17:59:29','2025-09-20 17:59:29'),(17,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-492F36B5',0,NULL,'pendente','2025-09-20 19:10:28','2025-09-20 19:10:28'),(18,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-235A9D89',0,NULL,'pendente','2025-09-20 19:14:15','2025-09-20 19:22:30'),(19,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-28BF22A7',0,NULL,'pendente','2025-09-20 20:32:50','2025-09-20 20:33:59'),(20,1,NULL,NULL,'Assédio Sexual',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-92B723FB',0,NULL,'pendente','2025-09-20 22:08:56','2025-09-20 22:09:47'),(23,1,NULL,'Fraude','Assédio Moral','Políticas Internas','Anônima','Sim',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-515AF28E',1,'teste@empresa.com','pendente','2025-09-24 00:20:27','2025-09-24 00:20:27'),(27,1,NULL,'Fraude','Assédio Moral','Políticas Internas','Anônima','Sim',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-4246F85F',1,'teste@empresa.com','pendente','2025-09-24 01:04:02','2025-09-24 01:04:02'),(28,1,NULL,'Fraude','Assédio Moral','Políticas Internas','Anônima','Sim',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-DBC807FE',1,'teste@empresa.com','pendente','2025-09-24 01:04:20','2025-09-24 01:04:20'),(31,1,NULL,'Fraude','Assédio Moral','Políticas Internas','Anônima','Sim',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-22C572ED',1,'teste@empresa.com','pendente','2025-09-24 23:41:56','2025-09-24 23:41:56'),(33,1,NULL,'Fraude','Assédio Moral','Políticas Internas','Anônima','Sim',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-0A76E768',1,'teste@empresa.com','pendente','2025-09-25 00:00:42','2025-09-25 00:00:42'),(34,1,NULL,'Fraude','Assédio Moral','Políticas Internas','Anônima','Sim','Setor Financeiro','2025-09-23 08:30','Gestor X','Sim','Maria, João','Descrição detalhada do ocorrido...','Alta','DN-2025-94A1B847',1,'teste@empresa.com','pendente','2025-09-25 00:00:42','2025-09-25 00:00:42'),(35,1,NULL,'Fraude','Assédio Moral','Políticas Internas','Anônima','Sim',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-26DF6A05',1,'teste@empresa.com','pendente','2025-09-25 00:01:15','2025-09-25 00:01:15'),(36,1,NULL,'Fraude','Assédio Moral','Políticas Internas','Anônima','Sim','Setor Financeiro','2025-09-23 08:30','Gestor X','Sim','Maria, João','Descrição detalhada do ocorrido...','Alta','DN-2025-3BAAC2B0',1,'teste@empresa.com','pendente','2025-09-25 00:01:15','2025-09-25 00:01:15'),(38,1,NULL,'Fraude','Assédio Moral','Políticas Internas','Anônima','Sim','Setor Financeiro','2025-09-23 08:30','Gestor X','Sim','Maria, João','Descrição detalhada do ocorrido...','Alta','DN-2025-01362F9D',1,'teste@empresa.com','pendente','2025-09-25 00:03:59','2025-09-25 00:03:59'),(39,1,NULL,'Fraude','Assédio Moral','Políticas Internas','Anônima','Sim',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-94369886',1,'teste@empresa.com','pendente','2025-09-25 00:03:59','2025-09-25 00:03:59'),(40,1,NULL,'Fraude','Assédio Moral','Políticas Internas','Anônima','Sim','Setor Financeiro','2025-09-23 08:30','Gestor X','Sim','Maria, João','Descrição detalhada do ocorrido...','Alta','DN-2025-9257CFD8',1,'teste@empresa.com','pendente','2025-09-25 00:11:43','2025-09-25 00:11:43'),(41,1,NULL,'Fraude','Assédio Moral','Políticas Internas','Anônima','Sim',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-45487DF8',1,'teste@empresa.com','pendente','2025-09-25 00:12:39','2025-09-25 00:12:39'),(42,1,NULL,'Fraude','Assédio Moral','Políticas Internas','Anônima','Sim','Setor Financeiro','2025-09-23 08:30','Gestor X','Sim','Maria, João','Descrição detalhada do ocorrido...','Alta','DN-2025-F584BDB5',1,'teste@empresa.com','pendente','2025-09-25 00:14:10','2025-09-25 00:14:10'),(43,1,NULL,'Fraude','Assédio Moral','Políticas Internas','Anônima','Sim','Setor Financeiro','2025-09-23 08:30','Gestor X','Sim','Maria, João','Descrição detalhada do ocorrido...','Alta','DN-2025-6DCB3E3B',1,'teste@empresa.com','pendente','2025-09-25 00:14:30','2025-09-25 00:14:30'),(44,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-5AC2053A',0,NULL,'pendente','2025-09-25 00:36:47','2025-09-25 00:37:29'),(45,1,NULL,NULL,NULL,'Políticas Internas',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-9ECFB0AB',0,NULL,'pendente','2025-09-25 17:56:49','2025-09-25 17:56:53'),(46,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-4958C6AB',0,NULL,'pendente','2025-09-25 18:23:26','2025-09-25 18:23:26'),(53,1,NULL,'Assédio Moral','joao','Gabigol fez merda com o joao','Sim','Sim',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-41DED31C',1,'teste@aliancadev.com','pendente','2025-10-06 23:27:56','2025-10-06 23:27:56'),(55,1,NULL,'Fraude','Assédio Moral','Políticas Internas','Anônima','Sim','Setor Financeiro','2025-09-23 08:30','Gestor X','Sim','Maria, João','Descrição detalhada do ocorrido...','Alta','DN-2025-F700A64D',1,'teste@empresa.com','pendente','2025-10-06 23:39:13','2025-10-06 23:39:13'),(56,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-90071683',0,NULL,'pendente','2025-10-06 23:54:09','2025-10-06 23:54:37'),(57,1,NULL,'Assédio Moral','—','—','Anônima','Sim','betim','2025-10-01 00:00','itallo','Sim','gabriel','teste','Média','DN-2025-B70D2A3B',1,NULL,'pendente','2025-10-07 17:05:03','2025-10-07 17:05:03'),(58,1,NULL,'Assédio Moral','—','—','Anônima','Sim','betim','2025-10-07 00:00','teste','Não','teste','teste','Média','DN-2025-47FA50DC',1,NULL,'pendente','2025-10-07 17:41:23','2025-10-07 17:41:23'),(59,1,NULL,'Agressão Física','—','—','Anônima','Sim','betim','2025-10-07 00:00','teste','Não','teste','teste','Média','DN-2025-1B3AA831',1,NULL,'pendente','2025-10-07 17:49:58','2025-10-07 17:49:58'),(60,1,NULL,'Assédio Sexual','—','—','Anônima','Sim','setor','2025-10-01 00:00','joo','Sim','maria','teste','Média','DN-2025-86B00286',1,NULL,'pendente','2025-10-27 18:01:22','2025-10-27 18:01:22'),(61,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-364A3F0E',0,NULL,'pendente','2025-11-27 02:17:34','2025-11-27 02:17:34'),(62,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-80547C6D',0,NULL,'pendente','2025-12-25 20:11:27','2025-12-25 20:11:56'),(63,1,NULL,NULL,NULL,'Políticas Internas',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-C07171BB',0,NULL,'pendente','2025-12-25 22:50:24','2025-12-25 22:50:28'),(64,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-6E537D77',0,NULL,'pendente','2025-12-25 23:41:43','2025-12-25 23:41:43'),(65,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-0CFB7AEB',0,NULL,'pendente','2025-12-27 15:00:10','2025-12-27 15:00:10'),(66,1,NULL,NULL,NULL,'Políticas Internas',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-F60B7E58',0,NULL,'pendente','2025-12-27 20:15:27','2025-12-27 20:15:34'),(67,1,NULL,'Fraude',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'DN-2025-77C93FC0',0,NULL,'pendente','2025-12-28 23:10:13','2025-12-28 23:10:17');
/*!40000 ALTER TABLE `denuncias` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-28 20:16:39
DROP TABLE IF EXISTS `denuncia_historico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `denuncia_historico` (
  `id_historico` int NOT NULL AUTO_INCREMENT,
  `id_denuncia` int NOT NULL,
  `id_usuario` int NOT NULL,
  `status` varchar(20) NOT NULL,
  `observacao` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_historico`),
  KEY `id_denuncia` (`id_denuncia`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `denuncia_historico_ibfk_1` FOREIGN KEY (`id_denuncia`) REFERENCES `denuncias` (`id_denuncia`) ON DELETE CASCADE,
  CONSTRAINT `denuncia_historico_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `denuncia_historico`
--

LOCK TABLES `denuncia_historico` WRITE;
/*!40000 ALTER TABLE `denuncia_historico` DISABLE KEYS */;
INSERT INTO `denuncia_historico` VALUES (1,1,2,'pendente','teste','2025-09-20 18:57:09'),(2,1,2,'concluida','concluida','2025-09-20 18:58:23'),(3,2,2,'em_analise','sei la alguma coisa ','2025-09-20 19:28:34'),(4,10,2,'em_analise','Itallo','2025-10-06 23:44:22'),(5,10,2,'pendente','1234','2025-10-06 23:46:23'),(6,10,2,'concluida','Concluida pelo gabriel','2025-10-06 23:47:24');
/*!40000 ALTER TABLE `denuncia_historico` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-28 20:16:40



DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `id_empresa` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `perfil` enum('admin','gestor','colaborador') DEFAULT 'colaborador',
  `status` enum('ativo','inativo') DEFAULT 'ativo',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_usuario_empresa` (`id_empresa`),
  CONSTRAINT `fk_usuario_empresa` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (2,1,'Itallo Alves','itallodev@outlook.com','123456','admin','ativo','2025-09-13 23:47:14','2025-09-14 19:52:00'),(3,1,'Gabriel Felipe','gabriel.feliper2d2@hotmail.com','123456','admin','ativo','2025-09-20 19:27:42','2025-09-20 19:27:42');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
