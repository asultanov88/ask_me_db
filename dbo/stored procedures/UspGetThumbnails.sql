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
            ath.[AttachmentThumbnailId],
            ath.[MessageAttachmentId],
            ath.[MimeType],
            ath.[Uuid],
            IIF(ath.[MimeType] LIKE '%gif%', ma.[S3Key], ath.[S3Key]) AS S3Key,
            IIF(ath.[MimeType] LIKE '%gif%', ma.[S3Bucket], ath.[S3Bucket]) AS S3Bucket,
            ath.[Location]
        FROM
            [dbo].[AttachmentThumbnail] ath
            JOIN [dbo].[MessageAttachment] ma
                ON ath.[MessageAttachmentId] = ma.[MessageAttachmentId]
        WHERE
            [AttachmentThumbnailId] IN (SELECT [Pk] FROM @AttachmentThumbnailIds)

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END