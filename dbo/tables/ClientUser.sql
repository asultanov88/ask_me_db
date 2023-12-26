CREATE TABLE [dbo].[ClientUser]
(
	[ClientId]	INT IDENTITY(1000, 1) NOT NULL,
	[UserId]	INT NOT NULL,
	CONSTRAINT [ClientId] PRIMARY KEY CLUSTERED ([ClientId] ASC),
	CONSTRAINT [FK_ClientUser_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[User]([UserId])
)
