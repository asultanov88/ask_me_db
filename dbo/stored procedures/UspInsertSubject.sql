-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Inserts a new subject.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspInsertSubject]

    @Subject SubjectTableType READONLY

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY

        DECLARE @SubjectId INT = NULL
        
        INSERT INTO
            [dbo].[Subject]
        SELECT
            [ProviderId],
            [ClientId],
            [Title],
            0 AS [Deleted]
        FROM
            @Subject

        SET @SubjectId = SCOPE_IDENTITY()

        SELECT @SubjectId AS SubjectId

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END