<%@ Page Title="Appearance Settings" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AppearanceSettings.aspx.cs" Inherits="Netra.AppearanceSettings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Base Dynamic Theme Engine */
        :root {
            --netra-primary-bg: #070d18;
            --netra-secondary-bg: #0b1320;
            --netra-border: #1e293b;
            --netra-text-main: #ffffff;
            --netra-text-sub: #64748b;
            --netra-accent: #00d2ff;
            --netra-density-padding: 12px 16px;
        }

        /* FULL LIGHT MODE OVERRIDES FOR ENTIRE SITE */
        body.light-mode-active {
            background-color: #f8fafc !important;
            color: #0f172a !important;
        }

        body.light-mode-active .sidebar {
            background-color: #ffffff !important;
            border-right: 1px solid #e2e8f0 !important;
        }

        body.light-mode-active .brand-header,
        body.light-mode-active .sidebar-footer {
            border-color: #e2e8f0 !important;
        }

        body.light-mode-active .brand-text h1,
        body.light-mode-active .nav-item a {
            color: #334155 !important;
        }

        body.light-mode-active .nav-item a:hover,
        body.light-mode-active .nav-item.active a {
            background-color: #f1f5f9 !important;
            color: var(--netra-accent) !important;
        }

        body.light-mode-active .top-header {
            background-color: #ffffff !important;
            border-bottom: 1px solid #e2e8f0 !important;
        }

        body.light-mode-active .header-title,
        body.light-mode-active .page-title,
        body.light-mode-active .card-title,
        body.light-mode-active .toggle-lbl,
        body.light-mode-active .card-incident-title {
            color: #0f172a !important;
        }

        body.light-mode-active .glass-card,
        body.light-mode-active .preview-panel {
            background-color: #ffffff !important;
            border-color: #cbd5e1 !important;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }

        body.light-mode-active .preview-data-card,
        body.light-mode-active .theme-card,
        body.light-mode-active .segmented-btn-group {
            background-color: #f8fafc !important;
            border-color: #cbd5e1 !important;
        }

        body.light-mode-active .search-box input {
            background-color: #f1f5f9 !important;
            border-color: #cbd5e1 !important;
            color: #0f172a !important;
        }

        /* Accent Dynamic Rule Hooks */
        .dynamic-accent-color {
            color: var(--netra-accent) !important;
        }

        .dynamic-accent-bg {
            background-color: var(--netra-accent) !important;
        }

        .dynamic-accent-border {
            border-color: var(--netra-accent) !important;
        }

        /* Layout & Controls Styling */
        .breadcrumb-text {
            font-size: 0.75rem;
            color: #64748b;
            margin-bottom: 8px;
        }

        .page-header-row {
            margin-bottom: 20px;
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

        .appearance-grid {
            display: grid;
            grid-template-columns: 1fr 340px;
            gap: 20px;
            margin-bottom: 20px;
        }

        @media (max-width: 1024px) {
            .appearance-grid {
                grid-template-columns: 1fr;
            }
        }

        .glass-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 18px;
        }

        .card-title {
            font-size: 0.95rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 4px;
        }

        .card-sub {
            font-size: 0.72rem;
            color: #64748b;
            margin-bottom: 16px;
        }

        /* Theme Cards */
        .theme-cards-row {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 14px;
        }

        .theme-card {
            background-color: #070d18;
            border: 2px solid #1e293b;
            border-radius: 8px;
            padding: 12px;
            cursor: pointer;
            text-align: center;
            transition: all 0.2s ease;
            position: relative;
        }

        .theme-card.active {
            border-color: var(--netra-accent) !important;
            box-shadow: 0 0 12px rgba(0, 210, 255, 0.25);
        }

        .theme-preview-box {
            height: 70px;
            border-radius: 4px;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            border: 1px solid #1e293b;
        }

        .theme-dark-bg {
            background-color: #070d18;
            width: 100%;
            height: 100%;
            padding: 8px;
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .theme-system-bg {
            background: linear-gradient(135deg, #070d18 50%, #f1f5f9 50%);
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }

        .theme-light-bg {
            background-color: #f1f5f9;
            width: 100%;
            height: 100%;
            padding: 8px;
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .theme-card-lbl {
            font-size: 0.75rem;
            font-weight: 700;
            color: #94a3b8;
        }

        .active-check-badge {
            position: absolute;
            bottom: 8px;
            right: 8px;
            width: 18px;
            height: 18px;
            border-radius: 50%;
            background-color: var(--netra-accent);
            color: #070d18;
            font-size: 0.65rem;
            font-weight: 900;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Swatches and Controls */
        .controls-subgrid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
        }

        .color-swatch-row {
            display: flex;
            gap: 12px;
            margin-top: 8px;
        }

        .color-swatch {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.75rem;
            font-weight: 900;
            color: #070d18;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .color-swatch:hover {
            transform: scale(1.12);
        }

        .swatch-cyan { background-color: #00d2ff; }
        .swatch-blue { background-color: #3b82f6; }
        .swatch-green { background-color: #10b981; }

        .segmented-btn-group {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 3px;
            display: flex;
            gap: 4px;
            margin-top: 8px;
        }

        .segmented-btn {
            flex: 1;
            background: none;
            border: none;
            color: #64748b;
            padding: 7px 0;
            font-size: 0.72rem;
            font-weight: 700;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .segmented-btn.active {
            background-color: #12283e;
            color: var(--netra-accent);
            font-weight: 800;
        }

        /* Toggles */
        .toggle-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #162234;
        }

        .toggle-row:last-child { border-bottom: none; }
        .toggle-lbl { font-size: 0.78rem; font-weight: 700; color: #ffffff; }

        .switch {
            position: relative;
            display: inline-block;
            width: 38px;
            height: 20px;
        }

        .switch input { opacity: 0; width: 0; height: 0; }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0; left: 0; right: 0; bottom: 0;
            background-color: #1e293b;
            transition: .2s;
            border-radius: 20px;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 14px;
            width: 14px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            transition: .2s;
            border-radius: 50%;
        }

        input:checked + .slider { background-color: var(--netra-accent) !important; }
        input:checked + .slider:before { transform: translateX(18px); background-color: #070d18; }

        /* Preview Panel */
        .preview-panel {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 24px;
        }

        .preview-badge-tag {
            background-color: rgba(6, 182, 212, 0.15);
            border: 1px solid var(--netra-accent);
            color: var(--netra-accent);
            font-size: 0.65rem;
            font-weight: 800;
            padding: 3px 8px;
            border-radius: 4px;
        }

        .preview-data-card {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: var(--netra-density-padding);
            transition: padding 0.2s ease;
        }

        .card-case-id {
            font-size: 0.68rem;
            font-weight: 800;
            color: var(--netra-accent);
            display: flex;
            justify-content: space-between;
            margin-bottom: 6px;
        }

        .footer-action-bar {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
        }

        .btn-reset-outline {
            background-color: #070d18;
            border: 1px solid #1e293b;
            color: #cbd5e1;
            padding: 9px 18px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 700;
            cursor: pointer;
        }

        .btn-save-cyan {
            background-color: var(--netra-accent);
            border: none;
            color: #070d18;
            padding: 9px 22px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 800;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-save-cyan:hover {
            opacity: 0.9;
            box-shadow: 0 0 12px var(--netra-accent);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="breadcrumb-text">Settings › <span class="dynamic-accent-color">Appearance</span></div>
    <div class="page-header-row">
        <div class="page-title">Appearance Settings</div>
        <div class="page-sub-text">Customize how NETRA looks and how information is displayed across the workspace.</div>
    </div>

    <div class="appearance-grid">
        <!-- Left Column: Themes, Accents & Density -->
        <div>
            <!-- Application Theme -->
            <div class="glass-card">
                <div class="card-title">Application Theme</div>
                <div class="card-sub">Select your preferred color mode for the interface.</div>

                <div class="theme-cards-row">
                    <!-- Dark Mode -->
                    <div id="themeCardDark" class="theme-card active" onclick="setAppTheme('dark', this)">
                        <div class="theme-preview-box">
                            <div class="theme-dark-bg">
                                <div style="height:8px; width:40%; background-color:#00d2ff; border-radius:2px;"></div>
                                <div style="height:6px; width:80%; background-color:#1e293b; border-radius:2px;"></div>
                            </div>
                        </div>
                        <div class="theme-card-lbl">Dark Mode</div>
                        <div class="active-check-badge">✓</div>
                    </div>

                    <!-- System Sync -->
                    <div id="themeCardSystem" class="theme-card" onclick="setAppTheme('system', this)">
                        <div class="theme-preview-box">
                            <div class="theme-system-bg">⚙️</div>
                        </div>
                        <div class="theme-card-lbl">System Sync</div>
                    </div>

                    <!-- Light Mode -->
                    <div id="themeCardLight" class="theme-card" onclick="setAppTheme('light', this)">
                        <div class="theme-preview-box">
                            <div class="theme-light-bg">
                                <div style="height:8px; width:40%; background-color:#3b82f6; border-radius:2px;"></div>
                                <div style="height:6px; width:80%; background-color:#cbd5e1; border-radius:2px;"></div>
                            </div>
                        </div>
                        <div class="theme-card-lbl">Light Mode</div>
                    </div>
                </div>
            </div>

            <!-- Accent & Density -->
            <div class="controls-subgrid">
                <!-- Accent Color Picker -->
                <div class="glass-card">
                    <div class="card-title">Accent Color</div>
                    <div class="card-sub" style="margin-bottom:8px;">Primary action color.</div>

                    <div class="color-swatch-row">
                        <div id="swatchCyan" class="color-swatch swatch-cyan" onclick="setAppAccent('#00d2ff', this)">✓</div>
                        <div id="swatchBlue" class="color-swatch swatch-blue" onclick="setAppAccent('#3b82f6', this)"></div>
                        <div id="swatchGreen" class="color-swatch swatch-green" onclick="setAppAccent('#10b981', this)"></div>
                    </div>
                </div>

                <!-- Display Density Picker -->
                <div class="glass-card">
                    <div class="card-title">Display Density</div>
                    <div class="card-sub" style="margin-bottom:8px;">Spacing in tables and lists.</div>

                    <div class="segmented-btn-group">
                        <button id="btnCompact" type="button" class="segmented-btn active" onclick="setAppDensity('compact', this)">Compact</button>
                        <button id="btnComfortable" type="button" class="segmented-btn" onclick="setAppDensity('comfortable', this)">Comfortable</button>
                        <button id="btnSpacious" type="button" class="segmented-btn" onclick="setAppDensity('spacious', this)">Spacious</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Column: Interface Preferences -->
        <div>
            <div class="glass-card">
                <div class="card-title" style="margin-bottom:14px;">Interface Preferences</div>

                <div class="toggle-row">
                    <div class="toggle-lbl">Keep sidebar expanded</div>
                    <label class="switch">
                        <input type="checkbox" checked="checked" />
                        <span class="slider"></span>
                    </label>
                </div>

                <div class="toggle-row">
                    <div class="toggle-lbl">Show status badges</div>
                    <label class="switch">
                        <input type="checkbox" checked="checked" id="chkBadges" onchange="toggleBadges(this)" />
                        <span class="slider"></span>
                    </label>
                </div>

                <div class="toggle-row">
                    <div class="toggle-lbl">Show timestamps</div>
                    <label class="switch">
                        <input type="checkbox" checked="checked" id="chkTime" onchange="toggleTimestamps(this)" />
                        <span class="slider"></span>
                    </label>
                </div>

                <div class="toggle-row">
                    <div class="toggle-lbl">Show table row numbers</div>
                    <label class="switch">
                        <input type="checkbox" />
                        <span class="slider"></span>
                    </label>
                </div>
            </div>
        </div>
    </div>

    <!-- Live Preview -->
    <div class="preview-panel">
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:14px;">
            <div>
                <div class="card-title" style="margin-bottom:2px;">Live Preview</div>
                <div class="card-sub" style="margin-bottom:0;">Changes applied to data cards.</div>
            </div>
            <span class="preview-badge-tag">PREVIEW</span>
        </div>

        <div class="preview-data-card">
            <div class="card-case-id">
                <span>● CASE ID: NX-2049</span>
                <span id="previewTime" style="color:#64748b; font-family:monospace;">10:42:05 UTC</span>
            </div>
            <div class="card-incident-title">Anomalous Network Traffic Detected</div>
            <div style="display:flex; justify-content:space-between; align-items:center; font-size:0.72rem;">
                <div>
                    <span style="color:#64748b;">Source IP</span><br />
                    <span style="color:#cbd5e1; font-family:monospace;">192.168.1.104</span>
                </div>
                <div>
                    <span style="color:#64748b;">Severity</span><br />
                    <span id="previewBadge" style="color:#f87171; font-weight:800;">Critical</span>
                </div>
                <div>
                    <a href="#" class="dynamic-accent-color" style="font-weight:800; text-decoration:none;" onclick="return false;">Analyze →</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer Action Buttons -->
    <div class="footer-action-bar">
        <button type="button" class="btn-reset-outline" onclick="resetToDefaults()">Reset to Default</button>
        <button type="button" class="btn-save-cyan" onclick="savePreferences()">Save Appearance Preferences</button>
    </div>

    <!-- Full Interactive JavaScript Engine -->
    <script>
        // 1. Theme Engine
        function setAppTheme(theme, cardElem) {
            document.querySelectorAll('.theme-card').forEach(c => {
                c.classList.remove('active');
                const badge = c.querySelector('.active-check-badge');
                if (badge) badge.remove();
            });

            if (cardElem) {
                cardElem.classList.add('active');
                cardElem.insertAdjacentHTML('beforeend', '<div class="active-check-badge">✓</div>');
            }

            if (theme === 'light') {
                document.body.classList.add('light-mode-active');
            } else if (theme === 'system') {
                const isSystemDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
                if (!isSystemDark) {
                    document.body.classList.add('light-mode-active');
                } else {
                    document.body.classList.remove('light-mode-active');
                }
            } else {
                document.body.classList.remove('light-mode-active');
            }

            localStorage.setItem('netra_theme', theme);
        }

        // 2. Accent Color Engine
        function setAppAccent(colorHex, swatchElem) {
            document.querySelectorAll('.color-swatch').forEach(s => s.innerText = '');
            if (swatchElem) swatchElem.innerText = '✓';

            document.documentElement.style.setProperty('--netra-accent', colorHex);
            localStorage.setItem('netra_accent', colorHex);
        }

        // 3. Display Density Engine
        function setAppDensity(density, btnElem) {
            document.querySelectorAll('.segmented-btn').forEach(b => b.classList.remove('active'));
            if (btnElem) btnElem.classList.add('active');

            let paddingVal = '12px 16px';
            if (density === 'compact') paddingVal = '8px 12px';
            if (density === 'spacious') paddingVal = '20px 24px';

            document.documentElement.style.setProperty('--netra-density-padding', paddingVal);
            localStorage.setItem('netra_density', density);
        }

        // 4. Toggle Listeners
        function toggleTimestamps(chk) {
            document.getElementById('previewTime').style.display = chk.checked ? 'inline' : 'none';
        }

        function toggleBadges(chk) {
            document.getElementById('previewBadge').style.display = chk.checked ? 'inline' : 'none';
        }

        // 5. Reset & Save Logic
        function resetToDefaults() {
            setAppTheme('dark', document.getElementById('themeCardDark'));
            setAppAccent('#00d2ff', document.getElementById('swatchCyan'));
            setAppDensity('compact', document.getElementById('btnCompact'));
            alert('Appearance settings reset to default.');
        }

        function savePreferences() {
            alert('✅ Appearance preferences saved successfully.');
        }

        // 6. On Page Load Initialization
        window.addEventListener('DOMContentLoaded', () => {
            const savedTheme = localStorage.getItem('netra_theme') || 'dark';
            const savedAccent = localStorage.getItem('netra_accent') || '#00d2ff';
            const savedDensity = localStorage.getItem('netra_density') || 'compact';

            if (savedTheme === 'light') setAppTheme('light', document.getElementById('themeCardLight'));
            else if (savedTheme === 'system') setAppTheme('system', document.getElementById('themeCardSystem'));
            else setAppTheme('dark', document.getElementById('themeCardDark'));

            if (savedAccent === '#3b82f6') setAppAccent('#3b82f6', document.getElementById('swatchBlue'));
            else if (savedAccent === '#10b981') setAppAccent('#10b981', document.getElementById('swatchGreen'));
            else setAppAccent('#00d2ff', document.getElementById('swatchCyan'));

            if (savedDensity === 'comfortable') setAppDensity('comfortable', document.getElementById('btnComfortable'));
            else if (savedDensity === 'spacious') setAppDensity('spacious', document.getElementById('btnSpacious'));
            else setAppDensity('compact', document.getElementById('btnCompact'));
        });
    </script>
</asp:Content>