CREATE TYPE [ProviderWorkHourTableType] AS TABLE
(
	[ProviderWorkHourId]	INT,
	[ProviderId]			INT NOT NULL,
	[FromLkWorkHourId]		INT NOT NULL,
	[ToLkWorkHourId]		INT NOT NULL
)
