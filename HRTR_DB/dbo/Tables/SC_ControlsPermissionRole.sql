CREATE TABLE [dbo].[SC_ControlsPermissionRole] (
    [PermissionRoleID] INT      NOT NULL,
    [ControlID]        INT      NOT NULL,
    [IsDenied]         BIT      NULL,
    [IsViewed]         BIT      NULL,
    [IsUpdated]        BIT      NULL,
    [LastUpdated]      DATETIME NULL,
    [LastUpdatedBy]    INT      NULL,
    CONSTRAINT [PK_SC_ControlsPermissionRole] PRIMARY KEY CLUSTERED ([PermissionRoleID] ASC, [ControlID] ASC)
);

