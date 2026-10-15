using System;

namespace Netra
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SetActiveMenu();
        }

        private void SetActiveMenu()
        {
            string rawPath = Request.Url.AbsolutePath.ToLower();

            // Clear active status from all navigation links
            if (navDashboard != null) navDashboard.Attributes["class"] = "nav-item";
            if (navCrimeCases != null) navCrimeCases.Attributes["class"] = "nav-item";
            if (navCrimeMap != null) navCrimeMap.Attributes["class"] = "nav-item";
            if (navAnalytics != null) navAnalytics.Attributes["class"] = "nav-item";
            if (navWorkspace != null) navWorkspace.Attributes["class"] = "nav-item";
            if (navPersons != null) navPersons.Attributes["class"] = "nav-item";
            if (navNetwork != null) navNetwork.Attributes["class"] = "nav-item";

            // Dynamic route matching
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
        }
    }
}