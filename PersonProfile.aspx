<%@ Page Title="Person Investigation Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PersonProfile.aspx.cs" Inherits="Netra.PersonProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .profile-container {
            display: grid;
            grid-template-columns: 320px 1fr;
            gap: 20px;
        }

        .glass-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .profile-img-large {
            width: 100%;
            height: 280px;
            object-fit: cover;
            border-radius: 8px;
            border: 2px solid #00d2ff;
            margin-bottom: 12px;
            background-color: #070d18;
            display: block;
        }

        .badge-status {
            background: rgba(239, 68, 68, 0.2);
            color: #f87171;
            border: 1px solid #ef4444;
            font-size: 0.7rem;
            font-weight: 800;
            padding: 6px 10px;
            border-radius: 4px;
            text-align: center;
            display: block;
            margin-bottom: 10px;
            letter-spacing: 0.8px;
        }

        .profile-name {
            font-size: 1.5rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 4px;
        }

        .profile-role {
            font-size: 0.72rem;
            font-weight: 800;
            color: #38bdf8;
            letter-spacing: 0.8px;
            text-transform: uppercase;
            margin-bottom: 16px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 14px;
            margin-bottom: 20px;
        }

        .info-box {
            background-color: #070d18;
            border: 1px solid #1e293b;
            padding: 12px;
            border-radius: 6px;
        }

        .info-label {
            font-size: 0.65rem;
            font-weight: 800;
            color: #64748b;
            text-transform: uppercase;
            margin-bottom: 4px;
        }

        .info-val {
            font-size: 0.85rem;
            font-weight: 800;
            color: #ffffff;
        }

        .table-custom {
            width: 100%;
            border-collapse: collapse;
        }

        .table-custom th {
            background: #070d18;
            color: #64748b;
            font-size: 0.68rem;
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #1e293b;
        }

        .table-custom td {
            padding: 12px 10px;
            font-size: 0.78rem;
            color: #cbd5e1;
            border-bottom: 1px solid #1e293b;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="font-size: 0.75rem; color: #64748b; margin-bottom: 14px;">
        <a href="PersonsDirectory.aspx" style="color:#00d2ff; text-decoration:none; font-weight:700;">← Back to Persons Directory</a>
    </div>

    <div class="profile-container">
        <!-- Left Sidebar Photo Card -->
        <div>
            <div class="glass-card" style="text-align: center;">
                <asp:Image ID="imgPersonPhoto" runat="server" CssClass="profile-img-large" onerror="handleImageError(this);" />
                
                <div id="avatarFallback" style="display:none; width:100%; height:280px; border-radius:8px; border:2px solid #00d2ff; background:#070d18; align-items:center; justify-content:center; flex-direction:column; margin-bottom:12px;">
                    <div style="font-size:3rem; color:#00d2ff;">👤</div>
                    <div style="font-size:0.75rem; color:#64748b; font-weight:800; margin-top:6px;">PHOTO CLASSIFIED</div>
                </div>

                <div class="badge-status">• ACTIVE INVESTIGATION</div>
                <div style="font-size: 0.72rem; color: #64748b;">ID: <asp:Label ID="lblPersonID" runat="server" Text="PR-1042-89"></asp:Label></div>
            </div>
        </div>

        <!-- Right Detail Content -->
        <div>
            <div class="glass-card">
                <div class="profile-name"><asp:Label ID="lblFullName" runat="server" Text="Keval Goswami"></asp:Label></div>
                <div class="profile-role"><asp:Label ID="lblPersonType" runat="server" Text="SUSPECT / PERSON OF INTEREST"></asp:Label></div>

                <div class="info-grid">
                    <div class="info-box">
                        <div class="info-label">Date of Birth</div>
                        <div class="info-val"><asp:Label ID="lblDOB" runat="server" Text="06-06-2006"></asp:Label></div>
                    </div>

                    <div class="info-box">
                        <div class="info-label">National ID / Passport</div>
                        <div class="info-val"><asp:Label ID="lblNationalID" runat="server" Text="X99 - 101"></asp:Label></div>
                    </div>

                    <div class="info-box">
                        <div class="info-label">Known Aliases</div>
                        <div class="info-val"><asp:Label ID="lblAlias" runat="server" Text="JD / Ghost"></asp:Label></div>
                    </div>
                </div>
            </div>

            <div class="glass-card">
                <div style="font-size:0.9rem; font-weight:800; color:#fff; margin-bottom:12px;">📁 Associated Cases</div>
                <table class="table-custom">
                    <thead>
                        <tr>
                            <th>CASE ID</th>
                            <th>DESCRIPTION</th>
                            <th>ROLE</th>
                            <th>STATUS</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td style="color:#00d2ff; font-weight:700;"><asp:Label ID="lblCase1ID" runat="server" Text="OP - 2023 - A9"></asp:Label></td>
                            <td><asp:Label ID="lblCase1Desc" runat="server" Text="Financial Syndicate Subversion"></asp:Label></td>
                            <td>Primary Suspect</td>
                            <td><span style="background:rgba(239,68,68,0.2); color:#f87171; padding:2px 8px; border-radius:4px; font-size:0.68rem; font-weight:700;">Open</span></td>
                        </tr>
                        <tr>
                            <td style="color:#00d2ff; font-weight:700;"><asp:Label ID="lblCase2ID" runat="server" Text="OP - 2022 - C4"></asp:Label></td>
                            <td><asp:Label ID="lblCase2Desc" runat="server" Text="Cross-Border Smuggling Ring"></asp:Label></td>
                            <td>Associate</td>
                            <td><span style="background:rgba(100,116,139,0.2); color:#94a3b8; padding:2px 8px; border-radius:4px; font-size:0.68rem; font-weight:700;">Closed</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        function handleImageError(img) {
            img.style.display = 'none';
            document.getElementById('avatarFallback').style.display = 'flex';
        }
    </script>
</asp:Content>