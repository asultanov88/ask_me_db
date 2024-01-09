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

        SELECT TOP 1
            m.[MessageId],
            cu.UserId AS ClientUserId,
            pu.[UserId] AS ProviderUserId
        FROM
            [dbo].[Message] m
            JOIN [SubjectMessage] sm
                ON sm.[MessageId] = m.[MessageId]
            JOIN [Subject] s
                ON s.[SubjectId] = sm.[SubjectId]
            JOIN [ClientProvider] cp
                ON cp.[ClientProviderId] = s.[ClientProviderId]
            JOIN [ClientUser] cu
                ON cu.[ClientId] = cp.[ClientId]
            JOIN [ProviderUser] pu
                ON pu.[ProviderId] = cp.[ProviderId]
        WHERE
            m.[MessageId] = @MessageId

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END