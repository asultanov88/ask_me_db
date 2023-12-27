CREATE TABLE [dbo].[ProviderDetails]
(
	[ProviderDetailsId] INT IDENTITY(1000, 1) NOT NULL,
	[ProviderId]		INT NOT NULL,
	[CompanyName]		NVARCHAR(255)	NOT NULL,
	[Address]			NVARCHAR(1000)	NOT NULL,
	[PhoneNumber]		NVARCHAR(50)	NOT NULL,
	[Description]		NVARCHAR(1000)	NOT NULL,
	CONSTRAINT [ProviderDetailsId] PRIMARY KEY CLUSTERED ([ProviderDetailsId] ASC),
	CONSTRAINT [FK_ProviderDetails_ProviderId] FOREIGN KEY ([ProviderId]) REFERENCES [dbo].[ProviderUser]([ProviderId])
)
