-- DML Triggers
CREATE TRIGGER EmployeeSickHours ON [HumanResources].[Employee] FOR UPDATE --, DELETE, INSERT
AS
BEGIN
	-- DELETED => Données enlevées de la BDD
	-- INSERTED => Nouvelles données
	If  IS_SRVROLEMEMBER('sysadmin') =0
	BEGIN
		-- IF UPDATE([SickLeaveHours])
		DECLARE @oldValue SMALLINT =(SELECT [SickLeaveHours] FROM DELETED)
		DECLARE @newValue SMALLINT =(SELECT [SickLeaveHours] FROM INSERTED)
		IF @oldValue>@newValue
		BEGIN

			ROLLBACK
		    

		END
	END
END

SELECT TOP 1 * INTO HumanResources.EmployeesHisto FROM [HumanResources].[Employee]
SELECT SUSER_SNAME()
