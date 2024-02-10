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
    @UserId         INT,
    @IsClient       BIT

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY

        DROP TABLE IF EXISTS #SubjectAccessValidation
        SELECT
            cp.[ClientProviderId],
            cu.[UserId] AS ClientUserId,
            pu.[UserId] AS ProviderUserId
        INTO
            #SubjectAccessValidation
        FROM
            [dbo].[Subject] s
            JOIN [ClientProvider] cp
                ON s.[ClientProviderId] = cp.[ClientProviderId]
            JOIN [ClientUser] cu
                ON cp.[ClientId] = cu.[ClientId]
            JOIN [ProviderUser] pu
                ON pu.[ProviderId] = cp.[ProviderId]
        WHERE
            s.[SubjectId] = @SubjectId

        IF(NOT EXISTS(
            SELECT 
                1
            FROM 
                #SubjectAccessValidation 
            WHERE
                @UserId =
                    CASE @IsClient
                        WHEN 1 THEN [ClientUserId]
                        WHEN 0 THEN [ProviderUserId]
                    END
            ))
            BEGIN
                RAISERROR('Unauthorised subjectId is requested.',16,1)
            END

        DECLARE @OffsetCount INT = @ChunkCount
     
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
            [dbo].[SubjectMessage] sm
            JOIN [Message] m
                ON sm.[MessageId] = m.[MessageId]
            LEFT JOIN [dbo].[MessageReply] mr
                ON m.[MessageId] = mr.[MessageId]
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