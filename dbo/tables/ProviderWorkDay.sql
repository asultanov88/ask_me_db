CREATE TABLE [dbo].[ProviderWorkDay]
(
	[ProviderWorkDayId] INT IDENTITY(1000, 1) NOT NULL,
	[ProviderId]		INT NOT NULL,
	[LkWeekDayId]		INT NOT NULL,
	CONSTRAINT [ProviderWorkDayId] PRIMARY KEY CLUSTERED ([ProviderWorkDayId] ASC),
	CONSTRAINT [FK_ProviderWorkDay_ProviderId] FOREIGN KEY ([ProviderId]) REFERENCES [dbo].[ProviderUser]([ProviderId]),
	CONSTRAINT [Fk_ProviderWorkDay_LkWeekDayId] FOREIGN KEY ([LkWeekDayId]) REFERENCES [dbo].[LkWeekDay]([LkWeekDayId]),
)
