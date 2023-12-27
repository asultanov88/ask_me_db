-- Delete old records.
DELETE [dbo].[ProviderUser] WHERE UserId<1000
DELETE [dbo].[ClientUser] WHERE	UserId<1000
DELETE [dbo].[User] WHERE UserId <1000

SET IDENTITY_INSERT [dbo].[User] ON

INSERT INTO	[dbo].[User]
	([UserId], [FirstName], [LastName], [Email], [Password], [CreatedAt], [Inactive], [IsClient], [IsProvider])
VALUES
	 (1, 'ClientUserFirstName', 'ClientUserLastName', 'clientuser@email.com', '$2b$10$SQ3Ip7YOqNL/p6nCRXgEeu70Z4OxvWHx9Z1XpVgwskBmYR0CIuS0m', SYSUTCDATETIME(), 0, 1, 0)
	,(2, 'ProviderUserFirstName', 'ProviderUserLastName', 'provideruser@email.com', '$2b$10$SQ3Ip7YOqNL/p6nCRXgEeu70Z4OxvWHx9Z1XpVgwskBmYR0CIuS0m', SYSUTCDATETIME(), 0, 0, 1)


SET IDENTITY_INSERT [dbo].[User] OFF
