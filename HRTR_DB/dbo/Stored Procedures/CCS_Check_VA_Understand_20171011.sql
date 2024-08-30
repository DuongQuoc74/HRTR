-- not use after OCMS V1.0.0.3 released
CREATE PROC [dbo].[CCS_Check_VA_Understand_20171011] 
(
	@UserName		varchar(50),
	@CourseID		int,
	@DocumentID		uniqueidentifier
)
AS
BEGIN
	SET NOCOUNT ON
	--DECLARE		@Valid int 
	--			, @CheckUser		int 
	--			, @LastLogout		datetime
	--			, @OneStationAtTime int
	--			, @PreStation		varchar(50)
	SELECT	[CCS_AuthenticationLogID]
			,[UserName]
			,[EmployeeID_ID]
			,[ClientName]
			,[LoginTime]
			,[IsSupervisor]
			,[LogoffTime]
			--,[IsValid]
			,[CourseID]
			,[IsUnderstand]
			,[DocumentID]
			,[LastUpdated]
			,[LastUpdatedBy]
	FROM [dbo].[CCS_AuthenticationLog] WITH (NOLOCK)
	WHERE [UserName] = @UserName
			AND [CourseID] = @CourseID
			AND [DocumentID] = @DocumentID
			AND [IsUnderstand] = 1

	--select * from CCS_AuthenticationLog where Username=@NTID and courseID=@CourseID and DocumentID=@NewDocumentID and Understand=1
	
	
END


