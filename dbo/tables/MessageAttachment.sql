CREATE TABLE [dbo].[MessageAttachment]
(
	[MessageAttachmentId]	INT IDENTITY(1000,1) NOT NULL,
	[MessageId]				INT				NOT NULL,
	[OriginalName]			NVARCHAR(255)	NOT NULL,
	[MimeType]				NVARCHAR(255)	NOT NULL,
	[Uuid]					NVARCHAR(255)	NOT NULL,
	[S3Key]					NVARCHAR(1000)	NOT NULL,
	[S3Bucket]				NVARCHAR(1000)	NOT NULL,
	[Location]				NVARCHAR(1000)	NOT NULL,
	CONSTRAINT [MessageAttachmentId] PRIMARY KEY CLUSTERED ([MessageAttachmentId] ASC),
	CONSTRAINT [FK_MessageAttachment_MessageId] FOREIGN KEY ([MessageId]) REFERENCES [dbo].[Message]([MessageId]),
)
