using System;
using System.Web.UI;

namespace Netra
{
    public partial class Settings : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUserProfile();
            }
        }

        private void LoadUserProfile()
        {
            // Null-safe session check with defaults
            string userName = Session["UserName"] != null ? Session["UserName"].ToString() : "Meet Kotecha";
            string userEmail = Session["UserEmail"] != null ? Session["UserEmail"].ToString() : "mkotecha581@rku.ac.in";

            if (txtFullName != null)
            {
                txtFullName.Text = userName;
            }

            if (txtEmailAddress != null)
            {
                txtEmailAddress.Text = userEmail;
            }
        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            if (txtFullName != null)
            {
                Session["UserName"] = txtFullName.Text.Trim();
            }

            if (txtEmailAddress != null)
            {
                Session["UserEmail"] = txtEmailAddress.Text.Trim();
            }

            lblStatusMessage.Text = "Settings updated successfully.";
            lblStatusMessage.Visible = true;
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Login.aspx");
        }
    }
}