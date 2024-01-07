-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Gets LkWorkDay table lookup values.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspGetMyProviders]

    @ClientId INT

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY
        IF(@ClientId IS NULL OR @ClientId = 0)
            BEGIN
                RAISERROR('Invalid ClientId was supllied.',16,1)
            END

        SELECT
            cp.[ClientProviderId],
            pu.[ProviderId],
            u.[UserId] AS ProviderUserId,
            u.[FirstName],
            u.[LastName],
            u.[Email],
            pd.[CompanyName],
            pd.[Address],
            pd.[PhoneNumber],
            pd.[Description],
            CAST(COUNT(m.[MessageId]) AS BIT) AS NewMessage
        FROM
            [dbo].[ClientProvider] cp
            JOIN [ProviderUser] pu
                ON cp.[ProviderId] = pu.[ProviderId]
            JOIN [User] u
                ON pu.[UserId] = u.[UserId]
            JOIN [ProviderDetails] pd
                ON cp.ProviderId = pd.[ProviderId]
            LEFT JOIN [Subject] s
                ON cp.[ClientProviderId] = s.[ClientProviderId]
            LEFT JOIN [SubjectMessage] sm
                ON s.[SubjectId] = sm.[SubjectId]
            LEFT JOIN [Message] m
                ON sm.[MessageId] = m.[MessageId]
                AND m.[Viewed] = 0
        WHERE
            cp.[ClientId] = @ClientId
        GROUP BY
            cp.[ClientProviderId],
            pu.[ProviderId],
            u.[UserId],
            u.[FirstName],
            u.[LastName],
            u.[Email],
            pd.[CompanyName],
            pd.[Address],
            pd.[PhoneNumber],
            pd.[Description]

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END