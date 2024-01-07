/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

-- Datafix.
:r .\datafix\UserClientProvider.datafix.sql

-- DataScript.
:r .\datascript\User.data.sql
:r .\datascript\ClientUser.data.sql
:r .\datascript\ProviderUser.data.sql
:r .\datascript\ProviderDetails.data.sql	
:r .\datascript\LkWeekDay.data.sql	
:r .\datascript\LkWorkHour.data.sql	
:r .\datascript\LkCategory.data.sql	

