<%@ Page Title="System Audit Logs" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AuditLogs.aspx.cs" Inherits="Netra.AuditLogs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Header Row */
        .page-header-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
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

        .header-actions {
            display: flex;
            gap: 10px;
        }

        .btn-export-outline {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            color: #cbd5e1;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .btn-export-outline:hover {
            border-color: #00d2ff;
            color: #00d2ff;
        }

        .btn-live-feed {
            background-color: #a5f3fc;
            border: none;
            color: #070d18;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 800;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s ease;
        }

        .btn-live-feed:hover {
            background-color: #38bdf8;
            box-shadow: 0 0 12px rgba(56, 189, 248, 0.4);
        }

        /* Filter Controls Bar */
        .filter-controls-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 14px 18px;
            margin-bottom: 20px;
            display: grid;
            grid-template-columns: 180px 180px 180px 180px 100px;
            gap: 14px;
            align-items: end;
        }

        @media (max-width: 1024px) {
            .filter-controls-card {
                grid-template-columns: 1fr 1fr;
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

        .filter-select, .filter-input {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 8px 12px;
            color: #cbd5e1;
            font-size: 0.75rem;
            outline: none;
            cursor: pointer;
            width: 100%;
        }

        .filter-select:focus, .filter-input:focus {
            border-color: #38bdf8;
        }

        .btn-reset {
            background-color: #070d18;
            border: 1px solid #1e293b;
            color: #cbd5e1;
            padding: 8px;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 700;
            cursor: pointer;
            text-align: center;
            transition: all 0.2s ease;
        }

        .btn-reset:hover {
            border-color: #64748b;
            color: #ffffff;
        }

        /* Audit Table Container */
        .table-container-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .audit-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.78rem;
        }

        .audit-table th {
            text-align: left;
            padding: 12px 16px;
            background-color: #070d18;
            color: #64748b;
            font-weight: 800;
            font-size: 0.65rem;
            letter-spacing: 0.8px;
            text-transform: uppercase;
            border-bottom: 1px solid #1e293b;
        }

        .audit-table td {
            padding: 12px 16px;
            border-bottom: 1px solid #162234;
            color: #cbd5e1;
            vertical-align: middle;
        }

        .audit-table tr:hover {
            background-color: rgba(18, 40, 62, 0.4);
        }

        /* Critical Failed Row Highlight */
        .audit-table tr.row-failed {
            background-color: rgba(239, 68, 68, 0.08);
            border-left: 3px solid #ef4444;
        }

        .audit-table tr.row-failed td {
            color: #fca5a5;
        }

        .user-chip {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .user-initials {
            width: 22px;
            height: 22px;
            border-radius: 50%;
            background-color: #12283e;
            border: 1px solid #1e293b;
            color: #38bdf8;
            font-size: 0.6rem;
            font-weight: 800;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .ip-code {
            font-family: monospace;
            color: #64748b;
            font-size: 0.72rem;
        }

        .status-dot-cyan {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background-color: #00d2ff;
            box-shadow: 0 0 8px #00d2ff;
            display: inline-block;
        }

        .status-dot-red {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background-color: #ef4444;
            box-shadow: 0 0 8px #ef4444;
            display: inline-block;
        }

        /* Pagination Footer */
        .table-footer-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 18px;
            background-color: #070d18;
            border-top: 1px solid #1e293b;
            font-size: 0.72rem;
            color: #64748b;
        }

        .pagination-controls {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-page-nav {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            color: #64748b;
            width: 26px;
            height: 26px;
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 0.75rem;
        }

        .btn-page-nav:hover {
            color: #ffffff;
            border-color: #38bdf8;
        }

        .page-text-indicator {
            font-size: 0.72rem;
            color: #cbd5e1;
            font-weight: 600;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Top Header -->
    <div class="page-header-row">
        <div>
            <div class="page-title">System Audit Logs</div>
            <div class="page-sub-text">Monitor important user and system activities across the NETRA platform.</div>
        </div>
        <div class="header-actions">
            <button type="button" class="btn-export-outline" onclick="alert('📥 Exporting Audit Log records to CSV...')">
                📥 Export CSV
            </button>
            <button type="button" class="btn-live-feed" onclick="alert('🔄 Connecting to NETRA Real-time Audit Telemetry Stream...')">
                🔄 Live Feed
            </button>
        </div>
    </div>

    <!-- Filter Bar Controls -->
    <div class="filter-controls-card">
        <div class="field-group">
            <label class="field-label">DATE RANGE</label>
            <select class="filter-select">
                <option value="24h">📅 Last 24 Hours</option>
                <option value="7d">Last 7 Days</option>
                <option value="30d">Last 30 Days</option>
            </select>
        </div>

        <div class="field-group">
            <label class="field-label">USER</label>
            <select class="filter-select">
                <option value="All">All Users</option>
                <option value="A. Silva">A. Silva</option>
                <option value="Unknown User">Unknown User</option>
                <option value="System">System</option>
                <option value="J. Reed">J. Reed</option>
            </select>
        </div>

        <div class="field-group">
            <label class="field-label">MODULE</label>
            <select class="filter-select">
                <option value="All">All Modules</option>
                <option value="Case Mgt">Case Mgt</option>
                <option value="Image Inv">Image Inv</option>
                <option value="Auth">Auth</option>
                <option value="Infrastructure">Infrastructure</option>
                <option value="Reports">Reports</option>
            </select>
        </div>

        <div class="field-group">
            <label class="field-label">SEVERITY</label>
            <select class="filter-select">
                <option value="All">All Levels</option>
                <option value="Info">Information</option>
                <option value="Warning">Warning</option>
                <option value="Critical">Critical Alert</option>
            </select>
        </div>

        <button type="button" class="btn-reset" onclick="alert('Filters reset to default.')">Reset</button>
    </div>

    <!-- Data Table Container -->
    <div class="table-container-card">
        <table class="audit-table">
            <thead>
                <tr>
                    <th style="width:160px;">TIMESTAMP</th>
                    <th style="width:140px;">USER</th>
                    <th style="width:180px;">ACTION</th>
                    <th style="width:120px;">MODULE</th>
                    <th>DESCRIPTION</th>
                    <th style="width:120px;">SESSION IP</th>
                    <th style="width:60px; text-align:center;">STATUS</th>
                </tr>
            </thead>
            <tbody>
                <!-- Row 1 -->
                <tr>
                    <td style="font-family:monospace; color:#94a3b8;">2023-10-27 14:32:01</td>
                    <td>
                        <div class="user-chip">
                            <div class="user-initials">AS</div>
                            <span>A. Silva</span>
                        </div>
                    </td>
                    <td style="font-weight:700; color:#ffffff;">Case Updated</td>
                    <td style="color:#64748b;">Case Mgt</td>
                    <td>Modified status of Case #9021-A to 'Active Inve</td>
                    <td class="ip-code">192.168.1.45</td>
                    <td style="text-align:center;"><span class="status-dot-cyan"></span></td>
                </tr>

                <!-- Row 2 -->
                <tr>
                    <td style="font-family:monospace; color:#94a3b8;">2023-10-27 14:28:15</td>
                    <td>
                        <div class="user-chip">
                            <div class="user-initials">AS</div>
                            <span>A. Silva</span>
                        </div>
                    </td>
                    <td style="font-weight:700; color:#ffffff;">Image Search Performed</td>
                    <td style="color:#64748b;">Image Inv</td>
                    <td>Executed reverse lookup on target 'suspect_vei</td>
                    <td class="ip-code">192.168.1.45</td>
                    <td style="text-align:center;"><span class="status-dot-cyan"></span></td>
                </tr>

                <!-- Row 3: Failed Login (Highlight) -->
                <tr class="row-failed">
                    <td style="font-family:monospace;">2023-10-27 14:15:22</td>
                    <td>
                        <div class="user-chip">
                            <div class="user-initials" style="background-color:#7f1d1d; color:#fca5a5; border-color:#ef4444;">UK</div>
                            <span style="font-weight:800;">Unknown User</span>
                        </div>
                    </td>
                    <td style="font-weight:800; color:#ef4444;">Failed Login Attempt</td>
                    <td style="color:#fca5a5;">Auth</td>
                    <td>Multiple failed authentication attempts for acco</td>
                    <td class="ip-code" style="color:#ef4444; font-weight:700;">45.22.109.11</td>
                    <td style="text-align:center;"><span class="status-dot-red"></span></td>
                </tr>

                <!-- Row 4 -->
                <tr>
                    <td style="font-family:monospace; color:#94a3b8;">2023-10-27 13:45:00</td>
                    <td>
                        <div class="user-chip">
                            <div class="user-initials" style="background-color:#070d18; border-color:#00d2ff; color:#00d2ff;">SYS</div>
                            <span>System</span>
                        </div>
                    </td>
                    <td style="font-weight:700; color:#ffffff;">Backup Completed</td>
                    <td style="color:#64748b;">Infrastructure</td>
                    <td>Automated snapshot backup 'snap-daily-1300'</td>
                    <td class="ip-code">localhost</td>
                    <td style="text-align:center;"><span class="status-dot-cyan"></span></td>
                </tr>

                <!-- Row 5 -->
                <tr>
                    <td style="font-family:monospace; color:#94a3b8;">2023-10-27 12:10:05</td>
                    <td>
                        <div class="user-chip">
                            <div class="user-initials">AS</div>
                            <span>A. Silva</span>
                        </div>
                    </td>
                    <td style="font-weight:700; color:#ffffff;">User Logged In</td>
                    <td style="color:#64748b;">Auth</td>
                    <td>Successful authentication via MFA</td>
                    <td class="ip-code">192.168.1.45</td>
                    <td style="text-align:center;"><span class="status-dot-cyan"></span></td>
                </tr>

                <!-- Row 6 -->
                <tr>
                    <td style="font-family:monospace; color:#94a3b8;">2023-10-27 11:55:30</td>
                    <td>
                        <div class="user-chip">
                            <div class="user-initials" style="background-color:#070d18; color:#64748b;">JR</div>
                            <span>J. Reed</span>
                        </div>
                    </td>
                    <td style="font-weight:700; color:#ffffff;">Report Exported</td>
                    <td style="color:#64748b;">Reports</td>
                    <td>Exported "Weekly Threat Assessment" to PDF</td>
                    <td class="ip-code">192.168.1.102</td>
                    <td style="text-align:center;"><span class="status-dot-cyan"></span></td>
                </tr>
            </tbody>
        </table>

        <!-- Table Pagination Footer -->
        <div class="table-footer-bar">
            <div>Showing 1-6 of 14,023 entries</div>
            <div class="pagination-controls">
                <button type="button" class="btn-page-nav">‹</button>
                <span class="page-text-indicator">Page 1 of 2338</span>
                <button type="button" class="btn-page-nav">›</button>
            </div>
        </div>
    </div>
</asp:Content>