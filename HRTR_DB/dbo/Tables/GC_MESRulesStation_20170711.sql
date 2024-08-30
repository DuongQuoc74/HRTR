CREATE TABLE [dbo].[GC_MESRulesStation_20170711] (
    [GC_MESRulesStationID] INT           NOT NULL,
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
    [LastUpdatedBy]        INT           NULL
);

