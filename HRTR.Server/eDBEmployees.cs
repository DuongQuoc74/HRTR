using System;
using System.Data;

namespace HRTR.Server
{
    public class eDBEmployees : OBase
    {
        public static DataTable SearchInactiveEmployees()
        {
            try
            {
                using (var db = new eDBDBAccess())
                {
                    var paramarr = new object[42, 2]
                    {
                        { "@EmployeeID", "" },
                        { "@EmployeeIDSAP", "" },
                        { "@WDNo", "" },
                        { "@FullName", "" },
                        { "@UserName", "" },
                        { "@IEID", 1 },
                        { "@ReviewDate", new DateTime(1900, 1, 1) },
                        { "@GenderID", -1 },
                        { "@ExpJoinedDateFrom", new DateTime(1900, 1, 1) },
                        { "@ExpJoinedDateTo", new DateTime(1900, 1, 1)},
                        { "@JoinedDateFrom", new DateTime(1900, 1, 1) },
                        { "@JoinedDateTo", new DateTime(1900, 1, 1) },
                        { "@IsHasJoinedDate", -1 },
                        { "@ConvertedDateFrom", new DateTime(1900, 1, 1) },
                        { "@ConvertedDateTo", new DateTime(1900, 1, 1) },
                        { "@IsHasConvertedDate", -1 },
                        { "@PITCode", "" },
                        { "@EmployeeTypeID", 0 },
                        { "@VendorID", 0 },
                        { "@DepartmentID", 0 },
                        { "@SectionID", 0 },
                        { "@WorkcellID", 0 },
                        { "@EmployeeGroupID", 0},
                        { "@CostCenterID", 0 },
                        { "@EmployeeLevelID", 0 },
                        { "@IsSupervisor", -1 },
                        { "@SupervisorID", 0 },
                        { "@LocalPositionID", 0 },
                        { "@IsDL", 0 },
                        { "@IsVA", -1 },
                        { "@Email", "" },
                        { "@CompanyPhone", "" },
                        { "@Ext", "" },
                        { "@JoinedSDNo", "" },
                        { "@IsNotOnBoard", -1 },
                        { "@WorkingStatusID", 0 },
                        { "@ResignedDateFrom", new DateTime(1900, 1, 1) },
                        { "@ResignedDateTo", new DateTime(1900, 1, 1) },
                        { "@IsActive", 0 },
                        { "@EmployeeKindID", -1 },
                        { "@SiteID", 1 },
                        { "@LastUpdatedBy", 0 }
                    };
                    return db.GetDataTableByStore("HR_Employee_Search", paramarr);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
