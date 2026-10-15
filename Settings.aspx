<%@ Page Title="Settings" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="Netra.Settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Top Page Header */
        .page-header-row {
            margin-bottom: 24px;
        }

        .page-title {
            font-size: 1.4rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 4px;
        }

        .page-sub-text {
            font-size: 0.78rem;
            color: #64748b;
        }

        /* 2-Column Split Settings Layout */
        .settings-grid {
            display: grid;
            grid-template-columns: 240px 1fr;
            gap: 20px;
            align-items: start;
        }

        @media (max-width: 900px) {
            .settings-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Left Settings Navigation Card */
        .settings-nav-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 10px;
        }

        .settings-nav-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 14px;
            color: #94a3b8;
            font-size: 0.78rem;
            font-weight: 600;
            border-radius: 6px;
            cursor: pointer;
            margin-bottom: 4px;
            transition: all 0.2s ease;
        }

        .settings-nav-item:hover {
            background-color: #12283e;
            color: #38bdf8;
        }

        .settings-nav-item.active {
            background-color: #12283e;
            color: #38bdf8;
            font-weight: 700;
            border-left: 3px solid #38bdf8;
        }

        /* Right Panel Glass Card */
        .settings-content-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 24px;
        }

        .panel-section-header {
            font-size: 0.95rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 8px;
            border-bottom: 1px solid #1e293b;
            padding-bottom: 14px;
        }

        /* Profile Picture Block */
        .avatar-upload-row {
            display: flex;
            align-items: center;
            gap: 18px;
            margin-bottom: 24px;
        }

        .avatar-preview-box {
            width: 70px;
            height: 70px;
            border-radius: 8px;
            background-color: #070d18;
            border: 1px solid #1e293b;
            overflow: hidden;
            flex-shrink: 0;
        }

        .avatar-preview-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .avatar-text-lbl {
            font-size: 0.8rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 4px;
        }

        .avatar-sub-lbl {
            font-size: 0.68rem;
            color: #64748b;
            margin-bottom: 10px;
        }

        .avatar-btn-row {
            display: flex;
            gap: 8px;
        }

        .btn-upload-cyan {
            background-color: #00d2ff;
            border: none;
            color: #070d18;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 0.72rem;
            font-weight: 800;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-upload-cyan:hover {
            opacity: 0.9;
            box-shadow: 0 0 10px rgba(0, 210, 255, 0.4);
        }

        .btn-remove-outline {
            background-color: #070d18;
            border: 1px solid #1e293b;
            color: #cbd5e1;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 0.72rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-remove-outline:hover {
            border-color: #ef4444;
            color: #ef4444;
        }

        /* Form Grid */
        .form-fields-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
            margin-bottom: 24px;
        }

        @media (max-width: 768px) {
            .form-fields-grid {
                grid-template-columns: 1fr;
            }
        }

        .field-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .field-label {
            font-size: 0.62rem;
            font-weight: 800;
            color: #64748b;
            letter-spacing: 0.8px;
            text-transform: uppercase;
        }

        .form-input {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 10px 12px;
            color: #ffffff;
            font-size: 0.8rem;
            outline: none;
            transition: border-color 0.2s ease;
        }

        .form-input:focus {
            border-color: #38bdf8;
        }

        .form-input.readonly {
            background-color: #09121f;
            color: #64748b;
            border-color: #1a2536;
            cursor: not-allowed;
        }

        /* Save Actions Footer */
        .panel-footer-actions {
            display: flex;
            justify-content: flex-end;
            border-top: 1px solid #1e293b;
            padding-top: 18px;
        }

        .btn-save-cyan {
            background-color: #00d2ff;
            border: none;
            color: #070d18;
            padding: 10px 22px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 800;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s ease;
        }

        .btn-save-cyan:hover {
            opacity: 0.9;
            box-shadow: 0 0 14px rgba(0, 210, 255, 0.4);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Page Header -->
    <div class="page-header-row">
        <div class="page-title">Settings</div>
        <div class="page-sub-text">Manage your account, preferences and application settings.</div>
    </div>

    <!-- Main Split Settings Grid -->
    <div class="settings-grid">
        <!-- Left Navigation Panel -->
        <div class="settings-nav-card">
            <div class="settings-nav-item active" onclick="switchTab(this, 'profileTab')">
                <span>👤</span> Profile
            </div>
            <div class="settings-nav-item" onclick="switchTab(this, 'securityTab')">
                <span>🛡️</span> Security
            </div>
            <div class="settings-nav-item" onclick="switchTab(this, 'notificationsTab')">
                <span>🔔</span> Notifications
            </div>
            <div class="settings-nav-item" onclick="switchTab(this, 'appearanceTab')">
                <span>🎨</span> Appearance
            </div>
            <div class="settings-nav-item" onclick="switchTab(this, 'systemTab')">
                <span>💻</span> System Preferences
            </div>
        </div>

        <!-- Right Content Panel -->
        <div class="settings-content-card">
            <div class="panel-section-header">
                <span>👤 Profile Information</span>
            </div>

            <!-- Profile Picture Section -->
            <div class="avatar-upload-row">
                <div class="avatar-preview-box">
                    <img id="imgAvatarPreview" src="Images/Digvijay.jpeg" alt="Alex Silva Profile" onerror="this.src='Images/Rohan.jpeg';" />
                </div>
                <div>
                    <div class="avatar-text-lbl">Profile Picture</div>
                    <div class="avatar-sub-lbl">JPG, GIF or PNG. Max size of 800K.</div>
                    
                    <asp:FileUpload ID="fileUploadAvatar" runat="server" Style="display:none;" onchange="previewNewAvatar(this)" />
                    <div class="avatar-btn-row">
                        <button type="button" class="btn-upload-cyan" onclick="document.getElementById('<%= fileUploadAvatar.ClientID %>').click();">Upload New</button>
                        <button type="button" class="btn-remove-outline" onclick="removeAvatar()">Remove</button>
                    </div>
                </div>
            </div>

            <!-- Form Fields Grid -->
            <div class="form-fields-grid">
                <div class="field-group">
                    <label class="field-label">FULL NAME</label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-input" Text="Alex Silva"></asp:TextBox>
                </div>

                <div class="field-group">
                    <label class="field-label">EMAIL ADDRESS</label>
                    <asp:TextBox ID="txtEmailAddress" runat="server" CssClass="form-input" Text="analyst@netra.gov"></asp:TextBox>
                </div>

                <div class="field-group">
                    <label class="field-label">ROLE</label>
                    <input type="text" class="form-input readonly" value="Intelligence Analyst" readonly="readonly" />
                </div>

                <div class="field-group">
                    <label class="field-label">DEPARTMENT</label>
                    <input type="text" class="form-input readonly" value="Crime Intelligence Unit" readonly="readonly" />
                </div>
            </div>

            <!-- Save Action Button -->
            <div class="panel-footer-actions">
                <button type="button" class="btn-save-cyan" onclick="saveSettings()">
                    💾 Save Changes
                </button>
            </div>
        </div>
    </div>

    <!-- Client Script -->
    <script>
        function switchTab(elem, tabName) {
            document.querySelectorAll('.settings-nav-item').forEach(item => {
                item.classList.remove('active');
            });
            elem.classList.add('active');
        }

        function previewNewAvatar(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    document.getElementById("imgAvatarPreview").src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        function removeAvatar() {
            document.getElementById("imgAvatarPreview").src = "Images/Rohan.jpeg";
            alert("Avatar reset to default.");
        }

        function saveSettings() {
            alert("✅ Profile settings updated successfully.");
        }
    </script>
</asp:Content>