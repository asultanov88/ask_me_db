-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Get user object by email.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspGetUserByEmail]

    @Email NVARCHAR(255)

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY
        SELECT 
            u.[UserId],
            u.[FirstName],
            u.[LastName],
            u.[Email],
            u.[Password],
            u.[CreatedAt],
            u.[IsClient],
            u.[IsProvider],
            cu.[ClientId],
            pu.[ProviderId]
        FROM 
            [dbo].[User] u
            LEFT JOIN [ClientUser] cu
                ON cu.[UserId] = u.[UserId]
            LEFT JOIN [ProviderUser] pu
                ON pu.[UserId] = u.[UserId]
        WHERE
            [Email] = @Email
    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END