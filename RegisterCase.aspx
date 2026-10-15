<%@ Page Title="Register New Crime Case" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RegisterCase.aspx.cs" Inherits="Netra.RegisterCase" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 15px;
        }
        .form-card {
            background-color: #1e293b;
            border: 1px solid #334155;
            border-radius: 8px;
            padding: 20px;
        }
        .form-card h3 {
            color: #06b6d4;
            margin-top: 0;
            margin-bottom: 15px;
            font-size: 1.1rem;
            border-bottom: 1px solid #334155;
            padding-bottom: 8px;
        }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; font-size: 0.85rem; color: #94a3b8; margin-bottom: 5px; }
        .form-control {
            width: 100%;
            padding: 8px 12px;
            background-color: #0f172a;
            border: 1px solid #334155;
            border-radius: 4px;
            color: #f8fafc;
            box-sizing: border-box;
        }
        .form-control:focus { outline: none; border-color: #06b6d4; }
        .val-error { color: #ef4444; font-size: 0.8rem; display: block; margin-top: 4px; }
        .btn-submit {
            background-color: #06b6d4;
            color: #0f172a;
            font-weight: bold;
            padding: 10px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-submit:hover { background-color: #22d3ee; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Register New Crime Case</h2>
    
    <div class="form-grid">
        <!-- Case Information -->
        <div class="form-card">
            <h3>📄 Case Information</h3>
            <div class="form-group">
                <label>Case Number (Auto-Generated)</label>
                <asp:TextBox ID="txtCaseNumber" runat="server" CssClass="form-control" Text="CAS-2026-89932" ReadOnly="true" />
            </div>
            <div class="form-group">
                <label>Crime Type</label>
                <asp:DropDownList ID="ddlCrimeType" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Select Type..." Value="" />
                    <asp:ListItem Text="Cyber Espionage" Value="Cyber Espionage" />
                    <asp:ListItem Text="Financial Fraud" Value="Financial Fraud" />
                    <asp:ListItem Text="Narcotics Distribution" Value="Narcotics Distribution" />
                    <asp:ListItem Text="Vehicle Theft" Value="Vehicle Theft" />
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvCrimeType" runat="server" ControlToValidate="ddlCrimeType" 
                    InitialValue="" ErrorMessage="Please select a crime type." CssClass="val-error" Display="Dynamic" />
            </div>
            <div class="form-group">
                <label>Incident Date</label>
                <asp:TextBox ID="txtIncidentDate" runat="server" TextMode="Date" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvIncidentDate" runat="server" ControlToValidate="txtIncidentDate" 
                    ErrorMessage="Incident date is required." CssClass="val-error" Display="Dynamic" />
            </div>
            <div class="form-group">
                <label>Severity</label>
                <asp:DropDownList ID="ddlSeverity" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Critical" Value="Critical" />
                    <asp:ListItem Text="High" Value="High" />
                    <asp:ListItem Text="Medium" Value="Medium" />
                    <asp:ListItem Text="Low" Value="Low" />
                </asp:DropDownList>
            </div>
        </div>

        <!-- Location Details -->
        <div class="form-card">
            <h3>📍 Location Details</h3>
            <div class="form-group">
                <label>District / Region</label>
                <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Sector 7G" Value="Sector 7G" />
                    <asp:ListItem Text="Industrial Park North" Value="Industrial Park North" />
                    <asp:ListItem Text="Downtown Metro" Value="Downtown Metro" />
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <label>Latitude (-90 to 90)</label>
                <asp:TextBox ID="txtLatitude" runat="server" CssClass="form-control" Placeholder="e.g. 12.9716" />
                <asp:RequiredFieldValidator ID="rfvLat" runat="server" ControlToValidate="txtLatitude" 
                    ErrorMessage="Latitude is required." CssClass="val-error" Display="Dynamic" />
                <asp:RangeValidator ID="rvLat" runat="server" ControlToValidate="txtLatitude" 
                    MinimumValue="-90" MaximumValue="90" Type="Double" 
                    ErrorMessage="Latitude must be between -90 and 90." CssClass="val-error" Display="Dynamic" />
            </div>
            <div class="form-group">
                <label>Longitude (-180 to 180)</label>
                <asp:TextBox ID="txtLongitude" runat="server" CssClass="form-control" Placeholder="e.g. 77.5946" />
                <asp:RequiredFieldValidator ID="rfvLng" runat="server" ControlToValidate="txtLongitude" 
                    ErrorMessage="Longitude is required." CssClass="val-error" Display="Dynamic" />
                <asp:RangeValidator ID="rvLng" runat="server" ControlToValidate="txtLongitude" 
                    MinimumValue="-180" MaximumValue="180" Type="Double" 
                    ErrorMessage="Longitude must be between -180 and 180." CssClass="val-error" Display="Dynamic" />
            </div>
        </div>

        <!-- Evidence Attachments -->
        <div class="form-card">
            <h3>📎 Evidence Attachments</h3>
            <div class="form-group">
                <label>Upload Evidence (Max 50MB)</label>
                <asp:FileUpload ID="fileEvidence" runat="server" CssClass="form-control" />
            </div>
            <div class="form-group" style="margin-top: 30px;">
                <asp:Button ID="btnRegister" runat="server" Text="Register Case" CssClass="btn-submit" OnClick="btnRegister_Click" />
                <asp:Label ID="lblStatus" runat="server" ForeColor="#10B981" style="display:block; margin-top:10px;"></asp:Label>
            </div>
        </div>
    </div>
</asp:Content>