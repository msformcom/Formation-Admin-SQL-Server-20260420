-- Sauvegarde Dimanche
BACKUP DATABASE [AdventureWorks]
TO DISK='d:\Backups\Complete Dimanche.bak'

BACKUP LOG  [AdventureWorks]
TO DISK='d:\Backups\LOG D 1.bak'

BACKUP LOG  [AdventureWorks]
TO DISK='d:\Backups\LOG D 2.bak'

-- Sauvegarde Lundi
BACKUP DATABASE [AdventureWorks]
TO DISK='d:\Backups\Differentielle Lundi.bak' WITH DIFFERENTIAL

BACKUP LOG  [AdventureWorks]
TO DISK='d:\Backups\LOG M 1.bak'

BACKUP LOG  [AdventureWorks]
TO DISK='d:\Backups\LOG M 2.bak'


-- Sauvegarde Mardi
BACKUP DATABASE [AdventureWorks]
TO DISK='d:\Backups\Differentielle Mardi.bak' WITH DIFFERENTIAL

BACKUP LOG  [AdventureWorks]
TO DISK='d:\Backups\LOG Me 1.bak'


-- Backup final (à ne pas oublier avant restauration)
-- Si l'instance est encore disponible
BACKUP LOG  [AdventureWorks]
TO DISK='d:\Backups\Tail log.bak'
WITH CONTINUE_AFTER_ERROR

-- Informations sur les sauvegardes dans un fichier
RESTORE HEADERONLY FROM DISK='d:\Backups\Differentielle Mardi.bak'


-- Code généré avec SSMS
-- A partir de UI =>
-- + historique MSDB
-- ou sélection des fichiers de sauvegarde
USE [master]
RESTORE DATABASE [AdventureWorks] FROM  DISK = N'D:\Backups\Complete Dimanche.bak' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE DATABASE [AdventureWorks] FROM  DISK = N'D:\Backups\Differentielle Mardi.bak' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [AdventureWorks] FROM  DISK = N'D:\Backups\LOG Me 1.bak' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE LOG [AdventureWorks] FROM  DISK = N'D:\Backups\Tail log.bak' WITH  FILE = 1,  NOUNLOAD,  STATS = 5



