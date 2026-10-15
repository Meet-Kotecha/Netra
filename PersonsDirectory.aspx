<%@ Page Title="Persons & Suspects" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PersonsDirectory.aspx.cs" Inherits="Netra.PersonsDirectory" %>

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
            font-size: 1.35rem;
            font-weight: 700;
            color: #ffffff;
        }

        .btn-add-person {
            background-color: #00d2ff;
            background: linear-gradient(135deg, #00d2ff 0%, #00a8cc 100%);
            color: #070d18;
            border: none;
            padding: 8px 18px;
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

        .btn-add-person:hover {
            opacity: 0.9;
            box-shadow: 0 0 14px rgba(0, 210, 255, 0.4);
        }

        /* Filter Toolbar */
        .filter-toolbar {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 14px 18px;
            margin-bottom: 20px;
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .search-box-input {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 8px 12px 8px 34px;
            color: #f8fafc;
            font-size: 0.8rem;
            width: 280px;
            outline: none;
            transition: border-color 0.2s ease;
        }

        .search-box-input:focus {
            border-color: #00d2ff;
        }

        .filter-select {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 8px 12px;
            color: #f8fafc;
            font-size: 0.8rem;
            outline: none;
            min-width: 160px;
            cursor: pointer;
        }

        .filter-select:focus {
            border-color: #00d2ff;
        }

        /* Data Table Card */
        .table-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            overflow: hidden;
            width: 100%;
        }

        .persons-table {
            width: 100%;
            border-collapse: collapse;
        }

        .persons-table th {
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

        .persons-table td {
            padding: 14px 18px;
            border-bottom: 1px solid #141f30;
            font-size: 0.78rem;
            color: #cbd5e1;
            vertical-align: middle;
        }

        .persons-table tbody tr {
            transition: background-color 0.15s ease;
        }

        .persons-table tbody tr:hover {
            background-color: #121e30;
        }

        /* Profile Cell */
        .profile-cell {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .profile-avatar {
            width: 38px;
            height: 38px;
            border-radius: 6px;
            background-color: #12283e;
            border: 1px solid #1e293b;
            object-fit: cover;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #38bdf8;
            font-size: 0.9rem;
            font-weight: 700;
        }

        .profile-name {
            font-size: 0.82rem;
            font-weight: 700;
            color: #ffffff;
        }

        .profile-dob {
            font-size: 0.68rem;
            color: #64748b;
            margin-top: 2px;
        }

        /* Type Badges */
        .badge-type {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 4px;
            font-size: 0.65rem;
            font-weight: 800;
            letter-spacing: 0.5px;
            text-transform: uppercase;
        }

        .type-suspect {
            background-color: rgba(239, 68, 68, 0.15);
            color: #ef4444;
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .type-poi {
            background-color: rgba(0, 210, 255, 0.15);
            color: #00d2ff;
            border: 1px solid rgba(0, 210, 255, 0.3);
        }

        .type-witness {
            background-color: rgba(148, 163, 184, 0.15);
            color: #94a3b8;
            border: 1px solid rgba(148, 163, 184, 0.3);
        }

        /* Case Tags */
        .case-tag-list {
            display: flex;
            gap: 6px;
            flex-wrap: wrap;
        }

        .case-tag {
            background-color: #070d18;
            border: 1px solid #1e293b;
            color: #94a3b8;
            padding: 2px 7px;
            border-radius: 4px;
            font-size: 0.68rem;
            font-family: monospace;
        }

        /* Table Footer */
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

        .disclaimer-banner {
            margin-top: 18px;
            background-color: rgba(11, 19, 32, 0.5);
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 10px 14px;
            font-size: 0.7rem;
            color: #64748b;
            display: flex;
            align-items: center;
            gap: 8px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Header -->
    <div class="page-header-row">
        <div class="page-title">
            <h2>Persons & Suspects</h2>
        </div>
        <button type="button" class="btn-add-person" onclick="alert('➕ Add New Person record portal initialized.')">+ Add Person</button>
    </div>

    <!-- Filter Bar -->
    <div class="filter-toolbar">
        <div style="position: relative;">
            <span style="position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: #64748b; font-size: 0.8rem;">🔍</span>
            <input type="text" id="txtSearchPersons" class="search-box-input" placeholder="Filter by Name, ID..." onkeyup="filterPersonsTable()" />
        </div>

        <select id="ddlTypeFilter" class="filter-select" onchange="filterPersonsTable()">
            <option value="">All Person Types</option>
            <option value="SUSPECT">Suspect</option>
            <option value="POI">POI (Person of Interest)</option>
            <option value="WITNESS">Witness</option>
        </select>

        <select id="ddlStatusFilter" class="filter-select" onchange="filterPersonsTable()">
            <option value="">All Statuses</option>
            <option value="Active">Active</option>
            <option value="Archived">Archived</option>
        </select>
    </div>

    <!-- Persons Table -->
    <div class="table-card">
        <table class="persons-table" id="tblPersons">
            <thead>
                <tr>
                    <th>PROFILE</th>
                    <th>PERSON ID</th>
                    <th>TYPE</th>
                    <th>ASSOCIATED CASES</th>
                    <th>KNOWN LOCATIONS</th>
                    <th>LAST UPDATED</th>
                    <th>ACTIONS</th>
                </tr>
            </thead>
            <tbody>
                <!-- Person 1 -->
                <tr class="person-row">
                    <td>
                        <div class="profile-cell">
                            <div class="profile-avatar">🧔</div>
                            <div>
                                <div class="profile-name col-name">Volkov, Dmitri</div>
                                <div class="profile-dob">DOB: 1982-04-12</div>
                            </div>
                        </div>
                    </td>
                    <td class="col-id" style="font-family: monospace; color:#38bdf8;">PR-892-441-A</td>
                    <td class="col-type"><span class="badge-type type-suspect">SUSPECT</span></td>
                    <td>
                        <div class="case-tag-list">
                            <span class="case-tag">#CS-2023-08A</span>
                            <span class="case-tag">#CS-2022-19B</span>
                        </div>
                    </td>
                    <td style="font-size:0.72rem; color:#cbd5e1;">📍 Prague, CZ; Vienna, AT</td>
                    <td style="font-size:0.72rem; color:#64748b;">2023-10-24 14:32Z</td>
                    <td><a href="#" style="color:#64748b; text-decoration:none;">•••</a></td>
                </tr>

                <!-- Person 2 -->
                <tr class="person-row">
                    <td>
                        <div class="profile-cell">
                            <div class="profile-avatar" style="background-color:#1e293b; color:#94a3b8;">❓</div>
                            <div>
                                <div class="profile-name col-name">Unknown (Alias: 'Ghost')</div>
                                <div class="profile-dob">DOB: Unknown</div>
                            </div>
                        </div>
                    </td>
                    <td class="col-id" style="font-family: monospace; color:#38bdf8;">PR-U99-102-X</td>
                    <td class="col-type"><span class="badge-type type-poi">POI</span></td>
                    <td>
                        <div class="case-tag-list">
                            <span class="case-tag">#CS-2023-08A</span>
                        </div>
                    </td>
                    <td style="font-size:0.72rem; color:#cbd5e1;">📍 Digital Footprint Only</td>
                    <td style="font-size:0.72rem; color:#64748b;">2023-10-22 09:15Z</td>
                    <td><a href="#" style="color:#64748b; text-decoration:none;">•••</a></td>
                </tr>

                <!-- Person 3 -->
                <tr class="person-row">
                    <td>
                        <div class="profile-cell">
                            <div class="profile-avatar">👩</div>
                            <div>
                                <div class="profile-name col-name">Chen, Elena</div>
                                <div class="profile-dob">DOB: 1990-11-03</div>
                            </div>
                        </div>
                    </td>
                    <td class="col-id" style="font-family: monospace; color:#38bdf8;">PR-112-998-C</td>
                    <td class="col-type"><span class="badge-type type-witness">WITNESS</span></td>
                    <td>
                        <div class="case-tag-list">
                            <span class="case-tag">#CS-2023-14D</span>
                        </div>
                    </td>
                    <td style="font-size:0.72rem; color:#cbd5e1;">📍 London, UK</td>
                    <td style="font-size:0.72rem; color:#64748b;">2023-10-20 11:45Z</td>
                    <td><a href="#" style="color:#64748b; text-decoration:none;">•••</a></td>
                </tr>

                <tr id="trNoPersons" style="display:none;">
                    <td colspan="7" style="text-align:center; padding:25px; color:#64748b;">⚠️ No entities matched your search parameters.</td>
                </tr>
            </tbody>
        </table>

        <!-- Table Footer -->
        <div class="table-footer">
            <span id="lblEntityCounter">Showing 1-3 of 1,248 Entities</span>
            <div class="pagination-controls">
                <button type="button" class="page-btn">❮</button>
                <span style="color:#f8fafc; font-weight:600;">Page 1 of 416</span>
                <button type="button" class="page-btn">❯</button>
            </div>
        </div>
    </div>

    <!-- Security Notice -->
    <div class="disclaimer-banner">
        <span>ℹ️ Association with a case does not by itself establish criminal responsibility. All data is classified and subject to strict operational security protocols.</span>
    </div>

    <!-- Filtering Script -->
    <script>
        function filterPersonsTable() {
            const searchVal = document.getElementById("txtSearchPersons").value.toLowerCase().trim();
            const typeVal = document.getElementById("ddlTypeFilter").value.toLowerCase();

            const rows = document.querySelectorAll(".person-row");
            let visibleCount = 0;

            rows.forEach(row => {
                const name = row.querySelector(".col-name").innerText.toLowerCase();
                const id = row.querySelector(".col-id").innerText.toLowerCase();
                const type = row.querySelector(".col-type").innerText.toLowerCase();

                const matchesSearch = (searchVal === "" || name.includes(searchVal) || id.includes(searchVal));
                const matchesType = (typeVal === "" || type.includes(typeVal));

                if (matchesSearch && matchesType) {
                    row.style.display = "";
                    visibleCount++;
                } else {
                    row.style.display = "none";
                }
            });

            document.getElementById("trNoPersons").style.display = (visibleCount === 0) ? "" : "none";
            document.getElementById("lblEntityCounter").innerText = `Showing 1-${visibleCount} of 1,248 Entities`;
        }
    </script>
</asp:Content>