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
            [UserId],
            [FirstName],
            [LastName],
            [Email],
            [Password],
            [CreatedAt]
        FROM 
            [dbo].[User]
        WHERE
            [Email] = @Email
    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END