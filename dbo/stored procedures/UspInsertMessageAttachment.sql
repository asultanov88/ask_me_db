-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Inserts message attachments.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspInsertMessageAttachment]

    @MessageAttachment MessageAttachmentTableType READONLY

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY

        DECLARE @MessageAttachmentId INT = NULL

        INSERT INTO
            [dbo].[MessageAttachment]
        SELECT
            [MessageId],
            [OriginalName],
            [MimeType],
            [Uuid],
            [S3Key],
            [S3Bucket],
            [Location]
        FROM
            @MessageAttachment

        SET @MessageAttachmentId = SCOPE_IDENTITY()

        SELECT
            [MessageAttachmentId],
            [MessageId],
            [OriginalName],
            [MimeType],
            [Uuid],
            [S3Key],
            [S3Bucket],
            [Location]
        FROM
            [dbo].[MessageAttachment]
        WHERE
            [MessageAttachmentId] = @MessageAttachmentId

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END