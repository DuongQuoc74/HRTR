CREATE TABLE [dbo].[CCS_ConfirmLog] (
    [CCS_AuthenticationLogID] INT              NOT NULL,
    [IsUnderstand]            BIT              NOT NULL,
    [DocumentID]              UNIQUEIDENTIFIER NULL,
    [LastUpdated]             DATETIME         NULL,
    [LastUpdatedBy]           INT              NULL
);


GO
CREATE CLUSTERED INDEX [IX_CCS_ConfirmLog]
    ON [dbo].[CCS_ConfirmLog]([CCS_AuthenticationLogID] ASC, [DocumentID] ASC, [IsUnderstand] ASC);

