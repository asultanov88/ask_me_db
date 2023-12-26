-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Inserts new user.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspInsertUser]

    @User UserTableType READONLY

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY
        DECLARE @UserId INT = NULL

        INSERT INTO
            [User]
        SELECT
            [FirstName],
            [LastName],
            [Email],
            [Password],
            SYSUTCDATETIME() AS CreatedAt,
            0 AS Inactive,
            [IsClient],
            [IsProvider]
        FROM
            @User

        SET @UserId = SCOPE_IDENTITY()

        -- Insert into [ClientUser]
        IF((SELECT TOP 1 [IsClient] FROM @User) = 1)
            BEGIN
                INSERT INTO [dbo].[ClientUser]
                SELECT @UserId
            END

        -- Insert into [ProviderUser]
        IF((SELECT TOP 1 [IsProvider] FROM @User) = 1)
            BEGIN
                INSERT INTO [dbo].[ProviderUser]
                SELECT @UserId
            END

        SELECT @UserId AS UserId

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END