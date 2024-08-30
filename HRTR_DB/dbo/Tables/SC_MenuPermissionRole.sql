CREATE TABLE [dbo].[SC_MenuPermissionRole] (
    [MenuID]           INT      NOT NULL,
    [PermissionRoleID] INT      NOT NULL,
    [LastUpdated]      DATETIME NULL,
    [LastUpdatedBy]    INT      NULL,
    CONSTRAINT [PK_SC_MenuPermissionRole] PRIMARY KEY CLUSTERED ([MenuID] ASC, [PermissionRoleID] ASC)
);

