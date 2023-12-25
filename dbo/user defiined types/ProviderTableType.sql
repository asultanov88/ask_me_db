CREATE TYPE [ProviderTableType] AS TABLE
( 
	[ProviderId]	INT				NULL,
	[FirstName]		NVARCHAR(255)	NOT NULL,
	[LastName]		NVARCHAR(255)	NOT NULL,
	[CreatedAt]		DATETIME2		NOT NULL
)