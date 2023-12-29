-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Inserts a new subject.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspInsertSubject]

    @Subject    SubjectTableType READONLY,
    @ClientId   INT NULL

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY

        IF(@ClientId IS NULL)
            BEGIN
                RAISERROR('ClientId cannot be null.',16,1)
            END

        DECLARE @ValidClientId INT = 
        (SELECT TOP 1 
            cp.[ClientId] 
        FROM 
            @Subject s
            JOIN [ClientProvider] cp
                ON cp.[ClientProviderId] = s.[ClientProviderId])

        IF(@ValidClientId IS NULL OR (@ValidClientId <> @ClientId))
            BEGIN
                RAISERROR('Invalid ClientId.',16,1)
            END

        DECLARE @SubjectId INT = NULL

        INSERT INTO
            [dbo].[Subject]
        SELECT
            [ClientProviderId],
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