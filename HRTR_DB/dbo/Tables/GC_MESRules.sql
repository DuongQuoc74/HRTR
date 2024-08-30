CREATE TABLE [dbo].[GC_MESRules] (
    [GC_MESRulesID]   INT           IDENTITY (1, 1) NOT NULL,
    [Customer_ID]     INT           NULL,
    [MESCustomer_ID]  INT           NOT NULL,
    [DetectedStepIns] NVARCHAR (50) NOT NULL,
    [Defect_ID]       INT           NOT NULL,
    [CRD]             NVARCHAR (27) NOT NULL,
    [CRDStepIns]      NVARCHAR (50) NULL,
    [EscapedStepIns]  NVARCHAR (50) NOT NULL,
    [IsActive]        BIT           NULL,
    [IsExcluded]      BIT           NULL,
    [LastUpdated]     DATETIME      NULL,
    [LastUpdatedBy]   INT           NULL,
    CONSTRAINT [PK_GC_MESRules] PRIMARY KEY NONCLUSTERED ([GC_MESRulesID] ASC)
);


GO
CREATE UNIQUE CLUSTERED INDEX [IX_GC_MESRules]
    ON [dbo].[GC_MESRules]([Customer_ID] ASC, [DetectedStepIns] ASC, [Defect_ID] ASC, [CRD] ASC, [CRDStepIns] ASC, [EscapedStepIns] ASC);

