-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Gets LkWorkDay table lookup values.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspGetLkWeekkDays]

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY
        SELECT 
            [LkWeekDayId],
            [WeekDay]
        FROM 
            [dbo].[LkWeekDay]

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END