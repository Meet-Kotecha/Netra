<%@ Page Title="Persons & Suspects Directory" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PersonsDirectory.aspx.cs" Inherits="Netra.PersonsDirectory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .table-card {
            background-color: #1e293b;
            border: 1px solid #334155;
            border-radius: 8px;
            padding: 20px;
            margin-top: 15px;
        }
        .filter-bar {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }
        .form-control {
            padding: 8px 12px;
            background-color: #0f172a;
            border: 1px solid #334155;
            border-radius: 4px;
            color: #f8fafc;
        }
        .gridview-table {
            width: 100%;
            border-collapse: collapse;
            color: #f8fafc;
        }
        .gridview-table th {
            background-color: #0f172a;
            color: #06b6d4;
            text-align: left;
            padding: 12px;
            border-bottom: 1px solid #334155;
        }
        .gridview-table td {
            padding: 12px;
            border-bottom: 1px solid #334155;
        }
        .badge-suspect { background-color: #7f1d1d; color: #fca5a5; padding: 4px 8px; border-radius: 4px; font-size: 0.8rem; }
        .badge-poi { background-color: #1e3a8a; color: #93c5fd; padding: 4px 8px; border-radius: 4px; font-size: 0.8rem; }
        .badge-witness { background-color: #14532d; color: #86efac; padding: 4px 8px; border-radius: 4px; font-size: 0.8rem; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Persons & Suspects Directory</h2>
    
    <div class="table-card">
        <div class="filter-bar">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Placeholder="Filter by Name, Person ID..." style="width:250px;" />
            <asp:DropDownList ID="ddlType" runat="server" CssClass="form-control">
                <asp:ListItem Text="All Person Types" Value="All" />
                <asp:ListItem Text="Suspect" Value="Suspect" />
                <asp:ListItem Text="POI" Value="POI" />
                <asp:ListItem Text="Witness" Value="Witness" />
            </asp:DropDownList>
        </div>

        <table class="gridview-table">
            <thead>
                <tr>
                    <th>PROFILE</th>
                    <th>PERSON ID</th>
                    <th>TYPE</th>
                    <th>ASSOCIATED CASES</th>
                    <th>KNOWN LOCATIONS</th>
                    <th>LAST UPDATED</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><strong>Volkov, Dmitri</strong><br /><small style="color:#94a3b8;">DOB: 1982-04-12</small></td>
                    <td>PR-892-441-A</td>
                    <td><span class="badge-suspect">SUSPECT</span></td>
                    <td>#CS-2023-08A, #CS-2022-19B</td>
                    <td>Prague, CZ; Vienna, AT</td>
                    <td>2026-10-24 14:32Z</td>
                </tr>
                <tr>
                    <td><strong>Unknown (Alias: 'Ghost')</strong><br /><small style="color:#94a3b8;">DOB: Unknown</small></td>
                    <td>PR-U99-102-X</td>
                    <td><span class="badge-poi">POI</span></td>
                    <td>#CS-2023-08A</td>
                    <td>Digital Footprint Only</td>
                    <td>2026-10-22 09:15Z</td>
                </tr>
                <tr>
                    <td><strong>Chen, Elena</strong><br /><small style="color:#94a3b8;">DOB: 1990-11-03</small></td>
                    <td>PR-112-998-C</td>
                    <td><span class="badge-witness">WITNESS</span></td>
                    <td>#CS-2023-14D</td>
                    <td>London, UK</td>
                    <td>2026-10-20 11:45Z</td>
                </tr>
            </tbody>
        </table>
    </div>
</asp:Content>