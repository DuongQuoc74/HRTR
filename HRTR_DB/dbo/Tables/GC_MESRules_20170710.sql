CREATE TABLE [dbo].[GC_MESRules_20170710] (
    [GC_MESRulesID]   INT           NOT NULL,
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
    [LastUpdatedBy]   INT           NULL
);

