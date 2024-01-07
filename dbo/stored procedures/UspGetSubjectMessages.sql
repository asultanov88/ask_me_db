-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Gets subject messages.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspGetSubjectMessages]

    @SubjectId      INT,
    @ChunkCount     INT,
    @ChunkNum       INT,
    @ClientId       INT

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY

        DROP TABLE IF EXISTS #ClientProviderValidation
        SELECT
            cp.[ClientId]
        INTO
            #ClientProviderValidation
        FROM
            [dbo].[Subject] s
            JOIN [ClientProvider] cp
                ON s.[ClientProviderId] = cp.[ClientProviderId]                
        WHERE
            s.[SubjectId] = @SubjectId
            AND cp.[ClientId] = @ClientId

        IF(NOT EXISTS(SELECT 1 FROM #ClientProviderValidation))
            BEGIN
                RAISERROR('Unauthorised subjectId is requested.',16,1)
            END

        DECLARE @OffsetCount INT = @ChunkCount
     
        SELECT
            m.[MessageId],
            m.[Message],
            m.[CreatedBy],
            m.[Viewed]
        FROM
            [dbo].[SubjectMessage] sm
            JOIN [Message] m
                ON sm.[MessageId] = m.[MessageId]
        WHERE
            sm.[SubjectId] = @SubjectId
        ORDER BY m.[MessageId] DESC
        OFFSET (@ChunkCount * (@ChunkNum - 1)) ROWS
        FETCH NEXT @ChunkCount ROWS ONLY

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END