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
                string username = txtUsername.Text.Trim();
                string password = txtPassword.Text.Trim();

                // Verification for Admin (Meet Kotecha)
                if ((username.Equals("meet8kotecha@gmail.com", StringComparison.OrdinalIgnoreCase) ||
                     username.Equals("Meet Kotecha", StringComparison.OrdinalIgnoreCase)) &&
                     password == "Meet123")
                {
                    Session["User"] = "Meet Kotecha";
                    Session["Role"] = "Admin";
                    Response.Redirect("Default.aspx");
                }
                else
                {
                    lblLoginError.Text = "Access Denied: Invalid Admin Credentials.";
                }
            }
        }
    }
}