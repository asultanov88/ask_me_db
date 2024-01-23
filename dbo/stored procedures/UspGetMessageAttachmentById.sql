-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Gets message attachment by id.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspGetMessageAttachmentById]

    @MessageAttachmentId INT,
    @ClientId INT,
    @ProviderId INT

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
            ma.[Location]
        FROM
            [dbo].[MessageAttachment] ma
            JOIN [dbo].[Message] m
                ON ma.[MessageId] = m.[MessageId]
            JOIN [dbo].[SubjectMessage] sm
                ON sm.[MessageId] = m.[MessageId]
            JOIN [dbo].[Subject] s
                ON s.[SubjectId] = sm.[SubjectId]
            JOIN [dbo].[ClientProvider] cp
                ON cp.[ClientProviderId] = s.[ClientProviderId]                      
        WHERE
            ma.[MessageAttachmentId] = @MessageAttachmentId
            AND (cp.[ClientId] = @ClientId OR @ClientId IS NULL)
            AND (cp.[ProviderId] = @ProviderId OR @ProviderId IS NULL)

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END