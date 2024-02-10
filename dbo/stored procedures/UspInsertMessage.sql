-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Inserts a new message.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspInsertMessage]

    @SubjectId INT,
    @ReplyToMessageId INT = NULL,
    @Message MessageTableType READONLY 

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY

        IF(@SubjectId IS NULL)
            BEGIN
                RAISERROR('SubjectId cannot be null.',16,1)
            END

        IF(ISNULL(TRIM((SELECT TOP 1 [Message] FROM @Message)), '') = '' AND (SELECT TOP 1 [IsAttachment] FROM @Message) = 0)
            BEGIN
                RAISERROR('Message cannot be null or blank.',16,1)
            END
        
        -- Messgae insert.
        DECLARE @MessageId INT = NULL
        INSERT INTO
            [dbo].[Message]
        SELECT
            [Message],
            [IsAttachment],
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

        IF(@ReplyToMessageId IS NOT NULL AND @ReplyToMessageId > 0)
            BEGIN
                INSERT INTO
                    [dbo].[MessageReply]
                SELECT
                    @MessageId,
                    @ReplyToMessageId,
                    (SELECT TOP 1 [Message] FROM [dbo].[Message] WHERE [MessageId] = @ReplyToMessageId)
            END

        -- Return posted message.
        SELECT
            m.[MessageId],
            m.[Message],
            m.[IsAttachment],
            m.[CreatedBy],
            m.[CreatedAt],
            m.[Viewed],
            mr.[ReplyToMessageId],
            mr.[ReplyToMessage]
        FROM
            [dbo].[Message] m
            LEFT JOIN [dbo].[MessageReply] mr
                ON m.[MessageId] = mr.[MessageId]
        WHERE
            m.[MessageId] = @MessageId

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END