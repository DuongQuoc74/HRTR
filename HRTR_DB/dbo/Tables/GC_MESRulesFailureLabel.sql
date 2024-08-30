CREATE TABLE [dbo].[GC_MESRulesFailureLabel] (
    [GC_StationID]           INT            NOT NULL,
    [FailureLabel]           NVARCHAR (100) NOT NULL,
    [EscapedGC_StationID]    INT            NULL,
    [EscapedByEmployeeID_ID] INT            NULL,
    [LastUpdated]            DATETIME       NULL,
    [LastUpdatedBy]          INT            NULL,
    CONSTRAINT [PK_GC_MESRulesFailureLabel] PRIMARY KEY CLUSTERED ([GC_StationID] ASC, [FailureLabel] ASC)
);

