<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Netra.Login" %>

<!DOCTYPE html>

<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>NETRA - Sign In</title>
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
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .login-card {
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

        .form-group {
            text-align: left;
            margin-bottom: 20px;
        }

        .form-label-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 6px;
        }

        .form-label {
            color: #94a3b8;
            font-size: 0.7rem;
            font-weight: 700;
            letter-spacing: 0.8px;
            text-transform: uppercase;
        }

        .forgot-link {
            color: #06b6d4;
            font-size: 0.7rem;
            text-decoration: none;
            font-weight: 600;
        }

        .forgot-link:hover {
            text-decoration: underline;
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

        .remember-row {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 22px;
            text-align: left;
        }

        .remember-row label {
            color: #94a3b8;
            font-size: 0.8rem;
            cursor: pointer;
        }

        .btn-signin {
            width: 100%;
            background: linear-gradient(135deg, #a5f3fc 0%, #cff4fc 100%);
            color: #080e18;
            border: none;
            border-radius: 4px;
            padding: 11px;
            font-size: 0.85rem;
            font-weight: 700;
            letter-spacing: 1px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            transition: opacity 0.2s;
        }

        .btn-signin:hover {
            opacity: 0.9;
        }

        .val-error {
            color: #ef4444;
            font-size: 0.75rem;
            margin-top: 4px;
            display: block;
        }

        .security-badge {
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #1e293b;
            display: inline-block;
        }

        .badge-pill {
            background-color: #2a1215;
            color: #f87171;
            border: 1px solid #451a1d;
            border-radius: 4px;
            padding: 5px 12px;
            font-size: 0.68rem;
            font-weight: 700;
            letter-spacing: 0.8px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-card">
            <!-- Icon & Branding -->
            <div class="icon-box">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                    <circle cx="12" cy="12" r="3"></circle>
                </svg>
            </div>
            <div class="brand-title">NETRA</div>
            <div class="brand-subtitle">NEURAL THREAT INTELLIGENCE &<br />RESPONSE ANALYTICS</div>

            <!-- Username Input -->
            <div class="form-group">
                <div class="form-label-row">
                    <span class="form-label">USERNAME OR EMAIL</span>
                </div>
                <div class="input-wrapper">
                    <span class="input-icon">👤</span>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-input" Placeholder="Enter credentials" />
                </div>
                <asp:RequiredFieldValidator ID="rfvUser" runat="server" ControlToValidate="txtUsername"
                    ErrorMessage="Username is required." CssClass="val-error" Display="Dynamic" />
            </div>

            <!-- Password Input -->
            <div class="form-group">
                <div class="form-label-row">
                    <span class="form-label">PASSWORD</span>
                    <a href="ForgotPassword.aspx" class="forgot-link">Forgot Password?</a>
                </div>
                <div class="input-wrapper">
                    <span class="input-icon">🔒</span>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-input" Placeholder="••••••••" />
                </div>
                <asp:RequiredFieldValidator ID="rfvPass" runat="server" ControlToValidate="txtPassword"
                    ErrorMessage="Password is required." CssClass="val-error" Display="Dynamic" />
            </div>

            <!-- Remember Me Checkbox -->
            <div class="remember-row">
                <asp:CheckBox ID="chkRemember" runat="server" />
                <label for="<%= chkRemember.ClientID %>">Remember me</label>
            </div>

            <!-- Error Label -->
            <asp:Label ID="lblLoginError" runat="server" CssClass="val-error" style="margin-bottom: 12px; text-align: center;"></asp:Label>

            <!-- Sign In Button -->
            <asp:Button ID="btnSignIn" runat="server" Text="SIGN IN ➔" CssClass="btn-signin" OnClick="btnSignIn_Click" />

            <!-- Security Badge Footer -->
            <div class="security-badge">
                <div class="badge-pill">
                    🛡️ AUTHORIZED ACCESS ONLY
                </div>
            </div>
        </div>
    </form>
</body>
</html>