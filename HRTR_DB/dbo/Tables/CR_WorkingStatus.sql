CREATE TABLE [dbo].[CR_WorkingStatus] (
    [WorkingStatusID]   INT            NOT NULL,
    [WorkingStatusCode] NVARCHAR (10)  NOT NULL,
    [WorkingStatusName] NVARCHAR (100) NOT NULL,
    [IsContract]        BIT            NULL,
    [IsWorking]         BIT            NOT NULL,
    [LastUpdated]       DATETIME       NULL,
    [LastUpdatedBy]     INT            NULL
);

