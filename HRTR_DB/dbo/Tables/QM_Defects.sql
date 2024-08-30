CREATE TABLE [dbo].[QM_Defects] (
    [Defect_ID]         INT            NOT NULL,
    [Defect]            INT            NOT NULL,
    [DefectCategory_ID] INT            NOT NULL,
    [Active]            BIT            NOT NULL,
    [UserID_ID]         INT            NOT NULL,
    [LastUpdated]       DATETIME       NOT NULL,
    [RequiresRework]    BIT            NOT NULL,
    [DefectText]        NVARCHAR (200) NULL,
    [DefextTextVN]      NVARCHAR (200) NULL,
    CONSTRAINT [PK_QM_Defects] PRIMARY KEY NONCLUSTERED ([Defect_ID] ASC) WITH (FILLFACTOR = 90) ON [INDEXES]
);


GO
CREATE CLUSTERED INDEX [IX_QM_Defects]
    ON [dbo].[QM_Defects]([DefectText] ASC);

