CREATE TABLE [dbo].[AL_IpRange] (
    [ID]         INT         NOT NULL,
    [Subnetmark] NCHAR (15)  NULL,
    [FromIP]     INT         NULL,
    [ToIp]       INT         NULL,
    [IsActive]   BIT         NULL,
    [Note]       NCHAR (100) NULL,
    CONSTRAINT [PK_AL_IpRange] PRIMARY KEY CLUSTERED ([ID] ASC)
);

