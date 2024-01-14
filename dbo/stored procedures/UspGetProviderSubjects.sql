-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Gets LkCategory table lookup values.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspGetProviderSubjects]

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

		DECLARE @ClientUserId INT = (
			SELECT
				cu.[UserId]
			FROM
				[ClientProvider] cp
				JOIN [ClientUser] cu
					ON cp.[ClientId] = cu.[ClientId]
            WHERE
				cp.[ClientProviderId] = @ClientProviderId
		)

        IF(@ClientProviderId IS NULL)
            BEGIN
                RAISERROR('Provider is not selected for this client.',16,1)
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
			AND m.CreatedBy != @ClientUserId

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