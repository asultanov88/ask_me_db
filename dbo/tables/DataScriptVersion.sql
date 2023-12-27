CREATE TABLE [dbo].[DataScriptVersion]
(
	[DataScriptVersionId]	INT IDENTITY(1000, 1) NOT NULL,
	[Name]					NVARCHAR(255) NOT NULL,
	[Version]				NVARCHAR(255) NOT NULL,
	CONSTRAINT [DataScriptVersionId] PRIMARY KEY CLUSTERED ([DataScriptVersionId] ASC)
)
