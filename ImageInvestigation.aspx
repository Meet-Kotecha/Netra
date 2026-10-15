<%@ Page Title="Image-Assisted Investigation" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ImageInvestigation.aspx.cs" Inherits="Netra.ImageInvestigation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-title-header {
            margin-bottom: 20px;
        }

        .page-title-text {
            font-size: 1.35rem;
            font-weight: 800;
            color: #ffffff;
            line-height: 1.2;
        }

        .page-sub-text {
            font-size: 0.78rem;
            color: #64748b;
            margin-top: 4px;
        }

        .image-inv-grid {
            display: grid;
            grid-template-columns: 340px 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }

        @media (max-width: 1100px) {
            .image-inv-grid {
                grid-template-columns: 1fr;
            }
        }

        .panel-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 18px;
        }

        .panel-header-title {
            font-size: 0.95rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 14px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .drop-zone-box {
            border: 1px dashed #1e293b;
            border-radius: 6px;
            padding: 24px 16px;
            text-align: center;
            background-color: #070d18;
            margin-bottom: 16px;
            transition: border-color 0.2s ease;
        }

        .drop-zone-box:hover {
            border-color: #00d2ff;
        }

        .drop-icon {
            font-size: 1.8rem;
            color: #64748b;
            margin-bottom: 8px;
        }

        .drop-text-main {
            font-size: 0.78rem;
            font-weight: 700;
            color: #cbd5e1;
            margin-bottom: 4px;
        }

        .drop-text-sub {
            font-size: 0.65rem;
            color: #64748b;
            margin-bottom: 12px;
        }

        .btn-browse {
            background-color: #12283e;
            border: 1px solid #1e293b;
            color: #f8fafc;
            padding: 6px 14px;
            border-radius: 4px;
            font-size: 0.72rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-browse:hover {
            border-color: #00d2ff;
            color: #00d2ff;
        }

        .divider-label {
            display: flex;
            align-items: center;
            text-align: center;
            font-size: 0.62rem;
            font-weight: 700;
            color: #64748b;
            margin: 14px 0;
            letter-spacing: 0.8px;
        }

        .divider-label::before, .divider-label::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid #1e293b;
        }

        .divider-label::before { margin-right: 8px; }
        .divider-label::after { margin-left: 8px; }

        .preview-box-card {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            overflow: hidden;
            position: relative;
            height: 180px;
            margin-bottom: 14px;
        }

        .preview-box-card img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .badge-source {
            position: absolute;
            top: 8px;
            left: 8px;
            background-color: rgba(7, 13, 24, 0.85);
            border: 1px solid rgba(0, 210, 255, 0.4);
            color: #00d2ff;
            font-size: 0.62rem;
            font-weight: 800;
            padding: 3px 6px;
            border-radius: 4px;
            font-family: monospace;
        }

        .btn-search-cyan {
            width: 100%;
            background-color: #00d2ff;
            border: none;
            color: #070d18;
            padding: 10px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 800;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            transition: all 0.2s ease;
        }

        .btn-search-cyan:hover {
            opacity: 0.9;
            box-shadow: 0 0 12px rgba(0, 210, 255, 0.4);
        }

        .params-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 14px 18px;
            margin-top: 14px;
        }

        .param-row {
            display: flex;
            justify-content: space-between;
            font-size: 0.72rem;
            padding: 4px 0;
        }

        .matches-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
        }

        .matches-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        @media (max-width: 800px) {
            .matches-grid {
                grid-template-columns: 1fr;
            }
        }

        .match-card {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 14px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: border-color 0.2s ease;
        }

        .match-card:hover {
            border-color: #00d2ff;
        }

        .match-card-top {
            display: flex;
            gap: 12px;
            margin-bottom: 14px;
        }

        .match-avatar {
            width: 60px;
            height: 70px;
            border-radius: 6px;
            background-color: #12283e;
            border: 1px solid #1e293b;
            object-fit: cover;
        }

        .match-badge-tag {
            position: absolute;
            bottom: 2px;
            left: 2px;
            background-color: rgba(7, 13, 24, 0.8);
            color: #64748b;
            font-size: 0.55rem;
            padding: 1px 3px;
            border-radius: 2px;
            font-family: monospace;
        }

        .match-info-name {
            font-size: 0.85rem;
            font-weight: 800;
            color: #ffffff;
        }

        .match-info-id {
            font-size: 0.68rem;
            color: #64748b;
            font-family: monospace;
            margin-top: 2px;
        }

        .match-info-loc {
            font-size: 0.7rem;
            color: #cbd5e1;
            margin-top: 6px;
        }

        .confidence-badge-cyan {
            background-color: rgba(0, 210, 255, 0.15);
            border: 1px solid #00d2ff;
            color: #00d2ff;
            padding: 2px 6px;
            border-radius: 4px;
            font-size: 0.65rem;
            font-weight: 800;
            height: fit-content;
        }

        .confidence-badge-grey {
            background-color: rgba(100, 116, 139, 0.15);
            border: 1px solid #64748b;
            color: #94a3b8;
            padding: 2px 6px;
            border-radius: 4px;
            font-size: 0.65rem;
            font-weight: 800;
            height: fit-content;
        }

        .match-actions-row {
            display: flex;
            gap: 8px;
            margin-top: 10px;
            border-top: 1px solid #1e293b;
            padding-top: 10px;
        }

        .btn-card-action {
            flex: 1;
            background-color: #0b1320;
            border: 1px solid #1e293b;
            color: #cbd5e1;
            padding: 6px;
            border-radius: 4px;
            font-size: 0.7rem;
            font-weight: 700;
            cursor: pointer;
            text-align: center;
            transition: all 0.2s ease;
            text-decoration: none;
            display: block;
        }

        .btn-card-action:hover {
            border-color: #00d2ff;
            color: #00d2ff;
        }

        .disclaimer-bar {
            background-color: rgba(11, 19, 32, 0.5);
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 10px 14px;
            font-size: 0.7rem;
            color: #64748b;
            display: flex;
            align-items: center;
            gap: 8px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Header -->
    <div class="page-title-header">
        <div class="page-title-text">Image-Assisted Investigation</div>
        <div class="page-sub-text">Search authorized investigation images for potential matches.</div>
    </div>

    <!-- Main Split Grid -->
    <div class="image-inv-grid">
        <!-- Left Column: Subject Input -->
        <div>
            <div class="panel-card">
                <div class="panel-header-title">
                    <span>Subject Input</span>
                    <span style="color:#64748b; cursor:pointer;" title="Upload Options">📄</span>
                </div>

                <div class="drop-zone-box">
                    <div class="drop-icon">☁️</div>
                    <div class="drop-text-main">Drag & Drop Image Here</div>
                    <div class="drop-text-sub">Supported formats: JPG, PNG, TIFF (Max 20MB)</div>
                    <asp:FileUpload ID="fileUploadImage" runat="server" Style="display:none;" onchange="previewSelectedImage(this)" />
                    <button type="button" class="btn-browse" onclick="document.getElementById('<%= fileUploadImage.ClientID %>').click();">Browse Files</button>
                </div>

                <div class="divider-label">OR PREVIEW CURRENT</div>

                <div class="preview-box-card">
                    <div class="badge-source">SRC: EXT-CAM-09</div>
                    <img id="imgSubjectPreview" src="Images/Meet.jpeg" alt="CCTV Subject Preview" onerror="this.src='Images/Keval.jpeg';" />
                </div>

                <button type="button" class="btn-search-cyan" onclick="runImageSearch()">
                    🔍 Search Potential Matches
                </button>
            </div>

            <div class="params-card">
                <div class="param-row" style="color:#64748b; font-weight:700; text-transform:uppercase; font-size:0.65rem;">
                    <span>SEARCH PARAMETERS</span>
                </div>
                <div class="param-row" style="color:#cbd5e1; margin-top:6px;">
                    <span>Confidence Threshold</span>
                    <span style="color:#00d2ff; font-weight:800;">85%</span>
                </div>
                <div class="param-row" style="color:#cbd5e1;">
                    <span>Database Scope</span>
                    <span>Global Records</span>
                </div>
            </div>
        </div>

        <!-- Right Column: Potential Matches Grid -->
        <div class="panel-card">
            <div class="matches-header">
                <div>
                    <div style="font-size:0.95rem; font-weight:700; color:#ffffff;">Potential Matches</div>
                    <div style="font-size:0.7rem; color:#64748b; margin-top:2px;">4 Candidates found above 85% confidence threshold</div>
                </div>
                <div style="display:flex; gap:6px;">
                    <button type="button" style="background:#12283e; border:1px solid #1e293b; color:#00d2ff; padding:4px 8px; border-radius:4px; cursor:pointer;">田</button>
                    <button type="button" style="background:#070d18; border:1px solid #1e293b; color:#64748b; padding:4px 8px; border-radius:4px; cursor:pointer;">≡</button>
                </div>
            </div>

            <div class="matches-grid">
                <!-- Candidate 1: Digvijaysinh Vaghela -->
                <div class="match-card">
                    <div>
                        <div class="match-card-top">
                            <div style="position:relative;">
                                <img src="Images/Digvijay.jpeg" class="match-avatar" alt="Digvijaysinh Vaghela" onerror="this.src='Images/Keval.jpeg';" />
                                <div class="match-badge-tag">DB-REC-01</div>
                            </div>
                            <div style="flex-grow:1;">
                                <div class="match-info-name">Digvijaysinh Vaghela</div>
                                <div class="match-info-id">ID: #883-902-11A</div>
                                <div class="match-info-loc">📁 Dubai</div>
                                <div class="match-info-loc" style="color:#64748b;">📍 Sector 4, Industrial District</div>
                            </div>
                            <div class="confidence-badge-cyan">✓ 98%</div>
                        </div>
                    </div>
                    <div class="match-actions-row">
                        <a href="PersonProfile.aspx?name=Digvijaysinh%20Vaghela&id=883-902-11A&dob=02-11-2002%20(24%20yrs)&img=Images/Digvijay.jpeg" class="btn-card-action">View Profile</a>
                        <button type="button" class="btn-card-action" onclick="linkToCase('Digvijaysinh Vaghela', '#883-902-11A')">Link Case</button>
                    </div>
                </div>

                <!-- Candidate 2: Rohan Siddhpura -->
                <div class="match-card">
                    <div>
                        <div class="match-card-top">
                            <div style="position:relative;">
                                <img src="Images/Rohan.jpeg" class="match-avatar" alt="Rohan Siddhpura" onerror="this.src='Images/Keval.jpeg';" />
                                <div class="match-badge-tag">EXT-VID-44</div>
                            </div>
                            <div style="flex-grow:1;">
                                <div class="match-info-name">Rohan Siddhpura</div>
                                <div class="match-info-id">ID: UNK-442-99B</div>
                                <div class="match-info-loc">📁 Germany</div>
                                <div class="match-info-loc" style="color:#64748b;">📍 Transit Hub Alpha</div>
                            </div>
                            <div class="confidence-badge-grey">91%</div>
                        </div>
                    </div>
                    <div class="match-actions-row">
                        <a href="PersonProfile.aspx?name=Rohan%20Siddhpura&id=UNK-442-99B&dob=14-08-1998%20(28%20yrs)&img=Images/Rohan.jpeg" class="btn-card-action">View Profile</a>
                        <button type="button" class="btn-card-action" onclick="linkToCase('Rohan Siddhpura', 'UNK-442-99B')">Link Case</button>
                    </div>
                </div>

                <!-- Candidate 3: Meet Kotecha -->
                <div class="match-card">
                    <div>
                        <div class="match-card-top">
                            <div style="position:relative;">
                                <img src="Images/Meet.jpeg" class="match-avatar" alt="Meet Kotecha" onerror="this.src='Images/Keval.jpeg';" />
                                <div class="match-badge-tag">DMV-REC-89</div>
                            </div>
                            <div style="flex-grow:1;">
                                <div class="match-info-name">Meet Kotecha</div>
                                <div class="match-info-id">ID: #990-112-44C</div>
                                <div class="match-info-loc">📁 India</div>
                                <div class="match-info-loc" style="color:#64748b;">📍 Suburban Grid 2</div>
                            </div>
                            <div class="confidence-badge-grey">88%</div>
                        </div>
                    </div>
                    <div class="match-actions-row">
                        <a href="PersonProfile.aspx?name=Meet%20Kotecha&id=990-112-44C&dob=10-05-2003%20(23%20yrs)&img=Images/Meet.jpeg" class="btn-card-action">View Profile</a>
                        <button type="button" class="btn-card-action" onclick="linkToCase('Meet Kotecha', '#990-112-44C')">Link Case</button>
                    </div>
                </div>

                <!-- Candidate 4: Keval Goswami -->
                <div class="match-card">
                    <div>
                        <div class="match-card-top">
                            <div style="position:relative;">
                                <img src="Images/Keval.jpeg" class="match-avatar" alt="Keval Goswami" />
                                <div class="match-badge-tag">ATM-CAM-12</div>
                            </div>
                            <div style="flex-grow:1;">
                                <div class="match-info-name">Keval Goswami</div>
                                <div class="match-info-id">ID: P-1042</div>
                                <div class="match-info-loc">📁 FIN-FRAUD-09</div>
                                <div class="match-info-loc" style="color:#64748b;">📍 Financial District</div>
                            </div>
                            <div class="confidence-badge-grey">85%</div>
                        </div>
                    </div>
                    <div class="match-actions-row">
                        <a href="PersonProfile.aspx?name=Keval%20Goswami&id=P-1042&dob=06-06-2006%20(20%20yrs)&img=Images/Keval.jpeg" class="btn-card-action">View Profile</a>
                        <button type="button" class="btn-card-action" onclick="linkToCase('Keval Goswami', 'P-1042')">Link Case</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="disclaimer-bar">
        <span>ℹ️ Image matching provides potential matches for investigative assistance and requires human verification. Automated results are not definitive proof of identity.</span>
    </div>

    <script>
        function previewSelectedImage(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    document.getElementById("imgSubjectPreview").src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        function runImageSearch() {
            alert('🔍 Facial Feature Matching Engine triggered: 4 candidates found above 85% confidence.');
        }

        function linkToCase(personName, personId) {
            alert(`🔗 Successfully linked subject '${personName}' (${personId}) to Active Case #CR-2026-1024 (Vehicle Theft Investigation).`);
        }
    </script>
</asp:Content>
