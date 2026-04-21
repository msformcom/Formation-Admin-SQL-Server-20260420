sp_configure 'show advanced options',1
reconfigure
-- Mémoire réservée au démarrage
EXEC sp_configure 'min server memory (MB)',1000
-- Mémoire maximale
EXEC sp_configure 'max server memory (MB)',4000
reconfigure

-- Exécution de commandes de l'os
EXEC sp_configure 'xp_cmdshell',1
reconfigure
xp_cmdshell 'dir c:'

-- max degree of parallelism => Nombre de thread pour 1 requete
-- 0 => autant que de coeurs
-- limiter à 4

-- cost threshold for parallelism
-- Cout minimum de 50 pour autoriser le paralelisme (processeurs actuels)

sp_configure 'cost threshold for parallelism', 50
reconfigure

-- Limite le volume de données du journal de transactions
-- non écrites dans les fichiers de données
-- pour éviter un temps de redemarrage trop long 
EXEC sys.sp_configure N'recovery interval (min)', N'5'
GO