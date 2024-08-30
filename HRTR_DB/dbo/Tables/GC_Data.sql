CREATE TABLE [dbo].[GC_Data] (
    [GC_DataID]               INT            IDENTITY (-2000000000, 1) NOT NULL,
    [WorkcellID]              INT            NULL,
    [MESCustomer_ID]          INT            NULL,
    [Customer_ID]             INT            NULL,
    [EscapedDate]             DATETIME       NOT NULL,
    [ShiftID]                 INT            NULL,
    [EscapedByEmployeeID_ID]  INT            NOT NULL,
    [EscapedStationID]        INT            NULL,
    [Defect_ID]               INT            NULL,
    [DefectText]              NVARCHAR (200) NULL,
    [CRD]                     NVARCHAR (255) NULL,
    [Description]             NVARCHAR (255) NULL,
    [DetectedByEmployeeID_ID] INT            NULL,
    [DetectedStationID]       INT            NULL,
    [Analysis_ID]             INT            NULL,
    [SerialNumber]            NVARCHAR (50)  NULL,
    [ChildSerialNumber]       NVARCHAR (50)  NULL,
    [DetectedStepIns]         NVARCHAR (50)  NULL,
    [DetectedWindowsUserID]   NVARCHAR (20)  NULL,
    [CRDStepIns]              NVARCHAR (50)  NULL,
    [StartDateTime]           DATETIME       NULL,
    [EscapedStepIns]          NVARCHAR (50)  NULL,
    [EscapedWindowsUserID]    NVARCHAR (20)  NULL,
    [IsMESAutoLinked]         BIT            CONSTRAINT [DF_GC_Data_IsMESAutoLinked] DEFAULT ((0)) NULL,
    [LastUpdated]             DATETIME       NULL,
    [LastUpdatedBy]           INT            NULL,
    [Route]                   NVARCHAR (50)  NULL,
    [FailureLabel]            NVARCHAR (100) NULL,
    [ClientName]              VARCHAR (150)  NULL,
    CONSTRAINT [PK_GC_Data] PRIMARY KEY NONCLUSTERED ([GC_DataID] ASC)
);


GO
CREATE CLUSTERED INDEX [IX_GC_Data]
    ON [dbo].[GC_Data]([Customer_ID] ASC, [EscapedDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_GC_Data_1]
    ON [dbo].[GC_Data]([Analysis_ID] ASC, [EscapedStepIns] ASC, [EscapedByEmployeeID_ID] ASC)
    ON [INDEXES];


GO
CREATE NONCLUSTERED INDEX [IX_GC_Data_2]
    ON [dbo].[GC_Data]([EscapedByEmployeeID_ID] ASC, [EscapedDate] ASC)
    INCLUDE([SerialNumber], [Defect_ID])
    ON [INDEXES];


GO
CREATE NONCLUSTERED INDEX [IX_GC_Data_3]
    ON [dbo].[GC_Data]([EscapedDate] ASC)
    INCLUDE([EscapedByEmployeeID_ID], [DetectedByEmployeeID_ID], [SerialNumber])
    ON [INDEXES];

