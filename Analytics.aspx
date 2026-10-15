<%@ Page Title="Crime Analytics" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Analytics.aspx.cs" Inherits="Netra.Analytics" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Chart.js for Visualization Rendering -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        .page-header-title {
            font-size: 1.35rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 20px;
        }

        /* Top Filter Bar */
        .analytics-filter-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 16px 20px;
            margin-bottom: 22px;
        }

        .filter-row-top {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 12px;
            margin-bottom: 12px;
        }

        .filter-row-bottom {
            display: grid;
            grid-template-columns: 1fr auto;
            gap: 12px;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .filter-label {
            font-size: 0.65rem;
            font-weight: 700;
            letter-spacing: 0.8px;
            color: #64748b;
            text-transform: uppercase;
        }

        .filter-select {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 8px 12px;
            color: #f8fafc;
            font-size: 0.8rem;
            outline: none;
            width: 100%;
            transition: border-color 0.2s ease;
        }

        .filter-select:focus {
            border-color: #00d2ff;
        }

        .btn-apply-filter {
            background: linear-gradient(135deg, #00d2ff 0%, #00a8cc 100%);
            color: #070d18;
            border: none;
            padding: 0 24px;
            border-radius: 6px;
            font-size: 0.82rem;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            height: 35px;
            align-self: flex-end;
            transition: all 0.25s ease;
        }

        .btn-apply-filter:hover {
            opacity: 0.9;
            box-shadow: 0 0 12px rgba(0, 210, 255, 0.4);
        }

        /* Two Column Main Grid */
        .analytics-grid {
            display: grid;
            grid-template-columns: 1fr 310px;
            gap: 22px;
        }

        @media (max-width: 1200px) {
            .analytics-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Key Metrics Row */
        .metrics-row {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 22px;
        }

        .metric-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 16px;
        }

        .metric-title {
            font-size: 0.65rem;
            font-weight: 700;
            color: #64748b;
            letter-spacing: 0.8px;
            text-transform: uppercase;
            margin-bottom: 8px;
        }

        .metric-value {
            font-size: 1.6rem;
            font-weight: 800;
            color: #ffffff;
            display: flex;
            align-items: baseline;
            gap: 8px;
            line-height: 1;
        }

        .metric-sub {
            font-size: 0.72rem;
            font-weight: 600;
            margin-top: 6px;
        }

        .trend-up { color: #f43f5e; font-size: 0.75rem; }
        .trend-down { color: #38bdf8; font-size: 0.75rem; }

        /* Chart Panels */
        .chart-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 18px 20px;
            margin-bottom: 22px;
        }

        .chart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
            padding-bottom: 8px;
            border-bottom: 1px solid #1a2536;
        }

        .chart-title {
            font-size: 0.95rem;
            font-weight: 700;
            color: #ffffff;
        }

        .charts-two-col {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        /* AI Insights Sidebar Panel */
        .ai-panel {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 18px;
            display: flex;
            flex-direction: column;
            gap: 14px;
            height: fit-content;
        }

        .ai-header {
            background-color: #12283e;
            color: #38bdf8;
            padding: 10px 14px;
            border-radius: 6px;
            font-size: 0.88rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .ai-dot {
            width: 7px;
            height: 7px;
            background-color: #38bdf8;
            border-radius: 50%;
            box-shadow: 0 0 8px #38bdf8;
        }

        .insight-card {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 14px;
            border-left: 3px solid #64748b;
        }

        .insight-card.alert-critical { border-left-color: #f43f5e; }
        .insight-card.alert-pattern { border-left-color: #00d2ff; }
        .insight-card.alert-obs { border-left-color: #38bdf8; }
        .insight-card.alert-anomaly { border-left-color: #f59e0b; }

        .insight-tag {
            font-size: 0.62rem;
            font-weight: 800;
            letter-spacing: 0.8px;
            text-transform: uppercase;
            margin-bottom: 6px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .insight-desc {
            font-size: 0.75rem;
            color: #cbd5e1;
            line-height: 1.45;
        }

        .btn-gen-insights {
            width: 100%;
            background-color: #070d18;
            border: 1px solid #1e293b;
            color: #f8fafc;
            padding: 10px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.2s ease;
            margin-top: 10px;
        }

        .btn-gen-insights:hover {
            border-color: #00d2ff;
            color: #00d2ff;
            background-color: #0d1a2d;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header-title">Crime Analytics</div>

    <!-- Filter Toolbar -->
    <div class="analytics-filter-card">
        <div class="filter-row-top">
            <div class="filter-group">
                <span class="filter-label">DATE RANGE</span>
                <asp:DropDownList ID="ddlDateRange" runat="server" CssClass="filter-select">
                    <asp:ListItem Value="30" Text="Last 30 Days" Selected="True" />
                    <asp:ListItem Value="7" Text="Last 7 Days" />
                    <asp:ListItem Value="90" Text="Last 90 Days" />
                </asp:DropDownList>
            </div>

            <div class="filter-group">
                <span class="filter-label">DISTRICT</span>
                <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="filter-select">
                    <asp:ListItem Value="ALL" Text="All Districts" Selected="True" />
                    <asp:ListItem Value="Central" Text="Central District" />
                    <asp:ListItem Value="North" Text="North District" />
                    <asp:ListItem Value="South" Text="South District" />
                    <asp:ListItem Value="East" Text="East District" />
                </asp:DropDownList>
            </div>

            <div class="filter-group">
                <span class="filter-label">CRIME TYPE</span>
                <asp:DropDownList ID="ddlCrimeType" runat="server" CssClass="filter-select">
                    <asp:ListItem Value="ALL" Text="All Types" Selected="True" />
                    <asp:ListItem Value="Theft" Text="Theft & Larceny" />
                    <asp:ListItem Value="Cyber" Text="Cyber Crime" />
                    <asp:ListItem Value="Fraud" Text="Financial Fraud" />
                </asp:DropDownList>
            </div>

            <div class="filter-group">
                <span class="filter-label">POLICE STATION</span>
                <asp:DropDownList ID="ddlStation" runat="server" CssClass="filter-select">
                    <asp:ListItem Value="ALL" Text="All Stations" Selected="True" />
                    <asp:ListItem Value="ST1" Text="Central HQ Station" />
                    <asp:ListItem Value="ST2" Text="West Precinct" />
                </asp:DropDownList>
            </div>
        </div>

        <div class="filter-row-bottom">
            <div class="filter-group">
                <span class="filter-label">SEVERITY</span>
                <asp:DropDownList ID="ddlSeverity" runat="server" CssClass="filter-select">
                    <asp:ListItem Value="ALL" Text="All Levels" Selected="True" />
                    <asp:ListItem Value="CRITICAL" Text="Critical" />
                    <asp:ListItem Value="HIGH" Text="High" />
                    <asp:ListItem Value="MEDIUM" Text="Medium" />
                </asp:DropDownList>
            </div>
            <button type="button" class="btn-apply-filter" onclick="updateAnalyticsCharts()">⚡ Apply</button>
        </div>
    </div>

    <!-- Analytics Main Grid -->
    <div class="analytics-grid">
        <!-- Left Side Dashboard Content -->
        <div>
            <!-- Key Metrics Overview Cards -->
            <div class="metrics-row">
                <div class="metric-card">
                    <div class="metric-title">TOTAL CASES</div>
                    <div class="metric-value">1,492 <span class="trend-up">↑12%</span></div>
                </div>

                <div class="metric-card">
                    <div class="metric-title">AVG CASES / DAY</div>
                    <div class="metric-value">49.7 <span class="trend-down">↓3%</span></div>
                </div>

                <div class="metric-card">
                    <div class="metric-title">MOST COMMON CRIME</div>
                    <div class="metric-value" style="font-size:1.15rem; font-weight:700;">Theft & Larceny</div>
                    <div class="metric-sub" style="color:#64748b;">32% of total</div>
                </div>

                <div class="metric-card">
                    <div class="metric-title">HIGHEST CRIME DISTRICT</div>
                    <div class="metric-value" style="font-size:1.15rem; font-weight:700;">Central District</div>
                    <div class="metric-sub" style="color:#f43f5e;">⚠️ Critical Level</div>
                </div>
            </div>

            <!-- Chart 1: Crime Trend Over Time -->
            <div class="chart-card">
                <div class="chart-header">
                    <div class="chart-title">Crime Trend Over Time</div>
                    <span style="color:#64748b; font-size:0.8rem; cursor:pointer;">•••</span>
                </div>
                <div style="height: 200px; width: 100%;">
                    <canvas id="trendChart"></canvas>
                </div>
            </div>

            <!-- Charts Row 2: Distribution & Severity Split -->
            <div class="charts-two-col">
                <div class="chart-card">
                    <div class="chart-header">
                        <div class="chart-title">Crime Type Distribution</div>
                    </div>
                    <div style="height: 180px; position:relative; display:flex; justify-content:center;">
                        <canvas id="distributionChart"></canvas>
                    </div>
                </div>

                <div class="chart-card">
                    <div class="chart-header">
                        <div class="chart-title">Severity by District</div>
                    </div>
                    <div style="height: 180px;">
                        <canvas id="severityChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Side: AI Insights Column -->
        <div class="ai-panel">
            <div class="ai-header">
                <span>📍 AI Insights</span>
                <div class="ai-dot"></div>
            </div>

            <div class="insight-card alert-critical">
                <div class="insight-tag" style="color:#f43f5e;">⚡ CRITICAL ALERT</div>
                <div class="insight-desc">
                    15% increase in burglary incidents reported in the West District over the last 72 hours, primarily between 02:00 and 05:00.
                </div>
            </div>

            <div class="insight-card alert-pattern">
                <div class="insight-tag" style="color:#00d2ff;">🕸️ PATTERN DETECTED</div>
                <div class="insight-desc">
                    Correlation found between narcotics arrests in Central District and auto theft in South District within 24-hour windows.
                </div>
            </div>

            <div class="insight-card alert-obs">
                <div class="insight-tag" style="color:#38bdf8;">📋 OBSERVATION</div>
                <div class="insight-desc">
                    Weekend assault rates have normalized to baseline levels following increased patrol deployment in entertainment zones.
                </div>
            </div>

            <div class="insight-card alert-anomaly">
                <div class="insight-tag" style="color:#f59e0b;">⚠️ ANOMALY</div>
                <div class="insight-desc">
                    Unusual cluster of financial fraud reports originating from IP subnet 192.168.x.x targeting elderly demographics in North District.
                </div>
            </div>

            <button type="button" class="btn-gen-insights" onclick="alert('🤖 Generating real-time neural intelligence insights...')">
                🔄 Generate New Insights
            </button>
        </div>
    </div>

    <!-- Chart.js Initializers -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // 1. Crime Trend Over Time Chart
            const ctxTrend = document.getElementById('trendChart').getContext('2d');
            const gradTrend = ctxTrend.createLinearGradient(0, 0, 0, 200);
            gradTrend.addColorStop(0, 'rgba(0, 210, 255, 0.3)');
            gradTrend.addColorStop(1, 'rgba(0, 210, 255, 0.0)');

            new Chart(ctxTrend, {
                type: 'line',
                data: {
                    labels: ['Jan 1', 'Jan 5', 'Jan 10', 'Jan 15', 'Jan 20', 'Jan 25', 'Jan 30'],
                    datasets: [{
                        label: 'Incidents',
                        data: [42, 48, 38, 56, 45, 62, 50],
                        borderColor: '#00d2ff',
                        backgroundColor: gradTrend,
                        borderWidth: 2,
                        fill: true,
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: { legend: { display: false } },
                    scales: {
                        x: { grid: { color: 'rgba(30, 41, 59, 0.5)' }, ticks: { color: '#64748b' } },
                        y: { grid: { color: 'rgba(30, 41, 59, 0.5)' }, ticks: { color: '#64748b' } }
                    }
                }
            });

            // 2. Crime Type Distribution Doughnut Chart
            const ctxDist = document.getElementById('distributionChart').getContext('2d');
            new Chart(ctxDist, {
                type: 'doughnut',
                data: {
                    labels: ['Theft & Larceny', 'Cyber Crime', 'Financial Fraud', 'Other'],
                    datasets: [{
                        data: [450, 320, 280, 442],
                        backgroundColor: ['#00d2ff', '#38bdf8', '#f59e0b', '#1e293b'],
                        borderWidth: 0
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: { legend: { display: false } },
                    cutout: '72%'
                }
            });

            // 3. Severity by District Stacked Bar Chart
            const ctxSev = document.getElementById('severityChart').getContext('2d');
            new Chart(ctxSev, {
                type: 'bar',
                data: {
                    labels: ['Central', 'North', 'South', 'East'],
                    datasets: [
                        { label: 'High', data: [35, 20, 40, 15], backgroundColor: '#f43f5e' },
                        { label: 'Med', data: [45, 55, 30, 25], backgroundColor: '#00d2ff' },
                        { label: 'Low', data: [20, 25, 30, 60], backgroundColor: '#1e293b' }
                    ]
                },
                options: {
                    indexAxis: 'y',
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: { legend: { display: false } },
                    scales: {
                        x: { stacked: true, grid: { color: 'rgba(30, 41, 59, 0.5)' }, ticks: { color: '#64748b' } },
                        y: { stacked: true, grid: { display: false }, ticks: { color: '#cbd5e1' } }
                    }
                }
            });
        });

        function updateAnalyticsCharts() {
            alert("📊 Analytics data dynamically updated according to your filter criteria!");
        }
    </script>
</asp:Content>