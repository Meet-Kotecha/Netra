<%@ Page Title="Bulk Crime Data Import" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BulkDataImport.aspx.cs" Inherits="Netra.BulkDataImport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Top Page Header */
        .page-header-row {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 20px;
        }

        .page-title {
            font-size: 1.4rem;
            font-weight: 800;
            color: #ffffff;
        }

        .workspace-badge {
            background-color: #12283e;
            border: 1px solid rgba(0, 210, 255, 0.3);
            color: #00d2ff;
            font-size: 0.65rem;
            font-weight: 800;
            padding: 3px 8px;
            border-radius: 4px;
            letter-spacing: 0.8px;
        }

        /* 4-Step Import Progress Stepper */
        .stepper-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 16px 40px;
            margin-bottom: 20px;
            position: relative;
        }

        .stepper-step {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 6px;
            position: relative;
            z-index: 2;
        }

        .step-circle {
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
        }

        .step-circle.active {
            background-color: #00d2ff;
            border-color: #00d2ff;
            color: #070d18;
            box-shadow: 0 0 12px rgba(0, 210, 255, 0.5);
        }

        .step-label {
            font-size: 0.68rem;
            font-weight: 800;
            color: #64748b;
            letter-spacing: 0.8px;
        }

        .step-label.active {
            color: #00d2ff;
        }

        .stepper-line {
            position: absolute;
            top: 31px;
            left: 80px;
            right: 80px;
            height: 2px;
            background-color: #1e293b;
            z-index: 1;
        }

        /* Main Split 2-Column Grid */
        .import-grid {
            display: grid;
            grid-template-columns: 1fr 340px;
            gap: 20px;
            margin-bottom: 20px;
        }

        @media (max-width: 1100px) {
            .import-grid {
                grid-template-columns: 1fr;
            }
        }

        .panel-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 20px;
        }

        /* Upload Zone Card */
        .upload-dropzone {
            border: 1px dashed #1e293b;
            border-radius: 8px;
            background-color: #070d18;
            padding: 45px 20px;
            text-align: center;
            margin-bottom: 20px;
            transition: border-color 0.2s ease;
        }

        .upload-dropzone:hover {
            border-color: #00d2ff;
        }

        .csv-icon-large {
            width: 48px;
            height: 48px;
            border-radius: 8px;
            background-color: #12283e;
            border: 1px solid #1e293b;
            color: #38bdf8;
            font-size: 1rem;
            font-weight: 800;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 14px auto;
        }

        .upload-title {
            font-size: 0.95rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 6px;
        }

        .upload-sub {
            font-size: 0.74rem;
            color: #64748b;
            margin-bottom: 18px;
        }

        .upload-actions-row {
            display: flex;
            justify-content: center;
            gap: 12px;
        }

        .btn-browse-cyan {
            background-color: #00d2ff;
            border: none;
            color: #070d18;
            padding: 8px 18px;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 800;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s ease;
        }

        .btn-browse-cyan:hover {
            opacity: 0.9;
            box-shadow: 0 0 10px rgba(0, 210, 255, 0.4);
        }

        .btn-template-outline {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            color: #cbd5e1;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-template-outline:hover {
            border-color: #00d2ff;
            color: #00d2ff;
        }

        /* Active File Progress Strip */
        .upload-progress-card {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 12px 16px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .file-info-left {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .file-icon-sm {
            color: #00d2ff;
            font-size: 1.1rem;
        }

        .file-name-text {
            font-size: 0.78rem;
            font-weight: 700;
            color: #cbd5e1;
        }

        .file-sub-text {
            font-size: 0.68rem;
            color: #64748b;
            margin-top: 2px;
        }

        .btn-close-upload {
            background: none;
            border: none;
            color: #64748b;
            font-size: 1rem;
            cursor: pointer;
        }

        .btn-close-upload:hover {
            color: #ef4444;
        }

        /* Right Panel Cards */
        .right-section-title {
            font-size: 0.88rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 12px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .profile-input-box {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 8px 12px;
            color: #cbd5e1;
            font-size: 0.78rem;
            font-family: monospace;
            margin-bottom: 12px;
            width: 100%;
        }

        .profile-stats-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            margin-bottom: 20px;
        }

        .meta-lbl {
            font-size: 0.65rem;
            font-weight: 700;
            color: #64748b;
            text-transform: uppercase;
            margin-bottom: 4px;
        }

        .meta-val {
            font-size: 0.82rem;
            font-weight: 800;
            color: #ffffff;
        }

        /* Validation Summary Box */
        .val-summary-card {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 12px 14px;
        }

        .val-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.75rem;
            padding: 8px 0;
            border-bottom: 1px solid #162234;
        }

        .val-row:last-child {
            border-bottom: none;
        }

        .val-row-label {
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 700;
        }

        .val-count {
            font-weight: 800;
            font-family: monospace;
        }

        /* Validation Table Section */
        .table-panel {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 18px;
            margin-bottom: 20px;
        }

        .table-header-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 14px;
        }

        .table-title {
            font-size: 0.9rem;
            font-weight: 800;
            color: #ffffff;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-export-log {
            color: #00d2ff;
            font-size: 0.68rem;
            font-weight: 800;
            background: none;
            border: none;
            cursor: pointer;
            letter-spacing: 0.6px;
        }

        .btn-export-log:hover {
            text-decoration: underline;
        }

        .custom-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.75rem;
        }

        .custom-table th {
            text-align: left;
            padding: 8px 12px;
            background-color: #070d18;
            color: #64748b;
            font-weight: 800;
            font-size: 0.65rem;
            text-transform: uppercase;
            border-bottom: 1px solid #1e293b;
        }

        .custom-table td {
            padding: 10px 12px;
            border-bottom: 1px solid #162234;
            color: #cbd5e1;
        }

        .field-tag {
            background-color: #070d18;
            border: 1px solid #1e293b;
            color: #38bdf8;
            font-family: monospace;
            padding: 2px 6px;
            border-radius: 4px;
            font-size: 0.68rem;
        }

        .badge-critical {
            background-color: rgba(239, 68, 68, 0.15);
            border: 1px solid #ef4444;
            color: #f87171;
            font-size: 0.62rem;
            font-weight: 800;
            padding: 2px 6px;
            border-radius: 4px;
        }

        .badge-warning {
            background-color: rgba(245, 158, 11, 0.15);
            border: 1px solid #f59e0b;
            color: #fbbf24;
            font-size: 0.62rem;
            font-weight: 800;
            padding: 2px 6px;
            border-radius: 4px;
        }

        /* Bottom Action Footer Bar */
        .bottom-actions-bar {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
        }

        .btn-cancel-session {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            color: #cbd5e1;
            padding: 10px 20px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-cancel-session:hover {
            border-color: #64748b;
            color: #ffffff;
        }

        .btn-import-records {
            background-color: #00d2ff;
            border: none;
            color: #070d18;
            padding: 10px 22px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 800;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s ease;
        }

        .btn-import-records:hover {
            opacity: 0.9;
            box-shadow: 0 0 14px rgba(0, 210, 255, 0.5);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Top Header Title -->
    <div class="page-header-row">
        <div class="page-title">Bulk Crime Data Import</div>
        <div class="workspace-badge">WORKSPACE-ALPHA</div>
    </div>

    <!-- Stepper Bar -->
    <div class="stepper-bar">
        <div class="stepper-line"></div>

        <div class="stepper-step">
            <div class="step-circle active">1</div>
            <div class="step-label active">UPLOAD</div>
        </div>

        <div class="stepper-step">
            <div class="step-circle">2</div>
            <div class="step-label">VALIDATE</div>
        </div>

        <div class="stepper-step">
            <div class="step-circle">3</div>
            <div class="step-label">PREVIEW</div>
        </div>

        <div class="stepper-step">
            <div class="step-circle">4</div>
            <div class="step-label">IMPORT</div>
        </div>
    </div>

    <!-- Main Import Split Grid -->
    <div class="import-grid">
        <!-- Left Column: Dropzone & File Progress -->
        <div class="panel-card">
            <div class="upload-dropzone">
                <div class="csv-icon-large">CSV</div>
                <div class="upload-title">Drag and Drop CSV File</div>
                <div class="upload-sub">Securely upload bulk crime incident records. Maximum file size: 500MB.</div>
                
                <asp:FileUpload ID="fileUploadCsv" runat="server" Style="display:none;" onchange="fileSelected(this)" />
                <div class="upload-actions-row">
                    <button type="button" class="btn-browse-cyan" onclick="document.getElementById('<%= fileUploadCsv.ClientID %>').click();">
                        📁 Browse File
                    </button>
                    <button type="button" class="btn-template-outline" onclick="alert('📥 Downloading standard NETRA CSV Import Template...')">
                        📥 Download Template
                    </button>
                </div>
            </div>

            <!-- Active File Progress -->
            <div class="upload-progress-card">
                <div class="file-info-left">
                    <div class="file-icon-sm">📄</div>
                    <div>
                        <div class="file-name-text">homicide_data_Q3_2023.csv</div>
                        <div class="file-sub-text">Uploading... 45% (12MB / 28MB)</div>
                    </div>
                </div>
                <button type="button" class="btn-close-upload" title="Cancel Upload" onclick="alert('Upload cancelled.')">✕</button>
            </div>
        </div>

        <!-- Right Column: File Profile & Validation Summary -->
        <div class="panel-card">
            <div class="right-section-title">Current File Profile</div>
            
            <div class="meta-lbl">FILE NAME</div>
            <div class="profile-input-box">Q1_Q2_Incidents_Master_v2.csv</div>

            <div class="profile-stats-row">
                <div>
                    <div class="meta-lbl">FILE SIZE</div>
                    <div class="meta-val">148.2 MB</div>
                </div>
                <div>
                    <div class="meta-lbl">RECORD COUNT</div>
                    <div class="meta-val">42,891 Rows</div>
                </div>
            </div>

            <div class="right-section-title">
                <span>Validation Summary</span>
                <span style="color:#ef4444; font-size:0.6rem;">●</span>
            </div>

            <div class="val-summary-card">
                <div class="val-row">
                    <div class="val-row-label" style="color:#38bdf8;">
                        <span>✓</span> Valid Records
                    </div>
                    <div class="val-count" style="color:#ffffff;">42,850</div>
                </div>

                <div class="val-row">
                    <div class="val-row-label" style="color:#f87171;">
                        <span>✕</span> Invalid
                    </div>
                    <div class="val-count" style="color:#f87171;">41</div>
                </div>

                <div class="val-row">
                    <div class="val-row-label" style="color:#fbbf24;">
                        <span>⚠️</span> Warnings
                    </div>
                    <div class="val-count" style="color:#fbbf24;">112</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Validation Issues Preview Table -->
    <div class="table-panel">
        <div class="table-header-row">
            <div class="table-title">
                <span>⚡ Validation Issues Preview</span>
            </div>
            <button type="button" class="btn-export-log" onclick="alert('📤 Exporting Error Log (CSV)...')">
                EXPORT ERROR LOG
            </button>
        </div>

        <table class="custom-table">
            <thead>
                <tr>
                    <th style="width:80px;">ROW</th>
                    <th style="width:140px;">FIELD</th>
                    <th>ERROR DESCRIPTION</th>
                    <th style="width:100px; text-align:right;">STATUS</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>894</td>
                    <td><span class="field-tag">lat_coord</span></td>
                    <td>Value '91.450' exceeds coordinate bounds. Expected range [-90, 90].</td>
                    <td style="text-align:right;"><span class="badge-critical">CRITICAL</span></td>
                </tr>
                <tr>
                    <td>1022</td>
                    <td><span class="field-tag">suspect_age</span></td>
                    <td>Value 'NULL' in required field. Defaulting to 'Unknown'.</td>
                    <td style="text-align:right;"><span class="badge-warning">WARNING</span></td>
                </tr>
                <tr>
                    <td>3451</td>
                    <td><span class="field-tag">incident_date</span></td>
                    <td>Unrecognized datetime format '2023-13-45'. Expected ISO 8601.</td>
                    <td style="text-align:right;"><span class="badge-critical">CRITICAL</span></td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- Bottom Actions Bar -->
    <div class="bottom-actions-bar">
        <button type="button" class="btn-cancel-session" onclick="alert('Import session cancelled.')">Cancel Session</button>
        <button type="button" class="btn-import-records" onclick="alert('🚀 Initiating Bulk Data Ingestion into Database Engine...')">
            Import Valid Records (42,850) →
        </button>
    </div>

    <script>
        function fileSelected(input) {
            if (input.files && input.files[0]) {
                alert("📄 Selected CSV File: " + input.files[0].name + " (" + (input.files[0].size / 1024 / 1024).toFixed(2) + " MB)");
            }
        }
    </script>
</asp:Content>