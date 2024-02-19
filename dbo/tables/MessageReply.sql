CREATE TABLE [dbo].[MessageReply]
(
	[MessageReplyId]			INT IDENTITY(1000,1) NOT NULL,
	[MessageId]					INT NOT NULL,
	[ReplyToMessageId]			INT	NOT NULL,
	[ReplyToMessage]			NVARCHAR(1000) NULL,
	[OriginalMessageCreatedBy]	INT NOT NULL,
	[ThumbnailS3Key]			NVARCHAR(1000) NULL,
	[ThumbnailS3Bucket]			NVARCHAR(1000) NULL,
	[AttachmentOriginalName]	NVARCHAR(1000) NULL,
	CONSTRAINT [MessageReplyId] PRIMARY KEY CLUSTERED ([MessageReplyId] ASC),
	CONSTRAINT [FK_MessageReply_MessageId] FOREIGN KEY ([MessageId]) REFERENCES [dbo].[Message]([MessageId]),
	CONSTRAINT [FK_MessageReply_ReplyToMessageId] FOREIGN KEY ([ReplyToMessageId]) REFERENCES [dbo].[Message]([MessageId]),
	CONSTRAINT [FK_MessageReply_OriginalMessageCreatedBy] FOREIGN KEY ([OriginalMessageCreatedBy]) REFERENCES [dbo].[User]([UserId]),
	CONSTRAINT UQ_MessageReply UNIQUE([MessageId])
)
