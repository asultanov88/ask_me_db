CREATE TABLE [dbo].[Subject]
(
	[SubjectId]		INT IDENTITY(1000, 1) NOT NULL,
	[ProviderId]	INT NOT NULL,
	[ClientId]		INT NOT NULL,
	[Title]			NVARCHAR(255) NOT NULL,
	[Deleted]		BIT DEFAULT(0) NOT NULL,
	CONSTRAINT [SubjectId] PRIMARY KEY CLUSTERED ([SubjectId] ASC),
	CONSTRAINT [FK_Subject_ProviderId] FOREIGN KEY ([ProviderId]) REFERENCES [dbo].[ProviderUser]([ProviderId]),
	CONSTRAINT [FK_Subject_ClientId] FOREIGN KEY ([ClientId])	REFERENCES [dbo].[ClientUser]([ClientId]),
)
