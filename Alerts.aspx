<%@ Page Title="Alerts & Notifications" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Alerts.aspx.cs" Inherits="Netra.Alerts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-header-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .page-title {
            font-size: 1.4rem;
            font-weight: 800;
            color: #ffffff;
        }

        .header-actions {
            display: flex;
            gap: 10px;
        }

        .btn-outline {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            color: #cbd5e1;
            padding: 9px 16px;
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-outline:hover {
            border-color: #00d2ff;
            color: #00d2ff;
        }

        .btn-cyan {
            background-color: #00d2ff;
            color: #070d18;
            border: none;
            padding: 9px 18px;
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 800;
            cursor: pointer;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-cyan:hover {
            box-shadow: 0 0 12px rgba(0, 210, 255, 0.4);
        }

        .summary-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 20px;
        }

        .summary-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 16px;
        }

        .filter-bar-container {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 14px 18px;
            margin-bottom: 20px;
            display: flex;
            gap: 14px;
            align-items: center;
            flex-wrap: wrap;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .filter-label {
            font-size: 0.62rem;
            font-weight: 800;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .filter-select {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 8px 12px;
            color: #ffffff;
            font-size: 0.78rem;
            outline: none;
            cursor: pointer;
        }

        .alert-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 18px;
            margin-bottom: 16px;
            display: flex;
            gap: 16px;
            position: relative;
            transition: all 0.2s ease;
        }

        .alert-card.critical { border-left: 4px solid #ef4444; }
        .alert-card.high { border-left: 4px solid #00d2ff; }
        .alert-card.medium { border-left: 4px solid #64748b; }

        .alert-icon-box {
            width: 42px;
            height: 42px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            flex-shrink: 0;
        }

        .critical .alert-icon-box { background: rgba(239, 68, 68, 0.15); color: #f87171; }
        .high .alert-icon-box { background: rgba(0, 210, 255, 0.15); color: #38bdf8; }
        .medium .alert-icon-box { background: rgba(100, 116, 139, 0.15); color: #cbd5e1; }

        .alert-body { flex-grow: 1; }

        .badge-sev {
            font-size: 0.65rem;
            font-weight: 800;
            padding: 2px 8px;
            border-radius: 4px;
            letter-spacing: 0.5px;
        }

        .badge-sev.critical { background: rgba(239, 68, 68, 0.2); color: #f87171; border: 1px solid rgba(239, 68, 68, 0.4); }
        .badge-sev.high { background: rgba(0, 210, 255, 0.2); color: #38bdf8; border: 1px solid rgba(0, 210, 255, 0.4); }
        .badge-sev.medium { background: rgba(148, 163, 184, 0.2); color: #cbd5e1; border: 1px solid rgba(148, 163, 184, 0.4); }

        .alert-title {
            font-size: 0.95rem;
            font-weight: 800;
            color: #ffffff;
            margin: 6px 0;
        }

        .alert-desc {
            font-size: 0.78rem;
            color: #94a3b8;
            margin-bottom: 12px;
            line-height: 1.4;
        }

        .alert-meta {
            display: flex;
            gap: 24px;
            font-size: 0.72rem;
            color: #64748b;
        }

        .alert-actions-col {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: flex-end;
            min-width: 110px;
        }

        .read-state { opacity: 0.6; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header-row">
        <div>
            <div class="page-title">Alerts & Notifications</div>
            <div style="font-size:0.75rem; color:#64748b; margin-top:4px;">Real-time monitoring of anomalies and threat detections.</div>
        </div>

        <div class="header-actions">
            <button type="button" class="btn-outline" onclick="exportAlertsCSV()">📥 Export Report</button>
            <button type="button" class="btn-cyan" id="btnMarkRead" onclick="markAllAlertsAsRead()">✓✓ Mark All Read</button>
        </div>
    </div>

    <!-- SUMMARY CARDS -->
    <div class="summary-grid">
        <div class="summary-card" style="border-top:3px solid #ef4444;">
            <div style="font-size:0.65rem; font-weight:800; color:#ef4444;">• CRITICAL ALERTS</div>
            <div style="display:flex; justify-content:space-between; align-items:baseline; margin-top:8px;">
                <span style="font-size:1.8rem; font-weight:800; color:#fff;" id="countCritical">12</span>
                <span style="font-size:0.72rem; color:#f87171; font-weight:700;">↗ +3</span>
            </div>
        </div>

        <div class="summary-card" style="border-top:3px solid #00d2ff;">
            <div style="font-size:0.65rem; font-weight:800; color:#00d2ff;">• HIGH ALERTS</div>
            <div style="display:flex; justify-content:space-between; align-items:baseline; margin-top:8px;">
                <span style="font-size:1.8rem; font-weight:800; color:#fff;" id="countHigh">34</span>
                <span style="font-size:0.72rem; color:#38bdf8; font-weight:700;">↘ -2</span>
            </div>
        </div>

        <div class="summary-card">
            <div style="font-size:0.65rem; font-weight:800; color:#64748b;">• MEDIUM ALERTS</div>
            <div style="display:flex; justify-content:space-between; align-items:baseline; margin-top:8px;">
                <span style="font-size:1.8rem; font-weight:800; color:#fff;">89</span>
                <span style="font-size:0.72rem; color:#64748b; font-weight:700;">—</span>
            </div>
        </div>

        <div class="summary-card">
            <div style="font-size:0.65rem; font-weight:800; color:#10b981;">✓ RESOLVED (24H)</div>
            <div style="display:flex; justify-content:space-between; align-items:baseline; margin-top:8px;">
                <span style="font-size:1.8rem; font-weight:800; color:#fff;">142</span>
                <span style="font-size:0.72rem; color:#10b981; font-weight:700;">98% rate</span>
            </div>
        </div>
    </div>

    <!-- FILTER BAR -->
    <div class="filter-bar-container">
        <div class="filter-group">
            <span class="filter-label">ALERT TYPE</span>
            <select id="filterType" class="filter-select" onchange="applyAlertFilters()">
                <option value="ALL">All Types</option>
                <option value="VEHICLE">Vehicle Security</option>
                <option value="DATABASE">Database / Network</option>
                <option value="PERIMETER">Perimeter Threat</option>
            </select>
        </div>

        <div class="filter-group">
            <span class="filter-label">SEVERITY</span>
            <select id="filterSeverity" class="filter-select" onchange="applyAlertFilters()">
                <option value="ALL">All Levels</option>
                <option value="CRITICAL">Critical</option>
                <option value="HIGH">High</option>
                <option value="MEDIUM">Medium</option>
            </select>
        </div>

        <div class="filter-group">
            <span class="filter-label">DISTRICT</span>
            <select id="filterDistrict" class="filter-select" onchange="applyAlertFilters()">
                <option value="ALL">All Districts</option>
                <option value="Sector 4">Sector 4</option>
                <option value="Central">Central</option>
                <option value="Gate 7">Gate 7</option>
            </select>
        </div>

        <div class="filter-group">
            <span class="filter-label">STATUS</span>
            <select id="filterStatus" class="filter-select" onchange="applyAlertFilters()">
                <option value="ALL">Open & Active</option>
                <option value="Open">Open</option>
                <option value="Investigating">Investigating</option>
                <option value="Resolved">Resolved</option>
            </select>
        </div>

        <div class="filter-group">
            <span class="filter-label">DATE RANGE</span>
            <input type="date" id="filterDate" class="filter-select" value="2026-10-15" onchange="applyAlertFilters()" />
        </div>
    </div>

    <!-- ALERTS LIST CONTAINER -->
    <div id="alertsContainer">
        <!-- CRITICAL ALERT -->
        <div class="alert-card critical" data-type="VEHICLE" data-severity="CRITICAL" data-district="Sector 4" data-status="Open">
            <div class="alert-icon-box">⚠️</div>
            <div class="alert-body">
                <div style="display:flex; align-items:center; gap:10px;">
                    <span class="badge-sev critical">CRITICAL</span>
                    <span style="font-size:0.7rem; color:#64748b;">⏱ 10:42 AM (2m ago)</span>
                </div>
                <div class="alert-title">Unusual increase in vehicle theft attempts</div>
                <div class="alert-desc">AI analysis detected a 400% spike in forced entry attempts on smart-lock vehicles in Sector 4 over the last 15 minutes. Matches patterns from Syndicate Alpha.</div>
                <div class="alert-meta">
                    <div>Location: <strong style="color:#cbd5e1;">📍 Sector 4, Northern Perimeter</strong></div>
                    <div>Related Asset/Case: <strong style="color:#00d2ff;">📁 Case #902-V</strong></div>
                </div>
            </div>
            <div class="alert-actions-col">
                <span style="font-size:0.72rem; color:#cbd5e1; font-weight:700;">Open</span>
                <button type="button" class="btn-cyan" style="padding:6px 12px; font-size:0.72rem;" onclick="viewAlertDetails('Unusual increase in vehicle theft attempts')">View Details</button>
            </div>
        </div>

        <!-- HIGH ALERT -->
        <div class="alert-card high" data-type="DATABASE" data-severity="HIGH" data-district="Central" data-status="Investigating">
            <div class="alert-icon-box">🛡️</div>
            <div class="alert-body">
                <div style="display:flex; align-items:center; gap:10px;">
                    <span class="badge-sev high">HIGH</span>
                    <span style="font-size:0.7rem; color:#64748b;">⏱ 09:15 AM (1h ago)</span>
                </div>
                <div class="alert-title">Unauthorized database access attempt</div>
                <div class="alert-desc">Multiple failed authentication attempts originating from a masked IP targeting the Central Personnel Registry. Automated countermeasures active.</div>
                <div class="alert-meta">
                    <div>Target System: <strong style="color:#cbd5e1;">🖥 Central Personnel Registry</strong></div>
                    <div>Source IP Trace: <strong style="color:#00d2ff;">192.168.x.x (Masked)</strong></div>
                </div>
            </div>
            <div class="alert-actions-col">
                <span style="font-size:0.72rem; color:#94a3b8; font-weight:700;">Investigating</span>
                <button type="button" class="btn-outline" style="padding:6px 12px; font-size:0.72rem;" onclick="reviewLogs('AuditLogs.aspx')">Review Logs</button>
            </div>
        </div>

        <!-- MEDIUM ALERT -->
        <div class="alert-card medium" data-type="PERIMETER" data-severity="MEDIUM" data-district="Gate 7" data-status="Resolved">
            <div class="alert-icon-box">📦</div>
            <div class="alert-body">
                <div style="display:flex; align-items:center; gap:10px;">
                    <span class="badge-sev medium">MEDIUM</span>
                    <span style="font-size:0.7rem; color:#64748b;">⏱ 04:30 AM (6h ago)</span>
                </div>
                <div class="alert-title">Suspicious package left near perimeter fence</div>
                <div class="alert-desc">Drone surveillance spotted an unattended bag near Gate 7. Security dispatched. Cleared as non-threat (abandoned worker tools).</div>
                <div class="alert-meta">
                    <div>Location: <strong style="color:#cbd5e1;">📍 Gate 7 Fence Outer Rim</strong></div>
                    <div>Status Note: <strong style="color:#10b981;">Cleared by Security Patrol</strong></div>
                </div>
            </div>
            <div class="alert-actions-col">
                <span style="font-size:0.72rem; color:#64748b; font-weight:700;">Resolved</span>
                <button type="button" class="btn-outline" style="padding:6px 12px; font-size:0.72rem;" onclick="viewAlertDetails('Suspicious package left near perimeter fence')">View Report</button>
            </div>
        </div>
    </div>

    <script>
        function applyAlertFilters() {
            const selectedType = document.getElementById('filterType').value;
            const selectedSev = document.getElementById('filterSeverity').value;
            const selectedDist = document.getElementById('filterDistrict').value;
            const selectedStatus = document.getElementById('filterStatus').value;

            const cards = document.querySelectorAll('.alert-card');

            cards.forEach(card => {
                const type = card.getAttribute('data-type');
                const sev = card.getAttribute('data-severity');
                const dist = card.getAttribute('data-district');
                const status = card.getAttribute('data-status');

                const matchType = (selectedType === 'ALL' || type === selectedType);
                const matchSev = (selectedSev === 'ALL' || sev === selectedSev);
                const matchDist = (selectedDist === 'ALL' || dist === selectedDist);
                const matchStatus = (selectedStatus === 'ALL' || status === selectedStatus);

                if (matchType && matchSev && matchDist && matchStatus) {
                    card.style.display = 'flex';
                } else {
                    card.style.display = 'none';
                }
            });
        }

        function markAllAlertsAsRead() {
            const cards = document.querySelectorAll('.alert-card');
            cards.forEach(card => card.classList.add('read-state'));

            document.getElementById('countCritical').innerText = '0';
            document.getElementById('countHigh').innerText = '0';

            const btn = document.getElementById('btnMarkRead');
            btn.innerText = '✓ All Read';
            btn.style.opacity = '0.6';
        }

        function reviewLogs(targetUrl) {
            window.location.href = targetUrl;
        }

        function viewAlertDetails(title) {
            alert("NETRA Intelligence Details for: " + title);
        }

        function exportAlertsCSV() {
            let csv = ["Severity,Title,Description,Status"];
            const visibleCards = document.querySelectorAll('.alert-card');

            visibleCards.forEach(card => {
                if (card.style.display !== 'none') {
                    const sev = card.getAttribute('data-severity');
                    const title = card.querySelector('.alert-title').innerText.replace(/"/g, '""');
                    const desc = card.querySelector('.alert-desc').innerText.replace(/"/g, '""');
                    const status = card.getAttribute('data-status');
                    csv.push(`"${sev}","${title}","${desc}","${status}"`);
                }
            });

            const blob = new Blob([csv.join('\n')], { type: 'text/csv' });
            const link = document.createElement('a');
            link.href = URL.createObjectURL(blob);
            link.download = 'NETRA_Alerts_Report.csv';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }
    </script>
</asp:Content>