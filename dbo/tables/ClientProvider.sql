CREATE TABLE [dbo].[ClientProvider]
(
	[ClientProviderId]	INT IDENTITY(1000, 1) NOT NULL,
	[ClientId]			INT NOT NULL,
	[ProviderId]		INT NOT NULL,
	CONSTRAINT [ClientProviderId] PRIMARY KEY CLUSTERED ([ClientProviderId] ASC),
	CONSTRAINT [FK_ClientProvider_ProviderId] FOREIGN KEY ([ProviderId]) REFERENCES [dbo].[ProviderUser]([ProviderId]),
	CONSTRAINT [FK_ClientProvider_ClientId] FOREIGN KEY ([ClientId]) REFERENCES [dbo].[ClientUser]([ClientId]),
	CONSTRAINT UQ_ClientProvider UNIQUE([ClientId],[ProviderId])
)
