CREATE TABLE [dbo].[MessageAttachment]
(
	[MessageAttachmentId]	INT IDENTITY(1000,1) NOT NULL,
	[MessageId]				INT NOT NULL,
	[OriginalName]			NVARCHAR(MAX) NOT NULL,
	[Uuid]					NVARCHAR(MAX) NOT NULL,
	[S3Key]					NVARCHAR(MAX) NOT NULL,
	[S3Bucket]				NVARCHAR(MAX) NOT NULL,
	[Location]				NVARCHAR(MAX) NOT NULL,
	CONSTRAINT [MessageAttachmentId] PRIMARY KEY CLUSTERED ([MessageAttachmentId] ASC),
	CONSTRAINT [FK_MessageAttachment_MessageId] FOREIGN KEY ([MessageId]) REFERENCES [dbo].[Message]([MessageId]),
)
