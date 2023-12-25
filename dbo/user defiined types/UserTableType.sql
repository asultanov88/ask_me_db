CREATE TYPE [UserTableType] AS TABLE
(
	[UserId]		INT,
	[FirstName]		NVARCHAR(255),
	[LastName]		NVARCHAR(255),
	[Email]			NVARCHAR(255),
	[Password]		NVARCHAR(MAX),
	[CreatedAt]		DATETIME2,
	[Inactive]		BIT,
	[IsClient]		BIT,
	[IsProvider]	BIT
)
