<%@ Page Title="Notification Settings" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NotificationSettings.aspx.cs" Inherits="Netra.NotificationSettings" %>

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
        .notification-grid {
            display: grid;
            grid-template-columns: 1fr 340px;
            gap: 20px;
            margin-bottom: 20px;
        }

        @media (max-width: 1024px) {
            .notification-grid {
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

        .glass-card:last-child {
            margin-bottom: 0;
        }

        .card-title {
            font-size: 0.95rem;
            font-weight: 800;
            color: #ffffff;
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 14px;
        }

        /* Toggle Switches */
        .toggle-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #162234;
        }

        .toggle-row:last-child {
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
            background-color: #38bdf8;
        }

        input:checked + .slider:before {
            transform: translateX(18px);
            background-color: #070d18;
        }

        /* Primary Cyan Save Button */
        .btn-save-cyan {
            width: 100%;
            background-color: #38bdf8;
            border: none;
            color: #070d18;
            padding: 9px 16px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 800;
            cursor: pointer;
            margin-top: 14px;
            transition: all 0.2s ease;
        }

        .btn-save-cyan:hover {
            background-color: #00d2ff;
            box-shadow: 0 0 12px rgba(0, 210, 255, 0.4);
        }

        /* Radio Group */
        .radio-option-row {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 8px 0;
            font-size: 0.78rem;
            color: #cbd5e1;
            font-weight: 600;
        }

        .radio-option-row input[type="radio"] {
            accent-color: #38bdf8;
            cursor: pointer;
        }

        /* Notification Preview List Cards */
        .preview-item-card {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 12px;
            margin-bottom: 10px;
        }

        .preview-item-card:last-child {
            margin-bottom: 0;
        }

        .preview-header {
            font-size: 0.75rem;
            font-weight: 700;
            color: #ffffff;
            display: flex;
            align-items: flex-start;
            gap: 8px;
            margin-bottom: 4px;
        }

        .dot-red {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background-color: #ef4444;
            display: inline-block;
            margin-top: 4px;
            flex-shrink: 0;
        }

        .dot-cyan {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background-color: #38bdf8;
            display: inline-block;
            margin-top: 4px;
            flex-shrink: 0;
        }

        .dot-grey {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background-color: #64748b;
            display: inline-block;
            margin-top: 4px;
            flex-shrink: 0;
        }

        .preview-meta {
            font-size: 0.68rem;
            color: #64748b;
            padding-left: 14px;
        }

        .btn-view-all {
            width: 100%;
            background-color: #070d18;
            border: 1px solid #1e293b;
            color: #cbd5e1;
            padding: 8px;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 700;
            cursor: pointer;
            margin-top: 14px;
            transition: all 0.2s ease;
        }

        .btn-view-all:hover {
            border-color: #38bdf8;
            color: #38bdf8;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Header -->
    <div class="page-header-row">
        <div class="page-title">Notification Settings</div>
        <div class="page-sub-text">Choose which alerts and system notifications you want to receive.</div>
    </div>

    <!-- Main Split Grid -->
    <div class="notification-grid">
        <!-- Left Column: Preference Categories -->
        <div>
            <!-- Crime Intelligence Alerts -->
            <div class="glass-card">
                <div class="card-title">⚠️ Crime Intelligence Alerts</div>

                <div class="toggle-row">
                    <div>
                        <div class="toggle-lbl">High-Risk Area Detected</div>
                        <div class="toggle-sub">Alert when a new high-risk zone is established.</div>
                    </div>
                    <label class="switch">
                        <input type="checkbox" checked="checked" />
                        <span class="slider"></span>
                    </label>
                </div>

                <div class="toggle-row">
                    <div>
                        <div class="toggle-lbl">Unusual Crime Activity</div>
                        <div class="toggle-sub">Spikes in specific crime types in a given sector.</div>
                    </div>
                    <label class="switch">
                        <input type="checkbox" checked="checked" />
                        <span class="slider"></span>
                    </label>
                </div>

                <div class="toggle-row">
                    <div>
                        <div class="toggle-lbl">Crime Pattern Detected</div>
                        <div class="toggle-sub">AI has linked multiple cases to a potential pattern.</div>
                    </div>
                    <label class="switch">
                        <input type="checkbox" />
                        <span class="slider"></span>
                    </label>
                </div>

                <div class="toggle-row">
                    <div>
                        <div class="toggle-lbl">Recurring Crime Pattern</div>
                        <div class="toggle-sub">Known patterns re-emerging in active cases.</div>
                    </div>
                    <label class="switch">
                        <input type="checkbox" checked="checked" />
                        <span class="slider"></span>
                    </label>
                </div>

                <div class="toggle-row">
                    <div>
                        <div class="toggle-lbl">New Related Case</div>
                        <div class="toggle-sub">A new case is linked to your active investigations.</div>
                    </div>
                    <label class="switch">
                        <input type="checkbox" checked="checked" />
                        <span class="slider"></span>
                    </label>
                </div>
            </div>

            <!-- Investigation Notifications -->
            <div class="glass-card">
                <div class="card-title">🔍 Investigation Notifications</div>

                <div class="toggle-row">
                    <div>
                        <div class="toggle-lbl">Case Assigned</div>
                        <div class="toggle-sub">You are assigned as primary or support on a case.</div>
                    </div>
                    <label class="switch">
                        <input type="checkbox" checked="checked" />
                        <span class="slider"></span>
                    </label>
                </div>

                <div class="toggle-row">
                    <div>
                        <div class="toggle-lbl">Case Updated</div>
                        <div class="toggle-sub">Status changes or major edits to your cases.</div>
                    </div>
                    <label class="switch">
                        <input type="checkbox" checked="checked" />
                        <span class="slider"></span>
                    </label>
                </div>

                <div class="toggle-row">
                    <div>
                        <div class="toggle-lbl">Investigation Note Added</div>
                        <div class="toggle-sub">Colleagues add notes to your assigned cases.</div>
                    </div>
                    <label class="switch">
                        <input type="checkbox" />
                        <span class="slider"></span>
                    </label>
                </div>

                <div class="toggle-row">
                    <div>
                        <div class="toggle-lbl">Person/Case Relationship Detected</div>
                        <div class="toggle-sub">AI uncovers new links between subjects and cases.</div>
                    </div>
                    <label class="switch">
                        <input type="checkbox" checked="checked" />
                        <span class="slider"></span>
                    </label>
                </div>

                <div class="toggle-row">
                    <div>
                        <div class="toggle-lbl">Image Search Completed</div>
                        <div class="toggle-sub">Bulk image analysis jobs have finished processing.</div>
                    </div>
                    <label class="switch">
                        <input type="checkbox" />
                        <span class="slider"></span>
                    </label>
                </div>

                <div class="toggle-row">
                    <div>
                        <div class="toggle-lbl">Report Generated</div>
                        <div class="toggle-sub">Scheduled or manual reports are ready to view.</div>
                    </div>
                    <label class="switch">
                        <input type="checkbox" checked="checked" />
                        <span class="slider"></span>
                    </label>
                </div>
            </div>

            <!-- System Notifications -->
            <div class="glass-card">
                <div class="card-title">💻 System Notifications</div>

                <div class="toggle-row">
                    <div>
                        <div class="toggle-lbl">System Maintenance</div>
                        <div class="toggle-sub">Upcoming downtime or scheduled updates.</div>
                    </div>
                    <label class="switch">
                        <input type="checkbox" checked="checked" />
                        <span class="slider"></span>
                    </label>
                </div>

                <div class="toggle-row">
                    <div>
                        <div class="toggle-lbl">Security Notifications</div>
                        <div class="toggle-sub">Alerts regarding potential unauthorized access.</div>
                    </div>
                    <label class="switch">
                        <input type="checkbox" checked="checked" />
                        <span class="slider"></span>
                    </label>
                </div>

                <div class="toggle-row">
                    <div>
                        <div class="toggle-lbl">Data Import Completed</div>
                        <div class="toggle-sub">Confirmation of successful bulk data ingestion.</div>
                    </div>
                    <label class="switch">
                        <input type="checkbox" checked="checked" />
                        <span class="slider"></span>
                    </label>
                </div>

                <div class="toggle-row">
                    <div>
                        <div class="toggle-lbl">Data Import Failed</div>
                        <div class="toggle-sub">Errors during bulk data ingestion processes.</div>
                    </div>
                    <label class="switch">
                        <input type="checkbox" checked="checked" />
                        <span class="slider"></span>
                    </label>
                </div>

                <div class="toggle-row">
                    <div>
                        <div class="toggle-lbl">Account Activity</div>
                        <div class="toggle-sub">New logins or changes to your account settings.</div>
                    </div>
                    <label class="switch">
                        <input type="checkbox" />
                        <span class="slider"></span>
                    </label>
                </div>
            </div>
        </div>

        <!-- Right Column: Delivery Channels, Email Frequency & Recent Preview -->
        <div>
            <!-- Delivery Channels -->
            <div class="glass-card">
                <div class="card-title">✈️ Delivery Channels</div>

                <div class="toggle-row">
                    <div class="toggle-lbl">💻 In-App</div>
                    <label class="switch">
                        <input type="checkbox" checked="checked" />
                        <span class="slider"></span>
                    </label>
                </div>

                <div class="toggle-row">
                    <div>
                        <div class="toggle-lbl">✉️ Email</div>
                        <div class="toggle-sub">analyst@netra.gov</div>
                    </div>
                    <label class="switch">
                        <input type="checkbox" checked="checked" />
                        <span class="slider"></span>
                    </label>
                </div>

                <div class="toggle-row">
                    <div class="toggle-lbl">🖥️ Desktop (OS)</div>
                    <label class="switch">
                        <input type="checkbox" />
                        <span class="slider"></span>
                    </label>
                </div>

                <button type="button" class="btn-save-cyan" onclick="alert('✅ Notification preferences saved.')">Save Notification Preferences</button>
            </div>

            <!-- Email Frequency -->
            <div class="glass-card">
                <div class="card-title">🕒 Email Frequency</div>

                <div class="radio-option-row">
                    <input type="radio" id="freqImmediately" name="emailFreq" checked="checked" />
                    <label for="freqImmediately">Immediately</label>
                </div>

                <div class="radio-option-row">
                    <input type="radio" id="freqDaily" name="emailFreq" />
                    <label for="freqDaily">Daily Summary</label>
                </div>

                <div class="radio-option-row">
                    <input type="radio" id="freqWeekly" name="emailFreq" />
                    <label for="freqWeekly">Weekly Summary</label>
                </div>
            </div>

            <!-- Recent Preview -->
            <div class="glass-card">
                <div class="card-title">⏱️ Recent Preview</div>

                <div class="preview-item-card">
                    <div class="preview-header">
                        <span class="dot-red"></span>
                        <span>Unusual increase in vehicle theft detected</span>
                    </div>
                    <div class="preview-meta">Sector 4, Downtown • 2 mins ago</div>
                </div>

                <div class="preview-item-card">
                    <div class="preview-header">
                        <span class="dot-cyan"></span>
                        <span>Case #892-A Updated</span>
                    </div>
                    <div class="preview-meta">Status changed to 'Active Investigation' • 1 hr ago</div>
                </div>

                <div class="preview-item-card">
                    <div class="preview-header">
                        <span class="dot-grey"></span>
                        <span>System Maintenance Scheduled</span>
                    </div>
                    <div class="preview-meta">Servers will restart at 0300 HRS • 5 hrs ago</div>
                </div>

                <button type="button" class="btn-view-all" onclick="window.location.href='Alerts.aspx';">View All Notifications</button>
            </div>
        </div>
    </div>
</asp:Content>