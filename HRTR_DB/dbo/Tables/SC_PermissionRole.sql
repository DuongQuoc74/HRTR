CREATE TABLE [dbo].[SC_PermissionRole] (
    [PermissionRoleID]   INT          NOT NULL,
    [PermissionRoleName] VARCHAR (50) NOT NULL,
    [IsActive]           BIT          NULL,
    [LastUpdated]        DATETIME     NULL,
    [LastUpdatedBy]      INT          NULL,
    CONSTRAINT [PK_SC_PermissionRole] PRIMARY KEY CLUSTERED ([PermissionRoleID] ASC)
);

