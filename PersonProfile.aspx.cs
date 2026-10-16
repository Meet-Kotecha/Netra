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
                string id = Request.QueryString["id"];
                LoadPersonData(id);
            }
        }

        private void LoadPersonData(string personId)
        {
            switch (personId)
            {
                case "101":
                    lblFullName.Text = "Digvijaysinh Vaghela";
                    lblPersonType.Text = "SUSPECT / HIGH RISK TARGET";
                    lblPersonID.Text = "PR-883-902-11A";
                    lblDOB.Text = "14-09-2002 (24 yrs)";
                    lblNationalID.Text = "DXB - 99182";
                    lblAlias.Text = "Vaghela / Sector 4 Contact";
                    imgPersonPhoto.Src = "Images/Digvijay.jpeg";
                    lblCase1ID.Text = "OP - 2023 - A9";
                    lblCase1Desc.Text = "Industrial Security Subversion & Asset Hijack";
                    lblCase2ID.Text = "CR - 2024 - 102";
                    lblCase2Desc.Text = "Dubai Sector 4 Traffic Interception";
                    break;

                case "102":
                    lblFullName.Text = "Rohan Siddhpura";
                    lblPersonType.Text = "PERSON OF INTEREST (POI)";
                    lblPersonID.Text = "PR-UNK-442-998";
                    lblDOB.Text = "22-03-2001 (25 yrs)";
                    lblNationalID.Text = "DE - 772109";
                    lblAlias.Text = "Alpha / Transit Node";
                    imgPersonPhoto.Src = "Images/Rohan.jpeg";
                    lblCase1ID.Text = "CS - 2023 - 08A";
                    lblCase1Desc.Text = "International Data Relay Surveillance";
                    lblCase2ID.Text = "CS - 2022 - 19B";
                    lblCase2Desc.Text = "Encrypted Network Node Manipulation";
                    break;

                case "103":
                    lblFullName.Text = "Meet Kotecha";
                    lblPersonType.Text = "PERSON OF INTEREST / SYSTEM ARCHITECT";
                    lblPersonID.Text = "PR-990-112-44C";
                    lblDOB.Text = "05-11-2003 (23 yrs)";
                    lblNationalID.Text = "IND - 442100";
                    lblAlias.Text = "MK / Netra Core";
                    imgPersonPhoto.Src = "Images/Meet.jpeg";
                    lblCase1ID.Text = "NETRA - DEV - 01";
                    lblCase1Desc.Text = "Neural Intelligence Unit Lead Engineer";
                    lblCase2ID.Text = "OP - 2026 - SEC";
                    lblCase2Desc.Text = "GIS Map & Analytics Subsystem Sync";
                    break;

                default: // Keval Goswami (id=1 or default)
                    lblFullName.Text = "Keval Goswami";
                    lblPersonType.Text = "SUSPECT / PERSON OF INTEREST";
                    lblPersonID.Text = "PR-1042-89";
                    lblDOB.Text = "06-06-2006 (20 yrs)";
                    lblNationalID.Text = "X99 - 101";
                    lblAlias.Text = "JD / Ghost";
                    imgPersonPhoto.Src = "Images/Keval.jpeg";
                    lblCase1ID.Text = "OP - 2023 - A9";
                    lblCase1Desc.Text = "Financial Syndicate Subversion";
                    lblCase2ID.Text = "OP - 2022 - C4";
                    lblCase2Desc.Text = "Cross-Border Smuggling Ring";
                    break;
            }
        }
    }
}