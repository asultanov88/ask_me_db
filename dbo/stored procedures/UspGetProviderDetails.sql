-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Gets provider details.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspGetProviderDetails]

@ProviderId INT

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY
        

    DROP TABLE IF EXISTS #providerDetails

	   	SELECT
            pu.[ProviderId],
            u.[UserId] AS ProviderUserId,
            u.[FirstName],
            u.[LastName],
            u.[Email],
		    pd.[CompanyName],
            pd.[Address],
            pd.[PhoneNumber],
            pd.[Description],
            CONCAT
            (
                (SELECT [WorkHour] FROM [dbo].[LkWorkHour] WHERE [LkWorkHourId] = pwh.[FromLkWorkHourId]),
                CASE 
                    WHEN ((SELECT [WorkHour] FROM [dbo].[LkWorkHour] WHERE [LkWorkHourId] = pwh.[ToLkWorkHourId]) IS NOT NULL) THEN N' - '
                    ELSE N''
                END,
                (SELECT [WorkHour] FROM [dbo].[LkWorkHour] WHERE [LkWorkHourId] = pwh.[ToLkWorkHourId])               
            ) AS WorkHours
        FROM
            [dbo].[ProviderDetails] pd
            JOIN [ProviderUser] pu
                ON pu.[ProviderId] = pd.[ProviderId]  
            JOIN [User] u
                ON u.[UserId] = pu.[UserId]
            LEFT JOIN [ProviderWorkHour] pwh
                ON pd.[ProviderId] = pwh.[ProviderId]
		WHERE
			pd.[ProviderId] = @ProviderId

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END