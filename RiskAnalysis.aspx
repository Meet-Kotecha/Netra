<%@ Page Title="Risk & Anomaly Analysis" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RiskAnalysis.aspx.cs" Inherits="Netra.RiskAnalysis" %>

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

        .glass-panel {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .panel-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
        }

        .panel-title {
            font-size: 0.9rem;
            font-weight: 800;
            color: #ffffff;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        .live-tag {
            color: #00d2ff;
            font-size: 0.7rem;
            font-weight: 800;
            letter-spacing: 0.8px;
        }

        .risk-table {
            width: 100%;
            border-collapse: collapse;
        }

        .risk-table th {
            background-color: #070d18;
            padding: 12px 14px;
            font-size: 0.65rem;
            font-weight: 800;
            color: #64748b;
            text-transform: uppercase;
            text-align: left;
            border-bottom: 1px solid #1e293b;
        }

        .risk-table td {
            padding: 14px;
            font-size: 0.78rem;
            color: #cbd5e1;
            border-bottom: 1px solid #1e293b;
            vertical-align: middle;
        }

        .badge-level {
            font-size: 0.65rem;
            font-weight: 800;
            padding: 3px 8px;
            border-radius: 4px;
            letter-spacing: 0.5px;
            display: inline-block;
        }

        .badge-critical { background: rgba(239, 68, 68, 0.15); color: #f87171; border: 1px solid rgba(239, 68, 68, 0.3); }
        .badge-high { background: rgba(249, 115, 22, 0.15); color: #fb923c; border: 1px solid rgba(249, 115, 22, 0.3); }
        .badge-elevated { background: rgba(234, 179, 8, 0.15); color: #fde047; border: 1px solid rgba(234, 179, 8, 0.3); }
        .badge-moderate { background: rgba(148, 163, 184, 0.15); color: #cbd5e1; border: 1px solid rgba(148, 163, 184, 0.3); }
        .badge-low { background: rgba(56, 189, 248, 0.15); color: #38bdf8; border: 1px solid rgba(56, 189, 248, 0.3); }

        .anomalies-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .anomaly-card {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 16px;
            display: flex;
            gap: 14px;
        }

        .anomaly-icon {
            width: 44px;
            height: 44px;
            border-radius: 8px;
            background: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            flex-shrink: 0;
        }

        /* Filter Modal */
        .modal-overlay {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.75);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 9999;
        }

        .modal-box {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            width: 420px;
            padding: 22px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        }

        .filter-label {
            font-size: 0.68rem;
            font-weight: 800;
            color: #64748b;
            text-transform: uppercase;
            display: block;
            margin-bottom: 6px;
        }

        .filter-select {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 8px 12px;
            color: #ffffff;
            font-size: 0.78rem;
            outline: none;
            width: 100%;
            margin-bottom: 14px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header-row">
        <div>
            <div class="page-title">Risk & Anomaly Analysis</div>
            <div style="font-size:0.75rem; color:#64748b; margin-top:4px;">Live assessment of regional threat models and automated pattern detection.</div>
        </div>

        <div class="header-actions">
            <button type="button" class="btn-outline" onclick="openFilterModal()">⊞ Filters</button>
            <button type="button" class="btn-cyan" onclick="exportTableToCSV('Area_Risk_Analysis.csv')">📥 Export Data</button>
        </div>
    </div>

    <!-- AREA RISK ANALYSIS PANEL -->
    <div class="glass-panel">
        <div class="panel-header">
            <div class="panel-title">🎯 Area Risk Analysis</div>
            <div class="live-tag">• LIVE FEED ACTIVE</div>
        </div>

        <table class="risk-table" id="tblRiskAnalysis">
            <thead>
                <tr>
                    <th>AREA</th>
                    <th>DISTRICT</th>
                    <th>CRIME COUNT</th>
                    <th>HISTORICAL TREND</th>
                    <th>RISK SCORE</th>
                    <th>RISK LEVEL</th>
                </tr>
            </thead>
            <tbody>
                <tr class="risk-row" data-district="Central" data-level="CRITICAL">
                    <td style="font-weight:800; color:#fff;">Downtown Commercial</td>
                    <td style="color:#64748b;">Central</td>
                    <td style="font-weight:800; color:#fff;">142</td>
                    <td style="color:#f87171; font-weight:700;">↗ +12.4%</td>
                    <td style="font-weight:800; color:#fff;">94</td>
                    <td><span class="badge-level badge-critical">• CRITICAL</span></td>
                </tr>
                <tr class="risk-row" data-district="West" data-level="ELEVATED">
                    <td style="font-weight:800; color:#fff;">Westside Industrial</td>
                    <td style="color:#64748b;">West</td>
                    <td style="font-weight:800; color:#fff;">87</td>
                    <td style="color:#f87171; font-weight:700;">↗ +5.2%</td>
                    <td style="font-weight:800; color:#fff;">76</td>
                    <td><span class="badge-level badge-elevated">• ELEVATED</span></td>
                </tr>
                <tr class="risk-row" data-district="North" data-level="LOW">
                    <td style="font-weight:800; color:#fff;">North Hills Residential</td>
                    <td style="color:#64748b;">North</td>
                    <td style="font-weight:800; color:#fff;">24</td>
                    <td style="color:#38bdf8; font-weight:700;">↘ -3.1%</td>
                    <td style="font-weight:800; color:#fff;">32</td>
                    <td><span class="badge-level badge-low">• LOW</span></td>
                </tr>
                <tr class="risk-row" data-district="South" data-level="HIGH">
                    <td style="font-weight:800; color:#fff;">South Port Terminal</td>
                    <td style="color:#64748b;">South</td>
                    <td style="font-weight:800; color:#fff;">112</td>
                    <td style="color:#f87171; font-weight:700;">↗ +8.7%</td>
                    <td style="font-weight:800; color:#fff;">88</td>
                    <td><span class="badge-level badge-high">• HIGH</span></td>
                </tr>
                <tr class="risk-row" data-district="East" data-level="MODERATE">
                    <td style="font-weight:800; color:#fff;">Eastside Medical</td>
                    <td style="color:#64748b;">East</td>
                    <td style="font-weight:800; color:#fff;">45</td>
                    <td style="color:#94a3b8; font-weight:700;">→ 0.0%</td>
                    <td style="font-weight:800; color:#fff;">41</td>
                    <td><span class="badge-level badge-moderate">• MODERATE</span></td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- DETECTED ANOMALIES PANEL -->
    <div style="font-size:0.85rem; font-weight:800; color:#fff; margin-bottom:12px; display:flex; align-items:center; gap:6px;">
        ⚠️ DETECTED ANOMALIES
    </div>

    <div class="anomalies-grid">
        <div class="anomaly-card">
            <div class="anomaly-icon">🚗</div>
            <div>
                <div style="display:flex; justify-content:space-between; align-items:center;">
                    <div style="font-weight:800; color:#fff; font-size:0.85rem;">Unusual Increase in Vehicle Theft</div>
                    <span class="badge-level badge-critical">CRITICAL</span>
                </div>
                <div style="font-size:0.72rem; color:#94a3b8; margin:6px 0 10px 0;">
                    Statistically significant spike in vehicle thefts concentrated in Downtown Commercial district over the last 48 hours.
                </div>
                <div style="display:flex; gap:20px; font-size:0.68rem; color:#64748b;">
                    <div>ACTIVITY VS AVG: <strong style="color:#f87171;">+315%</strong></div>
                    <div>DETECTION TIME: <strong style="color:#fff;">08:42:15 GMT</strong></div>
                </div>
            </div>
        </div>

        <div class="anomaly-card">
            <div class="anomaly-icon" style="background:rgba(234, 179, 8, 0.1); border-color:rgba(234, 179, 8, 0.2);">🧩</div>
            <div>
                <div style="display:flex; justify-content:space-between; align-items:center;">
                    <div style="font-weight:800; color:#fff; font-size:0.85rem;">Recurring Crime Pattern</div>
                    <span class="badge-level badge-elevated">ELEVATED</span>
                </div>
                <div style="font-size:0.72rem; color:#94a3b8; margin:6px 0 10px 0;">
                    Temporal correlation identified between minor vandalism incidents and subsequent commercial burglaries in Sector 4.
                </div>
                <div style="display:flex; gap:20px; font-size:0.68rem; color:#64748b;">
                    <div>CONFIDENCE SCORE: <strong style="color:#fde047;">84.2%</strong></div>
                    <div>DETECTION TIME: <strong style="color:#fff;">11:15:02 GMT</strong></div>
                </div>
            </div>
        </div>
    </div>

    <!-- Filter Modal Dialog -->
    <div id="modalFilters" class="modal-overlay">
        <div class="modal-box">
            <div style="font-size:1rem; font-weight:800; color:#fff; margin-bottom:16px;">⊞ Filter Risk Analysis</div>

            <label class="filter-label">District</label>
            <select id="filterDistrict" class="filter-select">
                <option value="ALL">All Districts</option>
                <option value="Central">Central</option>
                <option value="West">West</option>
                <option value="North">North</option>
                <option value="South">South</option>
                <option value="East">East</option>
            </select>

            <label class="filter-label">Risk Level</label>
            <select id="filterLevel" class="filter-select">
                <option value="ALL">All Risk Levels</option>
                <option value="CRITICAL">Critical</option>
                <option value="HIGH">High</option>
                <option value="ELEVATED">Elevated</option>
                <option value="MODERATE">Moderate</option>
                <option value="LOW">Low</option>
            </select>

            <div style="display:flex; justify-content:flex-end; gap:10px; margin-top:10px;">
                <button type="button" class="btn-outline" onclick="closeFilterModal()">Cancel</button>
                <button type="button" class="btn-cyan" onclick="applyRiskFilters()">Apply Filters</button>
            </div>
        </div>
    </div>

    <script>
        function openFilterModal() {
            document.getElementById('modalFilters').style.display = 'flex';
        }

        function closeFilterModal() {
            document.getElementById('modalFilters').style.display = 'none';
        }

        function applyRiskFilters() {
            const selectedDistrict = document.getElementById('filterDistrict').value;
            const selectedLevel = document.getElementById('filterLevel').value;
            const rows = document.querySelectorAll('.risk-row');

            rows.forEach(row => {
                const district = row.getAttribute('data-district');
                const level = row.getAttribute('data-level');

                const matchesDistrict = (selectedDistrict === 'ALL' || district === selectedDistrict);
                const matchesLevel = (selectedLevel === 'ALL' || level === selectedLevel);

                if (matchesDistrict && matchesLevel) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });

            closeFilterModal();
        }

        function exportTableToCSV(filename) {
            const table = document.getElementById('tblRiskAnalysis');
            let csv = [];

            for (let i = 0; i < table.rows.length; i++) {
                let row = [], cols = table.rows[i].querySelectorAll('td, th');
                for (let j = 0; j < cols.length; j++) {
                    // Exclude sparkline / graph column if present
                    if (j !== 3 || i === 0) {
                        row.push('"' + cols[j].innerText.replace(/"/g, '""').trim() + '"');
                    }
                }
                csv.push(row.join(','));
            }

            const csvFile = new Blob([csv.join('\n')], { type: 'text/csv' });
            const downloadLink = document.createElement('a');
            downloadLink.download = filename;
            downloadLink.href = window.URL.createObjectURL(csvFile);
            downloadLink.style.display = 'none';
            document.body.appendChild(downloadLink);
            downloadLink.click();
            document.body.removeChild(downloadLink);
        }
    </script>
</asp:Content>