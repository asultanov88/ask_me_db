-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Provider search by parameters.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspGetProviderSearch]

@LkCategoryId INT NULL,
@SearchKeyword NVARCHAR(255)

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY       
        IF(@LkCategoryId IS NULL AND (@SearchKeyword IS NULL OR @SearchKeyword = ''))
            BEGIN
                RAISERROR('Provider search parameters are not provided.', 16, 1)
            END

        IF(TRIM(@SearchKeyword) = '')
            BEGIN
                SET @SearchKeyword = NULL
            END

        IF(@SearchKeyword IS NOT NULL)
            BEGIN
                SET @SearchKeyword = CONCAT('%',@SearchKeyword,'%')
            END

        SELECT DISTINCT
            pu.[ProviderId],
            u.[FirstName],
            u.[LastName],
            u.[Email],
            pd.[CompanyName],
            pd.[Description],
            pd.[PhoneNumber],
            u.[UserId] AS ProviderUserId
        FROM
            [dbo].[ProviderUser] pu
            JOIN [User] u
                ON pu.[UserId] = u.[UserId]
            JOIN [ProviderDetails] pd
                ON pu.[ProviderId] = pd.[ProviderId]
            LEFT JOIN [ProviderCategory] pc
                ON pu.[ProviderId] = pc.[ProviderId]				
        WHERE
			(pc.[LkCategoryId] = @LkCategoryId OR @LkCategoryId IS NULL)
			AND (
				    (
                        u.[FirstName] LIKE @SearchKeyword					   
				        OR u.[LastName] LIKE @SearchKeyword
				        OR pd.[CompanyName] LIKE @SearchKeyword
				        OR pd.[Description] LIKE @SearchKeyword
				        OR pd.[PhoneNumber] LIKE @SearchKeyword
				    ) OR @SearchKeyword IS NULL
			    )

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END