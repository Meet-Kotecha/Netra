<%@ Page Title="Bulk Crime Data Import" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BulkDataImport.aspx.cs" Inherits="Netra.BulkDataImport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-title {
            font-size: 1.4rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 20px;
        }

        /* Stepper Styling */
        .stepper-panel {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 18px 40px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: relative;
        }

        .stepper-step {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 6px;
            z-index: 2;
            cursor: pointer;
        }

        .step-num {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background-color: #070d18;
            border: 2px solid #1e293b;
            color: #64748b;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
            font-weight: 800;
            transition: all 0.3s ease;
        }

        .step-label {
            font-size: 0.68rem;
            font-weight: 800;
            color: #64748b;
            letter-spacing: 0.8px;
            text-transform: uppercase;
        }

        .stepper-step.active .step-num {
            background-color: #00d2ff;
            border-color: #00d2ff;
            color: #070d18;
            box-shadow: 0 0 12px rgba(0, 210, 255, 0.5);
        }

        .stepper-step.active .step-label {
            color: #00d2ff;
        }

        .stepper-step.completed .step-num {
            background-color: #10b981;
            border-color: #10b981;
            color: #ffffff;
        }

        .stepper-line {
            position: absolute;
            top: 34px;
            left: 80px;
            right: 80px;
            height: 2px;
            background-color: #1e293b;
            z-index: 1;
        }

        /* Grid Layout */
        .import-grid {
            display: grid;
            grid-template-columns: 1fr 340px;
            gap: 20px;
            margin-bottom: 20px;
        }

        .glass-panel {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 24px;
        }

        /* Dropzone */
        .dropzone-box {
            border: 2px dashed #1e293b;
            border-radius: 8px;
            padding: 40px 20px;
            text-align: center;
            background-color: #070d18;
            transition: all 0.2s ease;
            cursor: pointer;
        }

        .dropzone-box:hover, .dropzone-box.dragover {
            border-color: #00d2ff;
            background-color: rgba(0, 210, 255, 0.02);
        }

        .icon-csv {
            width: 48px;
            height: 48px;
            background: rgba(0, 210, 255, 0.1);
            border: 1px solid rgba(0, 210, 255, 0.2);
            color: #00d2ff;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.85rem;
            font-weight: 800;
            margin: 0 auto 16px auto;
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
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-outline:hover {
            border-color: #00d2ff;
            color: #00d2ff;
        }

        /* Profile & Summary Panel */
        .profile-field {
            margin-bottom: 14px;
        }

        .profile-label {
            font-size: 0.62rem;
            font-weight: 800;
            color: #64748b;
            text-transform: uppercase;
            margin-bottom: 4px;
        }

        .profile-input {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 8px 12px;
            color: #ffffff;
            font-size: 0.8rem;
            width: 100%;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid #1e293b;
            font-size: 0.78rem;
        }

        /* Validation Table */
        .val-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 14px;
        }

        .val-table th {
            background-color: #070d18;
            padding: 10px 12px;
            font-size: 0.65rem;
            font-weight: 800;
            color: #64748b;
            text-transform: uppercase;
            text-align: left;
            border-bottom: 1px solid #1e293b;
        }

        .val-table td {
            padding: 10px 12px;
            font-size: 0.75rem;
            color: #cbd5e1;
            border-bottom: 1px solid #1e293b;
        }

        .badge-issue {
            font-size: 0.62rem;
            font-weight: 800;
            padding: 2px 6px;
            border-radius: 4px;
        }

        .badge-critical { background: rgba(239, 68, 68, 0.2); color: #f87171; border: 1px solid rgba(239, 68, 68, 0.4); }
        .badge-warning { background: rgba(234, 179, 8, 0.2); color: #fde047; border: 1px solid rgba(234, 179, 8, 0.4); }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-title">Bulk Crime Data Import</div>

    <!-- STEPPER PROGRESS BAR -->
    <div class="stepper-panel">
        <div class="stepper-line"></div>
        <div class="stepper-step active" id="step1" onclick="setStep(1)">
            <div class="step-num">1</div>
            <div class="step-label">UPLOAD</div>
        </div>
        <div class="stepper-step" id="step2" onclick="setStep(2)">
            <div class="step-num">2</div>
            <div class="step-label">VALIDATE</div>
        </div>
        <div class="stepper-step" id="step3" onclick="setStep(3)">
            <div class="step-num">3</div>
            <div class="step-label">PREVIEW</div>
        </div>
        <div class="stepper-step" id="step4" onclick="setStep(4)">
            <div class="step-num">4</div>
            <div class="step-label">IMPORT</div>
        </div>
    </div>

    <!-- UPLOAD & FILE PROFILE GRID -->
    <div class="import-grid">
        <!-- Dropzone Panel -->
        <div class="glass-panel">
            <div class="dropzone-box" id="dropzone" onclick="document.getElementById('fileUploadInput').click();">
                <div class="icon-csv">CSV</div>
                <div style="font-size:0.95rem; font-weight:800; color:#fff; margin-bottom:4px;">Drag and Drop CSV File</div>
                <div style="font-size:0.72rem; color:#64748b; margin-bottom:16px;">Securely upload bulk crime incident records. Maximum file size: 500MB.</div>

                <div style="display:flex; justify-center:center; gap:12px; justify-content:center;" onclick="event.stopPropagation();">
                    <button type="button" class="btn-cyan" onclick="document.getElementById('fileUploadInput').click();">📁 Browse File</button>
                    <button type="button" class="btn-outline" onclick="downloadTemplate();">📥 Download Template</button>
                </div>

                <input type="file" id="fileUploadInput" accept=".csv" style="display:none;" onchange="handleFileSelect(this.files)" />
            </div>

            <!-- Upload File Status Bar -->
            <div id="uploadStatusCard" style="display:none; background:#070d18; border:1px solid #1e293b; border-radius:6px; padding:12px 16px; margin-top:16px; align-items:center; justify-content:space-between;">
                <div style="display:flex; align-items:center; gap:10px;">
                    <div style="font-size:1.2rem;">📄</div>
                    <div>
                        <div style="font-size:0.8rem; font-weight:800; color:#fff;" id="lblSelectedFileName">homicide_data_Q3_2023.csv</div>
                        <div style="font-size:0.68rem; color:#00d2ff;" id="lblUploadProgress">Uploaded & Parsed 100%</div>
                    </div>
                </div>
                <button type="button" style="background:none; border:none; color:#64748b; cursor:pointer; font-size:1rem;" onclick="resetFileSession()">✕</button>
            </div>
        </div>

        <!-- Current File Profile -->
        <div class="glass-panel">
            <div style="font-size:0.85rem; font-weight:800; color:#fff; margin-bottom:14px;">Current File Profile</div>

            <div class="profile-field">
                <div class="profile-label">FILE NAME</div>
                <input type="text" id="txtFileName" class="profile-input" value="Q1_Q2_Incidents_Master_v2.csv" readonly />
            </div>

            <div style="display:grid; grid-template-columns:1fr 1fr; gap:10px; margin-bottom:16px;">
                <div>
                    <div class="profile-label">FILE SIZE</div>
                    <div style="font-size:0.9rem; font-weight:800; color:#fff;" id="lblFileSize">148.2 MB</div>
                </div>
                <div>
                    <div class="profile-label">RECORD COUNT</div>
                    <div style="font-size:0.9rem; font-weight:800; color:#fff;" id="lblRecordCount">42,891 Rows</div>
                </div>
            </div>

            <div style="font-size:0.75rem; font-weight:800; color:#fff; margin:16px 0 8px 0; border-top:1px solid #1e293b; padding-top:12px;">Validation Summary</div>

            <div class="summary-row">
                <span style="color:#10b981; font-weight:700;">✓ Valid Records</span>
                <span style="font-weight:800; color:#fff;" id="lblValidCount">42,850</span>
            </div>
            <div class="summary-row">
                <span style="color:#f87171; font-weight:700;">✕ Invalid</span>
                <span style="font-weight:800; color:#f87171;" id="lblInvalidCount">41</span>
            </div>
            <div class="summary-row">
                <span style="color:#fde047; font-weight:700;">⚠️ Warnings</span>
                <span style="font-weight:800; color:#fde047;" id="lblWarningCount">112</span>
            </div>
        </div>
    </div>

    <!-- VALIDATION ISSUES PREVIEW -->
    <div class="glass-panel">
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:10px;">
            <div style="font-size:0.85rem; font-weight:800; color:#fff;">⚡ Validation Issues Preview</div>
            <button type="button" class="btn-outline" style="font-size:0.72rem; padding:5px 10px;" onclick="exportErrorLogCSV()">EXPORT ERROR LOG</button>
        </div>

        <table class="val-table" id="tblValidationIssues">
            <thead>
                <tr>
                    <th>ROW</th>
                    <th>FIELD</th>
                    <th>ERROR DESCRIPTION</th>
                    <th>STATUS</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td style="font-weight:800; color:#fff;">894</td>
                    <td><code style="color:#00d2ff;">lat_coord</code></td>
                    <td>Value '91.450' exceeds coordinate bounds. Expected range [-90, 90].</td>
                    <td><span class="badge-issue badge-critical">CRITICAL</span></td>
                </tr>
                <tr>
                    <td style="font-weight:800; color:#fff;">1022</td>
                    <td><code style="color:#00d2ff;">suspect_age</code></td>
                    <td>Value 'NULL' in required field. Defaulting to 'Unknown'.</td>
                    <td><span class="badge-issue badge-warning">WARNING</span></td>
                </tr>
                <tr>
                    <td style="font-weight:800; color:#fff;">3451</td>
                    <td><code style="color:#00d2ff;">incident_date</code></td>
                    <td>Unrecognized datetime format '2023-13-45'. Expected ISO 8601.</td>
                    <td><span class="badge-issue badge-critical">CRITICAL</span></td>
                </tr>
            </tbody>
        </table>

        <div style="display:flex; justify-content:flex-end; gap:12px; margin-top:20px; border-top:1px solid #1e293b; padding-top:16px;">
            <button type="button" class="btn-outline" onclick="resetFileSession()">Cancel Session</button>
            <button type="button" class="btn-cyan" id="btnImportAction" onclick="executeImportWorkflow()">Import Valid Records (42,850) →</button>
        </div>
    </div>

    <script>
        // Drag and Drop Handlers
        const dropzone = document.getElementById('dropzone');

        ['dragenter', 'dragover'].forEach(eventName => {
            dropzone.addEventListener(eventName, (e) => {
                e.preventDefault();
                dropzone.classList.add('dragover');
            }, false);
        });

        ['dragleave', 'drop'].forEach(eventName => {
            dropzone.addEventListener(eventName, (e) => {
                e.preventDefault();
                dropzone.classList.remove('dragover');
            }, false);
        });

        dropzone.addEventListener('drop', (e) => {
            const dt = e.dataTransfer;
            const files = dt.files;
            handleFileSelect(files);
        });

        function handleFileSelect(files) {
            if (files.length === 0) return;
            const file = files[0];

            document.getElementById('uploadStatusCard').style.display = 'flex';
            document.getElementById('lblSelectedFileName').innerText = file.name;

            // Populate File Profile
            document.getElementById('txtFileName').value = file.name;
            document.getElementById('lblFileSize').innerText = (file.size / (1024 * 1024)).toFixed(1) + " MB";

            // Dynamic line estimation
            const estimatedRows = Math.floor(file.size / 120);
            document.getElementById('lblRecordCount').innerText = estimatedRows.toLocaleString() + " Rows";
            document.getElementById('lblValidCount').innerText = Math.floor(estimatedRows * 0.99).toLocaleString();

            setStep(2); // Automatically advance to Validate step
        }

        function setStep(stepNum) {
            for (let i = 1; i <= 4; i++) {
                const el = document.getElementById('step' + i);
                if (i < stepNum) {
                    el.className = 'stepper-step completed';
                } else if (i === stepNum) {
                    el.className = 'stepper-step active';
                } else {
                    el.className = 'stepper-step';
                }
            }
        }

        function downloadTemplate() {
            const templateCSV = "incident_id,incident_date,crime_type,district,lat_coord,long_coord,suspect_age,status\nINC-2026-001,2026-10-15,Theft,Central,22.3039,70.8022,24,Open";
            const blob = new Blob([templateCSV], { type: 'text/csv' });
            const link = document.createElement('a');
            link.href = URL.createObjectURL(blob);
            link.download = 'NETRA_Bulk_Import_Template.csv';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }

        function exportErrorLogCSV() {
            const table = document.getElementById('tblValidationIssues');
            let csv = [];
            for (let i = 0; i < table.rows.length; i++) {
                let row = [], cols = table.rows[i].querySelectorAll('td, th');
                for (let j = 0; j < cols.length; j++) {
                    row.push('"' + cols[j].innerText.replace(/"/g, '""').trim() + '"');
                }
                csv.push(row.join(','));
            }

            const blob = new Blob([csv.join('\n')], { type: 'text/csv' });
            const link = document.createElement('a');
            link.href = URL.createObjectURL(blob);
            link.download = 'NETRA_Validation_Errors.csv';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }

        function resetFileSession() {
            document.getElementById('uploadStatusCard').style.display = 'none';
            document.getElementById('fileUploadInput').value = '';
            document.getElementById('txtFileName').value = 'Q1_Q2_Incidents_Master_v2.csv';
            document.getElementById('lblFileSize').innerText = '148.2 MB';
            document.getElementById('lblRecordCount').innerText = '42,891 Rows';
            setStep(1);
        }

        function executeImportWorkflow() {
            setStep(4);
            const btn = document.getElementById('btnImportAction');
            btn.innerText = "Importing Records (100%)...";
            btn.style.backgroundColor = "#10b981";

            setTimeout(() => {
                alert("SUCCESS: 42,850 records imported successfully into NETRA Database.");
                btn.innerText = "Import Complete ✓";
            }, 800);
        }
    </script>
</asp:Content>