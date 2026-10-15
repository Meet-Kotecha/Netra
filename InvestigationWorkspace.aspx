<%@ Page Title="Investigation Workspace" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InvestigationWorkspace.aspx.cs" Inherits="Netra.InvestigationWorkspace" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Breadcrumb Subhead */
        .workspace-breadcrumb {
            font-size: 0.72rem;
            font-weight: 700;
            letter-spacing: 0.8px;
            color: #64748b;
            text-transform: uppercase;
            margin-bottom: 6px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .workspace-breadcrumb span {
            color: #00d2ff;
        }

        /* Top Case Header Bar */
        .case-header-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        .case-title {
            font-size: 1.5rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 8px;
        }

        .case-meta-bar {
            display: flex;
            align-items: center;
            gap: 16px;
            font-size: 0.78rem;
            font-weight: 600;
        }

        .meta-active { color: #00d2ff; display: flex; align-items: center; gap: 5px; }
        .meta-district { color: #cbd5e1; }
        .meta-severity { color: #ef4444; }

        .case-header-actions {
            display: flex;
            gap: 12px;
        }

        .btn-action-outline {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            color: #cbd5e1;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-action-outline:hover {
            border-color: #00d2ff;
            color: #00d2ff;
        }

        .btn-action-cyan {
            background-color: #00d2ff;
            border: none;
            color: #070d18;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-action-cyan:hover {
            opacity: 0.9;
            box-shadow: 0 0 12px rgba(0, 210, 255, 0.4);
        }

        /* Workspace 3-Column Top Grid */
        .workspace-top-grid {
            display: grid;
            grid-template-columns: 1fr 1fr 310px;
            gap: 18px;
            margin-bottom: 18px;
        }

        @media (max-width: 1250px) {
            .workspace-top-grid {
                grid-template-columns: 1fr;
            }
        }

        .ws-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 16px 18px;
            height: 100%;
        }

        .ws-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.9rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 12px;
        }

        .ws-card-body {
            font-size: 0.78rem;
            color: #cbd5e1;
            line-height: 1.5;
        }

        .victim-row {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 14px;
        }

        .victim-avatar {
            width: 40px;
            height: 40px;
            border-radius: 6px;
            background-color: #12283e;
            border: 1px solid #1e293b;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #38bdf8;
            font-size: 1.1rem;
        }

        .victim-details {
            display: grid;
            grid-template-columns: 80px 1fr;
            gap: 8px;
            font-size: 0.75rem;
            margin-top: 8px;
        }

        .victim-label {
            color: #64748b;
            font-weight: 600;
        }

        .mini-map-container {
            width: 100%;
            height: 150px;
            background-color: #060b14;
            border: 1px solid #1e293b;
            border-radius: 6px;
            position: relative;
            overflow: hidden;
            background-image: 
                radial-gradient(circle at 60% 50%, rgba(0, 210, 255, 0.25) 0%, transparent 40%),
                linear-gradient(rgba(56, 189, 248, 0.12) 1px, transparent 1px),
                linear-gradient(90deg, rgba(56, 189, 248, 0.12) 1px, transparent 1px);
            background-size: 100% 100%, 20px 20px, 20px 20px;
        }

        .mini-map-pin {
            position: absolute;
            top: 50%;
            left: 60%;
            transform: translate(-50%, -50%);
            width: 10px;
            height: 10px;
            background-color: #00d2ff;
            border-radius: 50%;
            box-shadow: 0 0 12px #00d2ff, 0 0 20px #00d2ff;
        }

        .mo-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 14px 18px;
            margin-bottom: 18px;
        }

        .mo-tags-row {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 10px;
        }

        .mo-tag {
            background-color: #070d18;
            border: 1px solid #1e293b;
            color: #cbd5e1;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 0.72rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .workspace-mid-grid {
            display: grid;
            grid-template-columns: 1fr 310px;
            gap: 18px;
            margin-bottom: 18px;
        }

        @media (max-width: 1100px) {
            .workspace-mid-grid {
                grid-template-columns: 1fr;
            }
        }

        .notes-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 18px;
        }

        .note-item {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 12px 14px;
            margin-bottom: 12px;
            display: flex;
            gap: 12px;
        }

        .note-avatar {
            width: 30px;
            height: 30px;
            border-radius: 4px;
            background-color: #12283e;
            color: #38bdf8;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.7rem;
            font-weight: 800;
            flex-shrink: 0;
        }

        .note-content {
            flex-grow: 1;
        }

        .note-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 4px;
            font-size: 0.75rem;
        }

        .note-author {
            font-weight: 700;
            color: #ffffff;
        }

        .note-time {
            color: #64748b;
            font-size: 0.68rem;
        }

        .note-text {
            font-size: 0.75rem;
            color: #cbd5e1;
            line-height: 1.45;
            margin-bottom: 8px;
        }

        .note-tag {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            background-color: #12283e;
            color: #00d2ff;
            border: 1px solid rgba(0, 210, 255, 0.3);
            padding: 2px 8px;
            border-radius: 4px;
            font-size: 0.65rem;
            font-weight: 700;
        }

        .note-input-box {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 14px;
        }

        .note-input-box input {
            background: none;
            border: none;
            color: #f8fafc;
            font-size: 0.78rem;
            flex-grow: 1;
            outline: none;
        }

        .btn-send-note {
            background-color: #12283e;
            border: 1px solid #1e293b;
            color: #00d2ff;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.8rem;
            transition: all 0.2s ease;
        }

        .btn-send-note:hover {
            background-color: #00d2ff;
            color: #070d18;
        }

        .sidebar-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 16px;
            margin-bottom: 18px;
        }

        .person-item {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 10px 12px;
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 8px;
            cursor: pointer;
            transition: border-color 0.2s ease;
        }

        .person-item:hover {
            border-color: #00d2ff;
        }

        .person-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background-color: #1e293b;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #94a3b8;
            font-size: 0.85rem;
        }

        .person-name {
            font-size: 0.78rem;
            font-weight: 700;
            color: #ffffff;
        }

        .person-sub {
            font-size: 0.68rem;
            color: #64748b;
        }

        .timeline-list {
            padding-left: 10px;
            border-left: 2px solid #1e293b;
            margin-top: 10px;
        }

        .timeline-item {
            position: relative;
            padding-left: 16px;
            padding-bottom: 16px;
        }

        .timeline-item::before {
            content: '';
            position: absolute;
            left: -15px;
            top: 2px;
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background-color: #00d2ff;
            box-shadow: 0 0 8px #00d2ff;
        }

        .timeline-date {
            font-size: 0.65rem;
            color: #00d2ff;
            font-weight: 700;
        }

        .timeline-text {
            font-size: 0.72rem;
            color: #cbd5e1;
            font-weight: 600;
        }

        .evidence-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 18px;
        }

        .evidence-tabs {
            display: flex;
            gap: 20px;
            border-bottom: 1px solid #1a2536;
            margin-bottom: 16px;
            padding-bottom: 8px;
        }

        .evidence-tab {
            font-size: 0.8rem;
            font-weight: 700;
            color: #64748b;
            cursor: pointer;
        }

        .evidence-tab.active {
            color: #00d2ff;
            border-bottom: 2px solid #00d2ff;
            padding-bottom: 6px;
        }

        .evidence-grid {
            display: flex;
            gap: 16px;
            flex-wrap: wrap;
        }

        .evidence-thumb {
            width: 140px;
            height: 100px;
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            overflow: hidden;
            position: relative;
            cursor: pointer;
        }

        .evidence-thumb img {
            width: 100%;
            height: 80px;
            object-fit: cover;
        }

        .evidence-label {
            font-size: 0.62rem;
            font-weight: 700;
            color: #cbd5e1;
            padding: 4px 6px;
            background-color: #0b1320;
            text-align: center;
        }

        .evidence-add-card {
            width: 140px;
            height: 100px;
            border: 1px dashed #1e293b;
            border-radius: 6px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 6px;
            color: #64748b;
            font-size: 0.72rem;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .evidence-add-card:hover {
            border-color: #00d2ff;
            color: #00d2ff;
            background-color: #070d18;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Breadcrumb -->
    <div class="workspace-breadcrumb">
        CASE INVESTIGATION WORKSPACE • <span>CR-2026-1024</span>
    </div>

    <!-- Case Title Header -->
    <div class="case-header-row">
        <div>
            <div class="case-title">Vehicle Theft Investigation</div>
            <div class="case-meta-bar">
                <span class="meta-active">● Status: Active</span>
                <span class="meta-district">📍 District: Downtown</span>
                <span class="meta-severity">⚠️ Severity: High</span>
            </div>
        </div>
        <div class="case-header-actions">
            <button type="button" class="btn-action-outline" onclick="alert('📝 Investigation note draft opened.')">📝 Add Investigation Note</button>
            <button type="button" class="btn-action-cyan" onclick="alert('🔍 Running Neural Analysis on Case #CR-2026-1024...')">🔍 Analyze Case</button>
        </div>
    </div>

    <!-- Top Grid Section (Case Overview, Victim Info, Location Map) -->
    <div class="workspace-top-grid">
        <div class="ws-card">
            <div class="ws-card-header">
                <span>📋 Case Overview</span>
                <span style="color:#64748b; font-size:0.8rem; cursor:pointer;" title="Edit Case Overview">✏️</span>
            </div>
            <div class="ws-card-body">
                Organized vehicle theft ring suspected operating in the downtown commercial sector. Targets primarily high-end SUVs (2024+ models) utilizing signal relay attacks.<br/><br/>
                Initial incident reported at Grand Plaza parking structure. Security footage under analysis. Connection suspected with previous CR-2026-0892 pattern.
            </div>
        </div>

        <div class="ws-card">
            <div class="ws-card-header">
                <span>👤 Victim Information</span>
            </div>
            <div class="ws-card-body">
                <div class="victim-row">
                    <div class="victim-avatar">👤</div>
                    <div>
                        <div style="font-weight:800; color:#ffffff; font-size:0.85rem;">Jonathan Hayes</div>
                        <div style="font-size:0.7rem; color:#64748b;">Corp Exec, Synthetix Inc.</div>
                    </div>
                </div>
                <div class="victim-details">
                    <span class="victim-label">Contact:</span>
                    <span style="color:#e2e8f0;">+1 (555) 019-8372</span>
                    <span class="victim-label">Property:</span>
                    <span style="color:#e2e8f0;">2025 Obsidian QX-9</span>
                </div>
            </div>
        </div>

        <div class="ws-card">
            <div class="ws-card-header">
                <span>📍 Incident Location</span>
                <span style="font-size:0.65rem; color:#64748b;">Grand Plaza, Sector 4</span>
            </div>
            <div class="mini-map-container">
                <div class="mini-map-pin" title="Grand Plaza Parking Structure"></div>
            </div>
        </div>
    </div>

    <!-- Modus Operandi Tags -->
    <div class="mo-card">
        <div style="font-size:0.85rem; font-weight:700; color:#ffffff; display:flex; align-items:center; gap:8px;">
            ⚙️ Modus Operandi (M.O.)
        </div>
        <div class="mo-tags-row">
            <div class="mo-tag">📡 Signal Relay Attack</div>
            <div class="mo-tag">🌙 Night Operation (0200-0400)</div>
            <div class="mo-tag">🚘 High-End SUV Target</div>
            <div class="mo-tag">👥 Team of 2-3</div>
        </div>
    </div>

    <!-- Middle Grid Section (Notes & Persons/Timeline) -->
    <div class="workspace-mid-grid">
        <div class="notes-card">
            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:14px;">
                <div style="font-size:0.9rem; font-weight:700; color:#ffffff; display:flex; align-items:center; gap:8px;">
                    💬 Investigation Notes
                </div>
                <div style="font-size:0.7rem; color:#64748b;">
                    FILTER: <span style="color:#00d2ff; font-weight:700; cursor:pointer;">All Notes ▾</span>
                </div>
            </div>

            <div class="note-item">
                <div class="note-avatar">AS</div>
                <div class="note-content">
                    <div class="note-header">
                        <span class="note-author">Analyst Silva</span>
                        <span class="note-time">Today, 09:14 AM</span>
                    </div>
                    <div class="note-text">
                        Reviewed CCTV from Grand Plaza exit gate. Spotted a dark sedan following the stolen SUV closely. Plates obscured, likely cloned.
                    </div>
                    <div class="note-tag">📹 CCTV Log #442</div>
                </div>
            </div>

            <div class="note-item">
                <div class="note-avatar" style="background-color:#1e293b; color:#94a3b8;">SYS</div>
                <div class="note-content">
                    <div class="note-header">
                        <span class="note-author">Automated ALPR Alert</span>
                        <span class="note-time">Yesterday, 11:45 PM</span>
                    </div>
                    <div class="note-text">
                        Vehicle matching stolen description flagged on Interstate 94, heading South.
                    </div>
                </div>
            </div>

            <div class="note-input-box">
                <input type="text" id="txtNewNote" placeholder="Add a new note or update..." />
                <button type="button" class="btn-send-note" onclick="addNote()">➤</button>
            </div>
        </div>

        <div>
            <div class="sidebar-card">
                <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:12px;">
                    <span style="font-size:0.85rem; font-weight:700; color:#ffffff;">👥 Persons of Interest</span>
                    <span style="font-size:0.68rem; color:#00d2ff; font-weight:700;">2 Identified</span>
                </div>

                <div class="person-item" onclick="window.location.href='PersonsDirectory.aspx';">
                    <div class="person-avatar">🧔</div>
                    <div style="flex-grow:1;">
                        <div class="person-name">Marcus Vane</div>
                        <div class="person-sub">Alias: 'Router' - Known Modder</div>
                    </div>
                    <span style="color:#64748b;">›</span>
                </div>

                <div class="person-item">
                    <div class="person-avatar">❓</div>
                    <div style="flex-grow:1;">
                        <div class="person-name">Unidentified Subject</div>
                        <div class="person-sub">Spotted on CCTV cam #442</div>
                    </div>
                    <span style="color:#64748b;">›</span>
                </div>
            </div>

            <div class="sidebar-card">
                <div style="font-size:0.85rem; font-weight:700; color:#ffffff; margin-bottom:10px;">
                    📈 Timeline
                </div>

                <div class="timeline-list">
                    <div class="timeline-item">
                        <div class="timeline-date">Today, 08:30 AM</div>
                        <div class="timeline-text">Case Assigned to Unit</div>
                    </div>
                    <div class="timeline-item">
                        <div class="timeline-date">Yesterday, 11:45 PM</div>
                        <div class="timeline-text">ALPR Hit (I-94 Southbound)</div>
                    </div>
                    <div class="timeline-item">
                        <div class="timeline-date">Yesterday, 03:15 AM</div>
                        <div class="timeline-text">Incident Reported by Security</div>
                    </div>
                    <div class="timeline-item" style="padding-bottom:0;">
                        <div class="timeline-date" style="color:#f43f5e;">Yesterday, 02:45 AM</div>
                        <div class="timeline-text">Estimated Time of Theft</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bottom Evidence Gallery -->
    <div class="evidence-card">
        <div style="display:flex; justify-content:space-between; align-items:center;">
            <div class="evidence-tabs">
                <div class="evidence-tab active">Evidence Gallery</div>
                <div class="evidence-tab">Related Cases</div>
            </div>
            <button type="button" class="btn-action-outline" style="padding:4px 12px; font-size:0.7rem;" onclick="alert('📤 Evidence upload portal initialized.')">📤 UPLOAD</button>
        </div>

        <div class="evidence-grid">
            <div class="evidence-thumb" onclick="alert('Viewing CCTV Frame IMG_8842.jpg')">
                <img src="https://images.unsplash.com/photo-1508974239320-0a029497e820?w=300&auto=format&fit=crop&q=60" alt="CCTV Footage" />
                <div class="evidence-label">IMG_8842.jpg</div>
            </div>

            <div class="evidence-thumb" onclick="alert('Viewing Damage Report PANEL_DAMAGE.png')">
                <img src="https://images.unsplash.com/photo-1581092160607-ee22621dd758?w=300&auto=format&fit=crop&q=60" alt="Panel Damage" />
                <div class="evidence-label">PANEL_DAMAGE.png</div>
            </div>

            <div class="evidence-add-card" onclick="alert('Select local files to attach as evidence...')">
                <span style="font-size:1.2rem;">🖼️</span>
                <span>Add Evidence</span>
            </div>
        </div>
    </div>

    <!-- Interactive Note Script -->
    <script>
        function addNote() {
            const txt = document.getElementById("txtNewNote").value.trim();
            if (txt === "") return;

            alert("✅ Investigation note added successfully: " + txt);
            document.getElementById("txtNewNote").value = "";
        }
    </script>
</asp:Content>