CREATE TABLE [dbo].[GC_CRDStepIns] (
    [GC_CRDStepInsID] INT           IDENTITY (1, 1) NOT NULL,
    [Customer_ID]     INT           NULL,
    [CRDStepIns]      NVARCHAR (50) NULL,
    [StepIns]         NVARCHAR (50) NULL,
    [LastUpdated]     DATETIME      NULL,
    [LastUpdatedBy]   INT           NULL,
    CONSTRAINT [PK_GC_CRDStepIns] PRIMARY KEY NONCLUSTERED ([GC_CRDStepInsID] ASC),
    CONSTRAINT [IX_GC_CRDStepIns] UNIQUE CLUSTERED ([Customer_ID] ASC, [StepIns] ASC)
);

