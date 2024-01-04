-- ====================================================================================================================
-- Author:      A. Sultanov
-- Create Date: 12/04/2023
-- Description: Gets LkCategory table lookup values.
-- Modification History:
-- When             Who                 Description 
-- ------------     ----------------    -------------------------------------------------------------------------------
-- ====================================================================================================================

CREATE PROCEDURE [dbo].[UspGetProviderSubjects]

    @ProviderId INT,
    @ClientId   INT

AS
BEGIN
    SET NOCOUNT, XACT_ABORT ON;
    BEGIN TRY

        DECLARE @ClientProviderId INT = (
            SELECT TOP 1
                [ClientProviderId]
            FROM
                [dbo].[ClientProvider]
            WHERE
                [ProviderId] = @ProviderId
                AND [ClientId] = @ClientId
        )

        IF(@ClientProviderId IS NULL)
            BEGIN
                RAISERROR('Provider is not selected for this client.',16,1)
            END

        IF(@ClientProviderId IS NOT NULL)
            BEGIN

                -- Subject select.
                DROP TABLE IF EXISTS #ClientProviderSubjects
                SELECT 
                    s.[SubjectId],
                    s.[Title]
                INTO 
                    #ClientProviderSubjects
                FROM
                    [dbo].[Subject] s
                WHERE
                    s.[ClientProviderId] = @ClientProviderId
                    AND s.[Deleted] = 0

                -- Message select.
                DROP TABLE IF EXISTS #SubjectMessages
                SELECT
                    m.[MessageId],
                    sm.[SubjectId]
                INTO
                    #SubjectMessages
                FROM
                    [dbo].[Message] m
                    JOIN [SubjectMessage] sm
                        ON m.[MessageId] = sm.[MessageId]
                    JOIN #ClientProviderSubjects cps
                        ON cps.[SubjectId] = sm.[SubjectId]
                WHERE
                    m.[Viewed] = 0

                -- Final select with message count.
                DROP TABLE IF EXISTS #FinalSubjectResult
                CREATE TABLE #FinalSubjectResult
                (
                    [SubjectId] INT,
                    [Title] NVARCHAR(MAX),
                    [NewMessageCount] INT
                )

			    DECLARE @SubjectId INT = NULL
                WHILE ((SELECT COUNT(1) FROM #ClientProviderSubjects) > 0)
                    BEGIN

                        SET @SubjectId = (SELECT TOP 1 [SubjectId] FROM #ClientProviderSubjects)

                        INSERT INTO #FinalSubjectResult
							([SubjectId],[Title],[NewMessageCount])                           
                        VALUES
							(
								@SubjectId,
								(SELECT [Title] FROM #ClientProviderSubjects WHERE [SubjectId] = @SubjectId),
								(SELECT COUNT(1) FROM #SubjectMessages WHERE [SubjectId] = @SubjectId)
							)                         
                            
                        DELETE #ClientProviderSubjects WHERE [SubjectId] = @SubjectId

                    END

                SELECT
                    [SubjectId],
                    [Title],
                    [NewMessageCount]
                FROM
                    #FinalSubjectResult
                ORDER BY
                    [SubjectId] DESC

            END
    END TRY
    BEGIN CATCH
        THROW
    END CATCH
END