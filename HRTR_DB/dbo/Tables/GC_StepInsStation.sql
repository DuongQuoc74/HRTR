CREATE TABLE [dbo].[GC_StepInsStation] (
    [GC_StepInsStationID] INT           IDENTITY (1, 1) NOT NULL,
    [Customer_ID]         INT           NOT NULL,
    [StepIns]             NVARCHAR (50) NOT NULL,
    [GC_StationID]        INT           NULL,
    [MESCustomer_ID]      INT           NULL,
    [Step_ID]             INT           NULL,
    [IsActive]            BIT           NULL,
    [LastUpdated]         DATETIME      NULL,
    [LastUpdatedBy]       INT           NULL,
    CONSTRAINT [PK_GC_StepInsStation] PRIMARY KEY NONCLUSTERED ([GC_StepInsStationID] ASC),
    CONSTRAINT [IX_GC_StepInsStation] UNIQUE CLUSTERED ([Customer_ID] ASC, [StepIns] ASC, [GC_StationID] ASC)
);

