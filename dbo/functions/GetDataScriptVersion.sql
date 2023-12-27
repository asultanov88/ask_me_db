-- Checks if specific data script/data fix has been executed.
CREATE FUNCTION [dbo].[GetDataScriptVersion]
(
    @DataScriptName     NVARCHAR(255),
    @DataScriptVersion  NVARCHAR(255) 
)
RETURNS BIT
AS BEGIN
    DECLARE @ExecutionExists BIT = 0

    SET @ExecutionExists = 
    (
        SELECT
            CAST(COUNT(1) AS BIT)
        FROM
            [dbo].[DataScriptVersion]
        WHERE
            [Name] = @DataScriptName
            AND [Version] = @DataScriptVersion
    )

    RETURN @ExecutionExists
END