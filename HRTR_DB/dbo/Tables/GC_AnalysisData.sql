CREATE TABLE [dbo].[GC_AnalysisData] (
    [Analysis_ID]        INT            NOT NULL,
    [MESCustomer_ID]     INT            NULL,
    [Customer_ID]        INT            NOT NULL,
    [WIP_ID]             INT            NOT NULL,
    [Process_ID]         INT            NOT NULL,
    [SerialNumber]       NVARCHAR (50)  NULL,
    [StepIns]            NVARCHAR (50)  NULL,
    [UserID]             NVARCHAR (20)  NULL,
    [WindowsUserID]      NVARCHAR (20)  NULL,
    [AnalysisDateTime]   DATETIME       NULL,
    [DefectText]         NVARCHAR (200) NULL,
    [DefectLocation]     NVARCHAR (27)  NULL,
    [Defect_ID]          INT            NULL,
    [Assembly_ID]        INT            NULL,
    [AssyNumber]         NVARCHAR (50)  NULL,
    [Revision]           NVARCHAR (20)  NULL,
    [CRDStepIns]         NVARCHAR (50)  NULL,
    [GC_ProcessStatusID] INT            NULL,
    [ReviewDate]         DATETIME       NULL,
    [IsChildProcess]     BIT            NULL,
    [LastUpdated]        DATETIME       NULL,
    [LastUpdatedBy]      INT            NULL,
    [Route]              NVARCHAR (50)  NULL,
    [Route_ID]           INT            NULL,
    [FailureLabel]       NVARCHAR (100) NULL,
    [GC_AnalysisDataID]  INT            IDENTITY (1, 1) NOT NULL
);


GO
CREATE CLUSTERED INDEX [IX_GC_AnalysisData]
    ON [dbo].[GC_AnalysisData]([Analysis_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_GC_AnalysisData_1]
    ON [dbo].[GC_AnalysisData]([AnalysisDateTime] ASC)
    INCLUDE([Analysis_ID])
    ON [INDEXES];

