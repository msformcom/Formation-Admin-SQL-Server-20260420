-- Script SQL qui permette via sqlcmd de :
-- 1) Créer une base de donnée en spécifiant le nom dans la ligne de commande
CREATE DATABASE $(dbname)
GO
-- Se placer dans le contexte de la nouvelle BDD
USE $(dbname)
GO

-- 2) Créer un utilisateur pour le LOGIN Student
IF NOT EXISTS(
	SELECT * FROM sys.syslogins WHERE name='BUILTIN\IIS_IUSRS'
)
BEGIN
	CREATE LOGIN [BUILTIN\IIS_IUSRS] FROM WINDOWS 
END
GO

-- Ajout de l'utilisateur dans la BDD
CREATE USER [BUILTIN\IIS_IUSRS] FOR LOGIN [BUILTIN\IIS_IUSRS]
GO

CREATE SCHEMA BDInternals
GO 
-- 3) Créer une table Historique 
CREATE TABLE BDInternals.Historique(id INT)
GO
-- 4) Créer un role HistoManager
CREATE ROLE HistoManager

-- 5) Ajouter Student à HistoManager
ALTER ROLE HistoManager ADD MEMBER [BUILTIN\IIS_IUSRS]


-- 6) Donner le droit delete au role sur le schema
-- HistoManager aura delete sur BDInternals => BDInternals.Historique
GRANT DELETE ON SCHEMA::BDInternals TO HistoManager
GO


-- 7) Ajouter student au ddlAdmin
ALTER ROLE [db_ddladmin] ADD MEMBER [BUILTIN\IIS_IUSRS]
GO

-- SQLCMD -v dbName="Ventes"



