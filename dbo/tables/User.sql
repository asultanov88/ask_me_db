CREATE TABLE [dbo].[User]
(
	[UserId]		INT				IDENTITY(1000,1) NOT NULL,
	[FirstName]		NVARCHAR(255)	NOT NULL,
	[LastName]		NVARCHAR(255)	NOT NULL,
	[Email]			NVARCHAR(255)	NOT NULL,
	[Password]		NVARCHAR(MAX)	NOT NULL,
	[CreatedAt]		DATETIME2		NOT NULL,
	[Inactive]		BIT				DEFAULT(0) NOT NULL,
	[IsClient]		BIT				NOT NULL,
	[IsProvider]	BIT				NOT NULL,
	CONSTRAINT [UserId] PRIMARY KEY CLUSTERED ([UserId] ASC),
	CONSTRAINT UC_Email UNIQUE(Email),
	CONSTRAINT [IsClient] CHECK (([IsClient] = 0 AND [IsProvider] = 1)
	OR ([IsClient] = 1 AND [IsProvider] = 0))
)
