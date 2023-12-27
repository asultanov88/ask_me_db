-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Gets LkWorkHour table lookup values.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspGetLkWorkHours]

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY
        SELECT 
            [LkWorkHourId],
            [WorkHour]
        FROM 
            [dbo].[LkWorkHour]
    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END