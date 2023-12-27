CREATE TABLE [dbo].[ProviderWorkHour]
(
	[ProviderWorkHourId]	INT IDENTITY(1000, 1) NOT NULL,
	[ProviderId]			INT NOT NULL,
	[FromLkWorkHourId]		INT NOT NULL,
	[ToLkWorkHourId]		INT NOT NULL,
	CONSTRAINT UC_ProviderWorkHour UNIQUE(ProviderId),
	CONSTRAINT [ProviderWorkHourId] PRIMARY KEY CLUSTERED ([ProviderWorkHourId] ASC),
	CONSTRAINT [FK_ProviderWorkHour_FromLkWorkHourId] FOREIGN KEY ([FromLkWorkHourId]) REFERENCES [dbo].[LkWorkHour]([LkWorkHourId]),
	CONSTRAINT [FK_ProviderWorkHour_ToLkWorkHourId] FOREIGN KEY ([ToLkWorkHourId]) REFERENCES [dbo].[LkWorkHour]([LkWorkHourId])
)
