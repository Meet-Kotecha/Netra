<%@ Page Title="Investigation Workspace" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InvestigationWorkspace.aspx.cs" Inherits="Netra.InvestigationWorkspace" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Leaflet GIS Map Support -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

    <style>
        .workspace-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .case-code-sub {
            font-size: 0.72rem;
            font-weight: 800;
            color: #38bdf8;
            letter-spacing: 0.8px;
            margin-bottom: 4px;
        }

        .case-title-main {
            font-size: 1.4rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 6px;
        }

        .case-meta-row {
            display: flex;
            gap: 16px;
            font-size: 0.75rem;
            color: #64748b;
        }

        .action-btns-group {
            display: flex;
            gap: 10px;
        }

        .btn-workspace-dark {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            color: #cbd5e1;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s ease;
        }

        .btn-workspace-dark:hover {
            border-color: #38bdf8;
            color: #38bdf8;
        }

        .btn-workspace-cyan {
            background-color: #00d2ff;
            color: #070d18;
            border: none;
            padding: 8px 18px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 800;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s ease;
        }

        .btn-workspace-cyan:hover {
            box-shadow: 0 0 12px rgba(0, 210, 255, 0.4);
        }

        /* Split Main Layout */
        .workspace-grid {
            display: grid;
            grid-template-columns: 1fr 340px;
            gap: 20px;
            margin-bottom: 20px;
        }

        .glass-panel {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 18px;
            margin-bottom: 20px;
        }

        .panel-header-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 14px;
        }

        .panel-title {
            font-size: 0.88rem;
            font-weight: 800;
            color: #ffffff;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .edit-icon-btn {
            background: none;
            border: none;
            color: #38bdf8;
            cursor: pointer;
            font-size: 0.85rem;
        }

        .edit-textarea {
            width: 100%;
            height: 90px;
            background-color: #070d18;
            border: 1px solid #00d2ff;
            color: #ffffff;
            padding: 10px;
            border-radius: 6px;
            font-size: 0.78rem;
            outline: none;
            margin-bottom: 8px;
        }

        /* Map Container */
        #locationMap {
            width: 100%;
            height: 170px;
            border-radius: 6px;
            border: 1px solid #1e293b;
        }

        /* Person Cards */
        .person-card-item {
            background-color: #070d18;
            border: 1px solid #162234;
            border-radius: 6px;
            padding: 12px;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .person-card-item:hover {
            border-color: #00d2ff;
            background-color: #0c182b;
            transform: translateX(3px);
        }

        /* Evidence Gallery Grid */
        .evidence-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(130px, 1fr));
            gap: 12px;
            margin-top: 14px;
        }

        .evidence-card {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 8px;
            text-align: center;
            position: relative;
        }

        .evidence-img {
            width: 100%;
            height: 90px;
            object-fit: cover;
            border-radius: 4px;
            margin-bottom: 6px;
        }

        .add-evidence-box {
            border: 2px dashed #1e293b;
            border-radius: 6px;
            height: 114px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            color: #64748b;
            font-size: 0.72rem;
            font-weight: 700;
            transition: all 0.2s ease;
        }

        .add-evidence-box:hover {
            border-color: #00d2ff;
            color: #00d2ff;
        }

        /* Modals */
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
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
            padding: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
        }

        .modal-title {
            font-size: 1rem;
            font-weight: 800;
            color: #fff;
            margin-bottom: 14px;
        }

        .modal-input {
            width: 100%;
            background-color: #070d18;
            border: 1px solid #1e293b;
            color: #fff;
            padding: 10px;
            border-radius: 6px;
            font-size: 0.8rem;
            margin-bottom: 14px;
            outline: none;
        }

        .person-detail-badge {
            background: rgba(0,210,255,0.15);
            color: #00d2ff;
            font-size: 0.68rem;
            font-weight: 800;
            padding: 4px 8px;
            border-radius: 4px;
            display: inline-block;
            margin-bottom: 10px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Workspace Top Header -->
    <div class="workspace-header">
        <div>
            <div class="case-code-sub">CASE INVESTIGATION WORKSPACE • CR-2026-1024</div>
            <div class="case-title-main">Vehicle Theft Investigation</div>
            <div class="case-meta-row">
                <span>Status: <strong style="color:#38bdf8;">Active</strong></span>
                <span>District: <strong style="color:#fff;">Downtown</strong></span>
                <span>Severity: <strong style="color:#f87171;">High</strong></span>
            </div>
        </div>

        <div class="action-btns-group">
            <button type="button" class="btn-workspace-dark" onclick="openNoteModal()">📝 Add Investigation Note</button>
            <button type="button" class="btn-workspace-cyan" onclick="runCaseAnalysis()">🔍 Analyze Case</button>
        </div>
    </div>

    <!-- AI Analysis Report Box -->
    <div id="aiAnalysisResult" style="display:none; background:#0b1320; border:1px solid #00d2ff; padding:16px; border-radius:8px; margin-bottom:20px;">
        <div style="font-size:0.85rem; font-weight:800; color:#00d2ff; margin-bottom:6px;">🤖 NEURAL INTELLIGENCE CASE ANALYSIS REPORT</div>
        <div style="font-size:0.75rem; color:#cbd5e1; line-height:1.5;">
            • High correlation (89.4%) with Organized SUV Theft Ring pattern operating in Sector 4.<br />
            • Primary M.O. identified: Signal Relay & Transponder Cloning between 02:00 - 04:00 AM.<br />
            • Recommended Action: Deploy ALPR alerts for Interstate 94 Southbound exits.
        </div>
    </div>

    <!-- Workspace Main Layout Grid -->
    <div class="workspace-grid">
        <div>
            <!-- Case Overview Section with Inline Edit Pencil -->
            <div class="glass-panel">
                <div class="panel-header-row">
                    <div class="panel-title">📋 Case Overview</div>
                    <button type="button" class="edit-icon-btn" onclick="toggleEditOverview()" title="Edit Case Overview">✏️</button>
                </div>

                <div id="viewOverviewText" style="font-size: 0.78rem; color: #cbd5e1; line-height: 1.5;">
                    Organized vehicle theft ring suspected operating in the downtown commercial sector. Targets primarily high-end SUVs (2024+ models) utilizing signal relay attacks.
                    <br /><br />
                    Initial incident reported at Grand Plaza parking structure. Security footage under analysis. Connection suspected with previous CR-2026-0892 pattern.
                </div>

                <div id="editOverviewBox" style="display:none;">
                    <textarea id="txtOverviewText" class="edit-textarea"></textarea>
                    <button type="button" class="btn-workspace-cyan" style="padding:4px 12px; font-size:0.72rem;" onclick="saveOverviewText()">Save Changes</button>
                </div>
            </div>

            <!-- Modus Operandi -->
            <div class="glass-panel">
                <div class="panel-title" style="margin-bottom:12px;">⚙️ Modus Operandi (M.O.)</div>
                <div style="display:flex; gap:10px; flex-wrap:wrap;">
                    <span style="background:#070d18; border:1px solid #1e293b; padding:6px 12px; border-radius:20px; font-size:0.72rem; color:#38bdf8;">▶ Signal Relay Attack</span>
                    <span style="background:#070d18; border:1px solid #1e293b; padding:6px 12px; border-radius:20px; font-size:0.72rem; color:#facc15;">🌙 Night Operation (0200-0400)</span>
                    <span style="background:#070d18; border:1px solid #1e293b; padding:6px 12px; border-radius:20px; font-size:0.72rem; color:#38bdf8;">🚘 High-End SUV Target</span>
                    <span style="background:#070d18; border:1px solid #1e293b; padding:6px 12px; border-radius:20px; font-size:0.72rem; color:#64748b;">👥 Team of 2-3</span>
                </div>
            </div>

            <!-- Investigation Notes -->
            <div class="glass-panel">
                <div class="panel-header-row">
                    <div class="panel-title">💬 Investigation Notes</div>
                    <select id="ddlFilterNotes" style="background:#070d18; border:1px solid #1e293b; color:#cbd5e1; padding:4px 8px; border-radius:4px; font-size:0.72rem;" onchange="filterNotes()">
                        <option value="all">FILTER: All Notes</option>
                        <option value="analyst">Analyst Notes Only</option>
                        <option value="sys">Automated System Logs</option>
                    </select>
                </div>

                <div id="notesContainer">
                    <div class="note-item note-type-analyst" style="background:#070d18; border:1px solid #162234; padding:12px; border-radius:6px; margin-bottom:10px;">
                        <div style="display:flex; justify-content:space-between; margin-bottom:6px;">
                            <span style="font-size:0.75rem; font-weight:800; color:#38bdf8;">Analyst Silva</span>
                            <span style="font-size:0.68rem; color:#64748b;">Today, 09:14 AM</span>
                        </div>
                        <div style="font-size:0.75rem; color:#cbd5e1;">Reviewed CCTV from Grand Plaza exit gate. Spotted a dark sedan following the stolen SUV closely. Plates obscured, likely cloned.</div>
                    </div>

                    <div class="note-item note-type-sys" style="background:#070d18; border:1px solid #162234; padding:12px; border-radius:6px; margin-bottom:10px;">
                        <div style="display:flex; justify-content:space-between; margin-bottom:6px;">
                            <span style="font-size:0.75rem; font-weight:800; color:#facc15;">Automated ALPR Alert</span>
                            <span style="font-size:0.68rem; color:#64748b;">Yesterday, 11:45 PM</span>
                        </div>
                        <div style="font-size:0.75rem; color:#cbd5e1;">Vehicle matching stolen description flagged on Interstate 94, heading South.</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Column Sidebar Panel -->
        <div>
            <!-- Victim Information -->
            <div class="glass-panel">
                <div class="panel-title" style="margin-bottom:12px;">👤 Victim Information</div>
                <div style="display:flex; align-items:center; gap:12px; margin-bottom:10px;">
                    <div style="width:36px; height:36px; border-radius:50%; background:#00d2ff; color:#070d18; font-weight:800; display:flex; align-items:center; justify-content:center;">JH</div>
                    <div>
                        <div style="font-size:0.82rem; font-weight:800; color:#fff;">Jonathan Hayes</div>
                        <div style="font-size:0.68rem; color:#64748b;">Corp Exec, Synthetix Inc.</div>
                    </div>
                </div>
                <div style="font-size:0.72rem; color:#94a3b8;">Contact: +1 (555) 019-8372</div>
                <div style="font-size:0.72rem; color:#94a3b8; margin-top:2px;">Property: 2025 Obsidian QX-9</div>
            </div>

            <!-- Incident Location Map -->
            <div class="glass-panel">
                <div class="panel-title" style="margin-bottom:10px;">📍 Incident Location</div>
                <div id="locationMap"></div>
            </div>

            <!-- Persons of Interest with Modal Quick-View -->
            <div class="glass-panel">
                <div class="panel-header-row">
                    <div class="panel-title">👥 Persons of Interest</div>
                    <span style="font-size:0.68rem; color:#38bdf8; font-weight:800;">2 Identified</span>
                </div>

                <div class="person-card-item" onclick="openPersonDetails('Marcus Vane', 'Router - Known Modder', 'Primary Suspect', 'Signal Relay Hardware Modding, Signal Interception')">
                    <div>
                        <div style="font-size:0.78rem; font-weight:800; color:#fff;">Marcus Vane</div>
                        <div style="font-size:0.68rem; color:#64748b;">Alias: Router - Known Modder</div>
                    </div>
                    <span style="color:#00d2ff;">👁️</span>
                </div>

                <div class="person-card-item" onclick="openPersonDetails('Unidentified Subject', 'Spotted on CCTV cam #442', 'Associate', 'Driver of dark sedan following stolen vehicle')">
                    <div>
                        <div style="font-size:0.78rem; font-weight:800; color:#fff;">Unidentified Subject</div>
                        <div style="font-size:0.68rem; color:#64748b;">Spotted on CCTV cam #442</div>
                    </div>
                    <span style="color:#00d2ff;">👁️</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Evidence Gallery Section -->
    <div class="glass-panel">
        <div class="panel-header-row">
            <div style="display:flex; gap:16px;">
                <span id="tabEvidence" class="panel-title" style="cursor:pointer; color:#00d2ff;" onclick="switchGalleryTab('evidence')">🖼️ Evidence Gallery</span>
                <span id="tabRelated" class="panel-title" style="cursor:pointer; color:#64748b;" onclick="switchGalleryTab('related')">🔗 Related Cases</span>
            </div>
            <button type="button" class="btn-workspace-cyan" onclick="openUploadModal()">📤 Upload Evidence</button>
        </div>

        <div id="galleryView" class="evidence-grid">
            <div class="evidence-card">
                <img src="Images/Meet.jpeg" class="evidence-img" alt="Evidence" />
                <div style="font-size:0.68rem; color:#38bdf8; font-weight:700;">IMG_8842.JPG</div>
            </div>

            <div id="boxAddEvidence" class="add-evidence-box" onclick="openUploadModal()">
                <span style="font-size:1.4rem;">🖼️</span>
                <span>Add Evidence</span>
            </div>
        </div>
    </div>

    <!-- Person Details Modal -->
    <div id="modalPerson" class="modal-overlay">
        <div class="modal-box">
            <div class="person-detail-badge" id="lblPersonRole">Primary Suspect</div>
            <div class="modal-title" id="lblPersonName">Marcus Vane</div>
            <div style="font-size:0.75rem; color:#64748b; margin-bottom:12px;" id="lblPersonAlias">Alias: Router</div>
            
            <div style="background:#070d18; border:1px solid #1e293b; border-radius:6px; padding:12px; font-size:0.75rem; color:#cbd5e1; margin-bottom:16px;" id="lblPersonNotes">
                Known modder specializing in vehicle transponder signal relay attacks.
            </div>

            <div style="display:flex; justify-content:space-between; gap:10px;">
                <button type="button" class="btn-workspace-dark" onclick="closePersonModal()">Close</button>
                <button type="button" class="btn-workspace-cyan" onclick="window.location.href='PersonsDirectory.aspx';">Open Full Directory →</button>
            </div>
        </div>
    </div>

    <!-- Modal 1: Add Note -->
    <div id="modalNote" class="modal-overlay">
        <div class="modal-box">
            <div class="modal-title">📝 Add Investigation Note</div>
            <textarea id="txtNewNote" class="modal-input" style="height:100px;" placeholder="Type your observation or CCTV finding..."></textarea>
            <div style="display:flex; justify-content:flex-end; gap:10px;">
                <button type="button" class="btn-workspace-dark" onclick="closeNoteModal()">Cancel</button>
                <button type="button" class="btn-workspace-cyan" onclick="submitNewNote()">Post Note</button>
            </div>
        </div>
    </div>

    <!-- Modal 2: Upload Evidence File -->
    <div id="modalUpload" class="modal-overlay">
        <div class="modal-box">
            <div class="modal-title">📤 Evidence Upload Portal</div>
            <asp:FileUpload ID="fileUploadEvidence" runat="server" CssClass="modal-input" />
            <div style="display:flex; justify-content:flex-end; gap:10px;">
                <button type="button" class="btn-workspace-dark" onclick="closeUploadModal()">Cancel</button>
                <button type="button" class="btn-workspace-cyan" onclick="uploadEvidenceLocal()">Upload Photo</button>
            </div>
        </div>
    </div>

    <script>
        function runCaseAnalysis() {
            document.getElementById('aiAnalysisResult').style.display = 'block';
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }

        function toggleEditOverview() {
            const currentText = document.getElementById('viewOverviewText').innerText;
            document.getElementById('txtOverviewText').value = currentText;
            document.getElementById('viewOverviewText').style.display = 'none';
            document.getElementById('editOverviewBox').style.display = 'block';
        }

        function saveOverviewText() {
            const updated = document.getElementById('txtOverviewText').value;
            document.getElementById('viewOverviewText').innerText = updated;
            document.getElementById('editOverviewBox').style.display = 'none';
            document.getElementById('viewOverviewText').style.display = 'block';
        }

        function filterNotes() {
            const filterVal = document.getElementById('ddlFilterNotes').value;
            const analystNotes = document.querySelectorAll('.note-type-analyst');
            const sysNotes = document.querySelectorAll('.note-type-sys');

            if (filterVal === 'analyst') {
                analystNotes.forEach(el => el.style.display = 'block');
                sysNotes.forEach(el => el.style.display = 'none');
            } else if (filterVal === 'sys') {
                analystNotes.forEach(el => el.style.display = 'none');
                sysNotes.forEach(el => el.style.display = 'block');
            } else {
                analystNotes.forEach(el => el.style.display = 'block');
                sysNotes.forEach(el => el.style.display = 'block');
            }
        }

        function openPersonDetails(name, alias, role, notes) {
            document.getElementById('lblPersonName').innerText = name;
            document.getElementById('lblPersonAlias').innerText = alias;
            document.getElementById('lblPersonRole').innerText = role;
            document.getElementById('lblPersonNotes').innerText = notes;
            document.getElementById('modalPerson').style.display = 'flex';
        }

        function closePersonModal() {
            document.getElementById('modalPerson').style.display = 'none';
        }

        function openNoteModal() { document.getElementById('modalNote').style.display = 'flex'; }
        function closeNoteModal() { document.getElementById('modalNote').style.display = 'none'; }

        function submitNewNote() {
            const noteContent = document.getElementById('txtNewNote').value;
            if (!noteContent) return;

            const container = document.getElementById('notesContainer');
            const newHtml = `
                <div class="note-item note-type-analyst" style="background:#070d18; border:1px solid #00d2ff; padding:12px; border-radius:6px; margin-bottom:10px;">
                    <div style="display:flex; justify-content:space-between; margin-bottom:6px;">
                        <span style="font-size:0.75rem; font-weight:800; color:#00d2ff;">Analyst (Meet Kotecha)</span>
                        <span style="font-size:0.68rem; color:#64748b;">Just Now</span>
                    </div>
                    <div style="font-size:0.75rem; color:#cbd5e1;">${noteContent}</div>
                </div>`;
            container.insertAdjacentHTML('afterbegin', newHtml);
            document.getElementById('txtNewNote').value = '';
            closeNoteModal();
        }

        function openUploadModal() { document.getElementById('modalUpload').style.display = 'flex'; }
        function closeUploadModal() { document.getElementById('modalUpload').style.display = 'none'; }

        function uploadEvidenceLocal() {
            const newCard = `
                <div class="evidence-card">
                    <img src="Images/Meet.jpeg" class="evidence-img" alt="Uploaded Evidence" />
                    <div style="font-size:0.68rem; color:#38bdf8; font-weight:700;">EVID_NEW_FILE.JPG</div>
                </div>`;
            document.getElementById('boxAddEvidence').insertAdjacentHTML('beforebegin', newCard);
            closeUploadModal();
        }

        function switchGalleryTab(tabName) {
            if (tabName === 'related') {
                document.getElementById('tabEvidence').style.color = '#64748b';
                document.getElementById('tabRelated').style.color = '#00d2ff';
            } else {
                document.getElementById('tabEvidence').style.color = '#00d2ff';
                document.getElementById('tabRelated').style.color = '#64748b';
            }
        }

        window.addEventListener('DOMContentLoaded', () => {
            // Standard CartoDB Dark Tiles
            const map = L.map('locationMap', { zoomControl: false }).setView([12.9716, 77.5946], 13);
            L.tileLayer('https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png', { maxZoom: 19 }).addTo(map);
            L.circleMarker([12.9716, 77.5946], { color: '#00d2ff', radius: 8, fillOpacity: 0.8 }).addTo(map);
        });
    </script>
</asp:Content>