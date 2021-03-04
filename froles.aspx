<%@ Page Language="VB" AutoEventWireup="false" CodeFile="froles.aspx.vb" Inherits="froles" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
<link type="text/css" href="recursos/estilos2.css" rel="stylesheet" />

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
</head>
<body onload="maximizar()">
    <form id="miForm" runat="server">
        <div class="intro">
             <asp:Image ID="logo" runat="server" ImageUrl="~/imagenes/logo.png"  Width="100px"  />
             <div class="aviso">
                  <asp:Label ID="aviso" runat="server" Text="Seleccione su rol de trabajo" />
             </div>
        </div>
        <div class="tarjeta-in">
             <div style="padding-top:25px;">
                <div class="circle-mask" >
                     <canvas id="canvas" class="circle" width="96" height="96"></canvas>
                </div>
             </div>
             <div style="margin-top:40px;">
                   <asp:DropDownList ID="DDLroles" runat="server" CssClass="textbox" />
             </div>
            
             <div style="margin-top:40px">
                 <asp:Button ID="BTempezar" runat="server" Text="Comenzar trabajo" CssClass="boton" />
             </div>

             <div style="text-align:left;padding-left:20px;margin-top:20px">
                   <asp:CheckBox ID="CKcontinuar" runat="server" Checked="True"  Text="Seguir con la misma cuenta"/>
             </div>
        </div>
    </form>
</body>
</html>