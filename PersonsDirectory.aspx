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
            width: 450px;
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

    <div class="filter-bar">
        <input type="text" id="txtSearchQuery" class="filter-input" placeholder="🔍 Filter by Name, ID..." onkeyup="filterDirectoryTable()" />
        
        <select id="ddlPersonType" class="filter-select" onchange="filterDirectoryTable()">
            <option value="all">All Person Types</option>
            <option value="SUSPECT">Suspect</option>
            <option value="POI">POI</option>
        </select>

        <select id="ddlStatus" class="filter-select">
            <option value="all">All Statuses</option>
            <option value="active">Active Investigation</option>
        </select>
    </div>

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
                <!-- Digvijaysinh Vaghela -->
                <tr class="person-row" data-name="digvijaysinh vaghela" data-type="SUSPECT">
                    <td>
                        <div class="person-profile-cell">
                            <img src="Images/digvijaysinh.jpg" class="person-thumb" alt="Digvijaysinh Vaghela" onerror="this.src='Images/Meet.jpeg';" />
                            <div>
                                <div style="font-weight: 800; color: #fff;">Digvijaysinh Vaghela</div>
                                <div style="font-size: 0.68rem; color: #64748b;">DOB: 2002-09-14</div>
                            </div>
                        </div>
                    </td>
                    <td style="font-weight: 700; color: #38bdf8;">PR-883-902-11A</td>
                    <td><span class="type-badge badge-suspect">SUSPECT</span></td>
                    <td><span class="case-tag">#OP-2023-A9</span></td>
                    <td>📍 Dubai; Sector 4 Industrial District</td>
                    <td style="font-size: 0.72rem; color: #64748b;">2026-10-16 10:14Z</td>
                    <td><a href="PersonProfile.aspx?id=101" class="btn-view-link">View →</a></td>
                </tr>

                <!-- Rohan Siddhpura -->
                <tr class="person-row" data-name="rohan siddhpura" data-type="POI">
                    <td>
                        <div class="person-profile-cell">
                            <img src="Images/rohan.jpg" class="person-thumb" alt="Rohan Siddhpura" onerror="this.src='Images/Meet.jpeg';" />
                            <div>
                                <div style="font-weight: 800; color: #fff;">Rohan Siddhpura</div>
                                <div style="font-size: 0.68rem; color: #64748b;">DOB: 2001-03-22</div>
                            </div>
                        </div>
                    </td>
                    <td style="font-weight: 700; color: #38bdf8;">PR-UNK-442-998</td>
                    <td><span class="type-badge badge-poi">POI</span></td>
                    <td><span class="case-tag">#CS-2023-08A</span></td>
                    <td>📍 Germany; Transit Hub Alpha</td>
                    <td style="font-size: 0.72rem; color: #64748b;">2026-10-15 12:30Z</td>
                    <td><a href="PersonProfile.aspx?id=102" class="btn-view-link">View →</a></td>
                </tr>

                <!-- Meet Kotecha -->
                <tr class="person-row" data-name="meet kotecha" data-type="POI">
                    <td>
                        <div class="person-profile-cell">
                            <img src="Images/Meet.jpeg" class="person-thumb" alt="Meet Kotecha" />
                            <div>
                                <div style="font-weight: 800; color: #fff;">Meet Kotecha</div>
                                <div style="font-size: 0.68rem; color: #64748b;">DOB: 2003-11-05</div>
                            </div>
                        </div>
                    </td>
                    <td style="font-weight: 700; color: #38bdf8;">PR-990-112-44C</td>
                    <td><span class="type-badge badge-poi">POI</span></td>
                    <td><span class="case-tag">#NETRA-DEV-01</span></td>
                    <td>📍 India; Suburban Grid 2</td>
                    <td style="font-size: 0.72rem; color: #64748b;">2026-10-16 11:00Z</td>
                    <td><a href="PersonProfile.aspx?id=103" class="btn-view-link">View →</a></td>
                </tr>

                <!-- Keval Goswami -->
                <tr class="person-row" data-name="keval goswami" data-type="SUSPECT">
                    <td>
                        <div class="person-profile-cell">
                            <img src="Images/keval.jpg" class="person-thumb" alt="Keval Goswami" onerror="this.src='Images/Meet.jpeg';" />
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
            </tbody>
        </table>
    </div>

    <!-- Modal for Add Person -->
    <div id="modalAddPerson" class="modal-overlay">
        <div class="modal-box">
            <div style="font-size:1.1rem; font-weight:800; color:#fff; margin-bottom:14px;">➕ Add Person Record</div>
            
            <label style="font-size:0.68rem; font-weight:800; color:#64748b; text-transform:uppercase; display:block; margin-bottom:4px;">Full Name</label>
            <input type="text" id="txtNewName" class="filter-input" style="width:100%; margin-bottom:12px;" placeholder="e.g. Alex Mercer" />

            <label style="font-size:0.68rem; font-weight:800; color:#64748b; text-transform:uppercase; display:block; margin-bottom:4px;">Person Type</label>
            <select id="ddlType" class="filter-select" style="width:100%; margin-bottom:16px;">
                <option value="SUSPECT">Suspect</option>
                <option value="POI">POI</option>
            </select>

            <div style="display:flex; justify-content:flex-end; gap:10px;">
                <button type="button" style="background:#070d18; border:1px solid #1e293b; color:#cbd5e1; padding:8px 16px; border-radius:6px; cursor:pointer;" onclick="closeAddPersonModal()">Cancel</button>
                <button type="button" class="btn-cyan" onclick="saveNewPerson()">Save Entity</button>
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

        function saveNewPerson() {
            const name = document.getElementById('txtNewName').value;
            const type = document.getElementById('ddlType').value;
            if (!name) return;

            const table = document.querySelector('#tblPersons tbody');
            const newRow = `
                <tr class="person-row" data-name="${name.toLowerCase()}" data-type="${type}">
                    <td>
                        <div class="person-profile-cell">
                            <img src="Images/Meet.jpeg" class="person-thumb" />
                            <div>
                                <div style="font-weight: 800; color: #fff;">${name}</div>
                                <div style="font-size: 0.68rem; color: #64748b;">DOB: Pending</div>
                            </div>
                        </div>
                    </td>
                    <td style="font-weight: 700; color: #38bdf8;">PR-NEW-99</td>
                    <td><span class="type-badge ${type === 'SUSPECT' ? 'badge-suspect' : 'badge-poi'}">${type}</span></td>
                    <td><span class="case-tag">#NEW-01</span></td>
                    <td>📍 Sector Investigation</td>
                    <td style="font-size: 0.72rem; color: #64748b;">Just Now</td>
                    <td><a href="PersonProfile.aspx?id=new" class="btn-view-link">View →</a></td>
                </tr>`;

            table.insertAdjacentHTML('afterbegin', newRow);
            document.getElementById('txtNewName').value = '';
            closeAddPersonModal();
        }
    </script>
</asp:Content>