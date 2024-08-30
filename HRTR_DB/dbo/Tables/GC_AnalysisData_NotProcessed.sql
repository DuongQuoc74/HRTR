CREATE TABLE [dbo].[GC_AnalysisData_NotProcessed] (
    [Analysis_ID]      INT            NOT NULL,
    [MESCustomer_ID]   INT            NULL,
    [Customer_ID]      INT            NOT NULL,
    [WIP_ID]           INT            NOT NULL,
    [Process_ID]       INT            NOT NULL,
    [SerialNumber]     NVARCHAR (50)  NULL,
    [StepIns]          NVARCHAR (50)  NULL,
    [UserID]           NVARCHAR (20)  NULL,
    [WindowsUserID]    NVARCHAR (20)  NULL,
    [AnalysisDateTime] DATETIME       NULL,
    [DefectText]       NVARCHAR (200) NULL,
    [DefectLocation]   NVARCHAR (27)  NULL,
    [Defect_ID]        INT            NULL,
    [Assembly_ID]      INT            NULL,
    [AssyNumber]       NVARCHAR (50)  NULL,
    [Revision]         NVARCHAR (20)  NULL,
    [IsChildProcess]   BIT            NULL,
    [LastUpdated]      DATETIME       NULL,
    [LastUpdatedBy]    INT            NULL,
    [Route]            NVARCHAR (50)  NULL,
    [Route_ID]         INT            NULL,
    [FailureLabel]     NVARCHAR (100) NULL
);


GO
CREATE CLUSTERED INDEX [IX_GC_AnalysisData_NotProcessed]
    ON [dbo].[GC_AnalysisData_NotProcessed]([Analysis_ID] ASC, [Customer_ID] ASC);

