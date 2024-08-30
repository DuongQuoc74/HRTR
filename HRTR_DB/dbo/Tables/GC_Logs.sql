CREATE TABLE [dbo].[GC_Logs] (
    [EmployeeID_ID]  INT           NOT NULL,
    [UserName]       VARCHAR (50)  NOT NULL,
    [TerminalName]   VARCHAR (150) NULL,
    [ProductName]    NVARCHAR (50) NULL,
    [ProductVersion] NVARCHAR (50) NULL,
    [LastUpdated]    DATETIME      NULL,
    [LastUpdatedBy]  INT           NULL
);

