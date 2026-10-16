using System;

namespace Netra
{
    public partial class Site : System.Web.UI.MasterPage
    {
        public string HeaderInitials { get; set; } = "MK";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserInitials"] != null)
            {
                HeaderInitials = Session["UserInitials"].ToString();
            }
            else
            {
                Session["UserName"] = "Meet Kotecha";
                Session["UserInitials"] = "MK";
            }

            SetActiveMenu();
        }

        private void SetActiveMenu()
        {
            string rawPath = Request.Url.AbsolutePath.ToLower();

            // Clear active status from all navigation items
            if (navDashboard != null) navDashboard.Attributes["class"] = "nav-item";
            if (navCrimeCases != null) navCrimeCases.Attributes["class"] = "nav-item";
            if (navCrimeMap != null) navCrimeMap.Attributes["class"] = "nav-item";
            if (navAnalytics != null) navAnalytics.Attributes["class"] = "nav-item";
            if (navWorkspace != null) navWorkspace.Attributes["class"] = "nav-item";
            if (navPersons != null) navPersons.Attributes["class"] = "nav-item";
            if (navNetwork != null) navNetwork.Attributes["class"] = "nav-item";
            if (navImage != null) navImage.Attributes["class"] = "nav-item";
            if (navRisk != null) navRisk.Attributes["class"] = "nav-item";
            if (navAlerts != null) navAlerts.Attributes["class"] = "nav-item";
            if (navAI != null) navAI.Attributes["class"] = "nav-item";
            if (navReports != null) navReports.Attributes["class"] = "nav-item";
            if (navImport != null) navImport.Attributes["class"] = "nav-item";
            if (navUsers != null) navUsers.Attributes["class"] = "nav-item";
            if (navAudit != null) navAudit.Attributes["class"] = "nav-item";
            if (navSettings != null) navSettings.Attributes["class"] = "nav-item";

            // Route active-state matching
            if (rawPath.EndsWith("/") || rawPath.Contains("/default"))
            {
                if (navDashboard != null) navDashboard.Attributes["class"] = "nav-item active";
            }
            else if (rawPath.Contains("/crimecases") || rawPath.Contains("/registercase"))
            {
                if (navCrimeCases != null) navCrimeCases.Attributes["class"] = "nav-item active";
            }
            else if (rawPath.Contains("/crimemap"))
            {
                if (navCrimeMap != null) navCrimeMap.Attributes["class"] = "nav-item active";
            }
            else if (rawPath.Contains("/analytics"))
            {
                if (navAnalytics != null) navAnalytics.Attributes["class"] = "nav-item active";
            }
            else if (rawPath.Contains("/investigationworkspace"))
            {
                if (navWorkspace != null) navWorkspace.Attributes["class"] = "nav-item active";
            }
            else if (rawPath.Contains("/personsdirectory") || rawPath.Contains("/personprofile"))
            {
                if (navPersons != null) navPersons.Attributes["class"] = "nav-item active";
            }
            else if (rawPath.Contains("/networkanalysis"))
            {
                if (navNetwork != null) navNetwork.Attributes["class"] = "nav-item active";
            }
            else if (rawPath.Contains("/imageinvestigation"))
            {
                if (navImage != null) navImage.Attributes["class"] = "nav-item active";
            }
            else if (rawPath.Contains("/riskanalysis"))
            {
                if (navRisk != null) navRisk.Attributes["class"] = "nav-item active";
            }
            else if (rawPath.Contains("/alerts"))
            {
                if (navAlerts != null) navAlerts.Attributes["class"] = "nav-item active";
            }
            else if (rawPath.Contains("/aiassistant"))
            {
                if (navAI != null) navAI.Attributes["class"] = "nav-item active";
            }
            else if (rawPath.Contains("/reports"))
            {
                if (navReports != null) navReports.Attributes["class"] = "nav-item active";
            }
            else if (rawPath.Contains("/bulkdataimport"))
            {
                if (navImport != null) navImport.Attributes["class"] = "nav-item active";
            }
            else if (rawPath.Contains("/usermanagement"))
            {
                if (navUsers != null) navUsers.Attributes["class"] = "nav-item active";
            }
            else if (rawPath.Contains("/auditlogs"))
            {
                if (navAudit != null) navAudit.Attributes["class"] = "nav-item active";
            }
            else if (rawPath.Contains("/settings") || rawPath.Contains("/securitysettings") || rawPath.Contains("/notificationsettings"))
            {
                if (navSettings != null) navSettings.Attributes["class"] = "nav-item active";
            }
        }
    }
}