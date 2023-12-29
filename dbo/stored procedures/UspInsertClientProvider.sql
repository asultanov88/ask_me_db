-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Gets new client provider record.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspInsertClientProvider]

    @ClientId   INT NULL,
    @ProviderId INT NULL

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY

        IF(@ClientId IS NULL OR @ProviderId IS NULL)
            BEGIN
                RAISERROR('Both ClientId and ProviderId must be supplied.',16,1)
            END

        IF(EXISTS(SELECT 1 FROM [ClientProvider] WHERE [ClientId] = @ClientId AND [ProviderId] = @ProviderId))
            BEGIN
                RAISERROR('Cannot select the same provider twice.',16,1)
            END
        
        DECLARE @ClientProviderId INT = NULL

        INSERT INTO
            [dbo].[ClientProvider]
        SELECT
            @ClientId,
            @ProviderId

        SET @ClientProviderId = SCOPE_IDENTITY()

        SELECT @ClientProviderId AS ClientProviderId

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END