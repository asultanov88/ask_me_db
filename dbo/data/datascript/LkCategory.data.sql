DECLARE @DataScriptNameLkCategory NVARCHAR(255) = 'LkCategory',
		@DataScriptVersionLkCategory NVARCHAR(255) = '1.0.0'
		
DECLARE @ExecutionExistsLkCategory BIT = [dbo].[GetDataScriptVersion](@DataScriptNameLkCategory, @DataScriptVersionLkCategory)

IF(@ExecutionExistsLkCategory <> 1)
	BEGIN

		SET IDENTITY_INSERT [dbo].[LkCategory] ON

		INSERT INTO	[dbo].[LkCategory]
			([LkCategoryId], [Name])
		VALUES
			 (1, 'Financial services')
			,(2, 'Insurance')
			,(3, 'Utilities')
			,(4, 'Consulting service')
			,(5, 'Health care')
			,(6, 'Training services')
			,(7, 'Construction services')
			,(8, 'Design')
			,(9, 'Housing')
			,(10, 'Legal services')
			,(11, 'Marketing services')
	
		SET IDENTITY_INSERT [dbo].[LkCategory] OFF

		INSERT INTO [dbo].[DataScriptVersion]
		([Name], [Version])
		SELECT @DataScriptNameLkCategory, @DataScriptVersionLkCategory

	END


