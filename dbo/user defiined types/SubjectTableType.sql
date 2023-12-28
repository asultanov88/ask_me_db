CREATE TYPE [SubjectTableType] AS TABLE
(
	[SubjectId]		INT,
	[ProviderId]	INT NOT NULL,
	[ClientId]		INT NOT NULL,
	[Title]			NVARCHAR(255) NOT NULL,
	[Deleted]		BIT
)
