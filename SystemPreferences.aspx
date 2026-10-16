<%@ Page Title="System Preferences" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SystemPreferences.aspx.cs" Inherits="Netra.SystemPreferences" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
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

        /* 2-Column Split Grid */
        .preferences-grid {
            display: grid;
            grid-template-columns: 1fr 340px;
            gap: 20px;
            align-items: start;
            margin-bottom: 30px;
        }

        @media (max-width: 1024px) {
            .preferences-grid {
                grid-template-columns: 1fr;
            }
        }

        .glass-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 22px;
        }

        .panel-header {
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

        /* Form Fields Grid */
        .form-fields-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
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

        .form-select {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 10px 12px;
            color: #ffffff;
            font-size: 0.8rem;
            outline: none;
            cursor: pointer;
            transition: border-color 0.2s ease;
        }

        .form-select:focus {
            border-color: #00d2ff;
        }

        /* Footer Action Controls */
        .footer-divider {
            border: none;
            border-top: 1px solid #1e293b;
            margin-bottom: 20px;
        }

        .footer-action-bar {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
        }

        .btn-cancel-outline {
            background-color: #070d18;
            border: 1px solid #1e293b;
            color: #cbd5e1;
            padding: 10px 24px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-cancel-outline:hover {
            border-color: #64748b;
            color: #ffffff;
        }

        .btn-save-cyan {
            background-color: #00d2ff;
            border: none;
            color: #070d18;
            padding: 10px 24px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 800;
            cursor: pointer;
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
        <div class="page-title">System Preferences</div>
        <div class="page-sub-text">Configure your default data, regional and application preferences.</div>
    </div>

    <!-- Main Grid -->
    <div class="preferences-grid">
        <!-- Default Data Preferences Panel -->
        <div class="glass-card">
            <div class="panel-header">
                <span>🗄️ Default Data Preferences</span>
            </div>

            <div class="form-fields-grid">
                <div class="field-group">
                    <label class="field-label">DEFAULT DISTRICT</label>
                    <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="form-select">
                        <asp:ListItem Text="Bengaluru Urban" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Bengaluru Rural"></asp:ListItem>
                        <asp:ListItem Text="Mysuru"></asp:ListItem>
                        <asp:ListItem Text="Mangaluru"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="field-group">
                    <label class="field-label">DEFAULT DATE RANGE</label>
                    <asp:DropDownList ID="ddlDateRange" runat="server" CssClass="form-select">
                        <asp:ListItem Text="Last 30 Days" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Last 7 Days"></asp:ListItem>
                        <asp:ListItem Text="Last 90 Days"></asp:ListItem>
                        <asp:ListItem Text="Year to Date"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="field-group">
                    <label class="field-label">DEFAULT CRIME TYPE</label>
                    <asp:DropDownList ID="ddlCrimeType" runat="server" CssClass="form-select">
                        <asp:ListItem Text="All Crime Types" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Cybercrime"></asp:ListItem>
                        <asp:ListItem Text="Vehicle Theft"></asp:ListItem>
                        <asp:ListItem Text="Narcotics"></asp:ListItem>
                        <asp:ListItem Text="Financial Fraud"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="field-group">
                    <label class="field-label">DEFAULT SEVERITY</label>
                    <asp:DropDownList ID="ddlSeverity" runat="server" CssClass="form-select">
                        <asp:ListItem Text="All Severities" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Critical"></asp:ListItem>
                        <asp:ListItem Text="High"></asp:ListItem>
                        <asp:ListItem Text="Medium"></asp:ListItem>
                        <asp:ListItem Text="Low"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
        </div>

        <!-- Regional Settings Panel -->
        <div class="glass-card">
            <div class="panel-header">
                <span>🌐 Regional</span>
            </div>

            <div style="display:flex; flex-direction:column; gap:16px;">
                <div class="field-group">
                    <label class="field-label">LANGUAGE</label>
                    <asp:DropDownList ID="ddlLanguage" runat="server" CssClass="form-select">
                        <asp:ListItem Text="English" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Hindi"></asp:ListItem>
                        <asp:ListItem Text="Kannada"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="field-group">
                    <label class="field-label">TIME ZONE</label>
                    <asp:DropDownList ID="ddlTimeZone" runat="server" CssClass="form-select">
                        <asp:ListItem Text="IST (UTC+05:30)" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="UTC (Coordinated Universal Time)"></asp:ListItem>
                        <asp:ListItem Text="EST (UTC-05:00)"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="form-fields-grid">
                    <div class="field-group">
                        <label class="field-label">DATE</label>
                        <asp:DropDownList ID="ddlDateFormat" runat="server" CssClass="form-select">
                            <asp:ListItem Text="DD/MM/YYYY" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="MM/DD/YYYY"></asp:ListItem>
                            <asp:ListItem Text="YYYY-MM-DD"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="field-group">
                        <label class="field-label">TIME</label>
                        <asp:DropDownList ID="ddlTimeFormat" runat="server" CssClass="form-select">
                            <asp:ListItem Text="24-hour" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="12-hour (AM/PM)"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <hr class="footer-divider" />

    <!-- Action Buttons -->
    <div class="footer-action-bar">
        <button type="button" class="btn-cancel-outline" onclick="window.location.href='Settings.aspx';">Cancel</button>
        <button type="button" class="btn-save-cyan" onclick="alert('✅ System preferences saved successfully.');">Save System Preferences</button>
    </div>
</asp:Content>