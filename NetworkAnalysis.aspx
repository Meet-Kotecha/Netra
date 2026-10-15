<%@ Page Title="Network & Link Analysis" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NetworkAnalysis.aspx.cs" Inherits="Netra.NetworkAnalysis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-header-title-bar {
            margin-bottom: 16px;
            display: flex;
            align-items: baseline;
            gap: 16px;
        }

        .page-title-text {
            font-size: 1.35rem;
            font-weight: 800;
            color: #ffffff;
        }

        .page-sub-text {
            font-size: 0.78rem;
            color: #64748b;
        }

        /* 3-Column Layout Grid */
        .network-layout-grid {
            display: grid;
            grid-template-columns: 280px 1fr 320px;
            gap: 16px;
            height: calc(100vh - 140px);
            min-height: 600px;
        }

        @media (max-width: 1280px) {
            .network-layout-grid {
                grid-template-columns: 260px 1fr;
            }
            .selected-entity-panel {
                display: none;
            }
        }

        /* Common Sidebar Styling */
        .sidebar-card-panel {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 16px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            overflow-y: auto;
        }

        .panel-section-title {
            font-size: 0.72rem;
            font-weight: 800;
            letter-spacing: 0.8px;
            color: #64748b;
            text-transform: uppercase;
            margin-bottom: 12px;
        }

        .form-group-item {
            margin-bottom: 14px;
        }

        .form-label-sm {
            font-size: 0.65rem;
            font-weight: 700;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 6px;
            display: block;
        }

        .form-input-dark {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 8px 12px;
            color: #f8fafc;
            font-size: 0.78rem;
            width: 100%;
            outline: none;
            transition: border-color 0.2s ease;
        }

        .form-input-dark:focus {
            border-color: #00d2ff;
        }

        /* Custom Checkbox Item */
        .checkbox-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.75rem;
            color: #cbd5e1;
            margin-bottom: 8px;
            cursor: pointer;
            user-select: none;
        }

        .checkbox-item input[type="checkbox"] {
            accent-color: #00d2ff;
            width: 14px;
            height: 14px;
            cursor: pointer;
        }

        /* Range Slider Styling */
        .range-slider-wrap {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 6px;
        }

        .range-val-badge {
            font-size: 0.7rem;
            font-weight: 800;
            color: #00d2ff;
        }

        .range-input {
            width: 100%;
            accent-color: #00d2ff;
            cursor: pointer;
        }

        .range-ticks {
            display: flex;
            justify-content: space-between;
            font-size: 0.62rem;
            color: #64748b;
            margin-top: 4px;
        }

        /* Action Buttons */
        .btn-render-graph {
            width: 100%;
            background-color: #070d18;
            border: 1px solid #1e293b;
            color: #f8fafc;
            padding: 10px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.2s ease;
            margin-top: 10px;
        }

        .btn-render-graph:hover {
            border-color: #00d2ff;
            color: #00d2ff;
            background-color: #0d1a2d;
        }

        /* Center Canvas Panel */
        .graph-canvas-viewport {
            background-color: #050a12;
            border: 1px solid #1e293b;
            border-radius: 8px;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            background-image: 
                radial-gradient(circle at 50% 50%, rgba(0, 210, 255, 0.08) 0%, transparent 60%),
                linear-gradient(rgba(30, 41, 59, 0.2) 1px, transparent 1px),
                linear-gradient(90deg, rgba(30, 41, 59, 0.2) 1px, transparent 1px);
            background-size: 100% 100%, 30px 30px, 30px 30px;
        }

        /* Zoom Controls Over Graph */
        .canvas-tools-stack {
            position: absolute;
            top: 14px;
            left: 14px;
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .canvas-tool-btn {
            width: 28px;
            height: 28px;
            background-color: rgba(11, 19, 32, 0.9);
            border: 1px solid #1e293b;
            color: #cbd5e1;
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            cursor: pointer;
        }

        .canvas-tool-btn:hover {
            border-color: #00d2ff;
            color: #00d2ff;
        }

        .canvas-legend-bar {
            position: absolute;
            bottom: 14px;
            left: 14px;
            background-color: rgba(11, 19, 32, 0.9);
            border: 1px solid #1e293b;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 0.65rem;
            color: #64748b;
            display: flex;
            gap: 12px;
        }

        /* Selected Entity Right Panel */
        .selected-entity-card {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 14px;
            margin-bottom: 14px;
        }

        .entity-header-row {
            display: flex;
            gap: 12px;
            align-items: center;
            margin-bottom: 10px;
        }

        .entity-icon-box {
            width: 36px;
            height: 36px;
            border-radius: 6px;
            background-color: #12283e;
            border: 1px solid #00d2ff;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #00d2ff;
            font-size: 1rem;
        }

        .entity-title-name {
            font-size: 0.95rem;
            font-weight: 800;
            color: #ffffff;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .entity-subtitle {
            font-size: 0.65rem;
            font-weight: 800;
            color: #00d2ff;
            letter-spacing: 0.5px;
        }

        .entity-meta-list {
            font-size: 0.72rem;
            color: #cbd5e1;
            line-height: 1.6;
        }

        .entity-meta-row {
            display: flex;
            justify-content: space-between;
            border-bottom: 1px solid #141f30;
            padding: 4px 0;
        }

        .entity-meta-label {
            color: #64748b;
        }

        /* Risk Matrix Bar */
        .risk-bar-container {
            height: 6px;
            background-color: #1e293b;
            border-radius: 3px;
            overflow: hidden;
            margin-top: 4px;
            margin-bottom: 10px;
        }

        .risk-bar-fill-high {
            height: 100%;
            width: 85%;
            background: linear-gradient(90deg, #f59e0b 0%, #ef4444 100%);
        }

        .risk-bar-fill-cyan {
            height: 100%;
            width: 84%;
            background-color: #00d2ff;
        }

        /* Connected Intel Items */
        .intel-item-box {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 8px 10px;
            margin-bottom: 8px;
            font-size: 0.7rem;
        }

        .intel-title {
            color: #ffffff;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .intel-sub {
            color: #64748b;
            font-size: 0.62rem;
            margin-top: 2px;
        }

        /* Right Panel Bottom Action Buttons */
        .btn-cyan-full {
            width: 100%;
            background-color: #00d2ff;
            border: none;
            color: #070d18;
            padding: 10px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 800;
            cursor: pointer;
            transition: all 0.2s ease;
            text-align: center;
            text-decoration: none;
            display: block;
            margin-bottom: 8px;
        }

        .btn-cyan-full:hover {
            opacity: 0.9;
            box-shadow: 0 0 12px rgba(0, 210, 255, 0.4);
        }

        .btn-dual-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px;
        }

        .btn-dark-sm {
            background-color: #070d18;
            border: 1px solid #1e293b;
            color: #cbd5e1;
            padding: 8px;
            border-radius: 6px;
            font-size: 0.7rem;
            font-weight: 700;
            cursor: pointer;
            text-align: center;
        }

        .btn-dark-sm:hover {
            border-color: #00d2ff;
            color: #00d2ff;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Header Title Bar -->
    <div class="page-header-title-bar">
        <div class="page-title-text">Network & Link Analysis</div>
        <div class="page-sub-text">Explore relationships between persons, cases and locations.</div>
    </div>

    <!-- Main 3-Column Layout -->
    <div class="network-layout-grid">
        <!-- Left Panel: Analysis Parameters -->
        <div class="sidebar-card-panel">
            <div>
                <div class="panel-section-title">Analysis Parameters</div>

                <!-- Focus Node -->
                <div class="form-group-item">
                    <label class="form-label-sm">FOCUS NODE</label>
                    <input type="text" id="txtFocusNode" class="form-input-dark" value="Keval Goswami" />
                </div>

                <!-- Entity Types -->
                <div class="form-group-item">
                    <label class="form-label-sm">ENTITY TYPES</label>
                    <label class="checkbox-item"><input type="checkbox" checked /> ⚪ Persons</label>
                    <label class="checkbox-item"><input type="checkbox" checked /> 🔲 Cases</label>
                    <label class="checkbox-item"><input type="checkbox" checked /> 🔺 Locations</label>
                    <label class="checkbox-item"><input type="checkbox" /> 🏢 Organizations</label>
                </div>

                <hr style="border: 0; border-top: 1px solid #1a2536; margin: 14px 0;" />

                <!-- Link Parameters -->
                <div class="form-group-item">
                    <label class="form-label-sm">LINK PARAMETERS</label>
                    <label class="checkbox-item"><input type="checkbox" checked /> Financial Transactions</label>
                    <label class="checkbox-item"><input type="checkbox" checked /> Communication (Comms)</label>
                    <label class="checkbox-item"><input type="checkbox" checked /> Co-Location Data</label>
                </div>

                <hr style="border: 0; border-top: 1px solid #1a2536; margin: 14px 0;" />

                <!-- Traversal Depth -->
                <div class="form-group-item">
                    <div class="range-slider-wrap">
                        <label class="form-label-sm" style="margin:0;">TRAVERSAL DEPTH</label>
                        <span class="range-val-badge" id="lblDepth">2 Degrees</span>
                    </div>
                    <input type="range" class="range-input" min="1" max="5" value="2" oninput="document.getElementById('lblDepth').innerText = this.value + ' Degrees'" />
                    <div class="range-ticks">
                        <span>1</span><span>2</span><span>3</span><span>4</span><span>5+</span>
                    </div>
                </div>

                <!-- Temporal Bounds -->
                <div class="form-group-item">
                    <label class="form-label-sm">TEMPORAL BOUNDS</label>
                    <div style="display:flex; gap:6px;">
                        <input type="text" class="form-input-dark" value="01/01/2023" style="font-size:0.7rem;" />
                        <input type="text" class="form-input-dark" value="10/24/2023" style="font-size:0.7rem;" />
                    </div>
                </div>
            </div>

            <button type="button" class="btn-render-graph" onclick="alert('🔄 Re-rendering Link Graph for Focus Node...')">
                🔄 Re-Render Graph
            </button>
        </div>

        <!-- Center Panel: Interactive Network Graph Canvas -->
        <div class="graph-canvas-viewport">
            <!-- Canvas Tools -->
            <div class="canvas-tools-stack">
                <div class="canvas-tool-btn" title="Zoom In" onclick="alert('Zoom In')">➕</div>
                <div class="canvas-tool-btn" title="Zoom Out" onclick="alert('Zoom Out')">➖</div>
                <div class="canvas-tool-btn" title="Reset View" onclick="alert('Reset Graph View')">🎯</div>
            </div>

            <!-- SVG Network Graph Render -->
            <svg width="100%" height="100%" style="position:absolute; inset:0;">
                <defs>
                    <filter id="glowCyan"><feGaussianBlur stdDeviation="3" result="blur"/><feMerge><feMergeNode in="blur"/><feMergeNode in="SourceGraphic"/></feMerge></filter>
                </defs>

                <!-- Connection Links -->
                <line x1="50%" y1="50%" x2="42%" y2="40%" stroke="#1e293b" stroke-width="1.5" />
                <line x1="50%" y1="50%" x2="58%" y2="38%" stroke="#1e293b" stroke-width="1.5" />
                <line x1="50%" y1="50%" x2="55%" y2="62%" stroke="#00d2ff" stroke-width="2" stroke-dasharray="4" />
                <line x1="50%" y1="50%" x2="40%" y2="58%" stroke="#1e293b" stroke-width="1.5" />
                <line x1="58%" y1="38%" x2="68%" y2="42%" stroke="#1e293b" stroke-width="1" />
                <line x1="58%" y1="38%" x2="65%" y2="30%" stroke="#1e293b" stroke-width="1" />
                <line x1="55%" y1="62%" x2="63%" y2="60%" stroke="#1e293b" stroke-width="1" />
                <line x1="42%" y1="40%" x2="35%" y2="48%" stroke="#1e293b" stroke-width="1" />

                <!-- Nodes -->
                <!-- Central Focus Node: Keval Goswami -->
                <circle cx="50%" cy="50%" r="14" fill="#0b1320" stroke="#00d2ff" stroke-width="3" filter="url(#glowCyan)" />
                <text x="50%" y="54%" fill="#ffffff" font-size="9" font-weight="bold" text-anchor="middle">Keval Goswami</text>

                <!-- Connected Node 1: E. Rostova -->
                <circle cx="58%" cy="38%" r="9" fill="#070d18" stroke="#38bdf8" stroke-width="2" />
                <text x="58%" y="34%" fill="#cbd5e1" font-size="8" text-anchor="middle">E. Rostova</text>

                <!-- Connected Node 2: Op. BLACKWOOD -->
                <rect x="40%" y="38%" width="14" height="14" fill="#070d18" stroke="#ef4444" stroke-width="2" rx="2" />
                <text x="42%" y="36%" fill="#cbd5e1" font-size="8" text-anchor="middle">Op. BLACKWOOD</text>

                <!-- Connected Node 3: Safehouse Alpha -->
                <polygon points="55%,60% 58%,65% 52%,65%" fill="#070d18" stroke="#f59e0b" stroke-width="2" />
                <text x="55%" y="69%" fill="#cbd5e1" font-size="8" text-anchor="middle">Safehouse Alpha</text>

                <!-- Connected Node 4: M. Vance -->
                <circle cx="40%" cy="58%" r="8" fill="#070d18" stroke="#38bdf8" stroke-width="2" />
                <text x="40%" y="63%" fill="#cbd5e1" font-size="8" text-anchor="middle">M. Vance</text>

                <!-- Outer Degree Nodes -->
                <circle cx="68%" cy="42%" r="5" fill="#1e293b" />
                <circle cx="65%" cy="30%" r="5" fill="#1e293b" />
                <rect x="62%" y="58%" width="8" height="8" fill="#1e293b" />
                <polygon points="35%,47% 37%,51% 33%,51%" fill="#1e293b" />
            </svg>

            <!-- Legend Bar -->
            <div class="canvas-legend-bar">
                <span>⚪ Person</span>
                <span>🔲 Case</span>
                <span>🔺 Location</span>
            </div>
        </div>

        <!-- Right Panel: Selected Entity Details -->
        <div class="sidebar-card-panel selected-entity-panel">
            <div>
                <div class="panel-section-title">Selected Entity</div>

                <!-- Entity Card Header -->
                <div class="selected-entity-card">
                    <div class="entity-header-row">
                        <div class="entity-icon-box">👤</div>
                        <div>
                            <div class="entity-title-name">Keval Goswami ⏱️</div>
                            <div class="entity-subtitle">POI-992 • HIGH PRIORITY</div>
                        </div>
                    </div>

                    <div class="entity-meta-list">
                        <div class="entity-meta-row">
                            <span class="entity-meta-label">DOB</span>
                            <span>06-06-2006 (20y)</span>
                        </div>
                        <div class="entity-meta-row">
                            <span class="entity-meta-label">Nationality</span>
                            <span>Unknown / Alleged Eastern</span>
                        </div>
                        <div class="entity-meta-row">
                            <span class="entity-meta-label">Status</span>
                            <span style="color:#ef4444; font-weight:700;">● At Large</span>
                        </div>
                        <div class="entity-meta-row" style="border:none;">
                            <span class="entity-meta-label">Known Assocs.</span>
                            <span>14 Direct, 42 2nd Degree</span>
                        </div>
                    </div>
                </div>

                <!-- Risk Matrix -->
                <div style="margin-bottom: 14px;">
                    <div class="panel-section-title">Risk Matrix</div>

                    <div style="display:flex; justify-content:space-between; font-size:0.7rem; font-weight:700; color:#cbd5e1;">
                        <span>Flight Risk</span>
                        <span style="color:#ef4444;">High</span>
                    </div>
                    <div class="risk-bar-container">
                        <div class="risk-bar-fill-high"></div>
                    </div>

                    <div style="display:flex; justify-content:space-between; font-size:0.7rem; font-weight:700; color:#cbd5e1;">
                        <span>Network Centrality</span>
                        <span style="color:#00d2ff;">0.84</span>
                    </div>
                    <div class="risk-bar-container">
                        <div class="risk-bar-fill-cyan"></div>
                    </div>
                </div>

                <!-- Latest Connected Intel -->
                <div>
                    <div class="panel-section-title">Latest Connected Intel</div>

                    <div class="intel-item-box">
                        <div class="intel-title">💳 Wire transfer flagged ($45k)</div>
                        <div class="intel-sub">2 days ago • Source: FinCEN</div>
                    </div>

                    <div class="intel-item-box">
                        <div class="intel-title">✈️ Border cross attempt (Denied)</div>
                        <div class="intel-sub">14 days ago • Checkpoint Charlie</div>
                    </div>
                </div>
            </div>

            <!-- Bottom Action Buttons -->
            <div style="margin-top: 14px;">
                <a href="PersonProfile.aspx" class="btn-cyan-full">
                    View Comprehensive Profile
                </a>
                <div class="btn-dual-row">
                    <button type="button" class="btn-dark-sm" onclick="alert('Node Isolated')">Isolate Node</button>
                    <button type="button" class="btn-dark-sm" onclick="alert('Expanding Network Links...')">Expand Links</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>