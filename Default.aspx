<%@ Page Title="Intelligence Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Netra.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .page-header-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
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

        /* Export Button Styling */
        .btn-export-cyan {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            color: #38bdf8;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s ease;
            text-decoration: none;
        }

        .btn-export-cyan:hover {
            border-color: #38bdf8;
            background-color: #12283e;
            box-shadow: 0 0 10px rgba(56, 189, 248, 0.2);
        }

        /* Metric Cards Grid */
        .metrics-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 18px;
            margin-bottom: 24px;
        }

        @media (max-width: 1100px) {
            .metrics-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        .metric-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 18px;
            position: relative;
        }

        .metric-top-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }

        .metric-title {
            font-size: 0.68rem;
            font-weight: 800;
            color: #64748b;
            letter-spacing: 0.8px;
            text-transform: uppercase;
        }

        .metric-value {
            font-size: 1.8rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 8px;
            line-height: 1;
        }

        .metric-sub {
            font-size: 0.7rem;
            color: #38bdf8;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        /* Main Charts Section */
        .charts-main-grid {
            display: grid;
            grid-template-columns: 1fr 340px;
            gap: 20px;
            margin-bottom: 24px;
        }

        @media (max-width: 1024px) {
            .charts-main-grid {
                grid-template-columns: 1fr;
            }
        }

        .glass-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .glass-card:last-child {
            margin-bottom: 0;
        }

        .card-header-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
        }

        .card-title {
            font-size: 0.9rem;
            font-weight: 800;
            color: #ffffff;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* View All Link */
        .link-view-all {
            color: #38bdf8;
            font-size: 0.72rem;
            font-weight: 700;
            text-decoration: none;
            transition: color 0.2s ease;
        }

        .link-view-all:hover {
            color: #00d2ff;
            text-decoration: underline;
        }

        /* High Risk Table */
        .risk-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #162234;
            font-size: 0.78rem;
        }

        .risk-row:last-child {
            border-bottom: none;
        }

        .risk-score-high {
            color: #f87171;
            font-weight: 800;
        }

        .risk-score-medium {
            color: #facc15;
            font-weight: 800;
        }

        .risk-score-low {
            color: #38bdf8;
            font-weight: 800;
        }

        /* Recent Alerts List */
        .alert-item {
            padding: 10px 0;
            border-bottom: 1px solid #162234;
        }

        .alert-item:last-child {
            border-bottom: none;
        }

        .alert-item-title {
            font-size: 0.78rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 4px;
        }

        .alert-item-sub {
            font-size: 0.68rem;
            color: #64748b;
            display: flex;
            justify-content: space-between;
        }

        /* Bottom Charts Subgrid */
        .charts-sub-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        @media (max-width: 768px) {
            .charts-sub-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Header with Functional Export Button -->
    <div class="page-header-row">
        <div>
            <div class="page-title">Intelligence Dashboard</div>
            <div class="page-sub-text">Real-time threat assessment and case analytics overview.</div>
        </div>
        <button type="button" class="btn-export-cyan" onclick="exportDashboardReport()">
            <span>📥</span> Export Report
        </button>
    </div>

    <!-- Metrics Cards Grid -->
    <div class="metrics-grid">
        <div class="metric-card">
            <div class="metric-top-row">
                <span class="metric-title">TOTAL CASES</span>
                <span>📁</span>
            </div>
            <div class="metric-value">14,208</div>
            <div class="metric-sub">📈 +2.4% from last month</div>
        </div>

        <div class="metric-card">
            <div class="metric-top-row">
                <span class="metric-title">ACTIVE CASES</span>
                <span>⚡</span>
            </div>
            <div class="metric-value">1,842</div>
            <div class="metric-sub">📌 +12 new today</div>
        </div>

        <div class="metric-card">
            <div class="metric-top-row">
                <span class="metric-title">HIGH-RISK AREAS</span>
                <span>⚠️</span>
            </div>
            <div class="metric-value">12</div>
            <div class="metric-sub" style="color:#f87171;">📌 3 elevated in 24h</div>
        </div>

        <div class="metric-card">
            <div class="metric-top-row">
                <span class="metric-title">ACTIVE ALERTS</span>
                <span>📢</span>
            </div>
            <div class="metric-value">34</div>
            <div class="metric-sub" style="color:#facc15;">👁️ 8 pending review</div>
        </div>
    </div>

    <!-- Charts Split Row -->
    <div class="charts-main-grid">
        <!-- Left Column: YTD Crime Trend -->
        <div class="glass-card">
            <div class="card-header-row">
                <div class="card-title">📈 Crime Trend Analysis (YTD)</div>
                <select style="background:#070d18; border:1px solid #1e293b; color:#cbd5e1; padding:4px 8px; border-radius:4px; font-size:0.75rem;">
                    <option>All Districts</option>
                    <option>Bengaluru Urban</option>
                    <option>Bengaluru Rural</option>
                </select>
            </div>
            <div style="height: 260px;">
                <canvas id="trendChart"></canvas>
            </div>
        </div>

        <!-- Right Column: High Risk & Alerts -->
        <div>
            <!-- High Risk Areas -->
            <div class="glass-card">
                <div class="card-header-row">
                    <div class="card-title">🛡️ High-Risk Areas</div>
                    <span style="font-size:0.68rem; color:#64748b;">Risk Score</span>
                </div>

                <div class="risk-row">
                    <span>🔴 Sector 7G</span>
                    <span class="risk-score-high">94.2</span>
                </div>
                <div class="risk-row">
                    <span>🔴 Industrial Park North</span>
                    <span class="risk-score-high">88.7</span>
                </div>
                <div class="risk-row">
                    <span>🟡 Downtown Metro</span>
                    <span class="risk-score-medium">76.4</span>
                </div>
                <div class="risk-row">
                    <span>🟡 Port Authority Zone</span>
                    <span class="risk-score-medium">72.1</span>
                </div>
                <div class="risk-row">
                    <span>🔵 Residential Block C</span>
                    <span class="risk-score-low">45.0</span>
                </div>
            </div>

            <!-- Recent Alerts with Functional View All Link -->
            <div class="glass-card">
                <div class="card-header-row">
                    <div class="card-title">🔔 Recent Alerts</div>
                    <a href="Alerts.aspx" class="link-view-all">View All</a>
                </div>

                <div class="alert-item">
                    <div class="alert-item-title">❗ Anomalous Data Transfer Detected</div>
                    <div class="alert-item-sub">
                        <span>Node: SVR-092</span>
                        <span>2 mins ago</span>
                    </div>
                </div>

                <div class="alert-item">
                    <div class="alert-item-title">🚗 Suspicious Vehicle Movement</div>
                    <div class="alert-item-sub">
                        <span>Sector 4, Downtown</span>
                        <span>14 mins ago</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bottom Charts Subgrid -->
    <div class="charts-sub-grid">
        <div class="glass-card">
            <div class="card-title" style="margin-bottom:14px;">📊 Distribution by Type</div>
            <div style="height: 200px;">
                <canvas id="typeChart"></canvas>
            </div>
        </div>

        <div class="glass-card">
            <div class="card-title" style="margin-bottom:14px;">🏛️ District Comparison</div>
            <div style="height: 200px;">
                <canvas id="districtChart"></canvas>
            </div>
        </div>
    </div>

    <!-- Dashboard JavaScript Engine -->
    <script>
        // Export Report CSV Generator
        function exportDashboardReport() {
            const csvRows = [
                ["NETRA INTELLIGENCE DASHBOARD SUMMARY REPORT"],
                ["Generated At", new Date().toISOString()],
                [],
                ["Metric", "Value"],
                ["Total Cases", "14208"],
                ["Active Cases", "1842"],
                ["High-Risk Areas", "12"],
                ["Active Alerts", "34"],
                [],
                ["High-Risk Area", "Risk Score"],
                ["Sector 7G", "94.2"],
                ["Industrial Park North", "88.7"],
                ["Downtown Metro", "76.4"],
                ["Port Authority Zone", "72.1"],
                ["Residential Block C", "45.0"]
            ];

            const csvContent = "data:text/csv;charset=utf-8," + csvRows.map(e => e.join(",")).join("\n");
            const encodedUri = encodeURI(csvContent);
            const link = document.createElement("a");
            link.setAttribute("href", encodedUri);
            link.setAttribute("download", "NETRA_Dashboard_Report.csv");
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }

        // Render Dashboard Charts
        window.addEventListener('DOMContentLoaded', () => {
            // Trend Line Chart
            const ctxTrend = document.getElementById('trendChart').getContext('2d');
            new Chart(ctxTrend, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [{
                        label: 'Incidents',
                        data: [800, 950, 1100, 900, 1400, 1250, 1700, 1500, 1900, 1100, 600, 1000],
                        borderColor: '#00d2ff',
                        backgroundColor: 'rgba(0, 210, 255, 0.1)',
                        borderWidth: 3,
                        tension: 0.4,
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: { legend: { display: false } },
                    scales: {
                        x: { grid: { color: '#1a2536' }, ticks: { color: '#64748b' } },
                        y: { grid: { color: '#1a2536' }, ticks: { color: '#64748b' } }
                    }
                }
            });

            // Donut Chart
            const ctxType = document.getElementById('typeChart').getContext('2d');
            new Chart(ctxType, {
                type: 'doughnut',
                data: {
                    labels: ['Cybercrime', 'Vehicle Theft', 'Financial Fraud', 'Narcotics'],
                    datasets: [{
                        data: [40, 25, 20, 15],
                        backgroundColor: ['#00d2ff', '#3b82f6', '#facc15', '#ef4444'],
                        borderWidth: 0
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: { legend: { position: 'right', labels: { color: '#cbd5e1' } } }
                }
            });

            // Bar Chart
            const ctxDistrict = document.getElementById('districtChart').getContext('2d');
            new Chart(ctxDistrict, {
                type: 'bar',
                data: {
                    labels: ['Bengaluru Urban', 'Bengaluru Rural', 'Mysuru', 'Mangaluru'],
                    datasets: [{
                        data: [1200, 850, 600, 400],
                        backgroundColor: '#00d2ff',
                        borderRadius: 4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: { legend: { display: false } },
                    scales: {
                        x: { grid: { display: false }, ticks: { color: '#64748b' } },
                        y: { grid: { color: '#1a2536' }, ticks: { color: '#64748b' } }
                    }
                }
            });
        });
    </script>
</asp:Content>