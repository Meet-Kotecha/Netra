using System;

namespace Netra
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // Successful login redirects to main dashboard
                Response.Redirect("Default.aspx");
            }
        }
    }
}