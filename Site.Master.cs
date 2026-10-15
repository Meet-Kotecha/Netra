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
            // Get raw absolute path in lower case
            string rawPath = Request.Url.AbsolutePath.ToLower();

            // Clear active class from all items
            navDashboard.Attributes["class"] = "nav-item";
            navCrimeCases.Attributes["class"] = "nav-item";
            if (navPersons != null) navPersons.Attributes["class"] = "nav-item";

            // Dynamic route matching
            if (rawPath.EndsWith("/") || rawPath.Contains("/default") || rawPath.Contains("/default.aspx"))
            {
                navDashboard.Attributes["class"] = "nav-item active";
            }
            else if (rawPath.Contains("/crimecases") || rawPath.Contains("/registercase"))
            {
                navCrimeCases.Attributes["class"] = "nav-item active";
            }
            else if (rawPath.Contains("/personsdirectory"))
            {
                if (navPersons != null) navPersons.Attributes["class"] = "nav-item active";
            }
        }
    }
}