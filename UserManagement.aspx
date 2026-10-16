<%@ Page Title="User Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="Netra.UserManagement" %>

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
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-cyan:hover {
            box-shadow: 0 0 12px rgba(0, 210, 255, 0.4);
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
        }

        .filter-bar-container {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 14px 18px;
            margin-bottom: 20px;
            display: grid;
            grid-template-columns: 1fr 140px 140px 140px;
            gap: 12px;
            align-items: center;
        }

        .search-input {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 9px 14px;
            color: #ffffff;
            font-size: 0.8rem;
            outline: none;
            width: 100%;
        }

        .filter-select {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 9px 12px;
            color: #ffffff;
            font-size: 0.78rem;
            outline: none;
            cursor: pointer;
        }

        .glass-panel {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 20px;
        }

        .user-table {
            width: 100%;
            border-collapse: collapse;
        }

        .user-table th {
            background-color: #070d18;
            padding: 12px 14px;
            font-size: 0.65rem;
            font-weight: 800;
            color: #64748b;
            text-transform: uppercase;
            text-align: left;
            border-bottom: 1px solid #1e293b;
        }

        .user-table td {
            padding: 14px;
            font-size: 0.78rem;
            color: #cbd5e1;
            border-bottom: 1px solid #1e293b;
            vertical-align: middle;
        }

        .user-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background-color: #00d2ff;
            color: #070d18;
            font-weight: 800;
            font-size: 0.75rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .badge-role {
            background: rgba(0, 210, 255, 0.15);
            color: #00d2ff;
            border: 1px solid rgba(0, 210, 255, 0.3);
            font-size: 0.65rem;
            font-weight: 800;
            padding: 3px 8px;
            border-radius: 4px;
        }

        .badge-status-active {
            color: #10b981;
            font-weight: 700;
            font-size: 0.75rem;
        }

        /* Modal Overlay */
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
            width: 440px;
            padding: 22px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        }

        .modal-label {
            font-size: 0.65rem;
            font-weight: 800;
            color: #64748b;
            text-transform: uppercase;
            margin-bottom: 4px;
            display: block;
        }

        .modal-input {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 8px 12px;
            color: #ffffff;
            font-size: 0.8rem;
            width: 100%;
            margin-bottom: 12px;
            outline: none;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header-row">
        <div>
            <div class="page-title">User Management</div>
            <div style="font-size:0.75rem; color:#64748b; margin-top:4px;">Manage platform access, assign roles, and monitor active intelligence personnel.</div>
        </div>

        <button type="button" class="btn-cyan" onclick="openAddUserModal()">👤+ Add User</button>
    </div>

    <!-- SEARCH AND FILTERS -->
    <div class="filter-bar-container">
        <input type="text" id="txtSearchUser" class="search-input" placeholder="🔍 Search by name or email..." onkeyup="filterUserList()" />

        <select id="ddlRole" class="filter-select" onchange="filterUserList()">
            <option value="ALL">Role: All</option>
            <option value="Administrator">Administrator</option>
            <option value="Analyst">Analyst</option>
            <option value="Investigator">Investigator</option>
        </select>

        <select id="ddlDept" class="filter-select" onchange="filterUserList()">
            <option value="ALL">Dept: All</option>
            <option value="Neural Unit">Neural Unit</option>
            <option value="Cyber Division">Cyber Division</option>
        </select>

        <select id="ddlStatus" class="filter-select" onchange="filterUserList()">
            <option value="ALL">Status: All</option>
            <option value="Active">Active</option>
            <option value="Suspended">Suspended</option>
        </select>
    </div>

    <!-- USER LIST PANEL -->
    <div class="glass-panel">
        <table class="user-table" id="tblUsers">
            <thead>
                <tr>
                    <th>USER</th>
                    <th>EMAIL</th>
                    <th>ROLE</th>
                    <th>DEPARTMENT</th>
                    <th>STATUS</th>
                    <th>LAST LOGIN</th>
                    <th style="text-align:right;">ACTIONS</th>
                </tr>
            </thead>
            <tbody id="userTableBody">
                <tr class="user-row" data-role="Administrator" data-dept="Neural Unit" data-status="Active">
                    <td>
                        <div style="display:flex; align-items:center; gap:10px;">
                            <div class="user-avatar">MK</div>
                            <span style="font-weight:800; color:#fff;" class="usr-name">Meet Kotecha</span>
                        </div>
                    </td>
                    <td class="usr-email" style="color:#00d2ff; font-weight:700;">meet8kotecha@gmail.com</td>
                    <td><span class="badge-role">Administrator</span></td>
                    <td>Neural Unit</td>
                    <td><span class="badge-status-active">• Active</span></td>
                    <td style="color:#64748b;">Just Now</td>
                    <td style="text-align:right;">
                        <button type="button" style="background:none; border:none; color:#64748b; cursor:pointer;" onclick="alert('User Settings for Meet Kotecha')">⚙️</button>
                    </td>
                </tr>
            </tbody>
        </table>

        <div style="display:flex; justify-style:space-between; justify-content:space-between; align-items:center; margin-top:16px; font-size:0.72rem; color:#64748b;">
            <div id="lblEntryCount">Showing 1 to 1 of 1 entries</div>
            <div style="display:flex; gap:4px;">
                <button type="button" class="btn-outline" style="padding:4px 8px; font-size:0.7rem;" disabled>‹</button>
                <button type="button" class="btn-cyan" style="padding:4px 8px; font-size:0.7rem;">1</button>
                <button type="button" class="btn-outline" style="padding:4px 8px; font-size:0.7rem;" disabled>›</button>
            </div>
        </div>
    </div>

    <!-- Add User Modal -->
    <div id="modalAddUser" class="modal-overlay">
        <div class="modal-box">
            <div style="font-size:1rem; font-weight:800; color:#fff; margin-bottom:16px;">👤 Add Personnel User</div>

            <label class="modal-label">Full Name</label>
            <input type="text" id="newUserName" class="modal-input" placeholder="e.g. Rohan Siddhpura" />

            <label class="modal-label">Email Address</label>
            <input type="email" id="newUserEmail" class="modal-input" placeholder="e.g. rohan@netra.gov" />

            <label class="modal-label">Role</label>
            <select id="newUserRole" class="modal-input">
                <option value="Analyst">Analyst</option>
                <option value="Investigator">Investigator</option>
                <option value="Administrator">Administrator</option>
            </select>

            <label class="modal-label">Department</label>
            <select id="newUserDept" class="modal-input">
                <option value="Field Intelligence">Field Intelligence</option>
                <option value="Cyber Division">Cyber Division</option>
                <option value="Digital Forensics">Digital Forensics</option>
            </select>

            <div style="display:flex; justify-content:flex-end; gap:10px; margin-top:10px;">
                <button type="button" class="btn-outline" onclick="closeAddUserModal()">Cancel</button>
                <button type="button" class="btn-cyan" onclick="saveNewUser()">Create Account</button>
            </div>
        </div>
    </div>

    <script>
        function openAddUserModal() {
            document.getElementById('modalAddUser').style.display = 'flex';
        }

        function closeAddUserModal() {
            document.getElementById('modalAddUser').style.display = 'none';
        }

        function saveNewUser() {
            const name = document.getElementById('newUserName').value.trim();
            const email = document.getElementById('newUserEmail').value.trim();
            const role = document.getElementById('newUserRole').value;
            const dept = document.getElementById('newUserDept').value;

            if (!name || !email) {
                alert('Please enter both name and email.');
                return;
            }

            const initials = name.split(' ').map(n => n[0]).join('').toUpperCase().substring(0, 2);

            const tbody = document.getElementById('userTableBody');
            const tr = document.createElement('tr');
            tr.className = 'user-row';
            tr.setAttribute('data-role', role);
            tr.setAttribute('data-dept', dept);
            tr.setAttribute('data-status', 'Active');

            tr.innerHTML = `
                <td>
                    <div style="display:flex; align-items:center; gap:10px;">
                        <div class="user-avatar">${initials}</div>
                        <span style="font-weight:800; color:#fff;" class="usr-name">${name}</span>
                    </div>
                </td>
                <td class="usr-email" style="color:#00d2ff; font-weight:700;">${email}</td>
                <td><span class="badge-role">${role}</span></td>
                <td>${dept}</td>
                <td><span class="badge-status-active">• Active</span></td>
                <td style="color:#64748b;">Just Now</td>
                <td style="text-align:right;">
                    <button type="button" style="background:none; border:none; color:#64748b; cursor:pointer;" onclick="alert('User Settings for ${name}')">⚙️</button>
                </td>
            `;

            tbody.appendChild(tr);
            closeAddUserModal();

            // Reset inputs
            document.getElementById('newUserName').value = '';
            document.getElementById('newUserEmail').value = '';

            updateCount();
        }

        function filterUserList() {
            const searchVal = document.getElementById('txtSearchUser').value.toLowerCase();
            const selectedRole = document.getElementById('ddlRole').value;
            const selectedDept = document.getElementById('ddlDept').value;
            const selectedStatus = document.getElementById('ddlStatus').value;

            const rows = document.querySelectorAll('.user-row');
            let visibleCount = 0;

            rows.forEach(row => {
                const name = row.querySelector('.usr-name').innerText.toLowerCase();
                const email = row.querySelector('.usr-email').innerText.toLowerCase();
                const role = row.getAttribute('data-role');
                const dept = row.getAttribute('data-dept');
                const status = row.getAttribute('data-status');

                const matchesSearch = name.includes(searchVal) || email.includes(searchVal);
                const matchesRole = (selectedRole === 'ALL' || role === selectedRole);
                const matchesDept = (selectedDept === 'ALL' || dept === selectedDept);
                const matchesStatus = (selectedStatus === 'ALL' || status === selectedStatus);

                if (matchesSearch && matchesRole && matchesDept && matchesStatus) {
                    row.style.display = '';
                    visibleCount++;
                } else {
                    row.style.display = 'none';
                }
            });

            document.getElementById('lblEntryCount').innerText = `Showing 1 to ${visibleCount} of ${visibleCount} entries`;
        }

        function updateCount() {
            const visibleCount = document.querySelectorAll('.user-row').length;
            document.getElementById('lblEntryCount').innerText = `Showing 1 to ${visibleCount} of ${visibleCount} entries`;
        }
    </script>
</asp:Content>