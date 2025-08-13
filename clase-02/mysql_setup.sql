-- =====================================================
-- Script de Configuración Inicial - Clase 02 - Unidad 1
-- Base de Datos Aplicada - UCC 2025
-- =====================================================

-- Configuración de la sesión
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

-- Crear base de datos para la clase
CREATE DATABASE IF NOT EXISTS `clase_02_unidad1_db` 
DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE `clase_02_unidad1_db`;

-- Configurar variables de sesión para mejor rendimiento
SET SESSION sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_DATE,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO';

-- Verificar configuración
SELECT 
    @@version as mysql_version,
    @@sql_mode as sql_mode,
    @@character_set_database as charset,
    @@collation_database as collation;

-- Mostrar bases de datos disponibles
SHOW DATABASES;

-- Mostrar tables de la base de datos actual
SHOW TABLES;

-- Verificar usuario actual
SELECT USER(), CURRENT_USER();

-- Verificar privilegios del usuario actual
SHOW GRANTS;

COMMIT;
