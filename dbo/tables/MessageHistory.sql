CREATE TABLE [dbo].[MessageHistory]
(
	[MessageHistoryId]		INT IDENTITY(1000,1) NOT NULL,
	[MessageId]				INT NOT NULL,
	[Message]				NVARCHAR(1000) NULL,
	[CreatedAt]				DATETIME2 NOT NULL,
	CONSTRAINT [MessageHistoryId] PRIMARY KEY CLUSTERED ([MessageHistoryId] ASC),
	CONSTRAINT [FK_MessageHistory_MessageId] FOREIGN KEY ([MessageId]) REFERENCES [dbo].[Message]([MessageId])
)
