<%@ Page Title="Intelligence Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Netra._Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Load Chart.js CDN for interactive charts -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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

        /* Metric Cards */
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

        /* Dashboard Panels */
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

        /* Canvas Chart Containers */
        .chart-box {
            position: relative;
            width: 100%;
            height: 240px;
        }

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

        .donut-wrapper {
            position: relative;
            height: 180px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .donut-center-text {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
            pointer-events: none;
        }

        .donut-center-text span {
            font-size: 1.2rem;
            font-weight: 800;
            color: #ffffff;
            display: block;
            line-height: 1;
        }

        .donut-center-text small {
            font-size: 0.65rem;
            color: #64748b;
        }

        /* High Risk Table Highlights */
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

    <!-- Main Interactive Dashboard Grid -->
    <div class="dashboard-grid">
        <!-- Left Column -->
        <div>
            <!-- Line Chart Section -->
            <div class="card-panel">
                <div class="panel-header">
                    <div class="panel-title">📈 Crime Trend Analysis (YTD)</div>
                    <select id="ddlDistrictFilter" class="filter-select" onchange="updateLineChart()">
                        <option value="All">All Districts</option>
                        <option value="Sector 7G">Sector 7G</option>
                        <option value="Industrial Park North">Industrial Park North</option>
                        <option value="Downtown Metro">Downtown Metro</option>
                    </select>
                </div>
                <div class="chart-box">
                    <canvas id="lineChart"></canvas>
                </div>
            </div>

            <!-- Bottom Row Charts -->
            <div class="bottom-grid">
                <!-- Donut Chart -->
                <div class="card-panel" style="margin-bottom:0;">
                    <div class="panel-header">
                        <div class="panel-title">Distribution by Type</div>
                    </div>
                    <div class="donut-wrapper">
                        <canvas id="donutChart"></canvas>
                        <div class="donut-center-text">
                            <span id="lblDonutTotal">1,842</span>
                            <small>Active</small>
                        </div>
                    </div>
                </div>

                <!-- Bar Chart -->
                <div class="card-panel" style="margin-bottom:0;">
                    <div class="panel-header">
                        <div class="panel-title">District Comparison</div>
                    </div>
                    <div class="chart-box" style="height:180px;">
                        <canvas id="barChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Side Panel -->
        <div>
            <!-- High Risk Areas Table -->
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

            <!-- Recent Alerts -->
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

    <!-- Chart.js Initialization Script -->
    <script>
        let lineChartInstance, donutChartInstance, barChartInstance;

        const lineDataSets = {
            "All": [800, 920, 1100, 950, 1400, 1200, 1650, 1450, 1850, 1100, 600, 950],
            "Sector 7G": [300, 450, 520, 480, 600, 580, 720, 690, 810, 500, 310, 420],
            "Industrial Park North": [200, 280, 310, 270, 420, 390, 510, 480, 590, 380, 180, 290],
            "Downtown Metro": [300, 190, 270, 200, 360, 230, 420, 280, 450, 220, 110, 240]
        };

        document.addEventListener("DOMContentLoaded", function () {
            // 1. Line Chart
            const ctxLine = document.getElementById('lineChart').getContext('2d');
            const lineGradient = ctxLine.createLinearGradient(0, 0, 0, 240);
            lineGradient.addColorStop(0, 'rgba(0, 210, 255, 0.35)');
            lineGradient.addColorStop(1, 'rgba(0, 210, 255, 0.0)');

            lineChartInstance = new Chart(ctxLine, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [{
                        label: 'Incidents Reported',
                        data: lineDataSets["All"],
                        borderColor: '#00d2ff',
                        borderWidth: 3,
                        backgroundColor: lineGradient,
                        fill: true,
                        tension: 0.4,
                        pointBackgroundColor: '#00d2ff',
                        pointBorderColor: '#0b1320',
                        pointBorderWidth: 2,
                        pointRadius: 4,
                        pointHoverRadius: 7,
                        pointHoverBackgroundColor: '#ffffff',
                        pointHoverBorderColor: '#00d2ff'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            backgroundColor: '#070d18',
                            borderColor: '#00d2ff',
                            borderWidth: 1,
                            titleColor: '#ffffff',
                            bodyColor: '#38bdf8',
                            displayColors: false
                        }
                    },
                    scales: {
                        x: {
                            grid: { display: false },
                            ticks: { color: '#64748b', font: { size: 10 } }
                        },
                        y: {
                            grid: { color: '#1e293b' },
                            ticks: { color: '#64748b', font: { size: 10 } }
                        }
                    }
                }
            });

            // 2. Donut Chart
            const ctxDonut = document.getElementById('donutChart').getContext('2d');
            donutChartInstance = new Chart(ctxDonut, {
                type: 'doughnut',
                data: {
                    labels: ['Cyber (42%)', 'Financial (35%)', 'Narcotics (15%)', 'Other (8%)'],
                    datasets: [{
                        data: [773, 645, 276, 148],
                        backgroundColor: ['#00d2ff', '#38bdf8', '#0284c7', '#334155'],
                        borderColor: '#0b1320',
                        borderWidth: 3,
                        hoverOffset: 6
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    cutout: '72%',
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: { color: '#94a3b8', font: { size: 10 }, boxWidth: 10 }
                        },
                        tooltip: {
                            backgroundColor: '#070d18',
                            borderColor: '#00d2ff',
                            borderWidth: 1,
                            titleColor: '#ffffff',
                            bodyColor: '#38bdf8'
                        }
                    }
                }
            });

            // 3. Bar Chart
            const ctxBar = document.getElementById('barChart').getContext('2d');
            barChartInstance = new Chart(ctxBar, {
                type: 'bar',
                data: {
                    labels: ['D1', 'D2', 'D3', 'D4', 'D5'],
                    datasets: [{
                        label: 'Cases',
                        data: [420, 680, 950, 510, 310],
                        backgroundColor: ['#1e293b', '#1e293b', '#00d2ff', '#1e293b', '#1e293b'],
                        borderRadius: 4,
                        hoverBackgroundColor: '#38bdf8'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            backgroundColor: '#070d18',
                            borderColor: '#00d2ff',
                            borderWidth: 1,
                            titleColor: '#ffffff',
                            bodyColor: '#38bdf8',
                            displayColors: false
                        }
                    },
                    scales: {
                        x: {
                            grid: { display: false },
                            ticks: { color: '#64748b', font: { size: 10 } }
                        },
                        y: {
                            display: false
                        }
                    }
                }
            });
        });

        function updateLineChart() {
            const selected = document.getElementById("ddlDistrictFilter").value;
            lineChartInstance.data.datasets[0].data = lineDataSets[selected] || lineDataSets["All"];
            lineChartInstance.update();
        }
    </script>
</asp:Content>