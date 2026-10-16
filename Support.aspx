<%@ Page Title="Support" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Support.aspx.cs" Inherits="Netra.Support" %>

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

        /* Search Bar Banner */
        .help-search-banner {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 16px;
            margin-bottom: 20px;
            position: relative;
        }

        .help-search-banner input {
            width: 100%;
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 12px 16px 12px 40px;
            color: #ffffff;
            font-size: 0.82rem;
            outline: none;
            transition: border-color 0.2s ease;
        }

        .help-search-banner input:focus {
            border-color: #00d2ff;
        }

        .help-search-icon {
            position: absolute;
            left: 30px;
            top: 50%;
            transform: translateY(-50%);
            color: #64748b;
            font-size: 0.9rem;
        }

        /* Split Main Layout */
        .support-grid {
            display: grid;
            grid-template-columns: 1fr 340px;
            gap: 20px;
            margin-bottom: 20px;
        }

        @media (max-width: 1024px) {
            .support-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Category Cards Subgrid */
        .category-cards-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
            margin-bottom: 20px;
        }

        .cat-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 18px;
            transition: border-color 0.2s ease;
        }

        .cat-card:hover {
            border-color: #00d2ff;
        }

        .cat-title {
            font-size: 0.92rem;
            font-weight: 800;
            color: #ffffff;
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 6px;
        }

        .cat-sub {
            font-size: 0.72rem;
            color: #64748b;
            margin-bottom: 12px;
            line-height: 1.4;
        }

        .cat-link {
            font-size: 0.75rem;
            font-weight: 800;
            color: #00d2ff;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        /* FAQ Section */
        .glass-panel {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 20px;
        }

        .panel-title {
            font-size: 0.92rem;
            font-weight: 800;
            color: #ffffff;
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 16px;
        }

        .faq-item {
            border-bottom: 1px solid #162234;
            padding: 12px 0;
            cursor: pointer;
        }

        .faq-item:last-child {
            border-bottom: none;
        }

        .faq-question {
            font-size: 0.78rem;
            font-weight: 700;
            color: #cbd5e1;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .faq-question:hover {
            color: #00d2ff;
        }

        .faq-answer {
            font-size: 0.72rem;
            color: #64748b;
            margin-top: 8px;
            display: none;
            line-height: 1.4;
        }

        /* Right Column Cards */
        .status-card {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 18px;
            margin-bottom: 16px;
        }

        .status-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 14px;
        }

        .badge-operational-tag {
            background-color: rgba(16, 185, 129, 0.15);
            border: 1px solid rgba(16, 185, 129, 0.4);
            color: #34d399;
            font-size: 0.62rem;
            font-weight: 800;
            padding: 2px 8px;
            border-radius: 4px;
        }

        .status-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 8px 0;
            font-size: 0.75rem;
            border-bottom: 1px solid #162234;
        }

        .status-row:last-child {
            border-bottom: none;
        }

        .status-lbl {
            color: #cbd5e1;
        }

        .badge-mini-op {
            background-color: rgba(6, 182, 212, 0.15);
            border: 1px solid rgba(6, 182, 212, 0.4);
            color: #00d2ff;
            font-size: 0.6rem;
            font-weight: 800;
            padding: 2px 6px;
            border-radius: 4px;
        }

        /* Assistance Buttons */
        .btn-cyan-full {
            width: 100%;
            background-color: #00d2ff;
            border: none;
            color: #070d18;
            padding: 9px;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 800;
            cursor: pointer;
            margin-top: 12px;
            margin-bottom: 8px;
            transition: all 0.2s ease;
        }

        .btn-cyan-full:hover {
            opacity: 0.9;
            box-shadow: 0 0 12px rgba(0, 210, 255, 0.4);
        }

        .btn-outline-full {
            width: 100%;
            background-color: #070d18;
            border: 1px solid #1e293b;
            color: #cbd5e1;
            padding: 9px;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 800;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-outline-full:hover {
            border-color: #00d2ff;
            color: #00d2ff;
        }

        .btn-feedback-outline {
            width: 100%;
            background-color: #070d18;
            border: 1px solid #1e293b;
            color: #cbd5e1;
            padding: 8px;
            border-radius: 6px;
            font-size: 0.72rem;
            font-weight: 700;
            cursor: pointer;
            margin-top: 12px;
        }

        .btn-feedback-outline:hover {
            border-color: #64748b;
            color: #ffffff;
        }

        /* Disclaimer Footer Notice */
        .security-notice-bar {
            border-top: 1px solid #1e293b;
            padding-top: 16px;
            margin-top: 20px;
            text-align: center;
            font-size: 0.68rem;
            color: #64748b;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Page Header -->
    <div class="page-header-row">
        <div class="page-title">Support</div>
        <div class="page-sub-text">Get help with NETRA, report issues and find useful resources.</div>
    </div>

    <!-- Search Help Banner -->
    <div class="help-search-banner">
        <span class="help-search-icon">🔍</span>
        <input type="text" placeholder="Search help articles, features or common issues..." />
    </div>

    <!-- Split Grid -->
    <div class="support-grid">
        <!-- Left Column: Help Categories & FAQ -->
        <div>
            <!-- Category Cards -->
            <div class="category-cards-grid">
                <!-- Getting Started -->
                <div class="cat-card">
                    <div class="cat-title">🚀 Getting Started</div>
                    <div class="cat-sub">Basic tutorials and overview of NETRA core functionalities.</div>
                    <a href="#" class="cat-link" onclick="alert('Opening Getting Started Guide...'); return false;">View Help →</a>
                </div>

                <!-- Case Management -->
                <div class="cat-card">
                    <div class="cat-title">📁 Case Management</div>
                    <div class="cat-sub">Learn how to create, manage, and share crime cases effectively.</div>
                    <a href="#" class="cat-link" onclick="alert('Opening Case Management Documentation...'); return false;">View Help →</a>
                </div>

                <!-- Analytics & Intelligence -->
                <div class="cat-card">
                    <div class="cat-title">📈 Analytics & Intelligence</div>
                    <div class="cat-sub">Deep dive into data visualization, network analysis, and AI tools.</div>
                    <a href="#" class="cat-link" onclick="alert('Opening Analytics & AI Documentation...'); return false;">View Help →</a>
                </div>

                <!-- Account & Security -->
                <div class="cat-card">
                    <div class="cat-title">🔓 Account & Security</div>
                    <div class="cat-sub">Manage your profile, permissions, and security settings.</div>
                    <a href="#" class="cat-link" onclick="window.location.href='SecuritySettings.aspx'; return false;">View Help →</a>
                </div>
            </div>

            <!-- FAQ Panel -->
            <div class="glass-panel">
                <div class="panel-title">❓ Frequently Asked Questions</div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">
                        <span>How do I register a new crime case?</span>
                        <span>˅</span>
                    </div>
                    <div class="faq-answer">
                        Navigate to <b>Crime Cases</b> in the sidebar and click on the <b>+ Register New Case</b> button. Complete the required field details and submit.
                    </div>
                </div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">
                        <span>How do I use the Crime Intelligence Map?</span>
                        <span>˅</span>
                    </div>
                    <div class="faq-answer">
                        Select <b>Crime Map</b> from the sidebar menu. You can apply filters by district, crime type, or date range to visualize geographic clusters.
                    </div>
                </div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">
                        <span>What formats are supported for Bulk Data Import?</span>
                        <span>˅</span>
                    </div>
                    <div class="faq-answer">
                        The platform supports <b>CSV, XLSX, and JSON</b> files up to 50MB per batch upload.
                    </div>
                </div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">
                        <span>How to request access to restricted modules?</span>
                        <span>˅</span>
                    </div>
                    <div class="faq-answer">
                        Contact your System Administrator via <b>User Management</b> or send an authorization request to support@netra.gov.
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Column: System Status & Contact -->
        <div>
            <!-- System Status -->
            <div class="status-card">
                <div class="status-header">
                    <div class="panel-title" style="margin-bottom:0;">⚙️ System Status</div>
                    <span class="badge-operational-tag">● All Systems Operational</span>
                </div>

                <div class="status-row">
                    <span class="status-lbl">Core Database</span>
                    <span class="badge-mini-op">Operational</span>
                </div>

                <div class="status-row">
                    <span class="status-lbl">AI Services Engine</span>
                    <span class="badge-mini-op">Operational</span>
                </div>

                <div class="status-row">
                    <span class="status-lbl">Crime Map Rendering</span>
                    <span class="badge-mini-op">Operational</span>
                </div>

                <div class="status-row">
                    <span class="status-lbl">Notification Services</span>
                    <span class="badge-mini-op">Operational</span>
                </div>
            </div>

            <!-- Need Further Assistance? -->
            <div class="status-card">
                <div class="panel-title" style="margin-bottom:12px;">Need Further Assistance?</div>
                
                <div style="font-size:0.72rem; color:#cbd5e1; margin-bottom:4px;">✉️ Email Support</div>
                <div style="font-size:0.75rem; color:#00d2ff; font-weight:700; margin-bottom:12px;">support@netra.gov</div>

                <div style="font-size:0.72rem; color:#cbd5e1; margin-bottom:2px;">🕒 Operating Hours</div>
                <div style="font-size:0.72rem; color:#64748b; margin-bottom:10px;">09:00 - 18:00 IST (Mon-Fri)</div>

                <button type="button" class="btn-cyan-full" onclick="alert('Opening Live Support Desk...');">🎧 Contact Support</button>
                <button type="button" class="btn-outline-full" onclick="alert('Issue report form opened.');">🐞 Report an Issue</button>
            </div>

            <!-- Help Us Improve NETRA -->
            <div class="status-card">
                <div class="panel-title" style="margin-bottom:6px;">Help Us Improve NETRA</div>
                <div style="font-size:0.72rem; color:#64748b; line-height:1.4;">Your feedback is critical for enhancing system capabilities.</div>

                <button type="button" class="btn-feedback-outline" onclick="alert('Opening feedback form...');">✉️ Send Feedback</button>
            </div>
        </div>
    </div>

    <!-- Security Disclaimer Footer -->
    <div class="security-notice-bar">
        ⚠️ SECURITY NOTICE: Do not include sensitive operational intelligence, classified case details, or PII in standard support requests or feedback forms.
    </div>

    <!-- FAQ Accordion Logic -->
    <script>
        function toggleFaq(elem) {
            const answer = elem.querySelector('.faq-answer');
            const isVisible = answer.style.display === 'block';

            document.querySelectorAll('.faq-answer').forEach(a => a.style.display = 'none');

            if (!isVisible) {
                answer.style.display = 'block';
            }
        }
    </script>
</asp:Content>