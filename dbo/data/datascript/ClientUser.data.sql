DECLARE @DataScriptNameClientUser NVARCHAR(255) = 'ClientUser',
		@DataScriptVersionClientUser NVARCHAR(255) = '1.0.0'
		
DECLARE @ExecutionExistsClientUser BIT = [dbo].[GetDataScriptVersion](@DataScriptNameClientUser, @DataScriptVersionClientUser)

IF(@ExecutionExistsClientUser <> 1)
	BEGIN

		SET IDENTITY_INSERT [dbo].[ClientUser] ON

		INSERT INTO	[dbo].[ClientUser]
			([ClientId], [UserId])
		VALUES
			 (1, 1),
			 (2, 4)
	
		SET IDENTITY_INSERT [dbo].[ClientUser] OFF

		INSERT INTO [dbo].[DataScriptVersion]
		([Name], [Version])
		SELECT @DataScriptNameClientUser, @DataScriptVersionClientUser

	END


