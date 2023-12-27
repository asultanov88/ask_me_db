DECLARE @DataFixNameUserClientProvider NVARCHAR(255) = 'UserClientProviderDatafix',
		@DataFixVersionUserClientProvider NVARCHAR(255) = '1.0.0'
		
DECLARE @ExecutionExistsUserClientProvider BIT = [dbo].[GetDataScriptVersion](@DataFixNameUserClientProvider, @DataFixVersionUserClientProvider)

IF(@ExecutionExistsUserClientProvider <> 1)
	BEGIN

		-- Delete old records.
		DELETE [dbo].[ClientUser] WHERE	UserId<1000
		DELETE [dbo].[ProviderUser] WHERE UserId<1000
		DELETE [dbo].[User] WHERE UserId <1000

		
		INSERT INTO [dbo].[DataScriptVersion]
		([Name], [Version])
		SELECT @DataFixNameUserClientProvider, @DataFixVersionUserClientProvider

	END




