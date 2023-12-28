-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Gets provider service categories.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspGetProviderCategory]

@ProviderId INT

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY   
	
		SELECT
			pc.[LkCategoryId],
			lc.[Name]
		FROM
			[dbo].[ProviderCategory] pc
			JOIN [LkCategory] lc
				ON pc.[LkCategoryId] = lc.[LkCategoryId]
		WHERE
			pc.[ProviderId] = @ProviderId

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END