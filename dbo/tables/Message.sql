CREATE TABLE [dbo].[Message]
(
	[MessageId]		INT IDENTITY(1000,1) NOT NULL,
	[Message]		NVARCHAR(1000) NOT NULL,
	[IsAttachment]	BIT	DEFAULT(0) NOT NULL,
	[CreatedBy]		INT	NOT NULL,
	[CreatedAt]		DATETIME2 NOT NULL,
	[Viewed]		BIT DEFAULT(0) NOT NULL,
	CONSTRAINT [MessageId] PRIMARY KEY CLUSTERED ([MessageId] ASC),
	CONSTRAINT [FK_Message_CreatedBy] FOREIGN KEY ([CreatedBy]) REFERENCES [dbo].[User]([UserId]),
)
