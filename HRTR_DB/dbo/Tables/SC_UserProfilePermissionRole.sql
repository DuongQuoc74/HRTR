CREATE TABLE [dbo].[SC_UserProfilePermissionRole] (
    [UserProfileID]    INT      NOT NULL,
    [PermissionRoleID] INT      NOT NULL,
    [IsActive]         BIT      CONSTRAINT [DF_SC_UserProfilePermissionRole_IsActive] DEFAULT ((1)) NOT NULL,
    [LastUpdated]      DATETIME NULL,
    [LastUpdatedBy]    INT      NULL,
    CONSTRAINT [PK_SC_UserProfilePermissionRole] PRIMARY KEY CLUSTERED ([UserProfileID] ASC, [PermissionRoleID] ASC)
);

