<%@ Page Title="Settings" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="Netra.Settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .settings-container {
            display: grid;
            grid-template-columns: 220px 1fr;
            gap: 24px;
        }

        .settings-menu {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 12px;
        }

        .menu-btn {
            display: flex;
            align-items: center;
            gap: 10px;
            width: 100%;
            padding: 10px 14px;
            background: none;
            border: none;
            color: #64748b;
            font-size: 0.82rem;
            font-weight: 600;
            border-radius: 6px;
            cursor: pointer;
            text-align: left;
            margin-bottom: 4px;
        }

        .menu-btn.active {
            background-color: #12283e;
            color: #00d2ff;
        }

        .settings-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 24px;
        }

        .card-header-title {
            font-size: 1rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .profile-img-preview {
            width: 72px;
            height: 72px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #00d2ff;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
            margin-top: 20px;
        }

        .form-group label {
            display: block;
            font-size: 0.68rem;
            font-weight: 800;
            color: #64748b;
            letter-spacing: 0.8px;
            text-transform: uppercase;
            margin-bottom: 6px;
        }

        .form-input {
            width: 100%;
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 9px 12px;
            color: #ffffff;
            font-size: 0.82rem;
            outline: none;
        }

        .form-input:focus {
            border-color: #00d2ff;
        }

        .btn-cyan {
            background-color: #00d2ff;
            color: #070d18;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 0.82rem;
            font-weight: 800;
            cursor: pointer;
            transition: opacity 0.2s ease;
        }

        .btn-cyan:hover {
            opacity: 0.9;
        }

        .alert-msg {
            padding: 10px 14px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 600;
            margin-bottom: 16px;
            display: block;
        }

        .alert-success { background: rgba(34, 197, 94, 0.15); color: #4ade80; border: 1px solid #22c55e; }
        .alert-error { background: rgba(239, 68, 68, 0.15); color: #f87171; border: 1px solid #ef4444; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="margin-bottom: 20px;">
        <h2 style="font-size: 1.4rem; font-weight: 800; color: #fff;">Settings</h2>
        <span style="font-size: 0.78rem; color: #64748b;">Manage your account, preferences, and profile settings.</span>
    </div>

    <asp:Label ID="lblStatus" runat="server" Visible="false"></asp:Label>

    <div class="settings-container">
        <!-- Left Submenu -->
        <div class="settings-menu">
            <button type="button" class="menu-btn active">👤 Profile</button>
            <button type="button" class="menu-btn" onclick="window.location.href='SecuritySettings.aspx';">🛡️ Security</button>
            <button type="button" class="menu-btn" onclick="window.location.href='NotificationSettings.aspx';">🔔 Notifications</button>
            <button type="button" class="menu-btn" onclick="window.location.href='AppearanceSettings.aspx';">🎨 Appearance</button>
        </div>

        <!-- Right Content Card -->
        <div class="settings-card">
            <div class="card-header-title">👤 Profile Information</div>

            <!-- Profile Image Section -->
            <div style="display: flex; align-items: center; gap: 20px; margin-bottom: 20px;">
                <asp:Image ID="imgProfile" runat="server" ImageUrl="~/Images/Meet.jpeg" CssClass="profile-img-preview" />
                <div>
                    <label style="display:block; font-size: 0.78rem; font-weight: 700; color: #fff; margin-bottom: 4px;">Profile Picture</label>
                    <span style="display:block; font-size: 0.68rem; color: #64748b; margin-bottom: 10px;">JPG, PNG or GIF. Max size 2MB.</span>
                    
                    <div style="display:flex; gap:10px; align-items:center;">
                        <asp:FileUpload ID="fileUploadPicture" runat="server" Style="display:none;" onchange="this.form.submit();" />
                        <button type="button" class="btn-cyan" onclick="document.getElementById('<%= fileUploadPicture.ClientID %>').click();">Upload New</button>
                        <asp:Button ID="btnRemovePic" runat="server" Text="Remove" OnClick="btnRemovePic_Click" Style="background:#1e293b; color:#cbd5e1; border:none; padding:10px 16px; border-radius:6px; font-size:0.82rem; font-weight:700; cursor:pointer;" />
                    </div>
                </div>
            </div>

            <!-- Form Inputs -->
            <div class="form-grid">
                <div class="form-group">
                    <label>Full Name</label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-input" Text="Meet Kotecha"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" Text="mkotecha581@rku.ac.in"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Role</label>
                    <asp:TextBox ID="txtRole" runat="server" CssClass="form-input" Text="Intelligence Analyst" ReadOnly="true" Style="opacity:0.6;"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Department</label>
                    <asp:TextBox ID="txtDepartment" runat="server" CssClass="form-input" Text="Crime Intelligence Unit"></asp:TextBox>
                </div>
            </div>

            <div style="display: flex; justify-content: flex-end; margin-top: 24px;">
                <asp:Button ID="btnSaveChanges" runat="server" Text="💾 Save Changes" OnClick="btnSaveChanges_Click" CssClass="btn-cyan" />
            </div>
        </div>
    </div>
</asp:Content>