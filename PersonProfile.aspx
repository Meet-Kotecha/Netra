<%@ Page Title="Person Investigation Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PersonProfile.aspx.cs" Inherits="Netra.PersonProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-breadcrumb {
            font-size: 0.85rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        /* Top Profile Banner Card */
        .profile-banner-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 22px 24px;
            margin-bottom: 20px;
            display: grid;
            grid-template-columns: 140px 1fr auto;
            gap: 24px;
            position: relative;
        }

        .avatar-box {
            width: 130px;
            height: 150px;
            background-color: #070d18;
            border: 2px solid #00d2ff;
            border-radius: 6px;
            overflow: hidden;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 0 15px rgba(0, 210, 255, 0.2);
        }

        .avatar-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .avatar-confidential-tag {
            position: absolute;
            bottom: 0;
            inset-x: 0;
            background-color: rgba(7, 13, 24, 0.85);
            color: #cbd5e1;
            font-size: 0.6rem;
            font-weight: 800;
            letter-spacing: 1px;
            text-align: center;
            padding: 4px 0;
            border-top: 1px solid #1e293b;
        }

        .profile-header-info {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .subject-name {
            font-size: 1.55rem;
            font-weight: 800;
            color: #ffffff;
            line-height: 1.1;
            margin-bottom: 4px;
        }

        .subject-type {
            font-size: 0.68rem;
            font-weight: 800;
            letter-spacing: 1.2px;
            color: #00d2ff;
            text-transform: uppercase;
            margin-bottom: 14px;
        }

        .status-pill-red {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background-color: rgba(239, 68, 68, 0.15);
            border: 1px solid rgba(239, 68, 68, 0.3);
            color: #ef4444;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 0.65rem;
            font-weight: 800;
            letter-spacing: 0.8px;
            width: fit-content;
        }

        .subject-id-label {
            font-size: 0.7rem;
            color: #64748b;
            font-family: monospace;
            margin-top: 6px;
        }

        /* Profile Details Grid */
        .profile-details-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 14px;
            margin-top: 10px;
        }

        .detail-box {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 10px 14px;
        }

        .detail-label {
            font-size: 0.62rem;
            font-weight: 700;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 4px;
        }

        .detail-val {
            font-size: 0.8rem;
            font-weight: 700;
            color: #f8fafc;
        }

        .alias-pill {
            display: inline-block;
            background-color: #12283e;
            border: 1px solid #1e293b;
            color: #cbd5e1;
            padding: 2px 8px;
            border-radius: 4px;
            font-size: 0.68rem;
            font-weight: 600;
            margin-right: 4px;
        }

        .btn-view-network {
            background-color: rgba(0, 210, 255, 0.1);
            border: 1px solid #00d2ff;
            color: #00d2ff;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            height: fit-content;
            transition: all 0.2s ease;
        }

        .btn-view-network:hover {
            background-color: #00d2ff;
            color: #070d18;
            box-shadow: 0 0 12px rgba(0, 210, 255, 0.4);
        }

        /* Two Column Main Body Grid */
        .profile-body-grid {
            display: grid;
            grid-template-columns: 360px 1fr;
            gap: 20px;
        }

        @media (max-width: 1100px) {
            .profile-body-grid {
                grid-template-columns: 1fr;
            }
        }

        .section-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 18px;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.9rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 14px;
        }

        /* Known Locations Mini Map & List */
        .locations-map-box {
            width: 100%;
            height: 160px;
            background-color: #060b14;
            border: 1px solid #1e293b;
            border-radius: 6px;
            overflow: hidden;
            position: relative;
            margin-bottom: 14px;
            background-image: 
                radial-gradient(circle at 65% 45%, rgba(239, 68, 68, 0.3) 0%, transparent 35%),
                linear-gradient(rgba(56, 189, 248, 0.12) 1px, transparent 1px),
                linear-gradient(90deg, rgba(56, 189, 248, 0.12) 1px, transparent 1px);
            background-size: 100% 100%, 20px 20px, 20px 20px;
        }

        .location-item {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 10px 12px;
            margin-bottom: 8px;
        }

        .location-title {
            font-size: 0.78rem;
            font-weight: 700;
            color: #ffffff;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .location-sub {
            font-size: 0.68rem;
            color: #64748b;
            margin-top: 3px;
            padding-left: 14px;
        }

        /* Associated Cases Table */
        .cases-table {
            width: 100%;
            border-collapse: collapse;
        }

        .cases-table th {
            text-align: left;
            font-size: 0.65rem;
            font-weight: 700;
            letter-spacing: 0.8px;
            color: #64748b;
            text-transform: uppercase;
            padding: 10px 12px;
            border-bottom: 1px solid #1e293b;
        }

        .cases-table td {
            padding: 12px;
            border-bottom: 1px solid #141f30;
            font-size: 0.78rem;
            color: #cbd5e1;
        }

        .case-link {
            color: #00d2ff;
            text-decoration: none;
            font-family: monospace;
            font-weight: 700;
        }

        .case-link:hover {
            text-decoration: underline;
        }

        .badge-status-open {
            background-color: rgba(239, 68, 68, 0.15);
            color: #ef4444;
            border: 1px solid rgba(239, 68, 68, 0.3);
            padding: 2px 8px;
            border-radius: 10px;
            font-size: 0.65rem;
            font-weight: 800;
        }

        .badge-status-closed {
            background-color: rgba(100, 116, 139, 0.15);
            color: #64748b;
            border: 1px solid rgba(100, 116, 139, 0.3);
            padding: 2px 8px;
            border-radius: 10px;
            font-size: 0.65rem;
            font-weight: 800;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Breadcrumb Header -->
    <div class="page-breadcrumb">
        <span style="color:#64748b;">/</span> Person Investigation Profile
    </div>

    <!-- Top Profile Banner -->
    <div class="profile-banner-card">
        <!-- Avatar Photo Box -->
        <div>
            <div class="avatar-box">
                <img src="Images/Keval.jpeg" alt="Keval Goswami Mugshot" />
                <div class="avatar-confidential-tag">CONFIDENTIAL</div>
            </div>
            <div style="text-align: center; margin-top: 8px;">
                <div class="status-pill-red">● ACTIVE INVESTIGATION</div>
                <div class="subject-id-label">ID: P-1042</div>
            </div>
        </div>

        <!-- Subject Core Information -->
        <div class="profile-header-info">
            <div>
                <div class="subject-name">Keval Goswami</div>
                <div class="subject-type">SUSPECT / PERSON OF INTEREST</div>

                <!-- Info Box Grid -->
                <div class="profile-details-grid">
                    <div class="detail-box">
                        <div class="detail-label">Date of Birth</div>
                        <div class="detail-val">06-06-2006 (20 yrs)</div>
                    </div>

                    <div class="detail-box">
                        <div class="detail-label">National ID / Passport</div>
                        <div class="detail-val">X99 - 234 - 112B</div>
                    </div>

                    <div class="detail-box">
                        <div class="detail-label">Known Aliases</div>
                        <div class="detail-val">
                            <span class="alias-pill">JD</span>
                            <span class="alias-pill">Ghost</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Side Network Button -->
        <div>
            <button type="button" class="btn-view-network" onclick="alert('🕸️ Loading Neural Network Analysis for Keval Goswami...')">
                🕸️ View Network
            </button>
        </div>
    </div>

    <!-- Main Content Split Grid -->
    <div class="profile-body-grid">
        <!-- Left: Known Locations Card -->
        <div class="section-card">
            <div class="section-header">
                <span>📍 Known Locations</span>
            </div>

            <div class="locations-map-box">
                <!-- Location Radar Center Dot -->
                <div style="position:absolute; top:45%; left:65%; width:10px; height:10px; background:#ef4444; border-radius:50%; box-shadow: 0 0 12px #ef4444;"></div>
            </div>

            <div class="location-item">
                <div class="location-title">
                    <span style="color:#ef4444;">●</span> Safehouse Alpha
                </div>
                <div class="location-sub">Last seen: 2023-10-12</div>
            </div>

            <div class="location-item">
                <div class="location-title">
                    <span style="color:#64748b;">●</span> Registered Address (Obsolete)
                </div>
                <div class="location-sub">Last seen: 2021-05-01</div>
            </div>
        </div>

        <!-- Right: Associated Cases Table -->
        <div class="section-card">
            <div class="section-header">
                <span>📁 Associated Cases</span>
                <a href="CrimeCases.aspx" style="color:#00d2ff; font-size:0.75rem; text-decoration:none; font-weight:700;">VIEW ALL ➔</a>
            </div>

            <table class="cases-table">
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
                        <td><a href="InvestigationWorkspace.aspx" class="case-link">OP - 2023 - A9</a></td>
                        <td>Financial Syndicate Subversion</td>
                        <td>Primary Suspect</td>
                        <td><span class="badge-status-open">Open</span></td>
                    </tr>
                    <tr>
                        <td><a href="InvestigationWorkspace.aspx" class="case-link">OP - 2022 - C4</a></td>
                        <td>Cross-Border Smuggling</td>
                        <td>Associate</td>
                        <td><span class="badge-status-closed">Closed</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>