using System;

namespace Netra
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                lblStatus.Text = "Reset instructions sent to your email!";
            }
        }
    }
}