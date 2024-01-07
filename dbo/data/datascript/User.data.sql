DECLARE @DataScriptNameUser NVARCHAR(255) = 'User',
		@DataScriptVersionUser NVARCHAR(255) = '1.0.0'
		
DECLARE @ExecutionExistsUser BIT = [dbo].[GetDataScriptVersion](@DataScriptNameUser, @DataScriptVersionUser)

IF(@ExecutionExistsUser <> 1)
	BEGIN

		SET IDENTITY_INSERT [dbo].[User] ON

		INSERT INTO	[dbo].[User]
			([UserId], [FirstName], [LastName], [Email], [Password], [CreatedAt], [Inactive], [IsClient], [IsProvider])
		VALUES
			 (1, 'ClientUserFirstName', 'ClientUserLastName', 'clientuser@email.com', '$2b$10$SQ3Ip7YOqNL/p6nCRXgEeu70Z4OxvWHx9Z1XpVgwskBmYR0CIuS0m', SYSUTCDATETIME(), 0, 1, 0)
			,(2, 'ProviderUserFirstName', 'ProviderUserLastName', 'provideruser@email.com', '$2b$10$SQ3Ip7YOqNL/p6nCRXgEeu70Z4OxvWHx9Z1XpVgwskBmYR0CIuS0m', SYSUTCDATETIME(), 0, 0, 1)
			,(3, '2 - ProviderUserFirstName', '2 - ProviderUserLastName', '2provideruser@email.com', '$2b$10$SQ3Ip7YOqNL/p6nCRXgEeu70Z4OxvWHx9Z1XpVgwskBmYR0CIuS0m', SYSUTCDATETIME(), 0, 0, 1)
			,(4, '2 - ClientUserFirstName', '2 - ClientUserLastName', '2clientuser@email.com', '$2b$10$SQ3Ip7YOqNL/p6nCRXgEeu70Z4OxvWHx9Z1XpVgwskBmYR0CIuS0m', SYSUTCDATETIME(), 0, 1, 0)

		SET IDENTITY_INSERT [dbo].[User] OFF

		INSERT INTO [dbo].[DataScriptVersion]
		([Name], [Version])
		SELECT @DataScriptNameUser, @DataScriptVersionUser

	END




