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
            NULL,
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

        -- MessageReply insert.
        IF(@ReplyToMessageId IS NOT NULL AND @ReplyToMessageId > 0)
            BEGIN
                INSERT INTO
                    [dbo].[MessageReply]
                SELECT
                    @MessageId,
                    @ReplyToMessageId,
                    m.[Message],
                    m.[CreatedBy],
                    ta.[S3Key],
                    ta.[S3Bucket],
                    ta.[OriginalName]
                FROM
                    [dbo].[Message] m
                    LEFT JOIN (
                        SELECT TOP 1
                            ath.[S3Key],
                            ath.[S3Bucket],
                            ma.[OriginalName],
                            @ReplyToMessageId AS ReplyToMessageId 
                        FROM
                            [dbo].[MessageAttachment] ma
                            JOIN [dbo].[AttachmentThumbnail] ath
                                ON ma.[MessageAttachmentId] = ath.[MessageAttachmentId]
                            WHERE
                                ma.MessageId = @ReplyToMessageId
                            ORDER BY
                                ma.[MessageAttachmentId] ASC
                    ) AS ta
                        ON m.[MessageId] = ta.[ReplyToMessageId]
                WHERE
                    m.[MessageId] = @ReplyToMessageId                    
            END

        -- Return posted message.
        SELECT
            m.[MessageId],
            m.[Message],
            m.[IsAttachment],
            m.[CreatedBy],
            m.[CreatedAt],
            m.[LastUpdatedAt],
            m.[Viewed],
            mr.[ReplyToMessageId],
            mr.[ReplyToMessage],
            mr.[OriginalMessageCreatedBy],
            mr.[ThumbnailS3Key],
            mr.[ThumbnailS3Bucket],
            mr.[AttachmentOriginalName]
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