<%@ Page Title="NETRA AI Assistant" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AIAssistant.aspx.cs" Inherits="Netra.AIAssistant" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-header-title-bar {
            margin-bottom: 16px;
        }

        .page-title-text {
            font-size: 1.35rem;
            font-weight: 800;
            color: #ffffff;
        }

        .page-sub-text {
            font-size: 0.78rem;
            color: #64748b;
            margin-top: 2px;
        }

        /* 2-Column Chat Layout */
        .ai-chat-layout {
            display: grid;
            grid-template-columns: 280px 1fr;
            gap: 16px;
            height: calc(100vh - 140px);
            min-height: 620px;
        }

        @media (max-width: 1024px) {
            .ai-chat-layout {
                grid-template-columns: 1fr;
            }
            .ai-history-sidebar {
                display: none;
            }
        }

        /* Sidebar Query History */
        .ai-history-sidebar {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 14px;
            display: flex;
            flex-direction: column;
        }

        .btn-new-chat {
            width: 100%;
            background-color: #a5f3fc;
            border: none;
            color: #070d18;
            padding: 10px;
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 800;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            margin-bottom: 20px;
            transition: all 0.2s ease;
        }

        .btn-new-chat:hover {
            background-color: #38bdf8;
            box-shadow: 0 0 12px rgba(56, 189, 248, 0.4);
        }

        .sidebar-section-title {
            font-size: 0.65rem;
            font-weight: 800;
            letter-spacing: 0.8px;
            color: #64748b;
            text-transform: uppercase;
            margin-bottom: 12px;
        }

        .query-history-list {
            display: flex;
            flex-direction: column;
            gap: 6px;
            overflow-y: auto;
            flex-grow: 1;
        }

        .query-history-item {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 6px;
            padding: 10px 12px;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .query-history-item:hover {
            border-color: #00d2ff;
            background-color: #0e1a2b;
        }

        .query-history-item.active {
            background-color: #12283e;
            border-color: #00d2ff;
        }

        .query-title {
            font-size: 0.78rem;
            font-weight: 700;
            color: #ffffff;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .query-time {
            font-size: 0.62rem;
            color: #64748b;
            margin-top: 4px;
            padding-left: 18px;
        }

        /* Main Chat Canvas Area */
        .ai-chat-canvas {
            background-color: #070d18;
            border: 1px solid #1e293b;
            border-radius: 8px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            overflow: hidden;
            padding: 20px;
        }

        .chat-messages-container {
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 18px;
            padding-right: 8px;
            flex-grow: 1;
        }

        /* AI Message Bubble */
        .msg-row-ai {
            display: flex;
            gap: 12px;
            max-width: 85%;
        }

        .ai-avatar-icon {
            width: 32px;
            height: 32px;
            border-radius: 6px;
            background-color: #00d2ff;
            color: #070d18;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.9rem;
            flex-shrink: 0;
            font-weight: 800;
        }

        .ai-bubble-box {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 14px 16px;
            color: #cbd5e1;
            font-size: 0.8rem;
            line-height: 1.5;
        }

        /* Quick Action Chips */
        .quick-chips-wrap {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-top: 12px;
        }

        .btn-chip {
            background-color: #070d18;
            border: 1px solid #1e293b;
            color: #f8fafc;
            padding: 6px 12px;
            border-radius: 14px;
            font-size: 0.7rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-chip:hover {
            border-color: #00d2ff;
            color: #00d2ff;
            background-color: #12283e;
        }

        /* User Message Bubble */
        .msg-row-user {
            display: flex;
            gap: 12px;
            justify-content: flex-end;
            align-self: flex-end;
            max-width: 80%;
        }

        .user-bubble-box {
            background-color: #12283e;
            border: 1px solid #00d2ff;
            border-radius: 8px;
            padding: 12px 16px;
            color: #ffffff;
            font-size: 0.8rem;
            line-height: 1.5;
        }

        .user-avatar-icon {
            width: 32px;
            height: 32px;
            border-radius: 6px;
            background-color: #1e293b;
            border: 1px solid #38bdf8;
            overflow: hidden;
            flex-shrink: 0;
        }

        .user-avatar-icon img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        /* Hotspot Alert Embedded Card */
        .hotspot-card-embed {
            background-color: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.3);
            border-radius: 6px;
            padding: 12px;
            margin: 10px 0;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .hotspot-icon {
            width: 32px;
            height: 32px;
            background-color: rgba(239, 68, 68, 0.2);
            color: #ef4444;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1rem;
        }

        /* Input Dock Area */
        .chat-input-dock {
            background-color: #0b1320;
            border: 1px solid #1e293b;
            border-radius: 8px;
            padding: 12px;
            margin-top: 14px;
        }

        .chat-textarea {
            width: 100%;
            background: transparent;
            border: none;
            color: #ffffff;
            font-size: 0.82rem;
            outline: none;
            resize: none;
            height: 48px;
        }

        .input-toolbar-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px solid #1a2536;
            padding-top: 8px;
            margin-top: 6px;
        }

        .input-tools-left {
            display: flex;
            gap: 12px;
            color: #64748b;
            font-size: 0.9rem;
        }

        .tool-icon-btn {
            cursor: pointer;
            transition: color 0.2s ease;
        }

        .tool-icon-btn:hover {
            color: #00d2ff;
        }

        .btn-submit-cyan {
            background-color: #a5f3fc;
            border: none;
            color: #070d18;
            padding: 7px 16px;
            border-radius: 6px;
            font-size: 0.78rem;
            font-weight: 800;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s ease;
        }

        .btn-submit-cyan:hover {
            background-color: #38bdf8;
            box-shadow: 0 0 10px rgba(56, 189, 248, 0.4);
        }

        .ai-disclaimer-footer {
            font-size: 0.62rem;
            color: #64748b;
            text-align: center;
            margin-top: 6px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Header Title -->
    <div class="page-header-title-bar">
        <div class="page-title-text">NETRA AI Assistant</div>
        <div class="page-sub-text">Ask questions about authorized crime intelligence data.</div>
    </div>

    <!-- Main 2-Column Chat Grid -->
    <div class="ai-chat-layout">
        <!-- Left Sidebar: History -->
        <div class="ai-history-sidebar">
            <button type="button" class="btn-new-chat" onclick="resetChatSession()">
                ➕ New Conversation
            </button>

            <div class="sidebar-section-title">RECENT QUERIES</div>

            <div class="query-history-list">
                <div class="query-history-item active">
                    <div class="query-title">💬 Vehicle theft trends Q3</div>
                    <div class="query-time">Today, 09:41 AM</div>
                </div>

                <div class="query-history-item">
                    <div class="query-title">💬 Person P-1042 associations</div>
                    <div class="query-time">Yesterday, 14:22 PM</div>
                </div>

                <div class="query-history-item">
                    <div class="query-title">💬 High-risk zones District 4</div>
                    <div class="query-time">Oct 24, 11:05 AM</div>
                </div>
            </div>
        </div>

        <!-- Right Main Canvas: Chat Screen -->
        <div class="ai-chat-canvas">
            <div class="chat-messages-container" id="chatStream">
                <!-- AI Welcome Message -->
                <div class="msg-row-ai">
                    <div class="ai-avatar-icon">⚙️</div>
                    <div class="ai-bubble-box">
                        <div style="font-weight:700; color:#ffffff; margin-bottom:4px;">Intelligence Engine Online. Authorization confirmed.</div>
                        I can assist with querying case files, generating predictive models, analyzing entity networks, or compiling spatial crime data. How can I assist with your investigation today?
                        
                        <div class="quick-chips-wrap">
                            <button type="button" class="btn-chip" onclick="sendQuickPrompt('Show vehicle theft trends')">📈 Show vehicle theft trends</button>
                            <button type="button" class="btn-chip" onclick="sendQuickPrompt('List high-risk areas')">⚠️ List high-risk areas</button>
                            <button type="button" class="btn-chip" onclick="sendQuickPrompt('Cases associated with P-1042')">👥 Cases associated with P-1042</button>
                        </div>
                    </div>
                </div>

                <!-- User Query Message -->
                <div class="msg-row-user">
                    <div class="user-bubble-box">
                        Analyze recent vehicle theft trends in Sector 7 over the past 30 days. Highlight any emerging hotspots.
                    </div>
                    <div class="user-avatar-icon">
                        <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&auto=format&fit=crop&q=60" alt="User Avatar" />
                    </div>
                </div>

                <!-- AI Response Message -->
                <div class="msg-row-ai">
                    <div class="ai-avatar-icon">⚙️</div>
                    <div class="ai-bubble-box">
                        <div>Processing Sector 7 vehicular data (T-30 days)...</div>
                        <div style="margin-top:6px;">Analysis complete. <strong>47 incidents</strong> of vehicle theft reported in Sector 7 over the last 30 days. This represents a <strong>14% increase</strong> compared to the previous period.</div>

                        <!-- Embedded Hotspot Card -->
                        <div class="hotspot-card-embed">
                            <div class="hotspot-icon">🚨</div>
                            <div>
                                <div style="font-weight:800; color:#ef4444; font-size:0.82rem;">Critical Hotspot Identified</div>
                                <div style="font-size:0.72rem; color:#cbd5e1;">Commercial District North (Grid ref: 7A-9) - 18 incidents.</div>
                            </div>
                        </div>

                        <div>Common modus operandi involves keyless entry relay attacks occurring primarily between 0200 and 0400 hours.</div>
                    </div>
                </div>
            </div>

            <!-- Bottom Textarea Input Dock -->
            <div class="chat-input-dock">
                <textarea id="txtPrompt" class="chat-textarea" placeholder="Ask NETRA about crime trends, entity connections, or operational data..."></textarea>
                <div class="input-toolbar-row">
                    <div class="input-tools-left">
                        <span class="tool-icon-btn" title="Attach Document">📎</span>
                        <span class="tool-icon-btn" title="Pin Location">📍</span>
                    </div>
                    <button type="button" class="btn-submit-cyan" onclick="submitUserQuery()">
                        Submit Query ▶
                    </button>
                </div>
            </div>

            <div class="ai-disclaimer-footer">
                ℹ️ AI-generated analysis should be reviewed by authorized personnel.
            </div>
        </div>
    </div>

    <!-- Client Script -->
    <script>
        function submitUserQuery() {
            const promptInput = document.getElementById("txtPrompt");
            const val = promptInput.value.trim();
            if (val === "") return;

            const stream = document.getElementById("chatStream");

            // Append User Message
            const userHtml = `
                <div class="msg-row-user">
                    <div class="user-bubble-box">${val}</div>
                    <div class="user-avatar-icon">
                        <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&auto=format&fit=crop&q=60" alt="User Avatar" />
                    </div>
                </div>`;
            stream.insertAdjacentHTML('beforeend', userHtml);
            promptInput.value = "";

            // Append Simulated AI Response
            setTimeout(() => {
                const aiHtml = `
                    <div class="msg-row-ai">
                        <div class="ai-avatar-icon">⚙️</div>
                        <div class="ai-bubble-box">
                            <div>Querying neural database...</div>
                            <div style="margin-top:4px;">Intelligence data query returned <strong>3 related records</strong> matching '${val}'. Operational log archived.</div>
                        </div>
                    </div>`;
                stream.insertAdjacentHTML('beforeend', aiHtml);
                stream.scrollTop = stream.scrollHeight;
            }, 600);
        }

        function sendQuickPrompt(promptText) {
            document.getElementById("txtPrompt").value = promptText;
            submitUserQuery();
        }

        function resetChatSession() {
            alert("✨ New conversation session started.");
            location.reload();
        }
    </script>
</asp:Content>