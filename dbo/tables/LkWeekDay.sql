﻿CREATE TABLE [dbo].[LkWeekDay]
(
	[LkWeekDayId]		INT IDENTITY(1000,1) NOT NULL,
	[WeekDay]		NVARCHAR(100),
	CONSTRAINT [LkWeekDayId] PRIMARY KEY CLUSTERED ([LkWeekDayId] ASC),
)
