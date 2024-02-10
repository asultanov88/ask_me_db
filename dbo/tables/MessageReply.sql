CREATE TABLE [dbo].[MessageReply]
(
	[MessageReplyId]	INT IDENTITY(1000,1) NOT NULL,
	[MessageId]			INT NOT NULL,
	[ReplyToMessageId]	INT	NOT NULL,
	[ReplyToMessage]	NVARCHAR(MAX) NULL,
	CONSTRAINT [MessageReplyId] PRIMARY KEY CLUSTERED ([MessageReplyId] ASC),
	CONSTRAINT [FK_MessageReply_MessageId] FOREIGN KEY ([MessageId]) REFERENCES [dbo].[Message]([MessageId]),
	CONSTRAINT [FK_MessageReply_ReplyToMessageId] FOREIGN KEY (ReplyToMessageId) REFERENCES [dbo].[Message]([MessageId]),
	CONSTRAINT UQ_MessageReply UNIQUE([MessageId])
)
