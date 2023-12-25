-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Gets All Providers
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspGetAllProviders]

    @Providers ProviderTableType READONLY,
    @Providers2 ProviderTableType READONLY,
    @PractitionerId INT

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY
        SELECT * FROM [dbo].[Provider]
    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END