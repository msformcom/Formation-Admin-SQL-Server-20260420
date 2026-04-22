-- DDL TRIGGER
CREATE OR ALTER TRIGGER trg_EnforceTableName
ON DATABASE 
FOR CREATE_TABLE 
AS 
BEGIN
	DECLARE @EventData XML = EVENTDATA();
    DECLARE @TableName NVARCHAR(256);
    DECLARE @check NVARCHAR(10) = 'tbl_%'; -- Votre convention ici

    -- Extraction du nom de la table depuis les données d'événement XML
    SET @TableName = @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'NVARCHAR(256)');
	IF @TableName NOT LIKE @check
	BEGIN
		PRINT 'ERREUR : Le nom de la table "' + @TableName + '" est invalide.';
		ROLLBACK
	END 
END

CREATE TABLE tbl_B (A INT)