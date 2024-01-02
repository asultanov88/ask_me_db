CREATE TYPE [SubjectTableType] AS TABLE
(
	[SubjectId]				INT,
	[ClientProviderId]		INT NULL,
	[ProviderId]			INT NULL,
	[Title]					NVARCHAR(255) NOT NULL,
	[Deleted]				BIT
)
