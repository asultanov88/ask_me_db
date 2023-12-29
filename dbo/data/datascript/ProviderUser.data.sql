DECLARE @DataScriptNameProviderUser NVARCHAR(255) = 'ProviderUser',
		@DataScriptVersionProviderUser NVARCHAR(255) = '1.0.0'
		
DECLARE @ExecutionExistsProviderUser BIT = [dbo].[GetDataScriptVersion](@DataScriptNameProviderUser, @DataScriptVersionProviderUser)

IF(@ExecutionExistsProviderUser <> 1)
	BEGIN

		SET IDENTITY_INSERT [dbo].[ProviderUser] ON

		INSERT INTO	[dbo].[ProviderUser]
			([ProviderId], [UserId])
		VALUES
			 (1, 2)
	
		SET IDENTITY_INSERT [dbo].[ProviderUser] OFF

		INSERT INTO [dbo].[DataScriptVersion]
		([Name], [Version])
		SELECT @DataScriptNameProviderUser, @DataScriptVersionProviderUser

	END



