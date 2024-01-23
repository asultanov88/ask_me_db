-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Inserts attachment thumbnail.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UpsInsertAttachmentThumbnail]

    @AttachmentThumbnail AttachmentThumbnailTableType READONLY

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY

        DECLARE @AttachmentThumbnailId INT = NULL

        INSERT INTO
            [dbo].[AttachmentThumbnail]
        SELECT
            [MessageAttachmentId],
            [MimeType],
            [Uuid],
            [S3Key],
            [S3Bucket],
            [Location]
        FROM
            @AttachmentThumbnail

        SET @AttachmentThumbnailId = SCOPE_IDENTITY()

        -- Return saved data.
        SELECT
            [AttachmentThumbnailId],
            [MimeType],
            [MessageAttachmentId],
            [Uuid],
            [S3Key],
            [S3Bucket],
            [Location]
        FROM
            [dbo].[AttachmentThumbnail]
        WHERE
            [AttachmentThumbnailId] = @AttachmentThumbnailId

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END