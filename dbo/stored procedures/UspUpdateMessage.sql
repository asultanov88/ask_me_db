-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Updates message.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspUpdateMessage]

    @MessageId INT,
    @Message NVARCHAR(1000)

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY
              
        IF(@MessageId IS NULL)
            BEGIN
                RAISERROR('MessageId cannot be null.',16,1)
            END

        IF(NULLIF(TRIM(@Message),'') IS NULL)
            BEGIN
                RAISERROR('Message cannot be null or blank.',16,1)
            END

        -- Insert into message history.
        INSERT INTO
            [dbo].[MessageHistory]
        SELECT
            [MessageId],
            [Message],
            SYSUTCDATETIME()
        FROM
            [dbo].[Message]
        WHERE
            [MessageId] = @MessageId

        -- Update the message.
        UPDATE
            [dbo].[Message]
        SET
            [Message] = @Message,
            [LastUpdatedAt] = SYSUTCDATETIME()
        WHERE
            [MessageId] = @MessageId

        -- Return user ids.
        SELECT
            cu.[UserId] AS ClientUserId,
            pu.[UserId] AS ProviderUserId
        FROM
            [dbo].[Message] m
            JOIN [dbo].[SubjectMessage] sm
                ON m.[MessageId] = sm.[MessageId]
            JOIN [dbo].[Subject] s
                ON s.[SubjectId] = sm.[SubjectId]
            JOIN [dbo].[ClientProvider] cp
                ON cp.[ClientProviderId] = s.[ClientProviderId]
            JOIN [dbo].[ClientUser] cu
                ON cp.[ClientId] = cu.[ClientId]
            JOIN [dbo].[ProviderUser] pu
                ON cp.[ProviderId] = pu.[ProviderId]
        WHERE
            m.[MessageId] = @MessageId

    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END