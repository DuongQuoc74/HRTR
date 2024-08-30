CREATE TABLE [dbo].[SY_Department] (
    [DepartmentID]      INT           IDENTITY (1, 1) NOT NULL,
    [DepartmentCode]    VARCHAR (5)   NOT NULL,
    [DepartmentName]    VARCHAR (100) NULL,
    [LastUpdated]       DATETIME      NULL,
    [LastUpdatedBy]     INT           NULL,
    [eDBDepartmentCode] VARCHAR (5)   NULL,
    CONSTRAINT [PK_SY_Department] PRIMARY KEY CLUSTERED ([DepartmentID] ASC),
    CONSTRAINT [IX_SY_Department] UNIQUE NONCLUSTERED ([DepartmentCode] ASC)
);

