using System;

namespace Netra
{
    public partial class RegisterCase : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                lblStatus.Text = "Case registered successfully!";
            }
        }
    }
}