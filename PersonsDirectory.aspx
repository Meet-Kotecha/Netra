<%@ Page Title="Persons & Suspects" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PersonsDirectory.aspx.cs" Inherits="Netra.PersonsDirectory" %>

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
        }

        .btn-cyan:hover {
            box-shadow: 0 0 12px rgba(0, 210, 255, 0.4);
        }

        /* Filter Controls Bar */
        .filter-bar {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 14px 18px;
            margin-bottom: 20px;
            display: flex;
            gap: 14px;
            align-items: center;
        }

        .filter-input {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 8px 12px;
            color: #ffffff;
            font-size: 0.78rem;
            outline: none;
            width: 260px;
        }

        .filter-input:focus {
            border-color: #00d2ff;
        }

        .filter-select {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 8px 12px;
            color: #cbd5e1;
            font-size: 0.78rem;
            outline: none;
            cursor: pointer;
        }

        /* Table Design */
        .directory-table-container {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .directory-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        .directory-table th {
            background-color: #070d18;
            border-bottom: 1px solid #1e293b;
            padding: 12px 18px;
            font-size: 0.65rem;
            font-weight: 800;
            color: #64748b;
            letter-spacing: 0.8px;
            text-transform: uppercase;
        }

        .directory-table td {
            padding: 14px 18px;
            border-bottom: 1px solid #1e293b;
            font-size: 0.78rem;
            color: #cbd5e1;
            vertical-align: middle;
        }

        .directory-table tr:hover {
            background-color: rgba(18, 40, 62, 0.4);
        }

        .person-profile-cell {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .person-thumb {
            width: 40px;
            height: 40px;
            border-radius: 6px;
            object-fit: cover;
            border: 1px solid #00d2ff;
        }

        .type-badge {
            font-size: 0.65rem;
            font-weight: 800;
            padding: 3px 8px;
            border-radius: 4px;
            letter-spacing: 0.5px;
            display: inline-block;
        }

        .badge-suspect { background: rgba(239, 68, 68, 0.15); color: #f87171; border: 1px solid rgba(239, 68, 68, 0.3); }
        .badge-poi { background: rgba(0, 210, 255, 0.15); color: #38bdf8; border: 1px solid rgba(0, 210, 255, 0.3); }
        .badge-witness { background: rgba(234, 179, 8, 0.15); color: #facc15; border: 1px solid rgba(234, 179, 8, 0.3); }

        .case-tag {
            background: #070d18;
            border: 1px solid #1e293b;
            color: #94a3b8;
            font-size: 0.68rem;
            padding: 2px 6px;
            border-radius: 4px;
            margin-right: 4px;
            display: inline-block;
        }

        .btn-view-link {
            color: #00d2ff;
            font-weight: 700;
            text-decoration: none;
            font-size: 0.75rem;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .btn-view-link:hover {
            text-decoration: underline;
        }

        /* Notice Banner */
        .security-notice {
            background: rgba(11, 19, 32, 0.8);
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 10px 16px;
            font-size: 0.72rem;
            color: #64748b;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* Modal Overlay */
        .modal-overlay {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.75);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 9999;
        }

        .modal-box {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            width: 480px;
            padding: 22px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header-row">
        <div class="page-title">Persons & Suspects</div>
        <button type="button" class="btn-cyan" onclick="openAddPersonModal()">+ Add Person</button>
    </div>

    <!-- Filter Control Toolbar -->
    <div class="filter-bar">
        <input type="text" id="txtSearchQuery" class="filter-input" placeholder="🔍 Filter by Name, ID..." onkeyup="filterDirectoryTable()" />
        
        <select id="ddlPersonType" class="filter-select" onchange="filterDirectoryTable()">
            <option value="all">All Person Types</option>
            <option value="SUSPECT">Suspect</option>
            <option value="POI">POI</option>
            <option value="WITNESS">Witness</option>
        </select>

        <select id="ddlStatus" class="filter-select" onchange="filterDirectoryTable()">
            <option value="all">All Statuses</option>
            <option value="active">Active Investigation</option>
            <option value="closed">Closed / Archived</option>
        </select>
    </div>

    <!-- Directory Data Table -->
    <div class="directory-table-container">
        <table class="directory-table" id="tblPersons">
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
                <!-- Row 1: Keval Goswami -->
                <tr class="person-row" data-name="keval goswami" data-type="SUSPECT">
                    <td>
                        <div class="person-profile-cell">
                            <img src="Images/Meet.jpeg" class="person-thumb" alt="Keval Goswami" />
                            <div>
                                <div style="font-weight: 800; color: #fff;">Keval Goswami</div>
                                <div style="font-size: 0.68rem; color: #64748b;">DOB: 2006-06-06</div>
                            </div>
                        </div>
                    </td>
                    <td style="font-weight: 700; color: #38bdf8;">PR-1042-89</td>
                    <td><span class="type-badge badge-suspect">SUSPECT</span></td>
                    <td>
                        <span class="case-tag">#OP-2023-A9</span>
                        <span class="case-tag">#OP-2022-C4</span>
                    </td>
                    <td>📍 Safehouse Alpha; Sector 4</td>
                    <td style="font-size: 0.72rem; color: #64748b;">2026-10-14 14:32Z</td>
                    <td><a href="PersonProfile.aspx?id=1" class="btn-view-link">View →</a></td>
                </tr>

                <!-- Row 2: Dmitri Volkov -->
                <tr class="person-row" data-name="dmitri volkov" data-type="SUSPECT">
                    <td>
                        <div class="person-profile-cell">
                            <div style="width:40px; height:40px; border-radius:6px; background:#12283e; color:#00d2ff; display:flex; align-items:center; justify-content:center; font-weight:800;">DV</div>
                            <div>
                                <div style="font-weight: 800; color: #fff;">Volkov, Dmitri</div>
                                <div style="font-size: 0.68rem; color: #64748b;">DOB: 1982-04-12</div>
                            </div>
                        </div>
                    </td>
                    <td style="font-weight: 700; color: #38bdf8;">PR-892-441-A</td>
                    <td><span class="type-badge badge-suspect">SUSPECT</span></td>
                    <td>
                        <span class="case-tag">#CS-2023-08A</span>
                        <span class="case-tag">#CS-2022-19B</span>
                    </td>
                    <td>📍 Prague, CZ; Vienna, AT</td>
                    <td style="font-size: 0.72rem; color: #64748b;">2026-10-12 11:15Z</td>
                    <td><a href="PersonProfile.aspx?id=2" class="btn-view-link">View →</a></td>
                </tr>

                <!-- Row 3: Unknown (Ghost) -->
                <tr class="person-row" data-name="unknown ghost" data-type="POI">
                    <td>
                        <div class="person-profile-cell">
                            <div style="width:40px; height:40px; border-radius:6px; background:#1e293b; color:#cbd5e1; display:flex; align-items:center; justify-content:center; font-weight:800;">?</div>
                            <div>
                                <div style="font-weight: 800; color: #fff;">Unknown (Alias: 'Ghost')</div>
                                <div style="font-size: 0.68rem; color: #64748b;">DOB: Unknown</div>
                            </div>
                        </div>
                    </td>
                    <td style="font-weight: 700; color: #38bdf8;">PR-U99-102-X</td>
                    <td><span class="type-badge badge-poi">POI</span></td>
                    <td><span class="case-tag">#CS-2023-08A</span></td>
                    <td>📍 Digital Footprint Only</td>
                    <td style="font-size: 0.72rem; color: #64748b;">2026-10-10 09:15Z</td>
                    <td><a href="PersonProfile.aspx?id=3" class="btn-view-link">View →</a></td>
                </tr>

                <!-- Row 4: Elena Chen -->
                <tr class="person-row" data-name="elena chen" data-type="WITNESS">
                    <td>
                        <div class="person-profile-cell">
                            <div style="width:40px; height:40px; border-radius:6px; background:#12283e; color:#facc15; display:flex; align-items:center; justify-content:center; font-weight:800;">EC</div>
                            <div>
                                <div style="font-weight: 800; color: #fff;">Chen, Elena</div>
                                <div style="font-size: 0.68rem; color: #64748b;">DOB: 1990-11-03</div>
                            </div>
                        </div>
                    </td>
                    <td style="font-weight: 700; color: #38bdf8;">PR-112-998-C</td>
                    <td><span class="type-badge badge-witness">WITNESS</span></td>
                    <td><span class="case-tag">#CS-2023-14D</span></td>
                    <td>📍 London, UK</td>
                    <td style="font-size: 0.72rem; color: #64748b;">2026-10-08 11:45Z</td>
                    <td><a href="PersonProfile.aspx?id=4" class="btn-view-link">View →</a></td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- Security Information Footer -->
    <div class="security-notice">
        <span>ℹ️</span> Association with a case does not by itself establish criminal responsibility. All data is classified and subject to strict operational security protocols.
    </div>

    <!-- Add Person Modal -->
    <div id="modalAddPerson" class="modal-overlay">
        <div class="modal-box">
            <div style="font-size:1.1rem; font-weight:800; color:#fff; margin-bottom:14px;">➕ Add Person / Suspect Record</div>
            
            <label style="font-size:0.68rem; font-weight:800; color:#64748b; text-transform:uppercase; display:block; margin-bottom:4px;">Full Name</label>
            <input type="text" id="txtNewPersonName" class="filter-input" style="width:100%; margin-bottom:12px;" placeholder="e.g., Marcus Vane" />

            <label style="font-size:0.68rem; font-weight:800; color:#64748b; text-transform:uppercase; display:block; margin-bottom:4px;">Person Type</label>
            <select id="ddlNewPersonType" class="filter-select" style="width:100%; margin-bottom:16px;">
                <option value="SUSPECT">Suspect</option>
                <option value="POI">Person of Interest (POI)</option>
                <option value="WITNESS">Witness</option>
            </select>

            <div style="display:flex; justify-content:flex-end; gap:10px;">
                <button type="button" style="background:#070d18; border:1px solid #1e293b; color:#cbd5e1; padding:8px 16px; border-radius:6px; font-weight:700; cursor:pointer;" onclick="closeAddPersonModal()">Cancel</button>
                <button type="button" class="btn-cyan" onclick="saveNewPersonRecord()">Save Entity</button>
            </div>
        </div>
    </div>

    <script>
        function filterDirectoryTable() {
            const query = document.getElementById('txtSearchQuery').value.toLowerCase();
            const selectedType = document.getElementById('ddlPersonType').value;
            const rows = document.querySelectorAll('.person-row');

            rows.forEach(row => {
                const name = row.getAttribute('data-name');
                const type = row.getAttribute('data-type');

                const matchesQuery = name.includes(query);
                const matchesType = (selectedType === 'all' || type === selectedType);

                if (matchesQuery && matchesType) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        function openAddPersonModal() {
            document.getElementById('modalAddPerson').style.display = 'flex';
        }

        function closeAddPersonModal() {
            document.getElementById('modalAddPerson').style.display = 'none';
        }

        function saveNewPersonRecord() {
            const name = document.getElementById('txtNewPersonName').value;
            const type = document.getElementById('ddlNewPersonType').value;
            if (!name) return;

            const tableBody = document.querySelector('#tblPersons tbody');
            const badgeClass = type === 'SUSPECT' ? 'badge-suspect' : (type === 'POI' ? 'badge-poi' : 'badge-witness');

            const newRowHtml = `
                <tr class="person-row" data-name="${name.toLowerCase()}" data-type="${type}">
                    <td>
                        <div class="person-profile-cell">
                            <div style="width:40px; height:40px; border-radius:6px; background:#12283e; color:#00d2ff; display:flex; align-items:center; justify-content:center; font-weight:800;">${name.substring(0, 2).toUpperCase()}</div>
                            <div>
                                <div style="font-weight: 800; color: #fff;">${name}</div>
                                <div style="font-size: 0.68rem; color: #64748b;">DOB: Pending Verification</div>
                            </div>
                        </div>
                    </td>
                    <td style="font-weight: 700; color: #38bdf8;">PR-${Math.floor(100 + Math.random() * 900)}-NEW</td>
                    <td><span class="type-badge ${badgeClass}">${type}</span></td>
                    <td><span class="case-tag">#NEW-CASE</span></td>
                    <td>📍 Sector 4 Investigation</td>
                    <td style="font-size: 0.72rem; color: #64748b;">Just Now</td>
                    <td><a href="PersonProfile.aspx?id=new" class="btn-view-link">View →</a></td>
                </tr>`;

            tableBody.insertAdjacentHTML('afterbegin', newRowHtml);
            document.getElementById('txtNewPersonName').value = '';
            closeAddPersonModal();
        }
    </script>
</asp:Content>