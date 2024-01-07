-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Inserts a new subject.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspGetProviderClients]

    @ProviderId INT

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY

        DECLARE @ProviderUserId INT = (
            SELECT TOP 1
                u.[UserId]
            FROM
                [dbo].[ClientProvider] cp
                JOIN [ProviderUser] pu
                    ON cp.[ProviderId] = pu.[ProviderId]
                JOIN [User] u
                    ON pu.[UserId] = u.[UserId]
            WHERE
                cp.ProviderId = @ProviderId
        )

        SELECT DISTINCT
            cp.[ClientId],
            u.[UserId] AS ClientUserId,
            u.[FirstName],
            u.[LastName],
            u.[Email],
            CAST(COUNT(m.[MessageId]) AS BIT) AS NewMessage
        FROM
            [dbo].[ClientProvider] cp
            JOIN [ClientUser] cu
                ON cp.[ClientId] = cu.[ClientId]
            JOIN [User] u
                ON cu.[UserId] = u.[UserId]
            LEFT JOIN [Subject] s
                ON cp.[ClientProviderId] = s.[ClientProviderId]
            LEFT JOIN [SubjectMessage] sm
                ON s.[SubjectId] = sm.[SubjectId]
            LEFT JOIN [Message] m
                ON sm.[MessageId] = m.[MessageId]
                AND m.[Viewed] = 0
                AND m.[CreatedBy] != @ProviderUserId
        WHERE
            cp.[ProviderId] = @ProviderId
        GROUP BY
            cp.[ClientId],
            u.[UserId],
            u.[FirstName],
            u.[LastName],
            u.[Email]

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END