<%@ Page Title="Settings" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="Netra.Settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-title {
            font-size: 1.4rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 4px;
        }

        .settings-container {
            display: grid;
            grid-template-columns: 240px 1fr;
            gap: 20px;
            margin-top: 20px;
        }

        .glass-panel {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 20px;
        }

        .nav-list {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .nav-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 14px;
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 700;
            color: #64748b;
            text-decoration: none;
            transition: all 0.2s ease;
            cursor: pointer;
        }

        .nav-item:hover, .nav-item.active {
            background-color: #070d18;
            color: #00d2ff;
            border-left: 3px solid #00d2ff;
        }

        .logout-btn-link {
            background: none;
            border: none;
            width: 100%;
            text-align: left;
            color: #f87171;
            margin-top: 12px;
            border-top: 1px solid #1e293b;
            padding: 14px 14px 10px 14px;
            font-size: 0.8rem;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .logout-btn-link:hover {
            background-color: rgba(239, 68, 68, 0.1);
            color: #ef4444;
        }

        .profile-header {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 24px;
        }

        .profile-avatar {
            width: 72px;
            height: 72px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #00d2ff;
        }

        .btn-cyan {
            background-color: #00d2ff;
            color: #070d18;
            border: none;
            padding: 9px 18px;
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 800;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-cyan:hover {
            box-shadow: 0 0 12px rgba(0, 210, 255, 0.4);
        }

        .btn-outline {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            color: #cbd5e1;
            padding: 9px 16px;
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 700;
            cursor: pointer;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
            margin-bottom: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .form-label {
            font-size: 0.62rem;
            font-weight: 800;
            color: #64748b;
            text-transform: uppercase;
        }

        .form-input {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 9px 12px;
            color: #ffffff;
            font-size: 0.8rem;
            outline: none;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-title">Settings</div>
    <div style="font-size:0.75rem; color:#64748b;">Manage your account, preferences, and profile settings.</div>

    <div class="settings-container">
        <!-- Sidebar Navigation -->
        <div class="glass-panel">
            <div class="nav-list">
                <div class="nav-item active">👤 Profile</div>
                <div class="nav-item">🛡 Security</div>
                <div class="nav-item">🔔 Notifications</div>
                <div class="nav-item">🎨 Appearance</div>
                <asp:Button ID="btnLogout" runat="server" Text="🚪 Session Logout" CssClass="logout-btn-link" OnClick="btnLogout_Click" OnClientClick="return confirm('Are you sure you want to log out?');" />
            </div>
        </div>

        <!-- Settings Content Body -->
        <div class="glass-panel">
            <div style="font-size:0.95rem; font-weight:800; color:#fff; margin-bottom:16px;">👤 Profile Information</div>

            <asp:Label ID="lblStatusMessage" runat="server" ForeColor="#10b981" Font-Bold="true" Font-Size="Small" Visible="false" Style="display:block; margin-bottom:12px;"></asp:Label>

            <div class="profile-header">
                <img src="Images/Meet.jpeg" class="profile-avatar" alt="Meet Kotecha" onerror="this.onerror=null; this.src='Images/Meet.jpeg';" />
                <div>
                    <div style="font-size:0.8rem; font-weight:800; color:#fff;">Profile Picture</div>
                    <div style="font-size:0.7rem; color:#64748b; margin-bottom:8px;">JPG, PNG or GIF. Max size 2MB.</div>
                    <div style="display:flex; gap:8px;">
                        <button type="button" class="btn-cyan" style="padding:6px 12px; font-size:0.72rem;">Upload New</button>
                        <button type="button" class="btn-outline" style="padding:6px 12px; font-size:0.72rem;">Remove</button>
                    </div>
                </div>
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <label class="form-label">FULL NAME</label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-input"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="form-label">EMAIL ADDRESS</label>
                    <asp:TextBox ID="txtEmailAddress" runat="server" CssClass="form-input"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="form-label">ROLE</label>
                    <input type="text" class="form-input" value="Intelligence Analyst" readonly />
                </div>
                <div class="form-group">
                    <label class="form-label">DEPARTMENT</label>
                    <input type="text" class="form-input" value="Crime Intelligence Unit" readonly />
                </div>
            </div>

            <div style="display:flex; justify-content:flex-end; gap:10px; border-top:1px solid #1e293b; padding-top:16px;">
                <asp:Button ID="btnSaveChanges" runat="server" Text="💾 Save Changes" CssClass="btn-cyan" OnClick="btnSaveChanges_Click" />
            </div>
        </div>
    </div>
</asp:Content>