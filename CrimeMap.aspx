<%@ Page Title="Crime Map" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CrimeMap.aspx.cs" Inherits="Netra.CrimeMap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Leaflet CSS & JS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

    <style>
        .map-header-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
        }

        .map-title-main {
            font-size: 1.4rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 4px;
        }

        .map-wrapper {
            position: relative;
            width: 100%;
            height: calc(100vh - 180px);
            border: 1px solid #1e293b;
            border-radius: 12px;
            overflow: hidden;
            background-color: #070d18;
        }

        #mapContainer {
            width: 100%;
            height: 100%;
            z-index: 1;
        }

        /* Top Filter Toolbar Overlay */
        .map-toolbar {
            position: absolute;
            top: 16px;
            left: 16px;
            z-index: 1000;
            background: rgba(11, 19, 32, 0.90);
            border: 1px solid #1e293b;
            backdrop-filter: blur(8px);
            padding: 8px 14px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            gap: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.5);
        }

        .map-toolbar-status {
            font-size: 0.65rem;
            font-weight: 800;
            color: #38bdf8;
            letter-spacing: 0.8px;
            text-transform: uppercase;
            border-right: 1px solid #1e293b;
            padding-right: 12px;
        }

        .map-select {
            background-color: #070d18;
            border: 1px solid #1e293b;
            color: #cbd5e1;
            padding: 6px 10px;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 600;
            cursor: pointer;
            outline: none;
        }

        .map-select:focus {
            border-color: #00d2ff;
        }

        /* Right Actions Tool Group */
        .map-controls-group {
            position: absolute;
            top: 16px;
            right: 16px;
            z-index: 1000;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .map-action-btn {
            width: 38px;
            height: 38px;
            background: rgba(11, 19, 32, 0.90);
            border: 1px solid #1e293b;
            border-radius: 8px;
            color: #38bdf8;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 2px 10px rgba(0,0,0,0.4);
        }

        .map-action-btn:hover {
            border-color: #00d2ff;
            background: #12283e;
            color: #ffffff;
            transform: scale(1.05);
        }

        /* Bottom Left Legend Box */
        .map-legend {
            position: absolute;
            bottom: 16px;
            left: 16px;
            z-index: 1000;
            background: rgba(11, 19, 32, 0.90);
            border: 1px solid #1e293b;
            backdrop-filter: blur(8px);
            padding: 12px 16px;
            border-radius: 8px;
            width: 180px;
        }

        .legend-title {
            font-size: 0.68rem;
            font-weight: 800;
            color: #64748b;
            letter-spacing: 0.8px;
            text-transform: uppercase;
            margin-bottom: 8px;
        }

        .legend-row {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.72rem;
            color: #cbd5e1;
            margin-bottom: 4px;
        }

        .dot-critical { width: 8px; height: 8px; border-radius: 50%; background-color: #ef4444; }
        .dot-high { width: 8px; height: 8px; border-radius: 50%; background-color: #f97316; }
        .dot-medium { width: 8px; height: 8px; border-radius: 50%; background-color: #eab308; }
        .dot-low { width: 8px; height: 8px; border-radius: 50%; background-color: #38bdf8; }

        /* Bottom Right Counter Widget */
        .map-stats-widget {
            position: absolute;
            bottom: 16px;
            right: 16px;
            z-index: 1000;
            background: rgba(11, 19, 32, 0.90);
            border: 1px solid #1e293b;
            backdrop-filter: blur(8px);
            padding: 10px 18px;
            border-radius: 8px;
            display: flex;
            gap: 20px;
        }

        .stat-col {
            text-align: center;
        }

        .stat-num {
            font-size: 1.4rem;
            font-weight: 800;
            color: #00d2ff;
            line-height: 1;
        }

        .stat-num-red {
            font-size: 1.4rem;
            font-weight: 800;
            color: #f87171;
            line-height: 1;
        }

        .stat-lbl {
            font-size: 0.62rem;
            font-weight: 800;
            color: #64748b;
            text-transform: uppercase;
            margin-top: 4px;
        }

        /* Leaflet Dark Custom Overrides */
        .leaflet-popup-content-wrapper {
            background: #0b1320;
            border: 1px solid #1e293b;
            color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0,210,255,0.2);
        }

        .leaflet-popup-tip {
            background: #0b1320;
        }

        .popup-case-id {
            font-size: 0.7rem;
            font-weight: 800;
            color: #38bdf8;
            margin-bottom: 2px;
        }

        .popup-title {
            font-size: 0.85rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 6px;
        }

        .popup-desc {
            font-size: 0.72rem;
            color: #94a3b8;
            margin-bottom: 8px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="map-header-row">
        <div>
            <div class="map-title-main">Crime Intelligence Map</div>
        </div>
    </div>

    <div class="map-wrapper">
        <!-- Interactive Leaflet Container -->
        <div id="mapContainer"></div>

        <!-- Top Interactive Filters -->
        <div class="map-toolbar">
            <span class="map-toolbar-status">NEURAL GIS | SECURE</span>
            
            <select id="ddlTimeframe" class="map-select" onchange="filterMapMarkers()">
                <option value="30">📅 Last 30 Days</option>
                <option value="7">📅 Last 7 Days</option>
                <option value="1">📅 Last 24 Hours</option>
            </select>

            <select id="ddlDistrict" class="map-select" onchange="filterMapMarkers()">
                <option value="all">🗺️ All Districts</option>
                <option value="urban">Bengaluru Urban</option>
                <option value="rural">Bengaluru Rural</option>
                <option value="mysuru">Mysuru Sector</option>
            </select>

            <select id="ddlCrimeType" class="map-select" onchange="filterMapMarkers()">
                <option value="all">⚠️ All Crime Types</option>
                <option value="violent">Violent Crime</option>
                <option value="cyber">Cyber Anomaly</option>
                <option value="narcotics">Narcotics Trafficking</option>
            </select>
        </div>

        <!-- Map Control Buttons -->
        <div class="map-controls-group">
            <button type="button" class="map-action-btn" onclick="recenterMap()" title="Recenter View">🎯</button>
            <button type="button" class="map-action-btn" onclick="zoomInMap()" title="Zoom In">➕</button>
            <button type="button" class="map-action-btn" onclick="zoomOutMap()" title="Zoom Out">➖</button>
            <button type="button" class="map-action-btn" onclick="toggleHeatmap()" title="Toggle Heatmap Focus">🔥</button>
        </div>

        <!-- Risk Legend -->
        <div class="map-legend">
            <div class="legend-title">RISK SEVERITY</div>
            <div class="legend-row"><span class="dot-critical"></span> Critical Threat</div>
            <div class="legend-row"><span class="dot-high"></span> High Risk Zone</div>
            <div class="legend-row"><span class="dot-medium"></span> Medium Priority</div>
            <div class="legend-row"><span class="dot-low"></span> Low Anomaly</div>
        </div>

        <!-- Live Metrics Widget -->
        <div class="map-stats-widget">
            <div class="stat-col">
                <div class="stat-num" id="lblActiveEvents">142</div>
                <div class="stat-lbl">Active Events</div>
            </div>
            <div style="width: 1px; background: #1e293b;"></div>
            <div class="stat-col">
                <div class="stat-num-red" id="lblCriticalEvents">12</div>
                <div class="stat-lbl">Critical</div>
            </div>
        </div>
    </div>

    <!-- Map Logic Script -->
    <script>
        let map;
        let markerLayerGroup;

        // Incident dataset with district & severity attributes[cite: 7]
        const incidentData = [
            { id: "CAS-2026-901", title: "Armed Hijack Incident", type: "violent", severity: "critical", district: "urban", days: 2, lat: 12.9716, lng: 77.5946, desc: "Commercial freight vehicle intercepted near Sector 7G." },
            { id: "CAS-2026-884", title: "Anomalous Server Transfer", type: "cyber", severity: "high", district: "urban", days: 5, lat: 12.9279, lng: 77.6271, desc: "Unauthorized data exfiltration detected at Node SVR-092." },
            { id: "CAS-2026-750", title: "Narcotics Stash Seizure", type: "narcotics", severity: "critical", district: "rural", days: 12, lat: 13.0827, lng: 77.5877, desc: "Warehouse raid yielded contraband inventory in Block C." },
            { id: "CAS-2026-612", title: "ATM Tampering Fraud", type: "cyber", severity: "medium", district: "mysuru", days: 18, lat: 12.2958, lng: 76.6394, desc: "Skimmer devices recovered from Mysuru Main Square." },
            { id: "CAS-2026-501", title: "Industrial Storage Fire", type: "violent", severity: "low", district: "rural", days: 25, lat: 13.1986, lng: 77.7066, desc: "Suspected arson under active forensic review." }
        ];

        function initMap() {
            // Center around Bengaluru Urban / Karnataka Sector[cite: 7]
            map = L.map('mapContainer', { zoomControl: false }).setView([12.9716, 77.5946], 11);

            // Dark Mode CartoDB Tile Layer
            L.tileLayer('https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png', {
                maxZoom: 19,
                subdomains: 'abcd',
                attribution: '&copy; NETRA Neural GIS'
            }).addTo(map);

            markerLayerGroup = L.layerGroup().addTo(map);
            filterMapMarkers();
        }

        function createCustomIcon(severity) {
            let color = '#38bdf8';
            if (severity === 'critical') color = '#ef4444';
            else if (severity === 'high') color = '#f97316';
            else if (severity === 'medium') color = '#eab308';

            const svgMarker = `
                <svg width="30" height="40" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M12 2C8.13 2 5 5.13 5 9C5 14.25 12 22 12 22C12 22 19 14.25 19 9C19 5.13 15.87 2 12 2Z" fill="${color}" stroke="#070d18" stroke-width="1.5"/>
                    <circle cx="12" cy="9" r="3.5" fill="#070d18"/>
                </svg>`;

            return L.divIcon({
                className: 'custom-map-pin',
                html: svgMarker,
                iconSize: [30, 40],
                iconAnchor: [15, 40],
                popupAnchor: [0, -35]
            });
        }

        function filterMapMarkers() {
            markerLayerGroup.clearLayers();

            const selectedDays = parseInt(document.getElementById('ddlTimeframe').value);
            const selectedDistrict = document.getElementById('ddlDistrict').value;
            const selectedType = document.getElementById('ddlCrimeType').value;

            let activeCount = 0;
            let criticalCount = 0;

            incidentData.forEach(item => {
                const matchesDays = item.days <= selectedDays;
                const matchesDistrict = (selectedDistrict === 'all' || item.district === selectedDistrict);
                const matchesType = (selectedType === 'all' || item.type === selectedType);

                if (matchesDays && matchesDistrict && matchesType) {
                    activeCount++;
                    if (item.severity === 'critical') criticalCount++;

                    const marker = L.marker([item.lat, item.lng], { icon: createCustomIcon(item.severity) });

                    const popupHtml = `
                        <div class="popup-case-id">${item.id}</div>
                        <div class="popup-title">${item.title}</div>
                        <div class="popup-desc">${item.desc}</div>
                        <a href="InvestigationWorkspace.aspx?case=${item.id}" style="color:#00d2ff; font-size:0.72rem; font-weight:800; text-decoration:none;">Open Case File →</a>
                    `;

                    marker.bindPopup(popupHtml);
                    markerLayerGroup.addLayer(marker);
                }
            });

            document.getElementById('lblActiveEvents').innerText = activeCount;
            document.getElementById('lblCriticalEvents').innerText = criticalCount;
        }

        function recenterMap() {
            map.setView([12.9716, 77.5946], 11);
        }

        function zoomInMap() {
            map.zoomIn();
        }

        function zoomOutMap() {
            map.zoomOut();
        }

        function toggleHeatmap() {
            map.setView([12.9716, 77.5946], 12);
        }

        window.addEventListener('DOMContentLoaded', initMap);
    </script>
</asp:Content>