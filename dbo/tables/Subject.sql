CREATE TABLE [dbo].[Subject]
(
	[SubjectId]			INT IDENTITY(1000, 1) NOT NULL,
	[ClientProviderId]	INT NOT NULL,
	[Title]				NVARCHAR(255) NOT NULL,
	[Deleted]			BIT DEFAULT(0) NOT NULL,
	CONSTRAINT [SubjectId] PRIMARY KEY CLUSTERED ([SubjectId] ASC),
	CONSTRAINT [FK_Subject_ClientProviderId] FOREIGN KEY ([ClientProviderId]) REFERENCES [dbo].[ClientProvider]([ClientProviderId]),
)
