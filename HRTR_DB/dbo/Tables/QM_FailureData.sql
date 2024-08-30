CREATE TABLE [dbo].[QM_FailureData] (
    [FailureData_ID] INT            NOT NULL,
    [Customer_ID]    INT            NOT NULL,
    [DataLabel]      NVARCHAR (100) NULL,
    [Step_ID]        INT            NOT NULL,
    [Comment]        NVARCHAR (300) NOT NULL,
    [LastUpdated]    DATETIME       NOT NULL,
    [LastUpdatedBy]  INT            NOT NULL,
    CONSTRAINT [PK_QM_FailureData] PRIMARY KEY CLUSTERED ([FailureData_ID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [IX_QM_FailureData] UNIQUE NONCLUSTERED ([Customer_ID] ASC, [DataLabel] ASC, [Step_ID] ASC) WITH (FILLFACTOR = 90)
);

