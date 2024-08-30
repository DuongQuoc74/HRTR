using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
//using EPS;
using eUtilities;

namespace HRTR.Server
{
    public static class MESReports
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="pi_customer_id"></param>
        /// <returns></returns>
        public static DataTable GetStepIns(int pi_customer_id)
        {
            using (MESDBAccess _mescon = new MESDBAccess())
            {
                string strquery = @"SELECT DISTINCT rs.[DescrText] AS [StepIns]
                                    FROM [dbo].[CR_Assemblies] A WITH (NOLOCK)
		                                    INNER JOIN [dbo].[CR_AssemblyRoutes] B WITH (NOLOCK) ON A.[Assembly_ID] = B.[Assembly_ID]
		                                    INNER JOIN [dbo].[CR_Customers] cus WITH (NOLOCK) ON cus.[Customer_ID] = A.[Customer_ID]
		                                    INNER JOIN [dbo].[CR_FMRS4_V] rs WITH (NOLOCK) ON rs.[FactoryMARoute_ID] = b.[FactoryMARoute_ID]
                                    WHERE A.[Customer_ID] =  " + pi_customer_id.ToString() + @"
                                    ORDER BY rs.[DescrText]";
                return _mescon.GetDataTableByQuery(strquery);
            }
        }
        public static DataTable GetLinkData(int pi_customer_id, string pstr_serialnumber)
        {
            using (MESDBAccess _mescon = new MESDBAccess())
            {
                string strquery = @"SELECT	TOP 1 wp.[SerialNumber], nld.[LinkData], wp.[Wip_ID]
                                FROM	[dbo].[WP_Wip] wp WITH (NOLOCK)
		                                INNER JOIN [dbo].[EP_WipUniqueLink] wul WITH (NOLOCK) ON wp.[Wip_ID] = wul.[Wip_ID]
		                                INNER JOIN [dbo].[EP_LinkObjectRevisions] lor WITH(NOLOCK) ON lor.[LinkMaterial_ID] = wul.[LinkMaterial_ID]
		                                INNER JOIN [dbo].[EP_NormalizedLinkData] nld WITH(NOLOCK) ON nld.[LinkData_ID] = wul.[LinkData_ID]
                                WHERE	nld.[LinkData] = '" + pstr_serialnumber + @"'
                                        AND wp.[Customer_ID] = " + pi_customer_id.ToString() + @"";
                return _mescon.GetDataTableByQuery(strquery);
            }
        }
        public static DataTable GetDefectData(int pi_customer_id, long pi_wip_id)
        {
            using (MESDBAccess _mescon = new MESDBAccess())
            {
                string strquery = @"SELECT  TOP 1 A.[Wip_ID], A.[DefectLocation], dt.[Translation] AS [DefectText], B.[SerialNumber]
                                    FROM [dbo].[QM_Analysis] A WITH (NOLOCK) INNER JOIN [dbo].[WP_WIP] B WITH (NOLOCK) ON A.[Wip_ID] = B.[Wip_ID]
										                                    INNER JOIN  [dbo].[QM_Defects] D ON D.[Defect_ID] = A.[Defect_ID]
										                                    INNER JOIN [dbo].[CR_Text] dt ON dt.[Text_ID] = D.[Defect] AND dt.[Language_ID] = 0  
                                    WHERE A.[Wip_ID] = " + pi_wip_id.ToString() + @"
                                            AND B.[Customer_ID] = " + pi_customer_id.ToString() + @"
                                    ORDER BY A.[AnalysisDateTime] DESC";
                return _mescon.GetDataTableByQuery(strquery);
            }
        }
    }
}
