<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="Netra.ForgotPassword" %>

<!DOCTYPE html>

<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>NETRA - Forgot Password</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
        }

        body {
            background-color: #080e18;
            height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .card-container {
            background-color: #0f1724;
            border: 1px solid #1e293b;
            border-top: 1px solid #06b6d4;
            border-radius: 8px;
            width: 380px;
            padding: 35px 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            text-align: center;
        }

        .icon-box {
            width: 42px;
            height: 42px;
            background-color: #162234;
            border: 1px solid #06b6d4;
            border-radius: 6px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: #06b6d4;
            margin-bottom: 12px;
        }

        .brand-title {
            color: #ffffff;
            font-size: 1.25rem;
            font-weight: 700;
            letter-spacing: 2px;
            margin-bottom: 4px;
        }

        .brand-subtitle {
            color: #64748b;
            font-size: 0.68rem;
            font-weight: 600;
            letter-spacing: 1px;
            text-transform: uppercase;
            line-height: 1.3;
            margin-bottom: 30px;
        }

        .section-title {
            color: #ffffff;
            font-size: 1.05rem;
            font-weight: 600;
            text-align: left;
            margin-bottom: 6px;
        }

        .section-desc {
            color: #64748b;
            font-size: 0.78rem;
            text-align: left;
            line-height: 1.45;
            margin-bottom: 24px;
        }

        .form-group {
            text-align: left;
            margin-bottom: 22px;
        }

        .form-label {
            display: block;
            color: #94a3b8;
            font-size: 0.7rem;
            font-weight: 700;
            letter-spacing: 0.8px;
            text-transform: uppercase;
            margin-bottom: 6px;
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #64748b;
            font-size: 0.9rem;
        }

        .form-input {
            width: 100%;
            background-color: #0a101d;
            border: 1px solid #1e293b;
            border-radius: 4px;
            padding: 10px 12px 10px 36px;
            color: #f8fafc;
            font-size: 0.85rem;
            outline: none;
            transition: border-color 0.2s;
        }

        .form-input:focus {
            border-color: #06b6d4;
        }

        .btn-reset {
            width: 100%;
            background-color: #00e5ff;
            background: linear-gradient(135deg, #00e5ff 0%, #00b8d4 100%);
            color: #080e18;
            border: none;
            border-radius: 4px;
            padding: 11px;
            font-size: 0.8rem;
            font-weight: 700;
            letter-spacing: 1px;
            cursor: pointer;
            transition: opacity 0.2s;
            margin-bottom: 20px;
        }

        .btn-reset:hover {
            opacity: 0.9;
        }

        .divider {
            border-top: 1px solid #1e293b;
            margin-bottom: 20px;
        }

        .back-row {
            color: #94a3b8;
            font-size: 0.78rem;
        }

        .back-link {
            color: #00e5ff;
            text-decoration: none;
            font-weight: 700;
            letter-spacing: 0.5px;
            margin-left: 4px;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .val-error {
            color: #ef4444;
            font-size: 0.75rem;
            margin-top: 4px;
            display: block;
        }

        .status-msg {
            color: #10b981;
            font-size: 0.8rem;
            margin-top: 10px;
            display: block;
        }

        .footer-badge {
            margin-top: 40px;
            color: #64748b;
            font-size: 0.68rem;
            font-weight: 700;
            letter-spacing: 1.2px;
            text-transform: uppercase;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="card-container">
            <!-- Icon & Branding -->
            <div class="icon-box">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                    <circle cx="12" cy="12" r="3"></circle>
                </svg>
            </div>
            <div class="brand-title">NETRA</div>
            <div class="brand-subtitle">NEURAL THREAT INTELLIGENCE &<br />RESPONSE ANALYTICS</div>

            <!-- Header Text -->
            <div class="section-title">Forgot Password?</div>
            <div class="section-desc">Enter your registered email address and we'll send you instructions to reset your password.</div>

            <!-- Email Input -->
            <div class="form-group">
                <label class="form-label">EMAIL ADDRESS</label>
                <div class="input-wrapper">
                    <span class="input-icon">✉</span>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-input" Placeholder="Enter your registered email" />
                </div>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                    ErrorMessage="Email address is required." CssClass="val-error" Display="Dynamic" />
                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                    ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"
                    ErrorMessage="Enter a valid email address." CssClass="val-error" Display="Dynamic" />
            </div>

            <!-- Submit Button -->
            <asp:Button ID="btnReset" runat="server" Text="SEND RESET LINK" CssClass="btn-reset" OnClick="btnReset_Click" />
            
            <asp:Label ID="lblStatus" runat="server" CssClass="status-msg"></asp:Label>

            <div class="divider"></div>

            <!-- Back link -->
            <div class="back-row">
                Remember your password? <a href="Login.aspx" class="back-link">BACK TO SIGN IN</a>
            </div>
        </div>

        <div class="footer-badge">AUTHORIZED ACCESS ONLY</div>
    </form>
</body>
</html>