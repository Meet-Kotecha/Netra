<%@ Page Title="Image Investigation" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ImageInvestigation.aspx.cs" Inherits="Netra.ImageInvestigation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-header-title {
            font-size: 1.4rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 18px;
        }

        .investigation-grid {
            display: grid;
            grid-template-columns: 360px 1fr;
            gap: 20px;
        }

        .glass-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 18px;
        }

        .card-title {
            font-size: 0.9rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 14px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* Drag and Drop Zone */
        .drop-zone {
            border: 2px dashed #1e293b;
            border-radius: 8px;
            padding: 24px;
            text-align: center;
            background-color: #070d18;
            cursor: pointer;
            transition: all 0.2s ease;
            margin-bottom: 16px;
        }

        .drop-zone:hover {
            border-color: #00d2ff;
            background-color: #0a172a;
        }

        .preview-box {
            width: 100%;
            height: 220px;
            border-radius: 8px;
            object-fit: cover;
            border: 1px solid #1e293b;
            margin-bottom: 14px;
            background-color: #070d18;
        }

        .btn-search-cyan {
            width: 100%;
            background-color: #00d2ff;
            color: #070d18;
            border: none;
            padding: 12px;
            border-radius: 6px;
            font-size: 0.82rem;
            font-weight: 800;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.2s ease;
        }

        .btn-search-cyan:hover {
            box-shadow: 0 0 16px rgba(0, 210, 255, 0.4);
        }

        /* Candidate Matches Grid */
        .matches-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 16px;
        }

        .candidate-card {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 14px;
            display: grid;
            grid-template-columns: 80px 1fr;
            gap: 14px;
            position: relative;
            transition: all 0.2s ease;
        }

        .candidate-card:hover {
            border-color: #00d2ff;
            background-color: #0b182d;
        }

        .candidate-thumb {
            width: 80px;
            height: 95px;
            border-radius: 6px;
            object-fit: cover;
            border: 1px solid #1e293b;
        }

        .confidence-badge {
            position: absolute;
            top: 12px;
            right: 12px;
            background: rgba(0, 210, 255, 0.15);
            color: #00d2ff;
            border: 1px solid #00d2ff;
            font-size: 0.68rem;
            font-weight: 800;
            padding: 2px 8px;
            border-radius: 4px;
        }

        .candidate-name {
            font-size: 0.9rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 2px;
        }

        .candidate-meta {
            font-size: 0.68rem;
            color: #64748b;
            margin-bottom: 8px;
        }

        .candidate-actions {
            grid-column: span 2;
            display: flex;
            gap: 8px;
            margin-top: 6px;
        }

        .btn-candidate {
            flex: 1;
            background-color: #0b1320;
            border: 1px solid #1e293b;
            color: #cbd5e1;
            padding: 6px;
            border-radius: 4px;
            font-size: 0.72rem;
            font-weight: 700;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            transition: all 0.2s ease;
        }

        .btn-candidate:hover {
            border-color: #00d2ff;
            color: #00d2ff;
        }

        .param-row {
            display: flex;
            justify-content: space-between;
            font-size: 0.72rem;
            color: #64748b;
            margin-bottom: 6px;
        }

        .param-val {
            color: #cbd5e1;
            font-weight: 700;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header-title">Image-Assisted Investigation</div>

    <div class="investigation-grid">
        <!-- Subject Input Sidebar -->
        <div>
            <div class="glass-card">
                <div class="card-title">
                    <span>Subject Input</span>
                    <span style="font-size: 0.72rem; color: #64748b;">📄</span>
                </div>

                <div class="drop-zone" onclick="document.getElementById('<%= fileUploadSubject.ClientID %>').click();">
                    <div style="font-size: 1.8rem; margin-bottom: 6px;">☁️</div>
                    <div style="font-size: 0.78rem; font-weight: 700; color: #fff; margin-bottom: 4px;">Drag & Drop Image Here</div>
                    <div style="font-size: 0.65rem; color: #64748b;">Supported formats: JPG, PNG, TIFF (Max 20MB)</div>
                </div>

                <asp:FileUpload ID="fileUploadSubject" runat="server" Style="display:none;" onchange="previewSelectedImage(this)" />

                <div style="font-size: 0.65rem; font-weight: 800; color: #64748b; text-transform: uppercase; margin-bottom: 8px;">OR PREVIEW CURRENT</div>
                
                <img id="imgPreview" src="Images/Meet.jpeg" class="preview-box" alt="Subject Preview" />

                <button type="button" class="btn-search-cyan" onclick="triggerFacialMatch()">
                    <span>🔍</span> Search Potential Matches
                </button>
            </div>

            <!-- Search Parameters -->
            <div class="glass-card">
                <div class="card-title">SEARCH PARAMETERS</div>
                <div class="param-row">
                    <span>Confidence Threshold</span>
                    <span class="param-val" style="color:#00d2ff;">85%</span>
                </div>
                <div class="param-row">
                    <span>Database Scope</span>
                    <span class="param-val">Global Records</span>
                </div>
            </div>
        </div>

        <!-- Potential Matches Panel -->
        <div>
            <div class="glass-card">
                <div class="card-title">
                    <div>
                        <span style="font-size: 1rem; color: #fff;">Potential Matches</span>
                        <div style="font-size: 0.68rem; color: #64748b; font-weight: 400; margin-top: 2px;">4 Candidates found above 85% confidence threshold</div>
                    </div>
                </div>

                <div class="matches-grid">
                    <!-- Candidate 1: Digvijaysinh Vaghela -->
                    <div class="candidate-card">
                        <img src="Images/Meet.jpeg" class="candidate-thumb" alt="Digvijaysinh Vaghela" />
                        <div>
                            <div class="confidence-badge">✓ 98%</div>
                            <div class="candidate-name">Digvijaysinh Vaghela</div>
                            <div class="candidate-meta">ID: #883-902-11A</div>
                            <div class="candidate-meta">📍 Dubai</div>
                            <div class="candidate-meta">📍 Sector 4, Industrial District</div>
                        </div>
                        <div class="candidate-actions">
                            <a href="PersonProfile.aspx?id=101" class="btn-candidate">View Profile</a>
                            <button type="button" class="btn-candidate" onclick="alert('Case linked to Digvijaysinh Vaghela')">Link Case</button>
                        </div>
                    </div>

                    <!-- Candidate 2: Rohan Siddhpura -->
                    <div class="candidate-card">
                        <img src="Images/Meet.jpeg" class="candidate-thumb" alt="Rohan Siddhpura" />
                        <div>
                            <div class="confidence-badge" style="border-color:#38bdf8; color:#38bdf8;">91%</div>
                            <div class="candidate-name">Rohan Siddhpura</div>
                            <div class="candidate-meta">ID: UNK-442-998</div>
                            <div class="candidate-meta">📍 Germany</div>
                            <div class="candidate-meta">📍 Transit Hub Alpha</div>
                        </div>
                        <div class="candidate-actions">
                            <a href="PersonProfile.aspx?id=102" class="btn-candidate">View Profile</a>
                            <button type="button" class="btn-candidate" onclick="alert('Case linked to Rohan Siddhpura')">Link Case</button>
                        </div>
                    </div>

                    <!-- Candidate 3: Meet Kotecha -->
                    <div class="candidate-card">
                        <img src="Images/Meet.jpeg" class="candidate-thumb" alt="Meet Kotecha" />
                        <div>
                            <div class="confidence-badge" style="border-color:#38bdf8; color:#38bdf8;">88%</div>
                            <div class="candidate-name">Meet Kotecha</div>
                            <div class="candidate-meta">ID: #990-112-44C</div>
                            <div class="candidate-meta">📍 India</div>
                            <div class="candidate-meta">📍 Suburban Grid 2</div>
                        </div>
                        <div class="candidate-actions">
                            <a href="PersonProfile.aspx?id=103" class="btn-candidate">View Profile</a>
                            <button type="button" class="btn-candidate" onclick="alert('Case linked to Meet Kotecha')">Link Case</button>
                        </div>
                    </div>

                    <!-- Candidate 4: Keval Goswami -->
                    <div class="candidate-card">
                        <img src="Images/Meet.jpeg" class="candidate-thumb" alt="Keval Goswami" />
                        <div>
                            <div class="confidence-badge" style="border-color:#38bdf8; color:#38bdf8;">85%</div>
                            <div class="candidate-name">Keval Goswami</div>
                            <div class="candidate-meta">ID: P-1042</div>
                            <div class="candidate-meta">📍 FIN-FRAUD-09</div>
                            <div class="candidate-meta">📍 Financial District</div>
                        </div>
                        <div class="candidate-actions">
                            <a href="PersonProfile.aspx?id=1" class="btn-candidate">View Profile</a>
                            <button type="button" class="btn-candidate" onclick="alert('Case linked to Keval Goswami')">Link Case</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Disclaimer Banner -->
            <div style="background: rgba(11, 19, 32, 0.8); border: 1px solid #1e293b; border-radius: 6px; padding: 10px 16px; font-size: 0.7rem; color: #64748b; display: flex; align-items: center; gap: 8px;">
                <span>ℹ️</span> Image matching provides potential matches for investigative assistance and requires human verification. Automated results are not definitive proof of identity.
            </div>
        </div>
    </div>

    <script>
        function previewSelectedImage(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    document.getElementById('imgPreview').src = e.target.result;
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

        function triggerFacialMatch() {
            const btn = event.currentTarget;
            btn.innerHTML = '<span>⏳</span> Scanning Database...';
            setTimeout(() => {
                btn.innerHTML = '<span>🔍</span> Search Potential Matches';
            }, 800);
        }
    </script>
</asp:Content>