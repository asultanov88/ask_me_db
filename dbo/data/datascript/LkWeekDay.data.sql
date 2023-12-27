DECLARE @DataScriptNameLkWekkDay NVARCHAR(255) = 'LkWeekDay',
		@DataScriptVersionLkWeekDay NVARCHAR(255) = '1.0.0'
		
DECLARE @ExecutionExistsLkWeekDay BIT = [dbo].[GetDataScriptVersion](@DataScriptNameLkWekkDay, @DataScriptVersionLkWeekDay)

IF(@ExecutionExistsLkWeekDay <> 1)
	BEGIN

		SET IDENTITY_INSERT [dbo].[LkWeekDay] ON

		INSERT INTO	[dbo].[LkWeekDay]
			([LkWeekDayId], [WeekDay])
		VALUES
			 (1, 'Monday')
			,(2, 'Tuesday')
			,(3, 'Wednesday')
			,(4, 'Thursday')
			,(5, 'Friday')
			,(6, 'Saturday')
			,(7, 'Sunday')

		SET IDENTITY_INSERT [dbo].[LkWeekDay] OFF

		INSERT INTO [dbo].[DataScriptVersion]
		([Name], [Version])
		SELECT @DataScriptNameLkWekkDay, @DataScriptVersionLkWeekDay

	END


