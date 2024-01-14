-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Gets LkCategory table lookup values.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspGetClientSubjects]

    @ProviderId INT,
    @ClientId   INT

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY

        DECLARE @ClientProviderId INT = (
            SELECT TOP 1
                [ClientProviderId]
            FROM
                [dbo].[ClientProvider]
            WHERE
                [ProviderId] = @ProviderId
                AND [ClientId] = @ClientId
        )

        DECLARE @ProviderUserId INT = (
			SELECT TOP 1
				pu.[UserId]
			FROM
				[ClientProvider] cp
				JOIN [ProviderUser] pu
					ON cp.[ProviderId] = pu.[ProviderId]
            WHERE
				cp.[ClientProviderId] = @ClientProviderId
		)

        IF(@ClientProviderId IS NULL)
            BEGIN
                RAISERROR('Client is not selected for this provider.',16,1)
            END     

        -- Subject select.
        DROP TABLE IF EXISTS #ClientProviderSubjects
        SELECT 
            s.[SubjectId],
            s.[Title]
        INTO 
            #ClientProviderSubjects
        FROM
            [dbo].[Subject] s
        WHERE
            s.[ClientProviderId] = @ClientProviderId
            AND s.[Deleted] = 0

        -- New Message select.
        DROP TABLE IF EXISTS #SubjectMessages
        SELECT
            m.[MessageId],
            sm.[SubjectId]
        INTO
            #SubjectMessages
        FROM
            [dbo].[Message] m
            JOIN [SubjectMessage] sm
                ON m.[MessageId] = sm.[MessageId]
            JOIN #ClientProviderSubjects cps
                ON cps.[SubjectId] = sm.[SubjectId]
        WHERE
            m.[Viewed] = 0
            AND m.CreatedBy != @ProviderUserId

        -- Final select with message count.
        SELECT 
            cps.[SubjectId],
            cps.[Title],
            COUNT(sm.[SubjectId]) AS NewMessageCount
        FROM 
            #ClientProviderSubjects cps
            LEFT JOIN #SubjectMessages sm 
                ON cps.[SubjectId] = sm.[SubjectId]
        GROUP BY 
            cps.[SubjectId],
			cps.[Title]
        ORDER BY
            cps.[SubjectId] DESC

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END