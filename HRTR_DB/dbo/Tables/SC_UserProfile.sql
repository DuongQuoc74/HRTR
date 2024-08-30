CREATE TABLE [dbo].[SC_UserProfile] (
    [UserProfileID] INT            IDENTITY (-1, 1) NOT NULL,
    [UserName]      VARCHAR (50)   NOT NULL,
    [EmployeeID]    VARCHAR (20)   NULL,
    [FullName]      NVARCHAR (100) NOT NULL,
    [Email]         VARCHAR (100)  NULL,
    [DepartmentID]  INT            NULL,
    [ContactNo]     VARCHAR (50)   NULL,
    [IsActive]      BIT            CONSTRAINT [DF_SC_UserProfile_IsActive] DEFAULT ((0)) NULL,
    [IsDeleted]     BIT            CONSTRAINT [DF_SC_UserProfile_IsDeleted] DEFAULT ((0)) NULL,
    [LastUpdated]   DATETIME       NULL,
    [LastUpdatedBy] INT            NULL,
    [Remarks]       NVARCHAR (255) NULL,
    [LastLoggedOn]  DATETIME       NULL,
    CONSTRAINT [PK_SC_UserProfile] PRIMARY KEY CLUSTERED ([UserProfileID] ASC),
    CONSTRAINT [IX_SC_UserProfile] UNIQUE NONCLUSTERED ([UserName] ASC)
);

