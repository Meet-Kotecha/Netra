<%@ Page Title="Security Settings" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SecuritySettings.aspx.cs" Inherits="Netra.SecuritySettings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
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

        /* Top 2-Column Split Layout */
        .security-top-grid {
            display: grid;
            grid-template-columns: 1fr 340px;
            gap: 20px;
            margin-bottom: 20px;
        }

        @media (max-width: 1024px) {
            .security-top-grid {
                grid-template-columns: 1fr;
            }
        }

        .glass-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 16px;
        }

        .glass-card:last-child {
            margin-bottom: 0;
        }

        .card-header-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 8px;
        }

        .card-title {
            font-size: 0.95rem;
            font-weight: 800;
            color: #ffffff;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .card-sub {
            font-size: 0.72rem;
            color: #64748b;
            margin-bottom: 12px;
        }

        .btn-outline {
            background-color: #070d18;
            border: 1px solid #1e293b;
            color: #cbd5e1;
            padding: 6px 14px;
            border-radius: 6px;
            font-size: 0.7rem;
            font-weight: 800;
            letter-spacing: 0.6px;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-outline:hover {
            border-color: #00d2ff;
            color: #00d2ff;
        }

        .badge-enabled-tag {
            background-color: rgba(6, 182, 212, 0.15);
            border: 1px solid rgba(6, 182, 212, 0.4);
            color: #38bdf8;
            font-size: 0.65rem;
            font-weight: 800;
            padding: 4px 10px;
            border-radius: 4px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        /* Toggle Switches */
        .toggle-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #162234;
        }

        .toggle-row:last-of-type {
            border-bottom: none;
        }

        .toggle-lbl {
            font-size: 0.78rem;
            font-weight: 700;
            color: #ffffff;
        }

        .toggle-sub {
            font-size: 0.68rem;
            color: #64748b;
            margin-top: 2px;
        }

        .switch {
            position: relative;
            display: inline-block;
            width: 38px;
            height: 20px;
        }

        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

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

        input:checked + .slider {
            background-color: #00d2ff;
        }

        input:checked + .slider:before {
            transform: translateX(18px);
            background-color: #070d18;
        }

        .form-select {
            width: 100%;
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 8px 12px;
            color: #cbd5e1;
            font-size: 0.75rem;
            outline: none;
            margin-top: 6px;
        }

        /* Danger Zone Box */
        .danger-card {
            background-color: rgba(239, 68, 68, 0.05);
            border: 1px solid rgba(239, 68, 68, 0.2);
            border-radius: 8px;
            padding: 16px;
            margin-top: 16px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .danger-title {
            font-size: 0.85rem;
            font-weight: 800;
            color: #f87171;
            display: flex;
            align-items: center;
            gap: 6px;
            margin-bottom: 4px;
        }

        .btn-danger {
            background-color: rgba(239, 68, 68, 0.15);
            border: 1px solid #ef4444;
            color: #f87171;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 0.7rem;
            font-weight: 800;
            letter-spacing: 0.6px;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-danger:hover {
            background-color: #ef4444;
            color: #ffffff;
        }

        /* Active Sessions Table Panel */
        .sessions-panel {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 18px;
            margin-bottom: 20px;
        }

        .sessions-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 14px;
        }

        .sessions-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.78rem;
        }

        .sessions-table th {
            text-align: left;
            padding: 10px 14px;
            background-color: #070d18;
            color: #64748b;
            font-weight: 800;
            font-size: 0.65rem;
            letter-spacing: 0.8px;
            text-transform: uppercase;
            border-bottom: 1px solid #1e293b;
        }

        .sessions-table td {
            padding: 12px 14px;
            border-bottom: 1px solid #162234;
            color: #cbd5e1;
            vertical-align: middle;
        }

        .badge-current-session {
            background-color: rgba(6, 182, 212, 0.15);
            border: 1px solid rgba(6, 182, 212, 0.4);
            color: #38bdf8;
            font-size: 0.62rem;
            font-weight: 800;
            padding: 2px 8px;
            border-radius: 4px;
        }

        .badge-active {
            background-color: rgba(16, 185, 129, 0.15);
            border: 1px solid rgba(16, 185, 129, 0.4);
            color: #34d399;
            font-size: 0.62rem;
            font-weight: 800;
            padding: 2px 8px;
            border-radius: 4px;
        }

        .disclaimer-footer {
            font-size: 0.72rem;
            color: #64748b;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Header -->
    <div class="page-header-row">
        <div class="page-title">Security Settings</div>
        <div class="page-sub-text">Manage your password, authentication and account security.</div>
    </div>

    <!-- Top 2-Column Grid -->
    <div class="security-top-grid">
        <!-- Left: Password & 2FA -->
        <div>
            <!-- Password Box -->
            <div class="glass-card">
                <div class="card-header-row">
                    <div>
                        <div class="card-title">*** Password & Authentication</div>
                        <div class="card-sub" style="margin-bottom:0; margin-top:4px;">Last password change: 45 days ago</div>
                    </div>
                    <button type="button" class="btn-outline" onclick="alert('Password reset link sent to your registered email.')">CHANGE PASSWORD</button>
                </div>
            </div>

            <!-- Two-Factor Authentication -->
            <div class="glass-card">
                <div class="card-header-row">
                    <div>
                        <div class="card-title">🛡️ Two-Factor Authentication</div>
                        <div class="card-sub" style="margin-top:6px; max-width:380px;">
                            Add an additional layer of security to your NETRA account. This requires a code from your authenticator app when signing in.
                        </div>
                    </div>
                    <button type="button" class="btn-outline" onclick="alert('Opening 2FA Management Portal...')">MANAGE 2FA</button>
                </div>

                <div style="margin-top:14px;">
                    <span class="badge-enabled-tag">● ENABLED</span>
                    <span style="font-size:0.72rem; color:#94a3b8; margin-left:10px;">📱 Method: Authenticator App</span>
                </div>
            </div>
        </div>

        <!-- Right: Login Security & Danger Zone -->
        <div>
            <div class="glass-card">
                <div class="card-title" style="margin-bottom:14px;">🛡️ Login Security</div>

                <div class="toggle-row">
                    <div>
                        <div class="toggle-lbl">Login Notifications</div>
                        <div class="toggle-sub">Alert on new device sign-ins</div>
                    </div>
                    <label class="switch">
                        <input type="checkbox" checked="checked" />
                        <span class="slider"></span>
                    </label>
                </div>

                <div class="toggle-row">
                    <div>
                        <div class="toggle-lbl">Suspicious Login Detection</div>
                        <div class="toggle-sub">AI-based anomaly detection</div>
                    </div>
                    <label class="switch">
                        <input type="checkbox" checked="checked" />
                        <span class="slider"></span>
                    </label>
                </div>

                <div class="toggle-row">
                    <div>
                        <div class="toggle-lbl">Failed Login Protection</div>
                        <div class="toggle-sub">Lock after 5 attempts</div>
                    </div>
                    <label class="switch">
                        <input type="checkbox" checked="checked" />
                        <span class="slider"></span>
                    </label>
                </div>

                <div style="margin-top:14px;">
                    <div style="font-size:0.65rem; font-weight:800; color:#64748b; text-transform:uppercase;">SESSION TIMEOUT</div>
                    <select class="form-select">
                        <option value="30">30 minutes</option>
                        <option value="15">15 minutes</option>
                        <option value="60">1 hour</option>
                    </select>
                </div>
            </div>

            <!-- Danger Zone -->
            <div class="danger-card">
                <div>
                    <div class="danger-title">⚠️ Danger Zone</div>
                    <div style="font-size:0.72rem; color:#ffffff; font-weight:700;">Sign Out From All Devices</div>
                    <div style="font-size:0.68rem; color:#64748b; margin-top:2px;">Instantly invalidate all active sessions across all platforms.</div>
                </div>
                <button type="button" class="btn-danger" onclick="alert('🚨 Signing out all active sessions...')">SIGN OUT ALL SESSIONS</button>
            </div>
        </div>
    </div>

    <!-- Active Sessions Table Panel -->
    <div class="sessions-panel">
        <div class="sessions-header">
            <div class="card-title">💻 Active Sessions</div>
            <a href="#" style="color:#00d2ff; font-size:0.72rem; font-weight:700; text-decoration:none;" onclick="alert('Displaying full session log history...'); return false;">View Full History</a>
        </div>

        <table class="sessions-table">
            <thead>
                <tr>
                    <th>DEVICE</th>
                    <th>LOCATION</th>
                    <th>IP ADDRESS</th>
                    <th>LAST ACTIVE</th>
                    <th>STATUS</th>
                    <th style="text-align:right;">ACTION</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <div style="display:flex; align-items:center; gap:8px; font-weight:700; color:#ffffff;">
                            <span>💻</span> Windows Desktop
                        </div>
                    </td>
                    <td>Bengaluru</td>
                    <td style="font-family:monospace; color:#94a3b8;">192.168.1.45</td>
                    <td>Active Now</td>
                    <td><span class="badge-current-session">● Current Session</span></td>
                    <td style="text-align:right; color:#64748b;">N/A</td>
                </tr>
                <tr>
                    <td>
                        <div style="display:flex; align-items:center; gap:8px; font-weight:700; color:#ffffff;">
                            <span>🌐</span> Chrome Browser
                        </div>
                    </td>
                    <td>Bengaluru</td>
                    <td style="font-family:monospace; color:#94a3b8;">192.168.1.102</td>
                    <td>2 hours ago</td>
                    <td><span class="badge-active">Active</span></td>
                    <td style="text-align:right;">
                        <button type="button" style="background:none; border:none; color:#f87171; font-size:0.72rem; font-weight:700; cursor:pointer;" onclick="alert('Session terminated.')">Sign Out</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- Disclaimer -->
    <div class="disclaimer-footer">
        <span>ℹ️ Never share your password, authentication codes or security credentials with other users.</span>
    </div>
</asp:Content>