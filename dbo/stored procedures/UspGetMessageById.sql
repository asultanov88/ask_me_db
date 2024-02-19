-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Gets message by id.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspGetMessageById]

    @MessageId INT

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY
              
        SELECT
            m.[MessageId],
            m.[Message],
            m.[IsAttachment],
            m.[CreatedBy],
            m.[CreatedAt],
            m.[Viewed],
            sm.[SubjectId],
            mr.[ReplyToMessageId],
            mr.[ReplyToMessage],
            mr.[OriginalMessageCreatedBy],
            mr.[ThumbnailS3Key],
            mr.[ThumbnailS3Bucket],
            mr.[AttachmentOriginalName]
        FROM
            [dbo].[Message] m
            JOIN [dbo].[SubjectMessage] sm
                ON sm.[MessageId] = m.[MessageId]
            LEFT JOIN [dbo].[MessageReply] mr
                ON m.[MessageId] = mr.[MessageId]
        WHERE
            m.[MessageId] = @MessageId

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END