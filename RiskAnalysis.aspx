<%@ Page Title="Risk & Anomaly Analysis" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RiskAnalysis.aspx.cs" Inherits="Netra.RiskAnalysis" %>

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

        /* Area Risk Analysis Section Card */
        .section-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 18px 22px;
            margin-bottom: 24px;
        }

        .section-header-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
        }

        .section-title {
            font-size: 0.85rem;
            font-weight: 800;
            letter-spacing: 0.8px;
            color: #ffffff;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .live-feed-badge {
            font-size: 0.65rem;
            font-weight: 800;
            color: #00d2ff;
            letter-spacing: 0.8px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        /* Table Styling */
        .risk-table {
            width: 100%;
            border-collapse: collapse;
        }

        .risk-table th {
            text-align: left;
            font-size: 0.65rem;
            font-weight: 800;
            letter-spacing: 0.8px;
            color: #64748b;
            text-transform: uppercase;
            padding: 12px 14px;
            border-bottom: 1px solid #1e293b;
        }

        .risk-table td {
            padding: 14px;
            border-bottom: 1px solid #141f30;
            font-size: 0.78rem;
            color: #cbd5e1;
            vertical-align: middle;
        }

        .risk-table tbody tr {
            transition: background-color 0.15s ease;
        }

        .risk-table tbody tr:hover {
            background-color: #121e30;
        }

        .area-name {
            font-weight: 700;
            color: #ffffff;
        }

        .trend-up { color: #ef4444; font-weight: 700; }
        .trend-elevated { color: #f59e0b; font-weight: 700; }
        .trend-down { color: #00d2ff; font-weight: 700; }
        .trend-neutral { color: #94a3b8; font-weight: 700; }

        /* Badges */
        .badge-risk {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 0.65rem;
            font-weight: 800;
            text-transform: uppercase;
        }

        .badge-critical { background-color: rgba(239, 68, 68, 0.15); border: 1px solid rgba(239, 68, 68, 0.4); color: #ef4444; }
        .badge-high { background-color: rgba(239, 68, 68, 0.15); border: 1px solid rgba(239, 68, 68, 0.4); color: #ef4444; }
        .badge-elevated { background-color: rgba(245, 158, 11, 0.15); border: 1px solid rgba(245, 158, 11, 0.4); color: #f59e0b; }
        .badge-moderate { background-color: rgba(148, 163, 184, 0.15); border: 1px solid rgba(148, 163, 184, 0.4); color: #94a3b8; }
        .badge-low { background-color: rgba(0, 210, 255, 0.15); border: 1px solid rgba(0, 210, 255, 0.4); color: #00d2ff; }

        /* Detected Anomalies Section */
        .anomalies-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        @media (max-width: 900px) {
            .anomalies-grid { grid-template-columns: 1fr; }
        }

        .anomaly-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 16px;
            display: flex;
            gap: 14px;
        }

        .anomaly-icon-box {
            width: 44px;
            height: 44px;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            flex-shrink: 0;
        }

        .icon-red { background-color: rgba(239, 68, 68, 0.15); border: 1px solid rgba(239, 68, 68, 0.3); color: #ef4444; }
        .icon-amber { background-color: rgba(245, 158, 11, 0.15); border: 1px solid rgba(245, 158, 11, 0.3); color: #f59e0b; }

        .anomaly-body {
            flex-grow: 1;
        }

        .anomaly-top-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 6px;
        }

        .anomaly-title {
            font-size: 0.82rem;
            font-weight: 800;
            color: #ffffff;
        }

        .anomaly-desc {
            font-size: 0.72rem;
            color: #94a3b8;
            line-height: 1.4;
            margin-bottom: 12px;
        }

        .anomaly-meta-grid {
            display: flex;
            gap: 24px;
            border-top: 1px solid #1a2536;
            padding-top: 10px;
        }

        .meta-col-label {
            font-size: 0.62rem;
            font-weight: 700;
            color: #64748b;
            text-transform: uppercase;
        }

        .meta-col-val {
            font-size: 0.75rem;
            font-weight: 800;
            color: #ffffff;
            margin-top: 2px;
        }

        .disclaimer-banner {
            margin-top: 20px;
            background-color: rgba(11, 19, 32, 0.5);
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 10px 14px;
            font-size: 0.7rem;
            color: #64748b;
            text-align: center;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Page Header -->
    <div class="page-header-row">
        <div>
            <div class="page-title-text">Risk & Anomaly Analysis</div>
            <div class="page-sub-text">Live assessment of regional threat models and automated pattern detection.</div>
        </div>
        <div class="header-actions">
            <button type="button" class="btn-action-dark" onclick="alert('⚙️ Filter panel opened.')">🎛️ Filters</button>
            <button type="button" class="btn-action-cyan" onclick="alert('📥 Risk dataset exported successfully.')">📥 Export Data</button>
        </div>
    </div>

    <!-- Area Risk Analysis Card -->
    <div class="section-card">
        <div class="section-header-row">
            <div class="section-title">
                <span>🎯 AREA RISK ANALYSIS</span>
            </div>
            <div class="live-feed-badge">
                <span>● LIVE FEED ACTIVE</span>
            </div>
        </div>

        <table class="risk-table">
            <thead>
                <tr>
                    <th>AREA</th>
                    <th>DISTRICT</th>
                    <th>CRIME COUNT</th>
                    <th>RECENT ACTIVITY</th>
                    <th>HISTORICAL TREND</th>
                    <th>RISK SCORE</th>
                    <th>RISK LEVEL</th>
                </tr>
            </thead>
            <tbody>
                <!-- Row 1 -->
                <tr>
                    <td class="area-name">Downtown Commercial</td>
                    <td style="color:#64748b;">Central</td>
                    <td style="font-weight:700; color:#f8fafc;">142</td>
                    <td>
                        <svg width="80" height="20">
                            <polyline points="0,18 15,12 30,15 45,8 60,10 75,3" fill="none" stroke="#ef4444" stroke-width="2" />
                        </svg>
                    </td>
                    <td class="trend-up">↗ +12.4%</td>
                    <td style="font-weight:800; color:#ffffff;">94</td>
                    <td><span class="badge-risk badge-critical">• Critical</span></td>
                </tr>

                <!-- Row 2 -->
                <tr>
                    <td class="area-name">Westside Industrial</td>
                    <td style="color:#64748b;">West</td>
                    <td style="font-weight:700; color:#f8fafc;">87</td>
                    <td>
                        <svg width="80" height="20">
                            <polyline points="0,15 15,14 30,10 45,12 60,8 75,5" fill="none" stroke="#f59e0b" stroke-width="2" />
                        </svg>
                    </td>
                    <td class="trend-elevated">↗ +5.2%</td>
                    <td style="font-weight:800; color:#ffffff;">76</td>
                    <td><span class="badge-risk badge-elevated">• Elevated</span></td>
                </tr>

                <!-- Row 3 -->
                <tr>
                    <td class="area-name">North Hills Residential</td>
                    <td style="color:#64748b;">North</td>
                    <td style="font-weight:700; color:#f8fafc;">24</td>
                    <td>
                        <svg width="80" height="20">
                            <polyline points="0,5 15,8 30,6 45,12 60,10 75,16" fill="none" stroke="#00d2ff" stroke-width="2" />
                        </svg>
                    </td>
                    <td class="trend-down">↘ -3.1%</td>
                    <td style="font-weight:800; color:#ffffff;">32</td>
                    <td><span class="badge-risk badge-low">• Low</span></td>
                </tr>

                <!-- Row 4 -->
                <tr>
                    <td class="area-name">South Port Terminal</td>
                    <td style="color:#64748b;">South</td>
                    <td style="font-weight:700; color:#f8fafc;">112</td>
                    <td>
                        <svg width="80" height="20">
                            <polyline points="0,16 15,14 30,10 45,8 60,12 75,4" fill="none" stroke="#ef4444" stroke-width="2" />
                        </svg>
                    </td>
                    <td class="trend-up">↗ +8.7%</td>
                    <td style="font-weight:800; color:#ffffff;">88</td>
                    <td><span class="badge-risk badge-high">• High</span></td>
                </tr>

                <!-- Row 5 -->
                <tr>
                    <td class="area-name">Eastside Medical</td>
                    <td style="color:#64748b;">East</td>
                    <td style="font-weight:700; color:#f8fafc;">45</td>
                    <td>
                        <svg width="80" height="20">
                            <polyline points="0,10 15,10 30,12 45,9 60,11 75,10" fill="none" stroke="#94a3b8" stroke-width="2" />
                        </svg>
                    </td>
                    <td class="trend-neutral">→ 0.0%</td>
                    <td style="font-weight:800; color:#ffffff;">41</td>
                    <td><span class="badge-risk badge-moderate">• Moderate</span></td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- Detected Anomalies Section Header -->
    <div style="font-size:0.95rem; font-weight:800; color:#ffffff; margin-bottom:14px; display:flex; align-items:center; gap:8px;">
        <span>⚠️ DETECTED ANOMALIES</span>
    </div>

    <!-- Detected Anomalies Grid -->
    <div class="anomalies-grid">
        <!-- Anomaly 1 -->
        <div class="anomaly-card">
            <div class="anomaly-icon-box icon-red">🚘</div>
            <div class="anomaly-body">
                <div class="anomaly-top-row">
                    <div class="anomaly-title">Unusual Increase in Vehicle Theft</div>
                    <span class="badge-risk badge-critical">Critical</span>
                </div>
                <div class="anomaly-desc">
                    Statistically significant spike in vehicle thefts concentrated in Downtown Commercial district over the last 48 hours.
                </div>
                <div class="anomaly-meta-grid">
                    <div>
                        <div class="meta-col-label">Activity vs Avg</div>
                        <div class="meta-col-val" style="color:#ef4444;">+315%</div>
                    </div>
                    <div>
                        <div class="meta-col-label">Detection Time</div>
                        <div class="meta-col-val">08:42:15 GMT</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Anomaly 2 -->
        <div class="anomaly-card">
            <div class="anomaly-icon-box icon-amber">🧩</div>
            <div class="anomaly-body">
                <div class="anomaly-top-row">
                    <div class="anomaly-title">Recurring Crime Pattern</div>
                    <span class="badge-risk badge-elevated">Elevated</span>
                </div>
                <div class="anomaly-desc">
                    Temporal correlation identified between minor vandalism incidents and subsequent commercial burglaries in Sector 4.
                </div>
                <div class="anomaly-meta-grid">
                    <div>
                        <div class="meta-col-label">Confidence Score</div>
                        <div class="meta-col-val" style="color:#f59e0b;">84.2%</div>
                    </div>
                    <div>
                        <div class="meta-col-label">Detection Time</div>
                        <div class="meta-col-val">11:15:02 GMT</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Legal Disclaimer -->
    <div class="disclaimer-banner">
        <span>ℹ️ RISK SCORES ARE ANALYTICAL INDICATORS AND DO NOT REPRESENT GUARANTEED PREDICTIONS.</span>
    </div>
</asp:Content>