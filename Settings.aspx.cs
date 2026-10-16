using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace Netra
{
    public partial class Settings : Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["NetraConnStr"] != null
            ? ConfigurationManager.ConnectionStrings["NetraConnStr"].ConnectionString
            : @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=NetraDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUserProfile();
            }
            else if (fileUploadPicture.HasFile)
            {
                UploadProfilePicture();
            }
        }

        private void LoadUserProfile()
        {
            if (Session["UserName"] != null)
            {
                txtFullName.Text = Session["UserName"].ToString();
            }

            if (Session["UserEmail"] != null)
            {
                txtEmail.Text = Session["UserEmail"].ToString();
            }

            if (Session["UserProfilePic"] != null)
            {
                imgProfile.ImageUrl = Session["UserProfilePic"].ToString();
            }
        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            try
            {
                string newName = txtFullName.Text.Trim();
                string newEmail = txtEmail.Text.Trim();
                string newDept = txtDepartment.Text.Trim();

                // 1. Update Session Variables
                Session["UserName"] = newName;
                Session["UserEmail"] = newEmail;

                // Derive initials for header avatar (e.g., Meet Kotecha -> MK)
                string[] parts = newName.Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
                string initials = parts.Length >= 2
                    ? $"{parts[0][0]}{parts[1][0]}".ToUpper()
                    : (parts.Length == 1 ? parts[0][0].ToString().ToUpper() : "MK");

                Session["UserInitials"] = initials;

                // 2. Persist to NetraDB database
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    string query = "UPDATE Users SET FullName = @FullName, Email = @Email, Department = @Dept WHERE UserID = 1";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@FullName", newName);
                        cmd.Parameters.AddWithValue("@Email", newEmail);
                        cmd.Parameters.AddWithValue("@Dept", newDept);
                        cmd.ExecuteNonQuery();
                    }
                }

                lblStatus.CssClass = "alert-msg alert-success";
                lblStatus.Text = "✅ Profile details updated successfully!";
                lblStatus.Visible = true;

                // Refresh page header
                Response.Redirect("Settings.aspx");
            }
            catch (Exception ex)
            {
                lblStatus.CssClass = "alert-msg alert-error";
                lblStatus.Text = "❌ Error saving changes: " + ex.Message;
                lblStatus.Visible = true;
            }
        }

        private void UploadProfilePicture()
        {
            try
            {
                string ext = Path.GetExtension(fileUploadPicture.FileName).ToLower();
                if (ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".gif")
                {
                    string folderPath = Server.MapPath("~/Images/");
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }

                    string fileName = "Profile_" + DateTime.Now.Ticks + ext;
                    string savePath = Path.Combine(folderPath, fileName);
                    fileUploadPicture.SaveAs(savePath);

                    string relativePath = "~/Images/" + fileName;
                    imgProfile.ImageUrl = relativePath;
                    Session["UserProfilePic"] = relativePath;

                    using (SqlConnection con = new SqlConnection(connStr))
                    {
                        con.Open();
                        string query = "UPDATE Users SET ProfilePicturePath = @Path WHERE UserID = 1";
                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            cmd.Parameters.AddWithValue("@Path", "Images/" + fileName);
                            cmd.ExecuteNonQuery();
                        }
                    }

                    lblStatus.CssClass = "alert-msg alert-success";
                    lblStatus.Text = "✅ Profile picture updated!";
                    lblStatus.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblStatus.CssClass = "alert-msg alert-error";
                lblStatus.Text = "❌ Image upload failed: " + ex.Message;
                lblStatus.Visible = true;
            }
        }

        protected void btnRemovePic_Click(object sender, EventArgs e)
        {
            imgProfile.ImageUrl = "~/Images/Meet.jpeg";
            Session["UserProfilePic"] = "~/Images/Meet.jpeg";
            lblStatus.CssClass = "alert-msg alert-success";
            lblStatus.Text = "Profile picture reset to default.";
            lblStatus.Visible = true;
        }
    }
}