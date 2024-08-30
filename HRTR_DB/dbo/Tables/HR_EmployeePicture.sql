CREATE TABLE [dbo].[HR_EmployeePicture] (
    [EmployeeID]      NVARCHAR (20)  NOT NULL,
    [EmployeePicture] IMAGE          NOT NULL,
    [LastUpdated]     DATETIME       NULL,
    [LastUpdatedBy]   INT            NULL,
    [PictureFile]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_HR_EmployeePicture] PRIMARY KEY CLUSTERED ([EmployeeID] ASC)
);

