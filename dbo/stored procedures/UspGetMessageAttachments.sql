-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Gets message attachments.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspGetMessageAttachments]

    @MessageIds PkTableType READONLY

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY
        
        SELECT
            ma.[MessageAttachmentId],
            ma.[MessageId],
            ma.[OriginalName],
            ma.[Uuid],
            ma.[S3Key],
            ma.[S3Bucket],
            ma.[Location],
            ath.[AttachmentThumbnailId]
        FROM
            [dbo].[MessageAttachment] ma
            JOIN [dbo].[Message] m
                ON ma.[MessageId] = m.[MessageId]
            JOIN @MessageIds mi
                ON m.[MessageId] = mi.[Pk]
            LEFT JOIN [dbo].[AttachmentThumbnail] ath
                ON ma.[MessageAttachmentId] = ath.[MessageAttachmentId]

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END