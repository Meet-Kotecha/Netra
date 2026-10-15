using System;
using System.Web.UI;

namespace Netra
{
    public partial class RegisterCase : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtIncidentDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtDateReported.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtIncidentTime.Text = DateTime.Now.ToString("HH:mm");
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                lblStatus.Text = "✅ Crime Case " + txtCaseNumber.Text + " registered successfully!";
            }
        }

        protected void btnSaveDraft_Click(object sender, EventArgs e)
        {
            lblStatus.Text = "💾 Case saved as draft successfully.";
        }
    }
}