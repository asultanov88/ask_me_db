CREATE TABLE [dbo].[SubjectMessage]
(
	[SubjectMessageId]	INT IDENTITY(1000, 1) NOT NULL,
	[SubjectId]			INT NOT NULL,
	[MessageId]			INT NOT NULL,
	CONSTRAINT [SubjectMessageId] PRIMARY KEY CLUSTERED ([SubjectMessageId] ASC),
	CONSTRAINT [FK_SubjectMessage_SubjectId] FOREIGN KEY([SubjectId]) REFERENCES [dbo].[Subject]([SubjectId]),
	CONSTRAINT [FK_SubjectMessage_MessageId] FOREIGN KEY([MessageId]) REFERENCES [dbo].[Message]([MessageId]),
)
