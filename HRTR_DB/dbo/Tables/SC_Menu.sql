CREATE TABLE [dbo].[SC_Menu] (
    [MenuID]           INT           NOT NULL,
    [MenuName]         VARCHAR (150) NULL,
    [MenuPath]         VARCHAR (150) NULL,
    [FileName]         VARCHAR (50)  NULL,
    [Description]      VARCHAR (50)  NULL,
    [ParentID]         INT           NULL,
    [PermissionRoleID] INT           NULL,
    [IsActive]         BIT           NULL,
    [LastUpdated]      DATETIME      NULL,
    [LastUpdatedBy]    INT           NULL,
    CONSTRAINT [PK_SC_Menu] PRIMARY KEY CLUSTERED ([MenuID] ASC),
    CONSTRAINT [FK_SC_Menu_SC_PermissionRole] FOREIGN KEY ([PermissionRoleID]) REFERENCES [dbo].[SC_PermissionRole] ([PermissionRoleID])
);

