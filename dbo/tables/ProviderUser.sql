CREATE TABLE [dbo].[ProviderUser]
(
	[ProviderId]	INT IDENTITY(1000, 1) NOT NULL,
	[UserId]		INT NOT NULL,
	CONSTRAINT [ProviderId] PRIMARY KEY CLUSTERED ([ProviderId] ASC),
	CONSTRAINT [FK_ProvidertUser_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[User]([UserId])
)
