<%@ Page Title="Crime Intelligence Map" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CrimeMap.aspx.cs" Inherits="Netra.CrimeMap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-header-title {
            font-size: 1.35rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 15px;
        }

        /* Map Canvas Outer Viewport */
        .map-viewport {
            width: 100%;
            height: calc(100vh - 145px);
            min-height: 560px;
            background-color: #060b14;
            border: 1px solid #1e293b;
            border-radius: 8px;
            position: relative;
            overflow: hidden;
            background-image: 
                radial-gradient(circle at 65% 45%, rgba(239, 68, 68, 0.35) 0%, rgba(239, 68, 68, 0.12) 20%, transparent 45%),
                radial-gradient(circle at 60% 40%, rgba(239, 68, 68, 0.4) 0%, transparent 25%),
                radial-gradient(circle at 70% 50%, rgba(239, 68, 68, 0.25) 0%, transparent 30%),
                linear-gradient(135deg, #091322 0%, #050a12 100%);
        }

        /* Tactical Map Grid SVG Overlay */
        .map-grid-overlay {
            position: absolute;
            inset: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            opacity: 0.25;
            transition: opacity 0.3s ease, transform 0.3s ease;
            background-image: 
                linear-gradient(rgba(56, 189, 248, 0.15) 1px, transparent 1px),
                linear-gradient(90deg, rgba(56, 189, 248, 0.15) 1px, transparent 1px);
            background-size: 40px 40px;
        }

        /* Tactical Ticker */
        .map-ticker {
            position: absolute;
            top: 14px;
            left: 20px;
            font-family: monospace;
            font-size: 0.68rem;
            color: #475569;
            letter-spacing: 1.2px;
            z-index: 10;
            pointer-events: none;
            text-transform: uppercase;
        }

        /* Top Bar Custom Dropdown Trigger Buttons */
        .map-controls-bar {
            position: absolute;
            top: 36px;
            left: 20px;
            display: flex;
            gap: 10px;
            z-index: 40;
        }

        .dropdown-wrapper {
            position: relative;
        }

        .map-filter-btn {
            background-color: rgba(11, 19, 32, 0.92);
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
            gap: 8px;
            transition: all 0.2s ease;
            outline: none;
        }

        .map-filter-btn:hover, .map-filter-btn.active {
            border-color: #00d2ff;
            color: #00d2ff;
            box-shadow: 0 0 10px rgba(0, 210, 255, 0.2);
        }

        /* Floating Custom Dropdown Menus */
        .dropdown-menu {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            margin-top: 6px;
            width: 180px;
            background-color: rgba(11, 19, 32, 0.96);
            border: 1px solid #1e293b;
            backdrop-filter: blur(12px);
            border-radius: 6px;
            padding: 6px 0;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.7);
            z-index: 50;
        }

        .dropdown-menu.show {
            display: block;
        }

        .dropdown-item {
            padding: 8px 14px;
            font-size: 0.75rem;
            color: #cbd5e1;
            cursor: pointer;
            transition: all 0.15s ease;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .dropdown-item:hover {
            background-color: #12283e;
            color: #00d2ff;
        }

        .dropdown-item.selected {
            color: #00d2ff;
            font-weight: 700;
        }

        /* Right Floating Tactical Tools Stack */
        .map-tools-right {
            position: absolute;
            top: 20px;
            right: 20px;
            display: flex;
            flex-direction: column;
            gap: 8px;
            z-index: 40;
        }

        .tool-btn {
            width: 36px;
            height: 36px;
            background-color: rgba(11, 19, 32, 0.88);
            border: 1px solid #1e293b;
            backdrop-filter: blur(8px);
            color: #cbd5e1;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 0.95rem;
            transition: all 0.2s ease;
            outline: none;
            user-select: none;
        }

        .tool-btn:hover {
            border-color: #00d2ff;
            color: #00d2ff;
            background-color: #12283e;
            transform: scale(1.08);
            box-shadow: 0 0 10px rgba(0, 210, 255, 0.2);
        }

        .tool-btn:active {
            transform: scale(0.95);
        }

        .tool-btn.active-tool {
            border-color: #00d2ff;
            background-color: #12283e;
            color: #00d2ff;
        }

        /* Custom SVG Drop Pins */
        .map-pin {
            position: absolute;
            width: 26px;
            height: 34px;
            cursor: pointer;
            z-index: 15;
            transition: transform 0.2s ease, opacity 0.3s ease;
        }

        .map-pin:hover {
            transform: scale(1.18) translateY(-3px);
            z-index: 25;
        }

        /* Floating Case Popup Card */
        .case-popup-card {
            position: absolute;
            top: 32px;
            left: 425px;
            width: 285px;
            background-color: rgba(11, 19, 32, 0.95);
            border: 1px solid #1e293b;
            backdrop-filter: blur(12px);
            border-radius: 8px;
            padding: 16px;
            z-index: 30;
            box-shadow: 0 12px 35px rgba(0, 0, 0, 0.75), 0 0 15px rgba(0, 210, 255, 0.1);
        }

        .popup-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 8px;
        }

        .popup-tag {
            font-size: 0.65rem;
            font-weight: 800;
            letter-spacing: 0.8px;
            color: #ef4444;
            display: flex;
            align-items: center;
            gap: 5px;
            text-transform: uppercase;
        }

        .popup-tag::before {
            content: '●';
            color: #ef4444;
            font-size: 0.8rem;
        }

        .popup-close {
            color: #64748b;
            cursor: pointer;
            font-size: 0.85rem;
            line-height: 1;
        }

        .popup-close:hover { color: #ffffff; }

        .popup-title {
            font-size: 0.95rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 14px;
            letter-spacing: 0.3px;
        }

        .popup-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            margin-bottom: 12px;
        }

        .popup-label {
            color: #64748b;
            font-size: 0.62rem;
            text-transform: uppercase;
            font-weight: 700;
            margin-bottom: 3px;
            letter-spacing: 0.5px;
        }

        .popup-val {
            color: #e2e8f0;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .btn-view-case {
            width: 100%;
            background-color: transparent;
            border: 1px solid #00d2ff;
            color: #00d2ff;
            padding: 8px 12px;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            transition: all 0.25s ease;
            text-decoration: none;
            margin-top: 4px;
        }

        .btn-view-case:hover {
            background-color: #00d2ff;
            color: #070d18;
            box-shadow: 0 0 12px rgba(0, 210, 255, 0.4);
        }

        /* Bottom Left Legend */
        .legend-card {
            position: absolute;
            bottom: 20px;
            left: 20px;
            background-color: rgba(11, 19, 32, 0.92);
            border: 1px solid #1e293b;
            backdrop-filter: blur(8px);
            border-radius: 6px;
            padding: 14px 18px;
            z-index: 20;
            min-width: 155px;
        }

        .legend-title {
            font-size: 0.65rem;
            font-weight: 800;
            letter-spacing: 0.8px;
            color: #64748b;
            text-transform: uppercase;
            margin-bottom: 10px;
            padding-bottom: 4px;
            border-bottom: 1px solid #1e293b;
        }

        .legend-row {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 0.75rem;
            color: #cbd5e1;
            margin-bottom: 6px;
            font-weight: 500;
        }

        .legend-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
        }

        /* Bottom Right Metrics Display */
        .metrics-card {
            position: absolute;
            bottom: 20px;
            right: 20px;
            background-color: rgba(11, 19, 32, 0.92);
            border: 1px solid #1e293b;
            backdrop-filter: blur(8px);
            border-radius: 6px;
            padding: 12px 22px;
            display: flex;
            gap: 22px;
            z-index: 20;
        }

        .metric-col {
            text-align: center;
        }

        .metric-num {
            font-size: 1.45rem;
            font-weight: 800;
            line-height: 1;
        }

        .metric-label {
            font-size: 0.58rem;
            font-weight: 700;
            color: #64748b;
            letter-spacing: 0.8px;
            text-transform: uppercase;
            margin-top: 5px;
        }

        /* Toast Alert Notification */
        .map-toast {
            position: absolute;
            top: 20px;
            left: 50%;
            transform: translateX(-50%) translateY(-20px);
            background-color: rgba(11, 19, 32, 0.95);
            border: 1px solid #00d2ff;
            color: #00d2ff;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 700;
            z-index: 100;
            opacity: 0;
            pointer-events: none;
            transition: all 0.3s ease;
            box-shadow: 0 0 15px rgba(0, 210, 255, 0.3);
        }

        .map-toast.show {
            opacity: 1;
            transform: translateX(-50%) translateY(0);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header-title">Crime Intelligence Map</div>

    <!-- Main Map Viewport -->
    <div class="map-viewport" id="mapViewport">
        <!-- Toast Banner -->
        <div id="mapToast" class="map-toast">🎯 Target Centered on Active Coordinates</div>

        <!-- Grid Overlay -->
        <div class="map-grid-overlay" id="gridOverlay"></div>

        <!-- Simulated City GIS Roads Overlay -->
        <svg id="svgMapBg" style="position:absolute; inset:0; width:100%; height:100%; opacity:0.18; pointer-events:none; transition: transform 0.3s ease;" xmlns="http://www.w3.org/2000/svg">
            <path d="M -100 380 Q 200 350, 400 480 T 900 520 T 1400 400" fill="none" stroke="#38bdf8" stroke-width="24" />
            <path d="M 0 180 L 1200 300 M 350 0 L 450 800 M 700 0 L 650 800 M 0 550 L 1200 420 M 1000 0 L 850 800" stroke="#94a3b8" stroke-width="2" fill="none" />
        </svg>

        <!-- Tactical Ticker -->
        <div class="map-ticker">NEURAL GIS | OPERATIONS MAP | STATUS: SECURE</div>

        <!-- Custom Dropdown Filter Controls -->
        <div class="map-controls-bar">
            <!-- 1. Date Range Dropdown -->
            <div class="dropdown-wrapper">
                <button type="button" class="map-filter-btn" onclick="toggleDropdown('menuDate', this)">
                    📅 <span id="lblDate">Last 30 Days</span> ▾
                </button>
                <div id="menuDate" class="dropdown-menu">
                    <div class="dropdown-item" onclick="selectFilter('lblDate', 'Last 24 Hours', 'menuDate')">Last 24 Hours</div>
                    <div class="dropdown-item" onclick="selectFilter('lblDate', 'Last 7 Days', 'menuDate')">Last 7 Days</div>
                    <div class="dropdown-item selected" onclick="selectFilter('lblDate', 'Last 30 Days', 'menuDate')">Last 30 Days</div>
                    <div class="dropdown-item" onclick="selectFilter('lblDate', 'Year to Date', 'menuDate')">Year to Date</div>
                </div>
            </div>

            <!-- 2. District Filter Dropdown -->
            <div class="dropdown-wrapper">
                <button type="button" class="map-filter-btn" onclick="toggleDropdown('menuDistrict', this)">
                    🏢 <span id="lblDistrict">All Districts</span> ▾
                </button>
                <div id="menuDistrict" class="dropdown-menu">
                    <div class="dropdown-item selected" onclick="filterByDistrict('All Districts', 'menuDistrict')">All Districts</div>
                    <div class="dropdown-item" onclick="filterByDistrict('Sector 7G', 'menuDistrict')">Sector 7G</div>
                    <div class="dropdown-item" onclick="filterByDistrict('District 1', 'menuDistrict')">District 1</div>
                    <div class="dropdown-item" onclick="filterByDistrict('District 2', 'menuDistrict')">District 2</div>
                    <div class="dropdown-item" onclick="filterByDistrict('District 3', 'menuDistrict')">District 3</div>
                </div>
            </div>

            <!-- 3. Crime Type Dropdown -->
            <div class="dropdown-wrapper">
                <button type="button" class="map-filter-btn" onclick="toggleDropdown('menuType', this)">
                    ⚠️ <span id="lblType">Violent Crime</span> ▾
                </button>
                <div id="menuType" class="dropdown-menu">
                    <div class="dropdown-item" onclick="filterByType('All Types', 'menuType')">All Types</div>
                    <div class="dropdown-item selected" onclick="filterByType('Violent Crime', 'menuType')">Violent Crime</div>
                    <div class="dropdown-item" onclick="filterByType('Cyber Espionage', 'menuType')">Cyber Espionage</div>
                    <div class="dropdown-item" onclick="filterByType('Financial Fraud', 'menuType')">Financial Fraud</div>
                    <div class="dropdown-item" onclick="filterByType('Vehicle Theft', 'menuType')">Vehicle Theft</div>
                </div>
            </div>
        </div>

        <!-- Right Side Tactical Tools -->
        <div class="map-tools-right">
            <button type="button" class="tool-btn" title="Center Location Pointer" onclick="toolLocation()">📍</button>
            <button type="button" class="tool-btn" id="btnLayer" title="Toggle Grid Overlay Layer" onclick="toolToggleGrid()">🥞</button>
            <button type="button" class="tool-btn" title="Zoom In" onclick="toolZoomIn()">➕</button>
            <button type="button" class="tool-btn" title="Zoom Out" onclick="toolZoomOut()">➖</button>
            <button type="button" class="tool-btn" title="Target Reticle Reset" onclick="toolResetMap()">🎯</button>
        </div>

        <!-- Custom Map Drop Pins -->
        <div id="pinCritical" class="map-pin" style="top: 295px; left: 490px;" data-district="Sector 7G" data-type="Violent Crime" onclick="selectCase('CR-2023-8942', 'Armed Robbery', 'Oct 24, 23:45', 'Sector 7G, Industrial District, Warehouse 4', 'CRITICAL PRIORITY', '#ef4444')" title="Case ID: #CR-2023-8942">
            <svg viewBox="0 0 24 32" width="26" height="34">
                <filter id="glowRed"><feGaussianBlur stdDeviation="3" result="coloredBlur"/><feMerge><feMergeNode in="coloredBlur"/><feMergeNode in="SourceGraphic"/></feMerge></filter>
                <path d="M12 0 C5.37 0 0 5.37 0 12 C0 21 12 32 12 32 C12 32 24 21 24 12 C24 5.37 18.63 0 12 0 Z" fill="#ef4444" filter="url(#glowRed)"/>
                <circle cx="12" cy="11" r="5" fill="#060b14"/>
            </svg>
        </div>

        <div id="pinHigh" class="map-pin" style="top: 485px; left: 382px;" data-district="District 1" data-type="Cyber Espionage" onclick="selectCase('C-24-8901', 'Cyber Espionage', 'Oct 24, 18:20', 'District 1, Tech Server Room Sector 4', 'HIGH PRIORITY', '#f97316')" title="Case ID: #C-24-8901">
            <svg viewBox="0 0 24 32" width="26" height="34">
                <path d="M12 0 C5.37 0 0 5.37 0 12 C0 21 12 32 12 32 C12 32 24 21 24 12 C24 5.37 18.63 0 12 0 Z" fill="#f97316"/>
                <circle cx="12" cy="11" r="5" fill="#060b14"/>
            </svg>
        </div>

        <div id="pinMedium" class="map-pin" style="top: 620px; left: 598px;" data-district="District 2" data-type="Vehicle Theft" onclick="selectCase('C-24-8851', 'Vehicle Theft', 'Oct 22, 10:15', 'District 2, Commercial Underpass C', 'MEDIUM PRIORITY', '#ffffff')" title="Case ID: #C-24-8851">
            <svg viewBox="0 0 24 32" width="26" height="34">
                <path d="M12 0 C5.37 0 0 5.37 0 12 C0 21 12 32 12 32 C12 32 24 21 24 12 C24 5.37 18.63 0 12 0 Z" fill="#ffffff"/>
                <circle cx="12" cy="11" r="5" fill="#060b14"/>
            </svg>
        </div>

        <!-- Floating Case Popup Card -->
        <div id="popupCard" class="case-popup-card">
            <div class="popup-header">
                <div id="popTag" class="popup-tag">CRITICAL PRIORITY</div>
                <div class="popup-close" onclick="closePopupCard()">✕</div>
            </div>
            <div id="popTitle" class="popup-title">Case ID: #CR-2023-8942</div>
            
            <div class="popup-grid">
                <div>
                    <div class="popup-label">TYPE</div>
                    <div id="popType" class="popup-val">Armed Robbery</div>
                </div>
                <div>
                    <div class="popup-label">DATE/TIME</div>
                    <div id="popDate" class="popup-val">Oct 24, 23:45</div>
                </div>
            </div>

            <div style="margin-bottom: 14px;">
                <div class="popup-label">LOCATION SUMMARY</div>
                <div id="popLocation" class="popup-val">Sector 7G, Industrial District, Warehouse 4</div>
            </div>

            <a href="CrimeCases.aspx" class="btn-view-case">
                ↗ View Full Case File
            </a>
        </div>

        <!-- Bottom Left Legend Card -->
        <div class="legend-card">
            <div class="legend-title">RISK SEVERITY</div>
            <div class="legend-row"><div class="legend-dot" style="background:#ef4444;"></div> Critical</div>
            <div class="legend-row"><div class="legend-dot" style="background:#f97316;"></div> High</div>
            <div class="legend-row"><div class="legend-dot" style="background:#ffffff;"></div> Medium</div>
            <div class="legend-row"><div class="legend-dot" style="background:#38bdf8;"></div> Low</div>
        </div>

        <!-- Bottom Right Metrics Display -->
        <div class="metrics-card">
            <div class="metric-col">
                <div class="metric-num" id="lblActiveEvents" style="color:#00d2ff;">142</div>
                <div class="metric-label">ACTIVE EVENTS</div>
            </div>
            <div class="metric-col" style="border-left: 1px solid #1e293b; padding-left: 20px;">
                <div class="metric-num" id="lblCriticalEvents" style="color:#ef4444;">12</div>
                <div class="metric-label">CRITICAL</div>
            </div>
        </div>
    </div>

    <!-- Complete Interactive Functionality Scripts -->
    <script>
        let zoomLevel = 1.0;
        let selectedDistrictFilter = "All Districts";
        let selectedTypeFilter = "Violent Crime";

        function toggleDropdown(menuId, btnElement) {
            closeAllDropdowns();
            const menu = document.getElementById(menuId);
            menu.classList.toggle("show");
            btnElement.classList.toggle("active");
            event.stopPropagation();
        }

        function closeAllDropdowns() {
            document.querySelectorAll(".dropdown-menu").forEach(m => m.classList.remove("show"));
            document.querySelectorAll(".map-filter-btn").forEach(b => b.classList.remove("active"));
        }

        document.addEventListener("click", function () {
            closeAllDropdowns();
        });

        function selectFilter(labelId, text, menuId) {
            document.getElementById(labelId).innerText = text;
            showToast("📅 Time Filter set to: " + text);
            closeAllDropdowns();
        }

        function filterByDistrict(districtName, menuId) {
            document.getElementById("lblDistrict").innerText = districtName;
            selectedDistrictFilter = districtName;
            applyFilters();
            showToast("🏢 Filtered by: " + districtName);
            closeAllDropdowns();
        }

        function filterByType(typeName, menuId) {
            document.getElementById("lblType").innerText = typeName;
            selectedTypeFilter = typeName;
            applyFilters();
            showToast("⚠️ Filtered by: " + typeName);
            closeAllDropdowns();
        }

        function applyFilters() {
            const pins = document.querySelectorAll(".map-pin");
            let visibleCount = 0;

            pins.forEach(pin => {
                const district = pin.getAttribute("data-district");
                const type = pin.getAttribute("data-type");

                const matchDist = (selectedDistrictFilter === "All Districts" || district === selectedDistrictFilter);
                const matchType = (selectedTypeFilter === "All Types" || type === selectedTypeFilter);

                if (matchDist && matchType) {
                    pin.style.display = "block";
                    visibleCount++;
                } else {
                    pin.style.display = "none";
                }
            });

            document.getElementById("lblActiveEvents").innerText = (selectedDistrictFilter === "All Districts" && selectedTypeFilter === "All Types") ? "142" : (visibleCount * 32 + 14);
            document.getElementById("lblCriticalEvents").innerText = (selectedDistrictFilter === "All Districts" && selectedTypeFilter === "All Types") ? "12" : (visibleCount * 4);
        }

        function selectCase(id, type, date, location, tag, color) {
            document.getElementById("popTitle").innerText = "Case ID: #" + id;
            document.getElementById("popType").innerText = type;
            document.getElementById("popDate").innerText = date;
            document.getElementById("popLocation").innerText = location;

            const tagEl = document.getElementById("popTag");
            tagEl.innerText = tag;
            tagEl.style.color = color;

            document.getElementById("popupCard").style.display = "block";
        }

        function closePopupCard() {
            document.getElementById("popupCard").style.display = "none";
        }

        function toolLocation() {
            showToast("📍 Tactical GPS: Centered on Sector 7G Command Node");
            zoomLevel = 1.15;
            updateZoomTransform();
        }

        function toolToggleGrid() {
            const grid = document.getElementById("gridOverlay");
            const btn = document.getElementById("btnLayer");
            if (grid.style.opacity === "0") {
                grid.style.opacity = "0.25";
                btn.classList.remove("active-tool");
                showToast("🥞 Tactical Grid Layer: Enabled");
            } else {
                grid.style.opacity = "0";
                btn.classList.add("active-tool");
                showToast("🥞 Tactical Grid Layer: Hidden");
            }
        }

        function toolZoomIn() {
            if (zoomLevel < 1.6) {
                zoomLevel += 0.15;
                updateZoomTransform();
                showToast("➕ Zoom Level: " + Math.round(zoomLevel * 100) + "%");
            }
        }

        function toolZoomOut() {
            if (zoomLevel > 0.7) {
                zoomLevel -= 0.15;
                updateZoomTransform();
                showToast("➖ Zoom Level: " + Math.round(zoomLevel * 100) + "%");
            }
        }

        function toolResetMap() {
            zoomLevel = 1.0;
            selectedDistrictFilter = "All Districts";
            selectedTypeFilter = "All Types";
            document.getElementById("lblDistrict").innerText = "All Districts";
            document.getElementById("lblType").innerText = "All Types";
            document.getElementById("lblDate").innerText = "Last 30 Days";
            updateZoomTransform();
            applyFilters();
            showToast("🎯 Tactical View & Filters Reset");
        }

        function updateZoomTransform() {
            document.getElementById("gridOverlay").style.transform = `scale(${zoomLevel})`;
            document.getElementById("svgMapBg").style.transform = `scale(${zoomLevel})`;
        }

        function showToast(message) {
            const toast = document.getElementById("mapToast");
            toast.innerText = message;
            toast.classList.add("show");
            setTimeout(() => {
                toast.classList.remove("show");
            }, 2500);
        }
    </script>
</asp:Content>