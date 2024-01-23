-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Gets thumbnail objects.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspGetThumbnails]

    @AttachmentThumbnailIds PkTableType READONLY

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY
        
        SELECT
            [AttachmentThumbnailId],
            [MessageAttachmentId],
            [MimeType],
            [Uuid],
            [S3Key],
            [S3Bucket],
            [Location]
        FROM
            [dbo].[AttachmentThumbnail]
        WHERE
            [AttachmentThumbnailId] IN (SELECT [Pk] FROM @AttachmentThumbnailIds)

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END