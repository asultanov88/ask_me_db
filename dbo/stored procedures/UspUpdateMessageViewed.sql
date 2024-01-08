-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Updates message as viewed.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspUpdateMessageViewed]

    @MessageId  INT

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY
        
        UPDATE
            [dbo].[Message]
        SET
            [Viewed] = 1
        WHERE
            [MessageId] = @MessageId

        IF @@ROWCOUNT = 0
            BEGIN
                DECLARE @Error NVARCHAR(MAX) = 'Unable to update message by messageId: ' +@MessageId+ ' as viewed.'
                RAISERROR(@Error,16,1)
            END

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END