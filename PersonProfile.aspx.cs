using System;
using System.Web.UI;

namespace Netra
{
    public partial class PersonProfile : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["name"]))
                {
                    lblSubjectName.Text = Server.UrlDecode(Request.QueryString["name"]);
                }

                if (!string.IsNullOrEmpty(Request.QueryString["id"]))
                {
                    lblSubjectId.Text = "ID: " + Server.UrlDecode(Request.QueryString["id"]);
                    lblSubjectPassport.Text = "X99 - " + Server.UrlDecode(Request.QueryString["id"]);
                }

                if (!string.IsNullOrEmpty(Request.QueryString["dob"]))
                {
                    lblSubjectDob.Text = Server.UrlDecode(Request.QueryString["dob"]);
                }

                if (!string.IsNullOrEmpty(Request.QueryString["img"]))
                {
                    imgProfileMugshot.ImageUrl = Server.UrlDecode(Request.QueryString["img"]);
                }
            }
        }
    }
}