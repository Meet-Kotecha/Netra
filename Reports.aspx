<%@ Page Title="Reports & Intelligence Summaries" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="Netra.Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .reports-header-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        .reports-title {
            font-size: 1.4rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 4px;
        }

        .reports-sub-text {
            font-size: 0.78rem;
            color: #64748b;
        }

        .btn-generate-cyan {
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

        .btn-generate-cyan:hover {
            background-color: #00d2ff;
            box-shadow: 0 0 12px rgba(0, 210, 255, 0.4);
        }

        /* Category Nav Filter Tabs */
        .reports-nav-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #1e293b;
            margin-bottom: 22px;
        }

        .reports-tabs-wrap {
            display: flex;
            gap: 24px;
        }

        .tab-item {
            font-size: 0.72rem;
            font-weight: 800;
            color: #64748b;
            padding-bottom: 10px;
            cursor: pointer;
            letter-spacing: 0.6px;
            transition: all 0.2s ease;
        }

        .tab-item:hover {
            color: #cbd5e1;
        }

        .tab-item.active {
            color: #38bdf8;
            border-bottom: 2px solid #38bdf8;
        }

        .btn-filter-toggle {
            background: none;
            border: none;
            color: #94a3b8;
            font-size: 0.72rem;
            font-weight: 700;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            margin-bottom: 8px;
        }

        .btn-filter-toggle:hover {
            color: #38bdf8;
        }

        /* 3-Column Report Cards Grid */
        .reports-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 18px;
            margin-bottom: 24px;
        }

        @media (max-width: 1200px) {
            .reports-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .reports-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Report Glass Card */
        .report-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 16px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            min-height: 180px;
            transition: all 0.2s ease;
        }

        .report-card:hover {
            border-color: #38bdf8;
            transform: translateY(-2px);
        }

        .card-top-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }

        .badge-category {
            font-size: 0.65rem;
            font-weight: 800;
            letter-spacing: 0.8px;
            display: flex;
            align-items: center;
            gap: 6px;
            text-transform: uppercase;
        }

        .cat-trend { color: #38bdf8; }
        .cat-risk { color: #f87171; }
        .cat-investigation { color: #38bdf8; }
        .cat-district { color: #cbd5e1; }
        .cat-cyber { color: #38bdf8; }

        .date-chip {
            background-color: #070d18;
            border: 1px solid #1e293b;
            color: #64748b;
            font-size: 0.62rem;
            font-weight: 700;
            padding: 2px 8px;
            border-radius: 4px;
        }

        .report-title-text {
            font-size: 0.95rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 8px;
            line-height: 1.3;
        }

        .report-desc-text {
            font-size: 0.74rem;
            color: #94a3b8;
            line-height: 1.45;
            margin-bottom: 16px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .card-footer-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px solid #162234;
            padding-top: 10px;
        }

        .author-wrap {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .author-avatar {
            width: 24px;
            height: 24px;
            border-radius: 50%;
            background-color: #12283e;
            border: 1px solid #1e293b;
            color: #38bdf8;
            font-size: 0.62rem;
            font-weight: 800;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .author-meta {
            display: flex;
            flex-direction: column;
        }

        .author-lbl {
            font-size: 0.58rem;
            color: #64748b;
        }

        .author-name {
            font-size: 0.72rem;
            font-weight: 700;
            color: #e2e8f0;
        }

        .action-icons-wrap {
            display: flex;
            gap: 10px;
        }

        .btn-icon-action {
            background: none;
            border: none;
            color: #94a3b8;
            cursor: pointer;
            font-size: 0.85rem;
            transition: color 0.2s ease;
        }

        .btn-icon-action:hover {
            color: #38bdf8;
        }

        /* Modal Backdrop */
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
            width: 500px;
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
    <div class="reports-header-row">
        <div>
            <div class="reports-title">Reports & Intelligence Summaries</div>
            <div class="reports-sub-text">Access, generate, and export automated intelligence briefings and data analyses.</div>
        </div>
        <button type="button" class="btn-generate-cyan" onclick="openGenerateModal()">
            ➕ Generate New Report
        </button>
    </div>

    <!-- Category Filter Tabs -->
    <div class="reports-nav-bar">
        <div class="reports-tabs-wrap">
            <div class="tab-item active">ALL REPORTS</div>
            <div class="tab-item">TREND ANALYSIS</div>
            <div class="tab-item">RISK ASSESSMENTS</div>
            <div class="tab-item">INVESTIGATIONS</div>
        </div>
        <button type="button" class="btn-filter-toggle" onclick="alert('Filter options opened.')">
            ⚙ FILTER
        </button>
    </div>

    <!-- 3-Column Grid of Briefing Cards -->
    <div class="reports-grid" id="reportsGrid">
        <!-- Card 1: Q3 Citywide Crime Trend Analysis -->
        <div class="report-card">
            <div>
                <div class="card-top-meta">
                    <span class="badge-category cat-trend">📈 CRIME TREND REPORT</span>
                    <span class="date-chip">Q3 2023</span>
                </div>
                <div class="report-title-text">Q3 Citywide Crime Trend Analysis</div>
                <div class="report-desc-text">
                    Comprehensive overview of major crime categories across all districts, highlighting key statistical deviations and operational patterns.
                </div>
            </div>
            <div class="card-footer-bar">
                <div class="author-wrap">
                    <div class="author-avatar" style="background-color:#070d18; border-color:#00d2ff; color:#00d2ff;">SYS</div>
                    <div class="author-meta">
                        <span class="author-lbl">Generated by</span>
                        <span class="author-name">System Auto-Gen</span>
                    </div>
                </div>
                <div class="action-icons-wrap">
                    <button type="button" class="btn-icon-action" title="Preview Report" onclick="alert('Viewing Q3 Citywide Crime Trend Analysis')">👁</button>
                    <button type="button" class="btn-icon-action" title="Download Briefing" onclick="alert('Downloading PDF Briefing...')">📥</button>
                </div>
            </div>
        </div>

        <!-- Card 2: District 5 Threat Assessment -->
        <div class="report-card">
            <div>
                <div class="card-top-meta">
                    <span class="badge-category cat-risk">⚠️ HIGH-RISK AREA REPORT</span>
                    <span class="date-chip">Oct 24, 2023</span>
                </div>
                <div class="report-title-text">District 5 Threat Assessment</div>
                <div class="report-desc-text">
                    Spatial analysis of recent organized crime activities in D5, identifying three primary hotspot zones requiring tactical deployment.
                </div>
            </div>
            <div class="card-footer-bar">
                <div class="author-wrap">
                    <div class="author-avatar">JD</div>
                    <div class="author-meta">
                        <span class="author-lbl">Generated by</span>
                        <span class="author-name">J. Doe, Lead Analyst</span>
                    </div>
                </div>
                <div class="action-icons-wrap">
                    <button type="button" class="btn-icon-action" title="Preview Report" onclick="alert('Viewing District 5 Threat Assessment')">👁</button>
                    <button type="button" class="btn-icon-action" title="Download Briefing" onclick="alert('Downloading PDF Briefing...')">📥</button>
                </div>
            </div>
        </div>

        <!-- Card 3: Operation Nightfall - Final Brief -->
        <div class="report-card">
            <div>
                <div class="card-top-meta">
                    <span class="badge-category cat-investigation">🌐 INVESTIGATION SUMMARY</span>
                    <span class="date-chip">Oct 20, 2023</span>
                </div>
                <div class="report-title-text">Operation Nightfall - Final Brief</div>
                <div class="report-desc-text">
                    Executive summary of the 6-month operation dismantling the eastern vehicular syndicate and recovering high-value assets.
                </div>
            </div>
            <div class="card-footer-bar">
                <div class="author-wrap">
                    <div class="author-avatar" style="overflow:hidden;">
                        <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&auto=format&fit=crop&q=60" style="width:100%; height:100%; object-fit:cover;" alt="A. Silva" />
                    </div>
                    <div class="author-meta">
                        <span class="author-lbl">Generated by</span>
                        <span class="author-name">A. Silva</span>
                    </div>
                </div>
                <div class="action-icons-wrap">
                    <button type="button" class="btn-icon-action" title="Preview Report" onclick="alert('Viewing Operation Nightfall Summary')">👁</button>
                    <button type="button" class="btn-icon-action" title="Download Briefing" onclick="alert('Downloading PDF Briefing...')">📥</button>
                </div>
            </div>
        </div>

        <!-- Card 4: Monthly Gang Activity Analysis -->
        <div class="report-card">
            <div>
                <div class="card-top-meta">
                    <span class="badge-category cat-district">🏢 DISTRICT CRIME REPORT</span>
                    <span class="date-chip">Oct 15, 2023</span>
                </div>
                <div class="report-title-text">Monthly Gang Activity Analysis</div>
                <div class="report-desc-text">
                    Detailed breakdown of territorial disputes, graffiti tagging mapping, and associated narcotics operations in suburban sectors.
                </div>
            </div>
            <div class="card-footer-bar">
                <div class="author-wrap">
                    <div class="author-avatar" style="background-color:#38bdf8; color:#070d18;">MK</div>
                    <div class="author-meta">
                        <span class="author-lbl">Generated by</span>
                        <span class="author-name">M. Kwan</span>
                    </div>
                </div>
                <div class="action-icons-wrap">
                    <button type="button" class="btn-icon-action" title="Preview Report" onclick="alert('Viewing Monthly Gang Activity Analysis')">👁</button>
                    <button type="button" class="btn-icon-action" title="Download Briefing" onclick="alert('Downloading PDF Briefing...')">📥</button>
                </div>
            </div>
        </div>

        <!-- Card 5: Emerging Phishing Vectors Q4 -->
        <div class="report-card">
            <div>
                <div class="card-top-meta">
                    <span class="badge-category cat-cyber">⚙️ CYBER INTEL BRIEF</span>
                    <span class="date-chip">Oct 10, 2023</span>
                </div>
                <div class="report-title-text">Emerging Phishing Vectors Q4</div>
                <div class="report-desc-text">
                    Analysis of newly identified spear-phishing campaigns targeting municipal database credentials and law enforcement portals.
                </div>
            </div>
            <div class="card-footer-bar">
                <div class="author-wrap">
                    <div class="author-avatar" style="background-color:#070d18; border-color:#00d2ff; color:#00d2ff;">SYS</div>
                    <div class="author-meta">
                        <span class="author-lbl">Generated by</span>
                        <span class="author-name">System Auto-Gen</span>
                    </div>
                </div>
                <div class="action-icons-wrap">
                    <button type="button" class="btn-icon-action" title="Preview Report" onclick="alert('Viewing Cyber Intel Brief')">👁</button>
                    <button type="button" class="btn-icon-action" title="Download Briefing" onclick="alert('Downloading PDF Briefing...')">📥</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Generate New Report Modal -->
    <div class="modal-overlay" id="generateModal">
        <div class="modal-card">
            <div class="modal-header">
                <div class="modal-title">⚡ Generate Intelligence Report</div>
                <button type="button" class="btn-modal-close" onclick="closeGenerateModal()">✕</button>
            </div>

            <div class="form-group">
                <label class="form-label">Report Title</label>
                <input type="text" id="modalTitle" class="form-input" placeholder="e.g. Q4 Regional Hotspot Assessment" />
            </div>

            <div class="form-group">
                <label class="form-label">Report Category</label>
                <select id="modalCategory" class="form-select">
                    <option value="CRIME TREND REPORT">📈 Crime Trend Report</option>
                    <option value="HIGH-RISK AREA REPORT">⚠️ High-Risk Area Report</option>
                    <option value="INVESTIGATION SUMMARY">🌐 Investigation Summary</option>
                    <option value="DISTRICT CRIME REPORT">🏢 District Crime Report</option>
                    <option value="CYBER INTEL BRIEF">⚙️ Cyber Intel Brief</option>
                </select>
            </div>

            <div class="form-group">
                <label class="form-label">Briefing Description</label>
                <textarea id="modalDesc" class="form-input" style="height:70px; resize:none;" placeholder="Summarize intelligence findings..."></textarea>
            </div>

            <div class="modal-actions">
                <button type="button" class="btn-cancel" onclick="closeGenerateModal()">Cancel</button>
                <button type="button" class="btn-create" onclick="submitNewReport()">Generate Report ▶</button>
            </div>
        </div>
    </div>

    <!-- Interactive Script -->
    <script>
        function openGenerateModal() {
            document.getElementById("generateModal").style.display = "flex";
        }

        function closeGenerateModal() {
            document.getElementById("generateModal").style.display = "none";
        }

        function submitNewReport() {
            const title = document.getElementById("modalTitle").value.trim() || "Generated Intelligence Briefing";
            const category = document.getElementById("modalCategory").value;
            const desc = document.getElementById("modalDesc").value.trim() || "Automated tactical overview compilation based on current system records.";

            const grid = document.getElementById("reportsGrid");

            const newCardHtml = `
                <div class="report-card">
                    <div>
                        <div class="card-top-meta">
                            <span class="badge-category cat-trend">📈 ${category}</span>
                            <span class="date-chip">Today</span>
                        </div>
                        <div class="report-title-text">${title}</div>
                        <div class="report-desc-text">${desc}</div>
                    </div>
                    <div class="card-footer-bar">
                        <div class="author-wrap">
                            <div class="author-avatar" style="background-color:#38bdf8; color:#070d18;">DV</div>
                            <div class="author-meta">
                                <span class="author-lbl">Generated by</span>
                                <span class="author-name">Digvijaysinh V.</span>
                            </div>
                        </div>
                        <div class="action-icons-wrap">
                            <button type="button" class="btn-icon-action" title="Preview Report" onclick="alert('Viewing ${title}')">👁</button>
                            <button type="button" class="btn-icon-action" title="Download Briefing" onclick="alert('Downloading PDF Briefing...')">📥</button>
                        </div>
                    </div>
                </div>`;

            grid.insertAdjacentHTML('afterbegin', newCardHtml);
            closeGenerateModal();
            alert("✅ Report generated and archived to database.");
        }
    </script>
</asp:Content>