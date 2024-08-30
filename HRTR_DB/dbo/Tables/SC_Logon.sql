CREATE TABLE [dbo].[SC_Logon] (
    [LogonID]              INT            IDENTITY (-2000000000, 1) NOT NULL,
    [AuthenticationTypeID] INT            NOT NULL,
    [AuthenticationName]   NVARCHAR (50)  NOT NULL,
    [EmployeeID_ID]        INT            NOT NULL,
    [UserProfileID]        INT            CONSTRAINT [DF_SC_Logon_UserProfileID] DEFAULT ((-1)) NOT NULL,
    [PCName]               NVARCHAR (50)  NOT NULL,
    [IPAddress]            VARCHAR (50)   NULL,
    [ApplicationID]        INT            NOT NULL,
    [SystemKindID]         INT            NOT NULL,
    [PageName]             NVARCHAR (255) NULL,
    [LastUpdated]          DATETIME       NULL,
    [LastUpdatedBy]        INT            NULL,
    CONSTRAINT [PK_SC_Logon] PRIMARY KEY CLUSTERED ([LogonID] ASC)
);

