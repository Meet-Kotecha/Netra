<%@ Page Title="Intelligence Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Netra._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2 style="margin-bottom: 5px;">Neural Threat Intelligence Dashboard</h2>
    <p style="color:#94a3b8; margin-bottom:25px;">Real-time crime threat overview and active investigation metrics.</p>

    <div style="display:grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap:20px;">
        <div style="background-color:#1e293b; padding:20px; border-radius:8px; border:1px solid #334155;">
            <span style="color:#94a3b8; font-size:0.85rem;">TOTAL CASES RECORDED</span>
            <h1 style="color:#06b6d4; margin-top:10px;">1,248</h1>
        </div>
        <div style="background-color:#1e293b; padding:20px; border-radius:8px; border:1px solid #334155;">
            <span style="color:#94a3b8; font-size:0.85rem;">CRITICAL SEVERITY</span>
            <h1 style="color:#ef4444; margin-top:10px;">42</h1>
        </div>
        <div style="background-color:#1e293b; padding:20px; border-radius:8px; border:1px solid #334155;">
            <span style="color:#94a3b8; font-size:0.85rem;">IDENTIFIED SUSPECTS</span>
            <h1 style="color:#f59e0b; margin-top:10px;">315</h1>
        </div>
        <div style="background-color:#1e293b; padding:20px; border-radius:8px; border:1px solid #334155;">
            <span style="color:#94a3b8; font-size:0.85rem;">SYSTEM STATUS</span>
            <h1 style="color:#10b981; margin-top:10px;">ONLINE</h1>
        </div>
    </div>
</asp:Content>