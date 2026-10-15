<%@ Page Title="Crime Intelligence Map" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CrimeMap.aspx.cs" Inherits="Netra.CrimeMap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-header-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            width: 100%;
        }

        .page-title h2 {
            font-size: 1.4rem;
            font-weight: 700;
            color: #ffffff;
        }

        /* Map Viewport Container */
        .map-viewport {
            width: 100%;
            height: calc(100vh - 140px);
            min-height: 550px;
            background-color: #060b14;
            border: 1px solid #1e293b;
            border-radius: 8px;
            position: relative;
            overflow: hidden;
            background-image: 
                radial-gradient(circle at 50% 50%, rgba(14, 165, 233, 0.05) 0%, transparent 70%),
                linear-gradient(rgba(30, 41, 59, 0.2) 1px, transparent 1px),
                linear-gradient(90deg, rgba(30, 41, 59, 0.2) 1px, transparent 1px);
            background-size: 100% 100%, 30px 30px, 30px 30px;
        }

        /* Tactical Header Ticker inside Map */
        .map-ticker {
            position: absolute;
            top: 15px;
            left: 20px;
            font-family: monospace;
            font-size: 0.7rem;
            color: #64748b;
            letter-spacing: 1px;
            z-index: 10;
            pointer-events: none;
        }

        /* Floating Top Filter Controls Bar */
        .map-controls-bar {
            position: absolute;
            top: 35px;
            left: 20px;
            display: flex;
            gap: 10px;
            z-index: 20;
        }

        .map-filter-btn {
            background-color: rgba(11, 19, 32, 0.85);
            border: 1px solid #1e293b;
            backdrop-filter: blur(8px);
            color: #cbd5e1;
            padding: 7px 14px;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s ease;
        }

        .map-filter-btn:hover {
            border-color: #00d2ff;
            color: #00d2ff;
        }

        /* Interactive Pins */
        .map-pin {
            position: absolute;
            width: 24px;
            height: 24px;
            border-radius: 50% 50% 50% 0;
            transform: rotate(-45deg);
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.25s ease;
            z-index: 15;
        }

        .map-pin::after {
            content: '';
            width: 8px;
            height: 8px;
            background-color: #060b14;
            border-radius: 50%;
        }

        .pin-critical {
            background-color: #f43f5e;
            box-shadow: 0 0 15px rgba(244, 63, 94, 0.7);
            animation: pulsePin 1.8s infinite;
        }

        .pin-high {
            background-color: #fb923c;
            box-shadow: 0 0 12px rgba(251, 146, 60, 0.6);
        }

        .pin-medium {
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.5);
        }

        @keyframes pulsePin {
            0% { transform: scale(1) rotate(-45deg); box-shadow: 0 0 10px rgba(244, 63, 94, 0.5); }
            50% { transform: scale(1.15) rotate(-45deg); box-shadow: 0 0 20px rgba(244, 63, 94, 0.9); }
            100% { transform: scale(1) rotate(-45deg); box-shadow: 0 0 10px rgba(244, 63, 94, 0.5); }
        }

        /* Floating Case Popup Card */
        .case-popup-card {
            position: absolute;
            top: 45px;
            left: 420px;
            width: 280px;
            background-color: rgba(11, 19, 32, 0.92);
            border: 1px solid #1e293b;
            backdrop-filter: blur(12px);
            border-radius: 8px;
            padding: 16px;
            z-index: 30;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.6);
        }

        .popup-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }

        .popup-tag {
            font-size: 0.62rem;
            font-weight: 800;
            letter-spacing: 0.8px;
            color: #f43f5e;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .popup-tag::before {
            content: '●';
            color: #f43f5e;
        }

        .popup-close {
            color: #64748b;
            cursor: pointer;
            font-size: 0.85rem;
        }

        .popup-close:hover { color: #ffffff; }

        .popup-title {
            font-size: 0.95rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 12px;
        }

        .popup-details-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px;
            margin-bottom: 12px;
            font-size: 0.72rem;
        }

        .popup-label {
            color: #64748b;
            font-size: 0.62rem;
            text-transform: uppercase;
            font-weight: 700;
            margin-bottom: 2px;
        }

        .popup-val {
            color: #e2e8f0;
            font-weight: 600;
        }

        .btn-view-case {
            width: 100%;
            background-color: transparent;
            border: 1px solid #00d2ff;
            color: #00d2ff;
            padding: 7px 10px;
            border-radius: 5px;
            font-size: 0.75rem;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            transition: all 0.2s ease;
        }

        .btn-view-case:hover {
            background-color: #00d2ff;
            color: #070d18;
            box-shadow: 0 0 10px rgba(0, 210, 255, 0.4);
        }

        /* Right Floating Tool Bar */
        .map-tools-right {
            position: absolute;
            top: 20px;
            right: 20px;
            display: flex;
            flex-direction: column;
            gap: 8px;
            z-index: 20;
        }

        .tool-btn {
            width: 34px;
            height: 34px;
            background-color: rgba(11, 19, 32, 0.85);
            border: 1px solid #1e293b;
            backdrop-filter: blur(8px);
            color: #00d2ff;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 0.9rem;
            transition: all 0.2s ease;
        }

        .tool-btn:hover {
            border-color: #00d2ff;
            background-color: #12283e;
            transform: scale(1.05);
        }

        /* Bottom Left Legend */
        .legend-card {
            position: absolute;
            bottom: 20px;
            left: 20px;
            background-color: rgba(11, 19, 32, 0.88);
            border: 1px solid #1e293b;
            backdrop-filter: blur(8px);
            border-radius: 6px;
            padding: 12px 16px;
            z-index: 20;
            min-width: 150px;
        }

        .legend-title {
            font-size: 0.62rem;
            font-weight: 800;
            letter-spacing: 0.8px;
            color: #64748b;
            text-transform: uppercase;
            margin-bottom: 8px;
            padding-bottom: 4px;
            border-bottom: 1px solid #1e293b;
        }

        .legend-row {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.72rem;
            color: #cbd5e1;
            margin-bottom: 5px;
        }

        .legend-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
        }

        /* Bottom Right Live Metrics Overlay */
        .metrics-card {
            position: absolute;
            bottom: 20px;
            right: 20px;
            background-color: rgba(11, 19, 32, 0.88);
            border: 1px solid #1e293b;
            backdrop-filter: blur(8px);
            border-radius: 6px;
            padding: 10px 18px;
            display: flex;
            gap: 20px;
            z-index: 20;
        }

        .metric-col {
            text-align: center;
        }

        .metric-num {
            font-size: 1.3rem;
            font-weight: 800;
            line-height: 1;
        }

        .metric-label {
            font-size: 0.58rem;
            font-weight: 700;
            color: #64748b;
            letter-spacing: 0.8px;
            text-transform: uppercase;
            margin-top: 4px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header-row">
        <div class="page-title">
            <h2>Crime Intelligence Map</h2>
        </div>
    </div>

    <!-- Map Canvas Viewport -->
    <div class="map-viewport">
        <!-- Tactical Ticker -->
        <div class="map-ticker">NEURAL GIS | OPERATIONS MAP | STATUS: SECURE</div>

        <!-- Top Filter Controls -->
        <div class="map-controls-bar">
            <button type="button" class="map-filter-btn">📅 Last 30 Days ▾</button>
            <button type="button" class="map-filter-btn">🏢 All Districts ▾</button>
            <button type="button" class="map-filter-btn">⚠️ Violent Crime ▾</button>
        </div>

        <!-- Right Side Tools -->
        <div class="map-tools-right">
            <div class="tool-btn" title="Current Location">📍</div>
            <div class="tool-btn" title="Map Layers">🥞</div>
            <div class="tool-btn" title="Zoom In">➕</div>
            <div class="tool-btn" title="Zoom Out">➖</div>
            <div class="tool-btn" title="Target Reticle">🎯</div>
        </div>

        <!-- Map Pins (Simulated GIS Coordinates) -->
        <div class="map-pin pin-critical" style="top: 30%; left: 48%;" onclick="togglePopup()" title="CRITICAL PRIORITY: #CR-2023-8942"></div>
        <div class="map-pin pin-high" style="top: 50%; left: 38%;" title="HIGH PRIORITY: #CR-2023-8819"></div>
        <div class="map-pin pin-medium" style="top: 65%; left: 60%;" title="MEDIUM PRIORITY: #CR-2023-8780"></div>

        <!-- Interactive Floating Popup Card -->
        <div id="popupCard" class="case-popup-card">
            <div class="popup-header">
                <div class="popup-tag">CRITICAL PRIORITY</div>
                <div class="popup-close" onclick="togglePopup()">✕</div>
            </div>
            <div class="popup-title">Case ID: #CR-2023-8942</div>
            <div class="popup-details-grid">
                <div>
                    <div class="popup-label">TYPE</div>
                    <div class="popup-val">Armed Robbery</div>
                </div>
                <div>
                    <div class="popup-label">DATE/TIME</div>
                    <div class="popup-val">Oct 24, 23:45</div>
                </div>
            </div>
            <div style="margin-bottom: 12px;">
                <div class="popup-label">LOCATION SUMMARY</div>
                <div class="popup-val">Sector 7G, Industrial District, Warehouse 4</div>
            </div>
            <button type="button" class="btn-view-case" onclick="window.location.href='CrimeCases.aspx';">
                ↗ View Full Case File
            </button>
        </div>

        <!-- Bottom Left Risk Severity Legend -->
        <div class="legend-card">
            <div class="legend-title">Risk Severity</div>
            <div class="legend-row"><div class="legend-dot" style="background:#f43f5e;"></div> Critical</div>
            <div class="legend-row"><div class="legend-dot" style="background:#fb923c;"></div> High</div>
            <div class="legend-row"><div class="legend-dot" style="background:#ffffff;"></div> Medium</div>
            <div class="legend-row"><div class="legend-dot" style="background:#38bdf8;"></div> Low</div>
        </div>

        <!-- Bottom Right Metrics Panel -->
        <div class="metrics-card">
            <div class="metric-col">
                <div class="metric-num" style="color:#00d2ff;">142</div>
                <div class="metric-label">ACTIVE EVENTS</div>
            </div>
            <div class="metric-col" style="border-left: 1px solid #1e293b; padding-left: 18px;">
                <div class="metric-num" style="color:#f43f5e;">12</div>
                <div class="metric-label">CRITICAL</div>
            </div>
        </div>
    </div>

    <script>
        function togglePopup() {
            const popup = document.getElementById("popupCard");
            popup.style.display = (popup.style.display === "none") ? "block" : "none";
        }
    </script>
</asp:Content>