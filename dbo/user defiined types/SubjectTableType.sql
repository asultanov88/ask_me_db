CREATE TYPE [SubjectTableType] AS TABLE
(
	[SubjectId]		INT,
	[ClientProviderId]	INT NOT NULL,
	[Title]			NVARCHAR(255) NOT NULL,
	[Deleted]		BIT
)
