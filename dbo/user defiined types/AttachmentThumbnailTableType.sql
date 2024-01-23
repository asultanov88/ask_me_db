CREATE TYPE [AttachmentThumbnailTableType] AS TABLE
(
	[AttachmentThumbnailId] INT NULL,
	[MessageAttachmentId]	INT NULL,
	[MimeType]				NVARCHAR(MAX) NULL,
	[Uuid]					NVARCHAR(MAX) NULL,
	[S3Key]					NVARCHAR(MAX) NULL,
	[S3Bucket]				NVARCHAR(MAX) NULL,
	[Location]				NVARCHAR(MAX) NULL
)
