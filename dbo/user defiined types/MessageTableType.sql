CREATE TYPE [MessageTableType] AS TABLE
(
	[MessageId]		INT NULL,
	[Message]		NVARCHAR(1000) NULL,
	[IsAttachment]	BIT DEFAULT(0) NOT NULL,
	[CreatedBy]		INT	NOT NULL,
	[CreatedAt]		DATETIME2 NULL,
	[LastUpdatedAt] DATETIME2 NULL,
	[Viewed]		BIT NULL
)
