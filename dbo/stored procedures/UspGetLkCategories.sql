-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Gets LkCategory table lookup values.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspGetLkCategories]

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY
        SELECT 
            [LkCategoryId],
            [Name]
        FROM 
            [dbo].[LkCategory]

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END