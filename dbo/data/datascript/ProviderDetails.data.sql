DECLARE @DataScriptNameProviderDetails NVARCHAR(255) = 'ProviderDetails',
		@DataScriptVersionProviderDetails NVARCHAR(255) = '1.0.0'
		
DECLARE @ExecutionExistsProviderDetails BIT = [dbo].[GetDataScriptVersion](@DataScriptNameProviderDetails, @DataScriptVersionProviderDetails)

IF(@ExecutionExistsProviderDetails <> 1)
	BEGIN

		SET IDENTITY_INSERT [dbo].[ProviderDetails] ON

		INSERT INTO	[dbo].[ProviderDetails]
			([ProviderDetailsId], [ProviderId], [CompanyName], [Address], [PhoneNumber], [Description])
		VALUES
			 (1,
			  1,
			  'Test Company Name',
			  '123 Happy Street,  FL, 33410',
			  '(561)777-7777',
			  'We can help you manage your finances.'				
			 ),
			 (2,
			  2,
			  '2 - Test Company Name',
			  '222 Happy Street,  FL, 33410',
			  '(561)222-2222',
			  'We can help you build your home.'				
			 )
	
		SET IDENTITY_INSERT [dbo].[ProviderDetails] OFF

		INSERT INTO [dbo].[DataScriptVersion]
		([Name], [Version])
		SELECT @DataScriptNameProviderDetails, @DataScriptVersionProviderDetails

	END


