CREATE TABLE [dbo].[GC_MESRulesStation] (
    [GC_MESRulesStationID] INT           IDENTITY (1, 1) NOT NULL,
    [Customer_ID]          INT           NULL,
    [MESCustomer_ID]       INT           NOT NULL,
    [DetectedStationID]    INT           NOT NULL,
    [Defect_ID]            INT           NOT NULL,
    [CRD]                  NVARCHAR (27) NOT NULL,
    [CRDStepIns]           NVARCHAR (50) NULL,
    [EscapedStationID]     INT           NOT NULL,
    [IsActive]             BIT           NULL,
    [IsExcluded]           BIT           NULL,
    [LastUpdated]          DATETIME      NULL,
    [LastUpdatedBy]        INT           NULL,
    CONSTRAINT [PK_GC_MESRulesStation] PRIMARY KEY NONCLUSTERED ([GC_MESRulesStationID] ASC)
);

