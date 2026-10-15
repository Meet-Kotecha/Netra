<%@ Page Title="Intelligence Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Netra._Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 22px;
            width: 100%;
        }

        .page-title h2 {
            font-size: 1.4rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 4px;
        }

        .page-title p {
            color: #64748b;
            font-size: 0.8rem;
        }

        .btn-export {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            color: #f8fafc;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: all 0.25s ease;
        }

        .btn-export:hover {
            border-color: #38bdf8;
            color: #38bdf8;
            box-shadow: 0 0 12px rgba(56, 189, 248, 0.25);
            transform: translateY(-2px);
        }

        /* Responsive & Interactive Metric Cards */
        .kpi-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 16px;
            margin-bottom: 22px;
            width: 100%;
        }

        .kpi-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 18px 20px;
            width: 100%;
            transition: all 0.25s ease;
            position: relative;
            overflow: hidden;
        }

        .kpi-card:hover {
            border-color: #00d2ff;
            transform: translateY(-4px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.4), 0 0 10px rgba(0, 210, 255, 0.15);
        }

        .kpi-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .kpi-title {
            font-size: 0.7rem;
            font-weight: 700;
            letter-spacing: 0.8px;
            color: #94a3b8;
            text-transform: uppercase;
        }

        .kpi-icon {
            color: #64748b;
            font-size: 0.95rem;
            transition: color 0.2s ease;
        }

        .kpi-card:hover .kpi-icon {
            color: #00d2ff;
        }

        .kpi-value {
            font-size: 1.85rem;
            font-weight: 800;
            color: #ffffff;
            line-height: 1.1;
            margin-bottom: 8px;
        }

        .kpi-sub {
            font-size: 0.7rem;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .sub-up { color: #38bdf8; }
        .sub-warn { color: #f59e0b; }

        /* Dashboard Responsive Panels */
        .dashboard-grid {
            display: grid;
            grid-template-columns: 2.3fr 1fr;
            gap: 20px;
            width: 100%;
        }

        @media (max-width: 1200px) {
            .dashboard-grid {
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
            transition: border-color 0.25s ease;
        }

        .card-panel:hover {
            border-color: #334155;
        }

        .panel-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
        }

        .panel-title {
            font-size: 0.92rem;
            font-weight: 700;
            color: #ffffff;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .filter-select {
            background-color: #070d18;
            border: 1px solid #1e293b;
            color: #94a3b8;
            padding: 5px 12px;
            border-radius: 4px;
            font-size: 0.75rem;
            outline: none;
            cursor: pointer;
            transition: border-color 0.2s ease;
        }

        .filter-select:hover {
            border-color: #00d2ff;
        }

        /* Chart SVG Canvas */
        .chart-container {
            width: 100%;
            height: 230px;
        }

        /* High Risk Table Hover Highlights */
        .risk-table {
            width: 100%;
            border-collapse: collapse;
        }

        .risk-table th {
            text-align: left;
            font-size: 0.72rem;
            color: #64748b;
            padding-bottom: 10px;
            border-bottom: 1px solid #1e293b;
            font-weight: 600;
        }

        .risk-table tr {
            transition: background-color 0.15s ease;
        }

        .risk-table tbody tr:hover {
            background-color: #121e30;
        }

        .risk-table td {
            padding: 10px 8px;
            border-bottom: 1px solid #141f30;
            font-size: 0.8rem;
        }

        .risk-score {
            font-weight: 800;
            text-align: right;
        }

        .score-critical { color: #ef4444; }
        .score-medium { color: #eab308; }
        .score-normal { color: #38bdf8; }

        /* Donut & Bar Charts */
        .bottom-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            width: 100%;
        }

        @media (max-width: 768px) {
            .bottom-grid {
                grid-template-columns: 1fr;
            }
        }

        .donut-container {
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            height: 150px;
        }

        .donut-hole {
            position: absolute;
            width: 90px;
            height: 90px;
            background-color: #0b1320;
            border-radius: 50%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .donut-hole span {
            font-size: 1.1rem;
            font-weight: 800;
            color: #ffffff;
        }

        .donut-hole small {
            font-size: 0.62rem;
            color: #64748b;
        }

        .legend-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px;
            margin-top: 15px;
            font-size: 0.72rem;
            color: #94a3b8;
        }

        .legend-item {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .legend-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
        }

        /* Interactive Bar Chart Bars */
        .bar-col {
            width: 15%;
            background: #1e293b;
            border-radius: 3px 3px 0 0;
            transition: all 0.25s ease;
            cursor: pointer;
        }

        .bar-col:hover {
            background: #00d2ff !important;
            box-shadow: 0 0 10px rgba(0, 210, 255, 0.5);
            transform: scaleY(1.05);
        }

        /* Alert Feed Hover Items */
        .alert-item {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 12px;
            margin-bottom: 10px;
            transition: all 0.2s ease;
            cursor: pointer;
        }

        .alert-item:hover {
            border-color: #00d2ff;
            transform: translateX(4px);
            box-shadow: -3px 0 0 #00d2ff;
        }

        .alert-item h5 {
            font-size: 0.78rem;
            color: #ffffff;
            margin-bottom: 4px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .alert-item p {
            font-size: 0.7rem;
            color: #64748b;
            display: flex;
            justify-content: space-between;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Top Header Bar -->
    <div class="page-header">
        <div class="page-title">
            <h2>Intelligence Dashboard</h2>
            <p>Real-time threat assessment and case analytics overview.</p>
        </div>
        <button type="button" class="btn-export">📥 Export Report</button>
    </div>

    <!-- Interactive Metric Cards -->
    <div class="kpi-grid">
        <div class="kpi-card">
            <div class="kpi-header">
                <span class="kpi-title">TOTAL CASES</span>
                <span class="kpi-icon">📁</span>
            </div>
            <div class="kpi-value">14,208</div>
            <div class="kpi-sub sub-up">📈 +2.4% from last month</div>
        </div>

        <div class="kpi-card">
            <div class="kpi-header">
                <span class="kpi-title">ACTIVE CASES</span>
                <span class="kpi-icon">⚡</span>
            </div>
            <div class="kpi-value">1,842</div>
            <div class="kpi-sub sub-up">📈 +12 new today</div>
        </div>

        <div class="kpi-card">
            <div class="kpi-header">
                <span class="kpi-title">HIGH-RISK AREAS</span>
                <span class="kpi-icon">⚠️</span>
            </div>
            <div class="kpi-value">12</div>
            <div class="kpi-sub sub-warn">📈 3 elevated in 24h</div>
        </div>

        <div class="kpi-card">
            <div class="kpi-header">
                <span class="kpi-title">ACTIVE ALERTS</span>
                <span class="kpi-icon">📢</span>
            </div>
            <div class="kpi-value">34</div>
            <div class="kpi-sub" style="color:#64748b;">⏱️ 8 pending review</div>
        </div>
    </div>

    <!-- Main Dashboard Workspace -->
    <div class="dashboard-grid">
        <!-- Left Column -->
        <div>
            <!-- Line Chart Section -->
            <div class="card-panel">
                <div class="panel-header">
                    <div class="panel-title">📈 Crime Trend Analysis (YTD)</div>
                    <select class="filter-select">
                        <option>All Districts</option>
                        <option>Sector 7G</option>
                        <option>Industrial Park North</option>
                    </select>
                </div>
                <div class="chart-container">
                    <svg width="100%" height="100%" viewBox="0 0 600 200" preserveAspectRatio="none">
                        <path d="M 0 150 Q 50 130, 100 145 T 200 80 T 300 100 T 400 50 T 500 80 T 600 120" fill="none" stroke="#00d2ff" stroke-width="4" />
                        <circle cx="200" cy="80" r="5" fill="#00d2ff" />
                        <circle cx="400" cy="50" r="5" fill="#00d2ff" />
                    </svg>
                </div>
            </div>

            <!-- Bottom Row Panels -->
            <div class="bottom-grid">
                <!-- Donut Chart -->
                <div class="card-panel" style="margin-bottom:0;">
                    <div class="panel-header">
                        <div class="panel-title">Distribution by Type</div>
                    </div>
                    <div class="donut-container">
                        <svg width="130" height="130" viewBox="0 0 36 36">
                            <path d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" fill="none" stroke="#1e293b" stroke-width="4" />
                            <path d="M18 2.0845 a 15.9155 15.9155 0 0 1 15 20" fill="none" stroke="#00d2ff" stroke-width="4" />
                        </svg>
                        <div class="donut-hole">
                            <span>1,842</span>
                            <small>Active</small>
                        </div>
                    </div>
                    <div class="legend-grid">
                        <div class="legend-item"><div class="legend-dot" style="background:#00d2ff;"></div> Cyber (42%)</div>
                        <div class="legend-item"><div class="legend-dot" style="background:#38bdf8;"></div> Financial (35%)</div>
                        <div class="legend-item"><div class="legend-dot" style="background:#0284c7;"></div> Narcotics (15%)</div>
                        <div class="legend-item"><div class="legend-dot" style="background:#64748b;"></div> Other (8%)</div>
                    </div>
                </div>

                <!-- Interactive Bar Chart -->
                <div class="card-panel" style="margin-bottom:0;">
                    <div class="panel-header">
                        <div class="panel-title">District Comparison</div>
                    </div>
                    <div style="display:flex; justify-content:space-between; align-items:flex-end; height:140px; padding-top:20px;">
                        <div class="bar-col" style="height:40%;"></div>
                        <div class="bar-col" style="height:70%;"></div>
                        <div class="bar-col" style="height:90%; background:#00d2ff;"></div>
                        <div class="bar-col" style="height:50%;"></div>
                        <div class="bar-col" style="height:30%;"></div>
                    </div>
                    <div style="display:flex; justify-content:space-between; margin-top:8px; font-size:0.65rem; color:#64748b;">
                        <span>D1</span><span>D2</span><span>D3</span><span>D4</span><span>D5</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Side Panel -->
        <div>
            <!-- High Risk Areas -->
            <div class="card-panel">
                <div class="panel-header">
                    <div class="panel-title">🛡️ High-Risk Areas</div>
                </div>
                <table class="risk-table">
                    <thead>
                        <tr>
                            <th>Location</th>
                            <th style="text-align:right;">Risk Score</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>🔴 Sector 7G</td>
                            <td class="risk-score score-critical">94.2</td>
                        </tr>
                        <tr>
                            <td>🔴 Industrial Park North</td>
                            <td class="risk-score score-critical">88.7</td>
                        </tr>
                        <tr>
                            <td>🟡 Downtown Metro</td>
                            <td class="risk-score score-medium">76.4</td>
                        </tr>
                        <tr>
                            <td>🟡 Port Authority Zone</td>
                            <td class="risk-score score-medium">72.1</td>
                        </tr>
                        <tr>
                            <td>🔵 Residential Block C</td>
                            <td class="risk-score score-normal">45.0</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Recent Alerts Feed -->
            <div class="card-panel">
                <div class="panel-header">
                    <div class="panel-title">🔔 Recent Alerts</div>
                    <a href="#" style="color:#00d2ff; font-size:0.75rem; text-decoration:none;">View All</a>
                </div>

                <div class="alert-item">
                    <h5>❗ Anomalous Data Transfer Detected</h5>
                    <p><span>Node: SVR-092</span> <span>2 mins ago</span></p>
                </div>

                <div class="alert-item">
                    <h5>👁️ Suspicious Vehicle Movement</h5>
                    <p><span>Cam: DT-Cam-04</span> <span>15 mins ago</span></p>
                </div>

                <div class="alert-item">
                    <h5>ℹ️ System Update Completed</h5>
                    <p><span>Mainframe</span> <span>1 hour ago</span></p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>