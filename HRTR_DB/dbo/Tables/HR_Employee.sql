CREATE TABLE [dbo].[HR_Employee] (
    [EmployeeID_ID]   INT            IDENTITY (1, 1) NOT NULL,
    [EmployeeID]      NVARCHAR (20)  NULL,
    [EmployeeIDSAP]   NVARCHAR (20)  NULL,
    [EmployeeName]    NVARCHAR (100) NULL,
    [OperatorGroupID] INT            NULL,
    [CompanyID]       INT            NULL,
    [DepartmentID]    INT            NULL,
    [JobTitle]        NVARCHAR (50)  NULL,
    [PositionID]      INT            NULL,
    [ShiftID]         INT            NULL,
    [WorkcellID]      INT            NULL,
    [Supervisor]      NVARCHAR (100) NULL,
    [IsActive]        BIT            CONSTRAINT [DF_HR_Employee_IsActive] DEFAULT ((1)) NULL,
    [JoinedDate]      DATETIME       NULL,
    [UserName]        VARCHAR (50)   NULL,
    [IsSupervisor]    BIT            CONSTRAINT [DF_HR_Employee_IsSupervisor] DEFAULT ((0)) NULL,
    [LastUpdated]     DATETIME       NULL,
    [LastUpdatedBy]   INT            NULL,
    [Customer_ID]     INT            NULL,
    [Email]           NVARCHAR (100) NULL,
    [IsValidUserName] BIT            NULL,
    [WorkingStatusID] INT            NULL,
    [eDBUserName]     VARCHAR (50)   NULL,
    [WDNo]            NVARCHAR (20)  NULL,
    CONSTRAINT [PK_HR_Employee] PRIMARY KEY NONCLUSTERED ([EmployeeID_ID] ASC) ON [INDEXES],
    CONSTRAINT [IX_HR_Employee] UNIQUE CLUSTERED ([EmployeeID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_HR_Employee_1]
    ON [dbo].[HR_Employee]([WorkcellID] ASC, [IsActive] ASC, [EmployeeID_ID] ASC)
    INCLUDE([EmployeeID], [EmployeeName])
    ON [INDEXES];


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_HR_Employee_2]
    ON [dbo].[HR_Employee]([EmployeeIDSAP] ASC) WHERE ([EmployeeIDSAP]<>'')
    ON [INDEXES];


GO
CREATE NONCLUSTERED INDEX [IX_HR_Employee_3]
    ON [dbo].[HR_Employee]([UserName] ASC)
    ON [INDEXES];


GO
CREATE NONCLUSTERED INDEX [IX_HR_Employee_4]
    ON [dbo].[HR_Employee]([eDBUserName] ASC)
    ON [INDEXES];

