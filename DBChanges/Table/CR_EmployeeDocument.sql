CREATE TABLE [dbo].[CR_EmployeeDocument](
	[EmployeeDocID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID_ID] [int] NOT NULL,
	[EmployeeID] [varchar](10) NOT NULL,
	[CourseID] [int] NOT NULL,
	[StationID] [int] NOT NULL,
	[WorkcellID] [int] NOT NULL,
	[DocumentNumber] [varchar](255) NOT NULL,
	[Revision] [varchar](10) NOT NULL,
	[Active] [bit] NOT NULL,
	[Created] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[LastUpdated] [datetime] NULL,
	[LastUpdatedBy] [int] NULL,
 CONSTRAINT [PK_EmployeeDocument] PRIMARY KEY NONCLUSTERED 
(
	[EmployeeDocID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY])
GO

CREATE NONCLUSTERED INDEX idx_EmployeeDocument_EmployeeID_ID_WorkcellID_CourseID ON dbo.CR_EmployeeDocument(EmployeeID_ID, WorkcellID, CourseID)