-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Gets message history.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspGetMessageHistory]

    @MessageIds PkTableType READONLY

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY
              
        SELECT
            mh.[MessageHistoryId],
            mh.[MessageId],
            mh.[Message],
            mh.[CreatedAt]
        FROM
            [dbo].[MessageHistory] mh
            JOIN @MessageIds mids
                ON mh.[MessageId] = mids.[Pk]
                AND mh.[Message] IS NOT NULL
        ORDER BY
            mh.[MessageHistoryId] DESC

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END