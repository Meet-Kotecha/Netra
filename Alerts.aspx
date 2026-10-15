<%@ Page Title="Alerts & Notifications" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Alerts.aspx.cs" Inherits="Netra.Alerts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-header-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        .page-title-text {
            font-size: 1.35rem;
            font-weight: 800;
            color: #ffffff;
            line-height: 1.2;
        }

        .page-sub-text {
            font-size: 0.78rem;
            color: #64748b;
            margin-top: 4px;
        }

        .header-actions {
            display: flex;
            gap: 10px;
        }

        .btn-action-dark {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            color: #cbd5e1;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s ease;
        }

        .btn-action-dark:hover {
            border-color: #00d2ff;
            color: #00d2ff;
        }

        .btn-action-cyan {
            background-color: #00d2ff;
            border: none;
            color: #070d18;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 800;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s ease;
        }

        .btn-action-cyan:hover {
            opacity: 0.9;
            box-shadow: 0 0 12px rgba(0, 210, 255, 0.4);
        }

        /* KPI Cards Grid Header */
        .kpi-grid-header {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 20px;
        }

        @media (max-width: 1024px) {
            .kpi-grid-header { grid-template-columns: repeat(2, 1fr); }
        }

        .kpi-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 16px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            position: relative;
        }

        .kpi-title-row {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 0.65rem;
            font-weight: 800;
            letter-spacing: 0.8px;
            text-transform: uppercase;
        }

        .kpi-val-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-top: 10px;
        }

        .kpi-num {
            font-size: 1.8rem;
            font-weight: 800;
            color: #ffffff;
            line-height: 1;
        }

        .kpi-trend-tag {
            font-size: 0.7rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        /* Filter Toolbar */
        .filter-toolbar {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 12px 16px;
            margin-bottom: 20px;
            display: flex;
            gap: 12px;
            align-items: center;
            flex-wrap: wrap;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .filter-label {
            font-size: 0.62rem;
            font-weight: 700;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .filter-select {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 6px 10px;
            color: #f8fafc;
            font-size: 0.78rem;
            outline: none;
            min-width: 130px;
            cursor: pointer;
        }

        .filter-select:focus { border-color: #00d2ff; }

        /* Alert Stream Item Cards */
        .alert-stream-stack {
            display: flex;
            flex-direction: column;
            gap: 14px;
        }

        .alert-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 16px 20px;
            display: flex;
            gap: 16px;
            position: relative;
            transition: transform 0.15s ease, border-color 0.15s ease;
        }

        .alert-card:hover { transform: translateY(-2px); }

        .alert-card-critical { border-left: 4px solid #ef4444; }
        .alert-card-high { border-left: 4px solid #00d2ff; }
        .alert-card-medium { border-left: 4px solid #64748b; }

        .alert-icon-box {
            width: 36px;
            height: 36px;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
            flex-shrink: 0;
        }

        .icon-box-critical { background-color: rgba(239, 68, 68, 0.15); color: #ef4444; border: 1px solid rgba(239, 68, 68, 0.3); }
        .icon-box-high { background-color: rgba(0, 210, 255, 0.15); color: #00d2ff; border: 1px solid rgba(0, 210, 255, 0.3); }
        .icon-box-medium { background-color: rgba(100, 116, 139, 0.15); color: #94a3b8; border: 1px solid rgba(100, 116, 139, 0.3); }

        .alert-main-body {
            flex-grow: 1;
        }

        .alert-header-row {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 6px;
        }

        .badge-severity {
            padding: 2px 6px;
            border-radius: 3px;
            font-size: 0.6rem;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .badge-sev-critical { background-color: rgba(239, 68, 68, 0.2); color: #ef4444; border: 1px solid rgba(239, 68, 68, 0.4); }
        .badge-sev-high { background-color: rgba(0, 210, 255, 0.2); color: #00d2ff; border: 1px solid rgba(0, 210, 255, 0.4); }
        .badge-sev-medium { background-color: rgba(100, 116, 139, 0.2); color: #94a3b8; border: 1px solid rgba(100, 116, 139, 0.4); }

        .alert-time-text { font-size: 0.68rem; color: #64748b; font-family: monospace; }

        .alert-title-text {
            font-size: 0.92rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 6px;
        }

        .alert-desc-text {
            font-size: 0.75rem;
            color: #cbd5e1;
            line-height: 1.4;
            margin-bottom: 12px;
        }

        .alert-meta-bar {
            display: flex;
            gap: 24px;
            border-top: 1px solid #141f30;
            padding-top: 10px;
            font-size: 0.7rem;
        }

        .meta-item-label { color: #64748b; font-weight: 700; margin-bottom: 2px; }
        .meta-item-val { color: #f8fafc; font-weight: 600; display: flex; align-items: center; gap: 4px; }

        .alert-action-side {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: flex-end;
            min-width: 120px;
        }

        .badge-status-pill {
            background-color: #070d18;
            border: 1px solid #1e293b;
            color: #64748b;
            padding: 3px 8px;
            border-radius: 10px;
            font-size: 0.62rem;
            font-weight: 700;
        }

        .btn-alert-action {
            background-color: #00d2ff;
            border: none;
            color: #070d18;
            padding: 7px 14px;
            border-radius: 6px;
            font-size: 0.72rem;
            font-weight: 800;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-alert-action:hover {
            opacity: 0.9;
            box-shadow: 0 0 10px rgba(0, 210, 255, 0.4);
        }

        .btn-alert-dark-sm {
            background-color: #070d18;
            border: 1px solid #1e293b;
            color: #cbd5e1;
            padding: 7px 14px;
            border-radius: 6px;
            font-size: 0.72rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-alert-dark-sm:hover {
            border-color: #00d2ff;
            color: #00d2ff;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Header -->
    <div class="page-header-row">
        <div>
            <div class="page-title-text">Alerts & Notifications</div>
            <div class="page-sub-text">Real-time monitoring of anomalies and threat detections.</div>
        </div>
        <div class="header-actions">
            <button type="button" class="btn-action-dark" onclick="alert('📥 Exporting real-time alert log report...')">📥 Export Report</button>
            <button type="button" class="btn-action-cyan" onclick="alert('✔✔ All pending notifications marked as read.')">✔✔ Mark All Read</button>
        </div>
    </div>

    <!-- KPI Cards Row -->
    <div class="kpi-grid-header">
        <!-- Card 1 -->
        <div class="kpi-card" style="border-top: 3px solid #ef4444;">
            <div class="kpi-title-row" style="color:#ef4444;">
                <span>● CRITICAL ALERTS</span>
            </div>
            <div class="kpi-val-row">
                <div class="kpi-num">12</div>
                <div class="kpi-trend-tag" style="color:#ef4444;">📈 +3</div>
            </div>
        </div>

        <!-- Card 2 -->
        <div class="kpi-card" style="border-top: 3px solid #00d2ff;">
            <div class="kpi-title-row" style="color:#00d2ff;">
                <span>● HIGH ALERTS</span>
            </div>
            <div class="kpi-val-row">
                <div class="kpi-num">34</div>
                <div class="kpi-trend-tag" style="color:#00d2ff;">📉 -2</div>
            </div>
        </div>

        <!-- Card 3 -->
        <div class="kpi-card" style="border-top: 3px solid #64748b;">
            <div class="kpi-title-row" style="color:#94a3b8;">
                <span>● MEDIUM ALERTS</span>
            </div>
            <div class="kpi-val-row">
                <div class="kpi-num">89</div>
                <div class="kpi-trend-tag" style="color:#64748b;">—</div>
            </div>
        </div>

        <!-- Card 4 -->
        <div class="kpi-card" style="border-top: 3px solid #10b981;">
            <div class="kpi-title-row" style="color:#10b981;">
                <span>✔ RESOLVED (24H)</span>
            </div>
            <div class="kpi-val-row">
                <div class="kpi-num">142</div>
                <div class="kpi-trend-tag" style="color:#10b981;">98% rate</div>
            </div>
        </div>
    </div>

    <!-- Filter Toolbar -->
    <div class="filter-toolbar">
        <span style="color:#64748b; font-size:0.8rem;">⚙️</span>

        <div class="filter-group">
            <span class="filter-label">Alert Type</span>
            <select class="filter-select" id="ddlType">
                <option>All Types</option>
                <option>Vehicle Theft</option>
                <option>Unauthorized Access</option>
                <option>Perimeter Security</option>
            </select>
        </div>

        <div class="filter-group">
            <span class="filter-label">Severity</span>
            <select class="filter-select" id="ddlSeverity">
                <option>All Levels</option>
                <option>Critical</option>
                <option>High</option>
                <option>Medium</option>
            </select>
        </div>

        <div class="filter-group">
            <span class="filter-label">District</span>
            <select class="filter-select" id="ddlDistrict">
                <option>All Districts</option>
                <option>Sector 4</option>
                <option>Central District</option>
                <option>Industrial Perimeter</option>
            </select>
        </div>

        <div class="filter-group">
            <span class="filter-label">Status</span>
            <select class="filter-select" id="ddlStatus">
                <option>Open & Active</option>
                <option>Investigating</option>
                <option>Resolved</option>
            </select>
        </div>

        <div class="filter-group">
            <span class="filter-label">Date Range</span>
            <input type="text" class="filter-select" value="10/15/2026" style="width:110px;" />
        </div>
    </div>

    <!-- Alert Cards Feed Stack -->
    <div class="alert-stream-stack">
        <!-- Alert Card 1: Critical -->
        <div class="alert-card alert-card-critical">
            <div class="alert-icon-box icon-box-critical">⚠️</div>
            <div class="alert-main-body">
                <div class="alert-header-row">
                    <span class="badge-severity badge-sev-critical">CRITICAL</span>
                    <span class="alert-time-text">⏱️ 10:42 AM (2m ago)</span>
                </div>
                <div class="alert-title-text">Unusual increase in vehicle theft attempts</div>
                <div class="alert-desc-text">
                    AI analysis detected a 400% spike in forced entry attempts on smart-lock vehicles in Sector 4 over the last 15 minutes. Matches patterns from Syndicate Alpha.
                </div>
                <div class="alert-meta-bar">
                    <div>
                        <div class="meta-item-label">Location</div>
                        <div class="meta-item-val">📍 Sector 4, Northern Perimeter</div>
                    </div>
                    <div>
                        <div class="meta-item-label">Related Asset/Case</div>
                        <div class="meta-item-val" style="color:#00d2ff;">📁 Case #902-V</div>
                    </div>
                </div>
            </div>
            <div class="alert-action-side">
                <span class="badge-status-pill">Open</span>
                <button type="button" class="btn-alert-action" onclick="window.location.href='InvestigationWorkspace.aspx';">View Details</button>
            </div>
        </div>

        <!-- Alert Card 2: High -->
        <div class="alert-card alert-card-high">
            <div class="alert-icon-box icon-box-high">🛡️</div>
            <div class="alert-main-body">
                <div class="alert-header-row">
                    <span class="badge-severity badge-sev-high">HIGH</span>
                    <span class="alert-time-text">⏱️ 09:15 AM (1h ago)</span>
                </div>
                <div class="alert-title-text">Unauthorized database access attempt</div>
                <div class="alert-desc-text">
                    Multiple failed authentication attempts originating from a masked IP targeting the Central Personnel Registry. Automated countermeasures active.
                </div>
                <div class="alert-meta-bar">
                    <div>
                        <div class="meta-item-label">Target System</div>
                        <div class="meta-item-val">🖥️ Central Personnel Registry</div>
                    </div>
                    <div>
                        <div class="meta-item-label">Source IP Trace</div>
                        <div class="meta-item-val" style="font-family:monospace; color:#38bdf8;">192.168.x.x (Masked)</div>
                    </div>
                </div>
            </div>
            <div class="alert-action-side">
                <span class="badge-status-pill">Investigating</span>
                <button type="button" class="btn-alert-dark-sm" onclick="alert('🔒 Audit logs loaded for IP Trace #192.168.x.x')">Review Logs</button>
            </div>
        </div>

        <!-- Alert Card 3: Medium -->
        <div class="alert-card alert-card-medium">
            <div class="alert-icon-box icon-box-medium">📦</div>
            <div class="alert-main-body">
                <div class="alert-header-row">
                    <span class="badge-severity badge-sev-medium">MEDIUM</span>
                    <span class="alert-time-text">⏱️ 04:30 AM (6h ago)</span>
                </div>
                <div class="alert-title-text">Suspicious package left near perimeter fence</div>
                <div class="alert-desc-text">
                    Drone surveillance spotted an unattended bag near Gate 7. Security dispatched. Cleared as non-threat (abandoned worker tools).
                </div>
            </div>
            <div class="alert-action-side">
                <span class="badge-status-pill">Resolved</span>
                <button type="button" class="btn-alert-dark-sm" onclick="alert('📋 Incident clearance report loaded.')">View Report</button>
            </div>
        </div>
    </div>
</asp:Content>