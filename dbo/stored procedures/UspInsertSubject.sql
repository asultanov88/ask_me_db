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

        DECLARE @ClientProviderId INT = NULL,
                @ProviderId INT = (SELECT TOP 1 [ProviderId] FROM @Subject)

        IF(@ClientId IS NULL)
            BEGIN
                RAISERROR('ClientId cannot be null.',16,1)
            END
                
        IF(@ProviderId IS NULL)
            BEGIN
                RAISERROR('ProviderId must be supplied.',16,1)
            END

        -- Check if ClientProviderId exists.
        SET @ClientProviderId = (
            SELECT TOP 1
                [ClientProviderId]
            FROM
                [dbo].[ClientProvider]
            WHERE
                [ClientId] = @ClientId
                AND [ProviderId] = @ProviderId
        )

        -- ClientProviderId not found. Insert a new one.
        IF(@ClientProviderId IS NULL)
            BEGIN
                INSERT INTO
                    [dbo].[ClientProvider]
                SELECT
                    @ClientId,
                    @ProviderId

                SET @ClientProviderId = SCOPE_IDENTITY()
            END

        DECLARE @SubjectId INT = NULL

        INSERT INTO
            [dbo].[Subject]
        SELECT
            @ClientProviderId,
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