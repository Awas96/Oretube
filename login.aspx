<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Login.aspx.vb" Inherits="login" %>
<%@ Register Assembly="Recaptcha.Web" Namespace="Recaptcha.Web.UI.Controls"TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script type="text/javascript">

        function maximizar()
        {
                window.moveTo(0, 0);
                if (document.all) {
                    top.window.resizeTo(screen.availWidth, screen.availHeight);
                }
                else if (document.layers || document.getElementById) {
                    if (top.window.outerHeight < screen.availHeight || top.window.outerWidth < screen.availWidth) {
                        top.window.outerHeight = screen.availHeight;
                        top.window.outerWidth = screen.availWidth;
                    }
                }
        } 

    </script>
    <link type="text/css"  href="recursos/estilos.css" rel="stylesheet" />
</head>
<body onload="maximizar()">
    <form id="miForm" runat="server">
        <div class="intro">
             <div class="aviso">
                  <asp:Label ID="aviso" runat="server" Text="Iniciar sesión para acceder" />
             </div>
        </div>
        <div class="tarjeta-in" style="padding-bottom:1.5em;">
             <div style="padding-top:25px;">
             </div>
             <div style="margin-top:20px;">
                 <asp:TextBox ID="TBAlias" runat="server" CssClass="textbox" />
                 <div style="padding-top:5px; padding-left:20px;text-align:left">
                     <asp:RequiredFieldValidator ID="RFValias" runat="server" Display="Static" ControlToValidate="TBAlias" ErrorMessage="Introduce tu Alias." cssClass="validator"/>
                 </div>
             </div>
             <div style="margin-top:10px">
                 <asp:TextBox ID="TBClave" runat="server" TextMode="Password" CssClass="textbox"  />
                 <div style="padding-top:5px; padding-left:20px; padding-right:20px;text-align :left">
                     <asp:RequiredFieldValidator ID="RFClave" runat="server" Display="Dynamic" ControlToValidate="TBClave" ErrorMessage="Introduce tu contraseña."  cssClass="validator"/>
                     <asp:RegularExpressionValidator ID="REClave" runat="server" Display="Dynamic" ControlToValidate="TBClave" ErrorMessage="Contraseña entre 6 y 15 caracteres" ValidationExpression="\w{6,15}" cssClass="validator" />
                     <asp:CustomValidator ID="CVok" runat="server" Display="Dynamic" ErrorMessage="Lo sentimos, el nombre del usuario y/o la contraseña no son correctos." cssClass="validator" OnServerValidate="OKusuario" />
                 </div>
                 
             </div>
             <div style="margin-top:5px">
                 <asp:Button ID="BTvalidar" runat="server" Text="Iniciar sesión" CssClass="boton" />
             </div>
             <div style="text-align:left;padding-left:15px;margin-top:10px">
                   <asp:CheckBox ID="CKrecordar" runat="server" Checked="False"  Text="Recordar en este equipo"/>
             </div>
             
        </div>
        
 
    </form>
</body>
</html>