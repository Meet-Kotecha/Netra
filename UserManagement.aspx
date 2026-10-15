<%@ Page Title="User Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="Netra.UserManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Header Bar */
        .page-header-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
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

        .btn-add-user {
            background-color: #38bdf8;
            border: none;
            color: #070d18;
            padding: 9px 18px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 800;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s ease;
        }

        .btn-add-user:hover {
            background-color: #00d2ff;
            box-shadow: 0 0 12px rgba(0, 210, 255, 0.4);
        }

        /* Search & Filter Controls Bar */
        .filter-controls-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 12px 16px;
            margin-bottom: 20px;
            display: grid;
            grid-template-columns: 1fr 140px 140px 140px;
            gap: 12px;
        }

        @media (max-width: 900px) {
            .filter-controls-card {
                grid-template-columns: 1fr;
            }
        }

        .search-input-wrap {
            position: relative;
        }

        .search-input-wrap input {
            width: 100%;
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 8px 12px 8px 32px;
            color: #ffffff;
            font-size: 0.78rem;
            outline: none;
        }

        .search-input-wrap input:focus {
            border-color: #38bdf8;
        }

        .search-icon-inside {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #64748b;
            font-size: 0.75rem;
        }

        .filter-select {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 8px 12px;
            color: #cbd5e1;
            font-size: 0.75rem;
            outline: none;
            cursor: pointer;
        }

        .filter-select:focus {
            border-color: #38bdf8;
        }

        /* User Table Panel */
        .table-container-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 20px;
        }

        .user-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.78rem;
        }

        .user-table th {
            text-align: left;
            padding: 12px 18px;
            background-color: #070d18;
            color: #64748b;
            font-weight: 800;
            font-size: 0.65rem;
            letter-spacing: 0.8px;
            text-transform: uppercase;
            border-bottom: 1px solid #1e293b;
        }

        .user-table td {
            padding: 14px 18px;
            border-bottom: 1px solid #162234;
            color: #cbd5e1;
            vertical-align: middle;
        }

        .user-table tr:hover {
            background-color: rgba(18, 40, 62, 0.4);
        }

        .user-info-cell {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .user-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background-color: #12283e;
            border: 1px solid #1e293b;
            color: #38bdf8;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.72rem;
            font-weight: 800;
            overflow: hidden;
        }

        .user-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .user-name {
            font-weight: 800;
            color: #ffffff;
            font-size: 0.82rem;
        }

        /* Role Badges */
        .role-badge-admin {
            background-color: rgba(6, 182, 212, 0.15);
            border: 1px solid rgba(6, 182, 212, 0.4);
            color: #38bdf8;
            font-size: 0.65rem;
            font-weight: 700;
            padding: 3px 8px;
            border-radius: 4px;
        }

        .role-badge-dark {
            background-color: #070d18;
            border: 1px solid #1e293b;
            color: #94a3b8;
            font-size: 0.65rem;
            font-weight: 700;
            padding: 3px 8px;
            border-radius: 4px;
        }

        /* Status Dot Indicator */
        .status-active {
            color: #38bdf8;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .status-suspended {
            color: #f87171;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        /* Pagination Footer */
        .table-footer-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 18px;
            background-color: #070d18;
            border-top: 1px solid #1e293b;
            font-size: 0.72rem;
            color: #64748b;
        }

        .pagination-wrap {
            display: flex;
            gap: 4px;
        }

        .page-btn {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            color: #64748b;
            width: 26px;
            height: 26px;
            border-radius: 4px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 0.72rem;
            font-weight: 700;
        }

        .page-btn.active {
            background-color: #12283e;
            border-color: #38bdf8;
            color: #38bdf8;
        }

        .page-btn:hover {
            color: #ffffff;
            border-color: #38bdf8;
        }

        /* Modal Overlay */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(7, 13, 24, 0.85);
            backdrop-filter: blur(4px);
            z-index: 999;
            align-items: center;
            justify-content: center;
        }

        .modal-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 10px;
            width: 480px;
            max-width: 90%;
            padding: 24px;
            box-shadow: 0 0 25px rgba(0, 0, 0, 0.7);
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
            border-bottom: 1px solid #1e293b;
            padding-bottom: 12px;
        }

        .modal-title {
            font-size: 1.1rem;
            font-weight: 800;
            color: #ffffff;
        }

        .btn-modal-close {
            background: none;
            border: none;
            color: #64748b;
            font-size: 1.2rem;
            cursor: pointer;
        }

        .btn-modal-close:hover {
            color: #ef4444;
        }

        .form-group {
            margin-bottom: 14px;
        }

        .form-label {
            display: block;
            font-size: 0.72rem;
            font-weight: 700;
            color: #94a3b8;
            margin-bottom: 6px;
            text-transform: uppercase;
        }

        .form-input, .form-select {
            width: 100%;
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 9px 12px;
            color: #ffffff;
            font-size: 0.8rem;
            outline: none;
        }

        .form-input:focus, .form-select:focus {
            border-color: #38bdf8;
        }

        .modal-actions {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            margin-top: 20px;
            border-top: 1px solid #1e293b;
            padding-top: 14px;
        }

        .btn-cancel {
            background-color: #070d18;
            border: 1px solid #1e293b;
            color: #cbd5e1;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 700;
            cursor: pointer;
        }

        .btn-create {
            background-color: #38bdf8;
            border: none;
            color: #070d18;
            padding: 8px 18px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 800;
            cursor: pointer;
        }

        .btn-create:hover {
            background-color: #00d2ff;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Top Header -->
    <div class="page-header-row">
        <div>
            <div class="page-title">User Management</div>
            <div class="page-sub-text">Manage platform access, assign roles, and monitor active intelligence personnel.</div>
        </div>
        <button type="button" class="btn-add-user" onclick="openAddUserModal()">
            👤+ Add User
        </button>
    </div>

    <!-- Filter & Search Controls Bar -->
    <div class="filter-controls-card">
        <div class="search-input-wrap">
            <span class="search-icon-inside">🔍</span>
            <input type="text" placeholder="Search by name or email..." />
        </div>
        <select class="filter-select">
            <option value="All">Role: All</option>
            <option value="Administrator">Administrator</option>
            <option value="Analyst">Analyst</option>
            <option value="Investigator">Investigator</option>
        </select>
        <select class="filter-select">
            <option value="All">Dept: All</option>
            <option value="Cyber Division">Cyber Division</option>
            <option value="Field Intelligence">Field Intelligence</option>
            <option value="Digital Forensics">Digital Forensics</option>
        </select>
        <select class="filter-select">
            <option value="All">Status: All</option>
            <option value="Active">Active</option>
            <option value="Suspended">Suspended</option>
        </select>
    </div>

    <!-- Personnel Data Table -->
    <div class="table-container-card">
        <table class="user-table" id="userTable">
            <thead>
                <tr>
                    <th style="width:220px;">USER</th>
                    <th style="width:200px;">EMAIL</th>
                    <th style="width:140px;">ROLE</th>
                    <th>DEPARTMENT</th>
                    <th style="width:120px;">STATUS</th>
                    <th style="width:140px;">LAST LOGIN</th>
                    <th style="width:80px; text-align:right;">ACTIONS</th>
                </tr>
            </thead>
            <tbody>
                <!-- Row 1: Marcus Vance -->
                <tr>
                    <td>
                        <div class="user-info-cell">
                            <div class="user-avatar">
                                <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&auto=format&fit=crop&q=60" alt="Marcus Vance" />
                            </div>
                            <span class="user-name">Marcus Vance</span>
                        </div>
                    </td>
                    <td style="color:#94a3b8; font-family:monospace;">m.vance@netra.gov</td>
                    <td><span class="role-badge-admin">Administrator</span></td>
                    <td>Cyber Division</td>
                    <td><span class="status-active">● Active</span></td>
                    <td style="color:#94a3b8;">2 mins ago</td>
                    <td style="text-align:right;">
                        <button type="button" style="background:none; border:none; color:#64748b; cursor:pointer;" onclick="alert('Managing Marcus Vance permissions...')">⚙️</button>
                    </td>
                </tr>

                <!-- Row 2: Sarah Chen -->
                <tr>
                    <td>
                        <div class="user-info-cell">
                            <div class="user-avatar">
                                <img src="https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=100&auto=format&fit=crop&q=60" alt="Sarah Chen" />
                            </div>
                            <span class="user-name">Sarah Chen</span>
                        </div>
                    </td>
                    <td style="color:#94a3b8; font-family:monospace;">s.chen@netra.gov</td>
                    <td><span class="role-badge-dark">Analyst</span></td>
                    <td>Field Intelligence</td>
                    <td><span class="status-active">● Active</span></td>
                    <td style="color:#94a3b8;">4 hrs ago</td>
                    <td style="text-align:right;">
                        <button type="button" style="background:none; border:none; color:#64748b; cursor:pointer;" onclick="alert('Managing Sarah Chen permissions...')">⚙️</button>
                    </td>
                </tr>

                <!-- Row 3: Jameson Reed -->
                <tr>
                    <td>
                        <div class="user-info-cell">
                            <div class="user-avatar" style="background-color:#070d18; color:#64748b;">JR</div>
                            <span class="user-name">Jameson Reed</span>
                        </div>
                    </td>
                    <td style="color:#94a3b8; font-family:monospace;">j.reed@netra.gov</td>
                    <td><span class="role-badge-dark">Investigator</span></td>
                    <td>Digital Forensics</td>
                    <td><span class="status-suspended">● Suspended</span></td>
                    <td style="color:#94a3b8;">Oct 12, 2023</td>
                    <td style="text-align:right;">
                        <button type="button" style="background:none; border:none; color:#64748b; cursor:pointer;" onclick="alert('Managing Jameson Reed permissions...')">⚙️</button>
                    </td>
                </tr>
            </tbody>
        </table>

        <!-- Footer Stats & Pagination -->
        <div class="table-footer-bar">
            <div>Showing 1 to 3 of 42 entries</div>
            <div class="pagination-wrap">
                <button type="button" class="page-btn">‹</button>
                <button type="button" class="page-btn active">1</button>
                <button type="button" class="page-btn">2</button>
                <button type="button" class="page-btn">3</button>
                <button type="button" class="page-btn">›</button>
            </div>
        </div>
    </div>

    <!-- Add User Modal -->
    <div class="modal-overlay" id="addUserModal">
        <div class="modal-card">
            <div class="modal-header">
                <div class="modal-title">👤 Add New Personnel User</div>
                <button type="button" class="btn-modal-close" onclick="closeAddUserModal()">✕</button>
            </div>

            <div class="form-group">
                <label class="form-label">Full Name</label>
                <input type="text" id="modalUserName" class="form-input" placeholder="e.g. Alex Mercer" />
            </div>

            <div class="form-group">
                <label class="form-label">Official Email</label>
                <input type="email" id="modalUserEmail" class="form-input" placeholder="a.mercer@netra.gov" />
            </div>

            <div class="form-group">
                <label class="form-label">Assigned Role</label>
                <select id="modalUserRole" class="form-select">
                    <option value="Administrator">Administrator</option>
                    <option value="Analyst">Analyst</option>
                    <option value="Investigator">Investigator</option>
                </select>
            </div>

            <div class="form-group">
                <label class="form-label">Department</label>
                <select id="modalUserDept" class="form-select">
                    <option value="Cyber Division">Cyber Division</option>
                    <option value="Field Intelligence">Field Intelligence</option>
                    <option value="Digital Forensics">Digital Forensics</option>
                    <option value="Tactical Operations">Tactical Operations</option>
                </select>
            </div>

            <div class="modal-actions">
                <button type="button" class="btn-cancel" onclick="closeAddUserModal()">Cancel</button>
                <button type="button" class="btn-create" onclick="submitNewUser()">Create Personnel Account ▶</button>
            </div>
        </div>
    </div>

    <script>
        function openAddUserModal() {
            document.getElementById("addUserModal").style.display = "flex";
        }

        function closeAddUserModal() {
            document.getElementById("addUserModal").style.display = "none";
        }

        function submitNewUser() {
            const name = document.getElementById("modalUserName").value.trim() || "New Officer";
            const email = document.getElementById("modalUserEmail").value.trim() || "officer@netra.gov";
            const role = document.getElementById("modalUserRole").value;
            const dept = document.getElementById("modalUserDept").value;

            const tbody = document.querySelector("#userTable tbody");
            const initials = name.split(" ").map(n => n[0]).join("").toUpperCase().substring(0, 2);

            const newRow = `
                <tr>
                    <td>
                        <div class="user-info-cell">
                            <div class="user-avatar" style="background-color:#12283e; color:#00d2ff;">${initials}</div>
                            <span class="user-name">${name}</span>
                        </div>
                    </td>
                    <td style="color:#94a3b8; font-family:monospace;">${email}</td>
                    <td><span class="${role === 'Administrator' ? 'role-badge-admin' : 'role-badge-dark'}">${role}</span></td>
                    <td>${dept}</td>
                    <td><span class="status-active">● Active</span></td>
                    <td style="color:#94a3b8;">Just now</td>
                    <td style="text-align:right;">
                        <button type="button" style="background:none; border:none; color:#64748b; cursor:pointer;" onclick="alert('Managing ${name} permissions...')">⚙️</button>
                    </td>
                </tr>`;

            tbody.insertAdjacentHTML('afterbegin', newRow);
            closeAddUserModal();
            alert("✅ Personnel account created for " + name);
        }
    </script>
</asp:Content>