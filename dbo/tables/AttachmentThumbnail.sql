CREATE TABLE [dbo].[AttachmentThumbnail]
(
	[AttachmentThumbnailId] INT IDENTITY(1000,1) NOT NULL,
	[MessageAttachmentId]	INT NOT NULL,
	[MimeType]				NVARCHAR(255) NOT NULL,
	[Uuid]					NVARCHAR(255) NOT NULL,
	[S3Key]					NVARCHAR(1000) NOT NULL,
	[S3Bucket]				NVARCHAR(1000) NOT NULL,
	[Location]				NVARCHAR(1000) NOT NULL,
	CONSTRAINT [AttachmentThumbnailId] PRIMARY KEY CLUSTERED ([AttachmentThumbnailId] ASC),
	CONSTRAINT [FK_AttachmentThumbnail_MessageAttachmentId] FOREIGN KEY ([MessageAttachmentId]) REFERENCES [dbo].[MessageAttachment]([MessageAttachmentId])
)
