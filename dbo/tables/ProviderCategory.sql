CREATE TABLE [dbo].[ProviderCategory]
(
	[ProviderCategoryId]	INT IDENTITY(1000, 1) NOT NULL,
	[ProviderId]			INT NOT NULL,
	[LkCategoryId]			INT NOT NULL,
	CONSTRAINT [ProviderCategoryId] PRIMARY KEY CLUSTERED ([ProviderCategoryId] ASC),
	CONSTRAINT [FK_ProviderCategory_ProviderId] FOREIGN KEY ([ProviderId]) REFERENCES [dbo].[ProviderUser]([ProviderId]),
	CONSTRAINT [FK_ProviderCategory_LkCategoryId] FOREIGN KEY ([LkCategoryId]) REFERENCES [dbo].[LkCategory]([LkCategoryId])
)
