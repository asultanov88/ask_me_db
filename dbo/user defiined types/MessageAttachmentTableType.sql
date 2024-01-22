CREATE TYPE [MessageAttachmentTableType] AS TABLE
(
	[MessageAttachmentId]	INT NULL,
	[MessageId]				INT NOT NULL,
	[OriginalName]			NVARCHAR(MAX) NOT NULL,
	[Uuid]					NVARCHAR(MAX) NOT NULL,
	[S3Key]					NVARCHAR(MAX) NOT NULL,
	[S3Bucket]				NVARCHAR(MAX) NOT NULL,
	[Location]				NVARCHAR(MAX) NOT NULL
)
