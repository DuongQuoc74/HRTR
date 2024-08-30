CREATE TABLE [dbo].[TL_Logs] (
    [EmployeeID_ID] INT           NOT NULL,
    [UserName]      VARCHAR (50)  NOT NULL,
    [TerminalName]  VARCHAR (150) NULL,
    [LastUpdated]   DATETIME      NULL,
    [LastUpdatedBy] INT           NULL
);

