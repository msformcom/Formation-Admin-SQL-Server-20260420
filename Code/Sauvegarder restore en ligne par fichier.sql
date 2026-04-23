

USE [master]
GO

CREATE DATABASE [Ventes]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Ventes', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Ventes.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
 FILEGROUP [DATA]  DEFAULT
( NAME = N'DATA_F1bis', FILENAME = N'D:\Disques\DATA_F1bis.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
( NAME = N'DATA_F2', FILENAME = N'D:\Disques\DATA_F2.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
 FILEGROUP [INDEX] 
( NAME = N'INDEX_F1', FILENAME = N'D:\Disques\INDEX_F1.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ),
( NAME = N'INDEX_F2', FILENAME = N'D:\Disques\INDEX_F2.ndf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Ventes_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Ventes_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

USE [Ventes]
GO



CREATE TABLE A(
ID INT PRIMARY KEY IDENTITY(1,1),
NOM NVARCHAR(1000)
)

CREATE INDEX IX_Nom ON A(Nom) ON [INDEX]

BACKUP DATABASE [Ventes] 
TO DISK='d:\Backups\Complete.bak'


BACKUP LOG [Ventes] 
TO DISK='d:\Backups\Logs.bak'

BACKUP DATABASE [Ventes] 
FILE = N'DATA_F1Bis' TO  DISK = N'd:\Backups\DATA_F1Bis.bak' 

BACKUP DATABASE [Ventes] 
FILE = N'DATA_F2' TO  DISK = N'd:\Backups\DATA_F2.bak'

BACKUP DATABASE [Ventes] 
FILE = N'INDEX_F1' TO  DISK = N'd:\Backups\INDEX_F1.bak' 

BACKUP DATABASE [Ventes] 
FILE = N'INDEX_F2' TO  DISK = N'd:\Backups\INDEX_F2.bak'

-- Changement dans la bdd
INSERT INTO A(Nom) VALUES ('Toto')

BACKUP LOG [Ventes] 
TO DISK='d:\Backups\Logs.bak'
GO

INSERT INTO A(Nom) SELECT nom FROM A


-- Echec d'accès à un disque => Base de données potentiellement ONLINE
-- Sauvegarder le journal (tail log)

-- Sauvegarde du journal des transaction (avant restoration)
BACKUP LOG [Ventes] 
TO DISK='d:\Backups\Logs.bak' WITH CONTINUE_AFTER_ERROR

USE master;

-- Restoration du fichier de données
RESTORE DATABASE Ventes 
FILE = 'INDEX_F1' 
FROM DISK = 'D:\Backups\INDEX_F1.bak' 
WITH NORECOVERY;
-- Restoration des logs
RESTORE LOG [Ventes] FROM  
DISK = N'd:\Backups\Logs.bak' WITH  FILE = 1,  NORECOVERY
RESTORE LOG [Ventes] FROM  
DISK = N'd:\Backups\Logs.bak' WITH  FILE = 2,  NORECOVERY
-- Restoration du dernier fichier de log
RESTORE LOG [Ventes] FROM  
DISK = N'd:\Backups\Logs.bak' WITH  FILE = 3

GO

