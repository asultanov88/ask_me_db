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

        SELECT SCOPE_IDENTITY() AS UserId
    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END