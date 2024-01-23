CREATE TABLE [dbo].[AttachmentThumbnail]
(
	[AttachmentThumbnailId] INT IDENTITY(1000,1) NOT NULL,
	[MessageAttachmentId]	INT NOT NULL,
	[MimeType]				NVARCHAR(MAX) NOT NULL,
	[Uuid]					NVARCHAR(MAX) NOT NULL,
	[S3Key]					NVARCHAR(MAX) NOT NULL,
	[S3Bucket]				NVARCHAR(MAX) NOT NULL,
	[Location]				NVARCHAR(MAX) NOT NULL,
	CONSTRAINT [AttachmentThumbnailId] PRIMARY KEY CLUSTERED ([AttachmentThumbnailId] ASC),
	CONSTRAINT [FK_AttachmentThumbnail_MessageAttachmentId] FOREIGN KEY ([MessageAttachmentId]) REFERENCES [dbo].[MessageAttachment]([MessageAttachmentId])
)
