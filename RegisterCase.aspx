<%@ Page Title="Register New Crime Case" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegisterCase.aspx.cs" Inherits="Netra.RegisterCase" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-header-title {
            font-size: 1.35rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 20px;
        }

        /* Two-Column Form Layout */
        .form-grid {
            display: grid;
            grid-template-columns: 1.8fr 1fr;
            gap: 20px;
            width: 100%;
            margin-bottom: 25px;
        }

        @media (max-width: 1200px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
        }

        .card-panel {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            width: 100%;
        }

        .panel-header {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.95rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 18px;
            padding-bottom: 10px;
            border-bottom: 1px solid #1a2536;
        }

        .panel-header-icon {
            color: #00d2ff;
        }

        /* Form Grid Controls */
        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 14px;
            margin-bottom: 14px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .form-label {
            font-size: 0.68rem;
            font-weight: 700;
            letter-spacing: 0.6px;
            color: #94a3b8;
            text-transform: uppercase;
        }

        .form-control {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 9px 12px;
            color: #f8fafc;
            font-size: 0.82rem;
            outline: none;
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
            width: 100%;
        }

        .form-control:focus {
            border-color: #00d2ff;
            box-shadow: 0 0 8px rgba(0, 210, 255, 0.2);
        }

        .form-control-readonly {
            background-color: #0d1626;
            color: #64748b;
            cursor: not-allowed;
        }

        textarea.form-control {
            resize: vertical;
            min-height: 100px;
            font-family: inherit;
        }

        /* Tag Input Pills */
        .tags-container {
            display: flex;
            gap: 8px;
            margin-top: 8px;
            flex-wrap: wrap;
        }

        .tag-pill {
            background-color: #162234;
            border: 1px solid #1e293b;
            color: #94a3b8;
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 0.72rem;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .tag-remove {
            color: #64748b;
            cursor: pointer;
            font-weight: 700;
        }

        .tag-remove:hover {
            color: #ef4444;
        }

        /* Interactive Map Container */
        .map-box {
            width: 100%;
            height: 140px;
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            margin-top: 10px;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            background-image: radial-gradient(#1e293b 1px, transparent 1px);
            background-size: 16px 16px;
        }

        .map-pin {
            font-size: 1.5rem;
            color: #f43f5e;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.15); }
            100% { transform: scale(1); }
        }

        .map-badge {
            position: absolute;
            bottom: 8px;
            left: 8px;
            background-color: #0b1320;
            border: 1px solid #1e293b;
            color: #00d2ff;
            font-size: 0.62rem;
            font-weight: 700;
            padding: 3px 8px;
            border-radius: 4px;
            letter-spacing: 0.8px;
        }

        /* Input Group with Action Button */
        .input-btn-group {
            display: flex;
            gap: 8px;
        }

        .btn-input-add {
            background-color: #162234;
            border: 1px solid #1e293b;
            color: #00d2ff;
            padding: 0 14px;
            border-radius: 6px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-input-add:hover {
            border-color: #00d2ff;
            background-color: #12283e;
        }

        /* Drag & Drop Upload Zone */
        .dropzone {
            border: 2px dashed #1e293b;
            border-radius: 8px;
            padding: 30px 20px;
            text-align: center;
            background-color: #070d18;
            cursor: pointer;
            transition: all 0.25s ease;
        }

        .dropzone:hover {
            border-color: #00d2ff;
            background-color: #0a1322;
        }

        .dropzone-icon {
            font-size: 1.8rem;
            color: #00d2ff;
            margin-bottom: 8px;
        }

        .dropzone-text {
            font-size: 0.82rem;
            color: #ffffff;
            font-weight: 600;
            margin-bottom: 4px;
        }

        .dropzone-sub {
            font-size: 0.7rem;
            color: #64748b;
        }

        /* Bottom Sticky Action Footer Bar */
        .form-action-bar {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 12px;
            padding-top: 15px;
            border-top: 1px solid #1e293b;
            margin-top: 10px;
        }

        .btn-sec {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            color: #94a3b8;
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 0.82rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-sec:hover {
            border-color: #38bdf8;
            color: #ffffff;
        }

        .btn-submit {
            background: linear-gradient(135deg, #00d2ff 0%, #00a8cc 100%);
            color: #070d18;
            border: none;
            padding: 10px 22px;
            border-radius: 6px;
            font-size: 0.82rem;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: all 0.25s ease;
        }

        .btn-submit:hover {
            opacity: 0.9;
            box-shadow: 0 0 15px rgba(0, 210, 255, 0.4);
            transform: translateY(-2px);
        }

        .val-msg {
            color: #ef4444;
            font-size: 0.72rem;
            margin-top: 3px;
            display: block;
        }

        .status-alert {
            color: #10b981;
            font-size: 0.85rem;
            margin-right: auto;
            font-weight: 600;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header-title">Register New Crime Case</div>

    <div class="form-grid">
        <!-- LEFT COLUMN -->
        <div>
            <!-- Panel 1: Case Information -->
            <div class="card-panel">
                <div class="panel-header">
                    <span class="panel-header-icon">📄</span> Case Information
                </div>

                <div class="form-row">
                    <div class="form-group" style="grid-column: span 2;">
                        <label class="form-label">Case Number (Auto-Generated)</label>
                        <asp:TextBox ID="txtCaseNumber" runat="server" CssClass="form-control form-control-readonly" ReadOnly="true" Text="CAS-2026-89932" />
                    </div>

                    <div class="form-group" style="grid-column: span 2;">
                        <label class="form-label">Crime Type</label>
                        <asp:DropDownList ID="ddlCrimeType" runat="server" CssClass="form-control">
                            <asp:ListItem Value="" Text="Select Type..." />
                            <asp:ListItem Value="Cyber Espionage" Text="Cyber Espionage" />
                            <asp:ListItem Value="Financial Fraud" Text="Financial Fraud" />
                            <asp:ListItem Value="Narcotics Distribution" Text="Narcotics Distribution" />
                            <asp:ListItem Value="Vehicle Theft" Text="Vehicle Theft" />
                            <asp:ListItem Value="Smuggling" Text="Smuggling" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvCrimeType" runat="server" ControlToValidate="ddlCrimeType"
                            InitialValue="" ErrorMessage="Please select a crime type." CssClass="val-msg" Display="Dynamic" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Incident Date</label>
                        <asp:TextBox ID="txtIncidentDate" runat="server" TextMode="Date" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="rfvDate" runat="server" ControlToValidate="txtIncidentDate"
                            ErrorMessage="Incident date required." CssClass="val-msg" Display="Dynamic" />
                    </div>

                    <div class="form-group">
                        <label class="form-label">Incident Time</label>
                        <asp:TextBox ID="txtIncidentTime" runat="server" TextMode="Time" CssClass="form-control" />
                    </div>

                    <div class="form-group" style="grid-column: span 2;">
                        <label class="form-label">Date Reported</label>
                        <asp:TextBox ID="txtDateReported" runat="server" TextMode="Date" CssClass="form-control" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Severity</label>
                        <asp:DropDownList ID="ddlSeverity" runat="server" CssClass="form-control">
                            <asp:ListItem Value="Critical" Text="Critical" Selected="True" />
                            <asp:ListItem Value="High" Text="High" />
                            <asp:ListItem Value="Medium" Text="Medium" />
                            <asp:ListItem Value="Low" Text="Low" />
                        </asp:DropDownList>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Case Status</label>
                        <asp:DropDownList ID="ddlCaseStatus" runat="server" CssClass="form-control" style="color:#00d2ff; font-weight:600;">
                            <asp:ListItem Value="Open - Under Investigation" Text="Open - Under Investigation" Selected="True" />
                            <asp:ListItem Value="Active" Text="Active" />
                            <asp:ListItem Value="Pending Legal" Text="Pending Legal" />
                            <asp:ListItem Value="Closed" Text="Closed" />
                        </asp:DropDownList>
                    </div>
                </div>
            </div>

            <!-- Panel 2: Case Description -->
            <div class="card-panel">
                <div class="panel-header">
                    <span class="panel-header-icon">≡</span> Case Description
                </div>
                <div class="form-group">
                    <label class="form-label">Detailed Summary</label>
                    <asp:TextBox ID="txtSummary" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control"
                        Placeholder="Enter comprehensive details of the incident..." />
                    <asp:RequiredFieldValidator ID="rfvSummary" runat="server" ControlToValidate="txtSummary"
                        ErrorMessage="Case summary is required." CssClass="val-msg" Display="Dynamic" />
                </div>
            </div>

            <!-- Panel 3: Investigation -->
            <div class="card-panel">
                <div class="panel-header">
                    <span class="panel-header-icon">🔍</span> Investigation
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Assigned Investigator</label>
                        <asp:TextBox ID="txtInvestigator" runat="server" CssClass="form-control" Placeholder="Search personnel..." />
                    </div>

                    <div class="form-group">
                        <label class="form-label">Modus Operandi (Tags)</label>
                        <asp:TextBox ID="txtModus" runat="server" CssClass="form-control" Placeholder="e.g., Phishing, Insider Threat, Nighttime..." />
                        <div class="tags-container">
                            <span class="tag-pill">Spear Phishing <span class="tag-remove">×</span></span>
                            <span class="tag-pill">Financial Gain <span class="tag-remove">×</span></span>
                        </div>
                    </div>
                </div>

                <div class="form-group" style="margin-top:12px;">
                    <label class="form-label">Initial Investigation Notes</label>
                    <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control"
                        Placeholder="Preliminary findings and next steps..." />
                </div>
            </div>
        </div>

        <!-- RIGHT COLUMN -->
        <div>
            <!-- Panel 4: Location Details -->
            <div class="card-panel">
                <div class="panel-header">
                    <span class="panel-header-icon">📍</span> Location Details
                </div>

                <div class="form-group" style="margin-bottom:12px;">
                    <label class="form-label">District / Region</label>
                    <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="form-control">
                        <asp:ListItem Value="Sector 7G" Text="Sector 7G" Selected="True" />
                        <asp:ListItem Value="District 1" Text="District 1" />
                        <asp:ListItem Value="District 2" Text="District 2" />
                        <asp:ListItem Value="District 3" Text="District 3" />
                    </asp:DropDownList>
                </div>

                <div class="form-group" style="margin-bottom:12px;">
                    <label class="form-label">Responding Police Station</label>
                    <asp:TextBox ID="txtStation" runat="server" CssClass="form-control" Placeholder="Station name or ID" />
                </div>

                <div class="form-group" style="margin-bottom:12px;">
                    <label class="form-label">Incident Address</label>
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" Placeholder="Full street address..." />
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Latitude</label>
                        <asp:TextBox ID="txtLat" runat="server" CssClass="form-control" Placeholder="00.000000" />
                    </div>
                    <div class="form-group">
                        <label class="form-label">Longitude</label>
                        <asp:TextBox ID="txtLng" runat="server" CssClass="form-control" Placeholder="00.000000" />
                    </div>
                </div>

                <!-- Dark Map Element -->
                <div class="map-box">
                    <div class="map-pin">📍</div>
                    <div class="map-badge">AWAITING COORDS</div>
                </div>
            </div>

            <!-- Panel 5: Related Persons -->
            <div class="card-panel">
                <div class="panel-header">
                    <span class="panel-header-icon">👥</span> Related Persons
                </div>

                <div class="form-group" style="margin-bottom:12px;">
                    <label class="form-label">Victim(s)</label>
                    <div class="input-btn-group">
                        <asp:TextBox ID="txtVictim" runat="server" CssClass="form-control" Placeholder="Search by name or ID..." />
                        <button type="button" class="btn-input-add">+</button>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Person of Interest / Suspect</label>
                    <div class="input-btn-group">
                        <asp:TextBox ID="txtSuspect" runat="server" CssClass="form-control" Placeholder="Search database..." />
                        <button type="button" class="btn-input-add">+</button>
                    </div>
                </div>
            </div>

            <!-- Panel 6: Evidence Attachments -->
            <div class="card-panel">
                <div class="panel-header">
                    <span class="panel-header-icon">📎</span> Evidence Attachments
                </div>

                <div class="dropzone" onclick="document.getElementById('<%= fileUpload.ClientID %>').click();">
                    <div class="dropzone-icon">☁️</div>
                    <div class="dropzone-text">Drag & drop files here</div>
                    <div class="dropzone-sub">or click to browse (Max 50MB)</div>
                    <asp:FileUpload ID="fileUpload" runat="server" Style="display:none;" />
                </div>
            </div>
        </div>
    </div>

    <!-- Bottom Sticky Action Bar -->
    <div class="form-action-bar">
        <asp:Label ID="lblStatus" runat="server" CssClass="status-alert"></asp:Label>
        <button type="button" class="btn-sec" onclick="window.location.href='CrimeCases.aspx';">Cancel</button>
        <asp:Button ID="btnSaveDraft" runat="server" Text="Save as Draft" CssClass="btn-sec" OnClick="btnSaveDraft_Click" UseSubmitBehavior="false" />
        <asp:Button ID="btnRegister" runat="server" Text="👤 Register Case" CssClass="btn-submit" OnClick="btnRegister_Click" />
    </div>
</asp:Content>