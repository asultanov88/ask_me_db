-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Inserts provider details.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspInsertProviderDetails]

    @ProviderDetails    ProviderDetailsTableType READONLY,
    @ProviderDays       PkTableType READONLY,
    @ProviderCategory   PkTableType READONLY,
    @ProviderWorkHour   ProviderWorkHourTableType READONLY

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY

        DECLARE @ProviderId INT = (SELECT TOP 1 [ProviderId] FROM @ProviderDetails),
                @ProviderDetailsId INT = NULL

        -- Provider details insert.
        INSERT INTO
            [dbo].[ProviderDetails]
        SELECT
            @ProviderId,
            [CompanyName],
            [Address],
            [PhoneNumber],
            [Description]
        FROM
            @ProviderDetails

        SET @ProviderDetailsId = SCOPE_IDENTITY()

        IF(@ProviderDetailsId IS NOT NULL)
            BEGIN
                -- Provider work days insert.
                INSERT INTO
                    [dbo].[ProviderWorkDay]
                SELECT
                    @ProviderId,
                    [Pk]
                FROM
                    @ProviderDays

                -- Provider work hours insert.
                INSERT INTO
                    [dbo].[ProviderWorkHour]
                SELECT
                    @ProviderId,
                    [FromLkWorkHourId],
                    [ToLkWorkHourId]
                FROM
                    @ProviderWorkHour

                -- Provider category insert.
                INSERT INTO
                    [dbo].[ProviderCategory]
                SELECT
                    @ProviderId,
                    [Pk]
                FROM
                    @ProviderCategory

                -- Insert was successful.
                SELECT CAST(1 AS BIT) AS Success  
            END
        ELSE
            BEGIN
                -- Unable to insert.
                SELECT CAST(0 AS BIT) AS Success  
            END          
        
    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END