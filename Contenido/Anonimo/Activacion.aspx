<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Activacion.aspx.vb" Inherits="Activacion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:SqlDataSource ID="SqlDSActivar" runat="server" ConnectionString="<%$ ConnectionStrings:oretubeConnectionString %>"
                SelectCommand="SELECT * FROM [Usuario] WHERE ([key] = @key)"
                UpdateCommand="UPDATE [Usuario] SET [activado] = 1 WHERE [key] = @key">
                <UpdateParameters>
                    <asp:QueryStringParameter Name="key" QueryStringField="K" DbType="Guid" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:Label ID="LbResult" runat="server" Text="Label"></asp:Label>
        </div>
    </form>
</body>
</html>
