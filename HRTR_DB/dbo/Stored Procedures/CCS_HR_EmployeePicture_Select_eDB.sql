CREATE PROC [dbo].[CCS_HR_EmployeePicture_Select_eDB] 
(
	@EmployeeID		nvarchar(20)
)
AS
BEGIN
	SET NOCOUNT ON;
	IF LEN(@EmployeeID) <= 3 -- 
	BEGIN
		SET @EmployeeID = RIGHT('000' + @EmployeeID, 4)
	END
	IF NOT EXISTS (SELECT 1
					FROM [VNHCMM0SQL03].[eDB].[dbo].[HR_EmployeePicture] B WITH (NOLOCK)
					WHERE B.[EmployeeID] = @EmployeeID
					)
	BEGIN
		SELECT B.[EmployeeID]
				, B.[EmployeePicture]
		FROM [VNHCMM0SQL03].[eDB].[dbo].[HR_EmployeePicture] B WITH (NOLOCK)
		WHERE B.[EmployeeID] = 'NoImage'
	END
	ELSE
	BEGIN
		SELECT B.[EmployeeID]
				, B.[EmployeePicture]
		FROM [VNHCMM0SQL03].[eDB].[dbo].[HR_EmployeePicture] B WITH (NOLOCK)
		WHERE B.[EmployeeID] = @EmployeeID
	END		

END

