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
                string email = txtEmail.Text.Trim();

                if (email.Equals("meet8kotecha@gmail.com", StringComparison.OrdinalIgnoreCase))
                {
                    lblStatus.ForeColor = System.Drawing.Color.FromArgb(16, 185, 129); // Green
                    lblStatus.Text = "✅ Reset instructions and secure login link have been dispatched to meet8kotecha@gmail.com.";
                }
                else
                {
                    lblStatus.ForeColor = System.Drawing.Color.FromArgb(239, 68, 68); // Red
                    lblStatus.Text = "❌ Unauthorized email address. Access denied.";
                }
            }
        }
    }
}