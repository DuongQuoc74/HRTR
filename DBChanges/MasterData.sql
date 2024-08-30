IF NOT EXISTS (SELECT 1 FROM [SC_Menu] WHERE MenuName = N'Employee Document Mapping')
BEGIN
	insert into [dbo].[SC_Menu] (MenuID, MenuName, MenuPath, FileName, Description, ParentID, PermissionRoleID, IsActive, LastUpdated, LastUpdatedBy)
	values (915, N'Employee Document Mapping', N'~/TR/EmployeeDocumentMapping.aspx', N'EmployeeDocumentMapping.aspx','',4,10,1,NULL,NULL) 
END

IF NOT EXISTS (SELECT 1 FROM [SC_MenuPermissionRole] WHERE MenuID = 915 and PermissionRoleID=1)
BEGIN
	insert into [dbo].[SC_MenuPermissionRole] (MenuID, PermissionRoleID, LastUpdated, LastUpdatedBy)
	values (915,1,NULL,NULL)
END

IF NOT EXISTS (SELECT 1 FROM [SC_MenuPermissionRole] WHERE MenuID = 4 and PermissionRoleID=1)
BEGIN
	insert into [dbo].[SC_MenuPermissionRole] (MenuID, PermissionRoleID, LastUpdated, LastUpdatedBy)
	values (4,1,NULL,NULL)
END

IF NOT EXISTS (SELECT 1 FROM [SC_MenuPermissionRole] WHERE MenuID = 915 and PermissionRoleID=2)
BEGIN
	insert into [dbo].[SC_MenuPermissionRole] (MenuID, PermissionRoleID, LastUpdated, LastUpdatedBy)
	values (915,2,NULL,NULL)
END

IF NOT EXISTS (SELECT 1 FROM [SC_MenuPermissionRole] WHERE MenuID = 4 and PermissionRoleID=2)
BEGIN
	insert into [dbo].[SC_MenuPermissionRole] (MenuID, PermissionRoleID, LastUpdated, LastUpdatedBy)
	values (4,2,NULL,NULL)
END

IF NOT EXISTS (SELECT 1 FROM [SC_MenuPermissionRole] WHERE MenuID = 915 and PermissionRoleID=10)
BEGIN
	insert into [dbo].[SC_MenuPermissionRole] (MenuID, PermissionRoleID, LastUpdated, LastUpdatedBy)
	values (915,10,NULL,NULL)
END