-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Gets provider work days.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspGetProviderWeekDays]

@ProviderId INT

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY        

        SELECT
	        pwd.[LkWeekDayId],
	        lwd.[WeekDay]
        FROM
	        [dbo].[ProviderWorkDay] pwd
	        JOIN [LkWeekDay] lwd
		        ON pwd.[LkWeekDayId] = lwd.[LkWeekDayId]
        WHERE
	        pwd.[ProviderId] = @ProviderId

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END