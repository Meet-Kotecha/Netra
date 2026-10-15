using System;
using System.IO;

namespace Netra
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SetActiveMenu();
            }
        }

        private void SetActiveMenu()
        {
            string currentPage = Path.GetFileName(Request.Url.AbsolutePath).ToLower();

            // Clear active class from all
            navDashboard.Attributes["class"] = "nav-item";
            navCrimeCases.Attributes["class"] = "nav-item";
            navPersons.Attributes["class"] = "nav-item";

            // Highlight current page
            if (currentPage == "default.aspx" || string.IsNullOrEmpty(currentPage))
            {
                navDashboard.Attributes["class"] = "nav-item active";
            }
            else if (currentPage == "crimecases.aspx" || currentPage == "registercase.aspx")
            {
                navCrimeCases.Attributes["class"] = "nav-item active";
            }
            else if (currentPage == "personsdirectory.aspx")
            {
                navPersons.Attributes["class"] = "nav-item active";
            }
        }
    }
}