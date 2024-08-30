CREATE TABLE [dbo].[CR_Workcell] (
    [WorkcellID]             INT          IDENTITY (1, 1) NOT NULL,
    [WorkcellCode]           VARCHAR (10) NOT NULL,
    [WorkcellName]           VARCHAR (50) NULL,
    [MESCustomer_ID]         INT          NULL,
    [IsAppliedCCS]           BIT          NULL,
    [IsCCS]                  BIT          CONSTRAINT [DF_CR_Workcell_IsCCS] DEFAULT ((1)) NULL,
    [IsActive]               BIT          NULL,
    [eDBWorkcellCode]        VARCHAR (10) NULL,
    [IsAppliedClientProcess] BIT          CONSTRAINT [DF_CR_Workcell_IsAppliedClientProcess] DEFAULT ((0)) NOT NULL,
    [LastUpdated]            DATETIME     NULL,
    [LastUpdatedBy]          INT          NULL,
    CONSTRAINT [PK_CR_Workcell] PRIMARY KEY CLUSTERED ([WorkcellID] ASC)
);

