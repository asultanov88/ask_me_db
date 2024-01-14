-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Gets LkCategory table lookup values.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspInsertMessage]

    @SubjectId INT,
    @Message MessageTableType READONLY 

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY

        IF(@SubjectId IS NULL)
            BEGIN
                RAISERROR('SubjectId cannot be null.',16,1)
            END

        IF(ISNULL(TRIM((SELECT TOP 1 [Message] FROM @Message)), '') = '')
            BEGIN
                RAISERROR('Message cannot be null or blank.',16,1)
            END
        
        -- Messgae insert.
        DECLARE @MessageId INT = NULL
        INSERT INTO
            [dbo].[Message]
        SELECT
            [Message],
            [CreatedBy],
            SYSUTCDATETIME(),
            0 -- Not viewed.
        FROM
            @Message

        SET @MessageId = SCOPE_IDENTITY()

        -- Subject Message insert.
        INSERT INTO
            [dbo].[SubjectMessage]
        SELECT
            @SubjectId,
            @MessageId

        -- Return posted message.
        SELECT
            [MessageId],
            [Message],
            [CreatedBy],
            [CreatedAt],
            [Viewed]
        FROM
            [dbo].[Message]
        WHERE
            [MessageId] = @MessageId

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END