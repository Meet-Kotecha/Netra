<%@ Page Title="Crime Cases" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CrimeCases.aspx.cs" Inherits="Netra.CrimeCases" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-header-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
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

        .btn-add-case {
            background-color: #00d2ff;
            background: linear-gradient(135deg, #00d2ff 0%, #00a8cc 100%);
            color: #070d18;
            border: none;
            padding: 9px 18px;
            border-radius: 6px;
            font-size: 0.82rem;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: all 0.25s ease;
            text-decoration: none;
        }

        .btn-add-case:hover {
            opacity: 0.9;
            box-shadow: 0 0 15px rgba(0, 210, 255, 0.4);
            transform: translateY(-2px);
        }

        /* Filter Toolbar */
        .filter-toolbar {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 16px 20px;
            margin-bottom: 20px;
            width: 100%;
        }

        .filter-row {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            align-items: flex-end;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
            flex: 1;
            min-width: 140px;
        }

        .filter-group.search-group {
            flex: 2;
            min-width: 220px;
        }

        .filter-label {
            font-size: 0.65rem;
            font-weight: 700;
            letter-spacing: 0.8px;
            color: #64748b;
            text-transform: uppercase;
        }

        .filter-input, .filter-select {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 8px 12px;
            color: #f8fafc;
            font-size: 0.8rem;
            outline: none;
            transition: border-color 0.2s ease;
            width: 100%;
        }

        .filter-input:focus, .filter-select:focus {
            border-color: #00d2ff;
        }

        .btn-filter-icon {
            background-color: #070d18;
            border: 1px solid #1e293b;
            color: #94a3b8;
            padding: 8px 12px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.85rem;
            height: 35px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-filter-icon:hover {
            border-color: #00d2ff;
            color: #00d2ff;
        }

        /* Cases Data Table Card */
        .table-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            overflow: hidden;
            width: 100%;
        }

        .cases-table {
            width: 100%;
            border-collapse: collapse;
        }

        .cases-table th {
            text-align: left;
            font-size: 0.68rem;
            font-weight: 700;
            letter-spacing: 0.8px;
            color: #64748b;
            text-transform: uppercase;
            padding: 14px 18px;
            border-bottom: 1px solid #1e293b;
            background-color: #0b1320;
        }

        .cases-table td {
            padding: 14px 18px;
            border-bottom: 1px solid #141f30;
            font-size: 0.8rem;
            color: #cbd5e1;
            vertical-align: middle;
        }

        .cases-table tr {
            transition: background-color 0.15s ease;
        }

        .cases-table tbody tr:hover {
            background-color: #121e30;
        }

        .case-id-link {
            color: #00d2ff;
            text-decoration: none;
            font-weight: 700;
        }

        .case-id-link:hover {
            text-decoration: underline;
        }

        /* Severity Badges */
        .badge-severity {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 0.65rem;
            font-weight: 800;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        .severity-critical {
            background-color: rgba(239, 68, 68, 0.15);
            color: #ef4444;
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .severity-high {
            background-color: rgba(245, 158, 11, 0.15);
            color: #f59e0b;
            border: 1px solid rgba(245, 158, 11, 0.3);
        }

        .severity-medium {
            background-color: rgba(56, 189, 248, 0.15);
            color: #38bdf8;
            border: 1px solid rgba(56, 189, 248, 0.3);
        }

        /* Status Dot Pills */
        .status-pill {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 0.78rem;
        }

        .status-dot {
            width: 7px;
            height: 7px;
            border-radius: 50%;
        }

        .dot-active { background-color: #00d2ff; }
        .dot-open { border: 1px solid #94a3b8; }
        .dot-closed { background-color: #64748b; }

        /* Investigator Avatar */
        .investigator-cell {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .investigator-avatar {
            width: 26px;
            height: 26px;
            border-radius: 50%;
            background-color: #1e293b;
            color: #94a3b8;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.68rem;
            font-weight: 700;
        }

        /* Table Pagination Footer */
        .table-footer {
            padding: 14px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px solid #1e293b;
            font-size: 0.75rem;
            color: #64748b;
        }

        .pagination-controls {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .page-btn {
            background: none;
            border: none;
            color: #64748b;
            cursor: pointer;
            font-size: 0.85rem;
        }

        .page-btn:hover {
            color: #00d2ff;
        }

        .no-data-row {
            text-align: center;
            color: #64748b;
            padding: 25px !important;
            font-size: 0.85rem;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Top Row -->
    <div class="page-header-row">
        <div class="page-title">
            <h2>Crime Cases</h2>
            <p>Search, review and manage registered crime cases.</p>
        </div>
        <a href="RegisterCase.aspx" class="btn-add-case">➕ Add New Case</a>
    </div>

    <!-- Filter Toolbar with Client-Side Events -->
    <div class="filter-toolbar">
        <div class="filter-row">
            <div class="filter-group search-group">
                <span class="filter-label">SEARCH</span>
                <input type="text" id="txtSearch" class="filter-input" placeholder="🔍 ID, Title, Location, Suspect..." onkeyup="filterCasesTable()" />
            </div>

            <div class="filter-group">
                <span class="filter-label">CRIME TYPE</span>
                <select id="ddlCrimeType" class="filter-select" onchange="filterCasesTable()">
                    <option value="">All Types</option>
                    <option value="Cyber Espionage">Cyber Espionage</option>
                    <option value="Financial Fraud">Financial Fraud</option>
                    <option value="Narcotics Distribution">Narcotics Distribution</option>
                    <option value="Vehicle Theft">Vehicle Theft</option>
                    <option value="Smuggling">Smuggling</option>
                </select>
            </div>

            <div class="filter-group">
                <span class="filter-label">DISTRICT</span>
                <select id="ddlDistrict" class="filter-select" onchange="filterCasesTable()">
                    <option value="">All Districts</option>
                    <option value="District 1">District 1</option>
                    <option value="District 2">District 2</option>
                    <option value="District 3">District 3</option>
                </select>
            </div>

            <div class="filter-group">
                <span class="filter-label">STATUS</span>
                <select id="ddlStatus" class="filter-select" onchange="filterCasesTable()">
                    <option value="">All</option>
                    <option value="Active">Active</option>
                    <option value="Open">Open</option>
                    <option value="Closed">Closed</option>
                </select>
            </div>

            <div class="filter-group">
                <span class="filter-label">SEVERITY</span>
                <select id="ddlSeverity" class="filter-select" onchange="filterCasesTable()">
                    <option value="">All</option>
                    <option value="CRITICAL">Critical</option>
                    <option value="HIGH">High</option>
                    <option value="MEDIUM">Medium</option>
                </select>
            </div>

            <div class="filter-group" style="min-width: 160px;">
                <span class="filter-label">DATE RANGE</span>
                <div style="display:flex; gap:6px;">
                    <input type="text" class="filter-input" value="📅 Last 30 Days" readonly />
                    <button type="button" class="btn-filter-icon" onclick="resetFilters()">🔄</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Cases Data Table -->
    <div class="table-card">
        <table class="cases-table" id="tblCases">
            <thead>
                <tr>
                    <th>CASE ID</th>
                    <th>CRIME TYPE</th>
                    <th>DATE</th>
                    <th>LOCATION</th>
                    <th>DISTRICT</th>
                    <th>SEVERITY</th>
                    <th>STATUS</th>
                    <th>INVESTIGATOR</th>
                    <th>ACTIONS</th>
                </tr>
            </thead>
            <tbody>
                <tr class="case-row">
                    <td><a href="#" class="case-id-link">C-24-8901</a></td>
                    <td class="col-type">Cyber Espionage</td>
                    <td>2024-10-24</td>
                    <td class="col-location">Tech Hub Sector 4, Server Room</td>
                    <td class="col-district">District 1</td>
                    <td class="col-severity"><span class="badge-severity severity-critical">CRITICAL</span></td>
                    <td class="col-status"><div class="status-pill"><span class="status-dot dot-active"></span> Active</div></td>
                    <td><div class="investigator-cell"><div class="investigator-avatar">AS</div> A. Silva</div></td>
                    <td><a href="#" style="color:#64748b; text-decoration:none;">•••</a></td>
                </tr>
                <tr class="case-row">
                    <td><a href="#" class="case-id-link">C-24-8894</a></td>
                    <td class="col-type">Financial Fraud</td>
                    <td>2024-10-22</td>
                    <td class="col-location">Global Trade Bank, Main Branch</td>
                    <td class="col-district">District 2</td>
                    <td class="col-severity"><span class="badge-severity severity-high">HIGH</span></td>
                    <td class="col-status"><div class="status-pill"><span class="status-dot dot-open"></span> Open</div></td>
                    <td><div class="investigator-cell"><div class="investigator-avatar">MK</div> M. Kovač</div></td>
                    <td><a href="#" style="color:#64748b; text-decoration:none;">•••</a></td>
                </tr>
                <tr class="case-row">
                    <td><a href="#" class="case-id-link">C-24-8870</a></td>
                    <td class="col-type">Narcotics Distribution</td>
                    <td>2024-10-18</td>
                    <td class="col-location">Port Authority, Warehouse 42</td>
                    <td class="col-district">District 3</td>
                    <td class="col-severity"><span class="badge-severity severity-high">HIGH</span></td>
                    <td class="col-status"><div class="status-pill"><span class="status-dot dot-active"></span> Active</div></td>
                    <td><div class="investigator-cell"><div class="investigator-avatar">JR</div> J. Reyes</div></td>
                    <td><a href="#" style="color:#64748b; text-decoration:none;">•••</a></td>
                </tr>
                <tr class="case-row">
                    <td><a href="#" class="case-id-link">C-24-8851</a></td>
                    <td class="col-type">Vehicle Theft</td>
                    <td>2024-10-15</td>
                    <td class="col-location">Residential Block C, Underpass</td>
                    <td class="col-district">District 1</td>
                    <td class="col-severity"><span class="badge-severity severity-medium">MEDIUM</span></td>
                    <td class="col-status"><div class="status-pill"><span class="status-dot dot-closed"></span> Closed</div></td>
                    <td><div class="investigator-cell"><div class="investigator-avatar">AS</div> A. Silva</div></td>
                    <td><a href="#" style="color:#64748b; text-decoration:none;">•••</a></td>
                </tr>
                <tr class="case-row">
                    <td><a href="#" class="case-id-link">C-24-8842</a></td>
                    <td class="col-type">Smuggling</td>
                    <td>2024-10-12</td>
                    <td class="col-location">Border Checkpoint Alpha</td>
                    <td class="col-district">District 3</td>
                    <td class="col-severity"><span class="badge-severity severity-critical">CRITICAL</span></td>
                    <td class="col-status"><div class="status-pill"><span class="status-dot dot-active"></span> Active</div></td>
                    <td><div class="investigator-cell"><div class="investigator-avatar">JR</div> J. Reyes</div></td>
                    <td><a href="#" style="color:#64748b; text-decoration:none;">•••</a></td>
                </tr>
                <!-- Dynamic No Results Message Row -->
                <tr id="trNoData" style="display:none;">
                    <td colspan="9" class="no-data-row">⚠️ No matching cases found for your selected filters.</td>
                </tr>
            </tbody>
        </table>

        <!-- Footer Pagination -->
        <div class="table-footer">
            <span id="lblCaseCounter">Showing 5 of 5 cases</span>
            <div class="pagination-controls">
                <button type="button" class="page-btn">❮</button>
                <span style="color:#f8fafc; font-weight:600;">Page 1 of 1</span>
                <button type="button" class="page-btn">❯</button>
            </div>
        </div>
    </div>

    <!-- Client-Side Real-Time Filter Logic Script -->
    <script>
        function filterCasesTable() {
            const searchVal = document.getElementById("txtSearch").value.toLowerCase().trim();
            const crimeTypeVal = document.getElementById("ddlCrimeType").value.toLowerCase();
            const districtVal = document.getElementById("ddlDistrict").value.toLowerCase();
            const statusVal = document.getElementById("ddlStatus").value.toLowerCase();
            const severityVal = document.getElementById("ddlSeverity").value.toLowerCase();

            const rows = document.querySelectorAll(".case-row");
            let visibleCount = 0;

            rows.forEach(row => {
                const rowText = row.innerText.toLowerCase();
                const crimeType = row.querySelector(".col-type").innerText.toLowerCase();
                const district = row.querySelector(".col-district").innerText.toLowerCase();
                const status = row.querySelector(".col-status").innerText.toLowerCase();
                const severity = row.querySelector(".col-severity").innerText.toLowerCase();

                const matchesSearch = searchVal === "" || rowText.includes(searchVal);
                const matchesType = crimeTypeVal === "" || crimeType === crimeTypeVal;
                const matchesDistrict = districtVal === "" || district === districtVal;
                const matchesStatus = statusVal === "" || status.includes(statusVal);
                const matchesSeverity = severityVal === "" || severity.includes(severityVal);

                if (matchesSearch && matchesType && matchesDistrict && matchesStatus && matchesSeverity) {
                    row.style.display = "";
                    visibleCount++;
                } else {
                    row.style.display = "none";
                }
            });

            // Toggle No Data row
            document.getElementById("trNoData").style.display = (visibleCount === 0) ? "" : "none";
            document.getElementById("lblCaseCounter").innerText = `Showing ${visibleCount} of 5 cases`;
        }

        function resetFilters() {
            document.getElementById("txtSearch").value = "";
            document.getElementById("ddlCrimeType").value = "";
            document.getElementById("ddlDistrict").value = "";
            document.getElementById("ddlStatus").value = "";
            document.getElementById("ddlSeverity").value = "";
            filterCasesTable();
        }
    </script>
</asp:Content>