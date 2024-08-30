CREATE TABLE [dbo].[CR_LocalPosition] (
    [LocalPositionID]   INT            NOT NULL,
    [LocalPositionCode] NVARCHAR (50)  NULL,
    [LocalPositionName] NVARCHAR (255) NULL,
    [SAPJobKeyID]       INT            NULL,
    [EmployeeLevelID]   INT            NULL,
    [IsDL]              BIT            NULL,
    [LastUpdated]       DATETIME       NULL,
    [LastUpdatedBy]     INT            NULL,
    CONSTRAINT [PK_CR_LocalPosition] PRIMARY KEY NONCLUSTERED ([LocalPositionID] ASC) ON [INDEXES],
    CONSTRAINT [IX_CR_LocalPosition] UNIQUE CLUSTERED ([LocalPositionCode] ASC)
);

