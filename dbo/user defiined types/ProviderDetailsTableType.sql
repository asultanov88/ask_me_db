CREATE TYPE [ProviderDetailsTableType] AS TABLE
(
	[ProviderDetailsId] INT,
	[ProviderId]		INT NOT NULL,
	[CompanyName]		NVARCHAR(255) NOT NULL,
	[Address]			NVARCHAR(1000) NOT NULL,
	[PhoneNumber]		NVARCHAR(50) NOT NULL,
	[Description]		NVARCHAR(1000) NOT NULL
)
