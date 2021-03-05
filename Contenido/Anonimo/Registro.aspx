<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Registro.aspx.vb" Inherits="Registro" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <%-- <script src = "js/jquery-1.8.2.js" ></script>  --%>
    <%-- <script src="js/jquery-ui.js"></script>        --%>
    <%-- <script src = "js/llamadaAjax.js" ></script>   --%>
</head>
<body>
    <form id="form1" runat="server">

        <asp:FormView ID="fvOretube" runat="server" DataSourceID="SPRegistroDS">
            <InsertItemTemplate>
                login:
                <asp:TextBox ID="usuarioTextBox" runat="server" Text='<%# Bind("login") %>' />
                <asp:RequiredFieldValidator ID="rfvUsuario" runat="server" ControlToValidate="usuarioTextBox" ErrorMessage="Introduzca su nombre de usuario."></asp:RequiredFieldValidator>

                <br />
                password:
                <asp:TextBox ID="passwordTextBox" TextMode="Password" runat="server" Text='<%# Bind("password") %>' />
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="passwordTextBox" EnableTheming="True" ErrorMessage="Introuzca su contraseña."></asp:RequiredFieldValidator>

                <br />
                Repita su contraseña:
                <asp:TextBox ID="passwordTextBox2" TextMode="Password" runat="server" />
                <asp:RequiredFieldValidator ID="rfvPasswor2" runat="server" ControlToValidate="passwordTextBox2" EnableTheming="True" ErrorMessage="Repita su contraseña."></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cvPassword" runat="server" ControlToCompare="passwordTextBox2" ControlToValidate="passwordTextBox" ErrorMessage="Las contraseñas no coinciden."></asp:CompareValidator>

                <br />
                email:
                <asp:TextBox ID="emailTextBox" runat="server" Text='<%# Bind("email") %>' />
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="emailTextBox" ErrorMessage="Introduzca su dirección de correo electrónico."></asp:RequiredFieldValidator>

                <br />
                nombre:
                <asp:TextBox ID="nombreTextBox" runat="server" Text='<%# Bind("nombre") %>' />
                <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="nombreTextBox" ErrorMessage="Introduzca su nombre y apellidos."></asp:RequiredFieldValidator>

                <br />
                departamento:              
                <asp:DropDownList ID="ddlDepartamento" runat="server" DataSourceID="SqlDsDepartamento" AppendDataBoundItems="True" DataTextField="nombre" DataValueField="id" SelectedValue='<%# Bind("departamento") %>'>
                    <asp:ListItem Text="Elige departamento" Value="" />
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvDepartamento" runat="server" ErrorMessage="Elige un departamento" ControlToValidate="ddlDepartamento" ForeColor="red"></asp:RequiredFieldValidator>
                <asp:SqlDataSource ID="SqlDsDepartamento" runat="server" ConnectionString="<%$ ConnectionStrings:oretubeConnectionString %>" SelectCommand="SELECT * FROM [Departamento]"></asp:SqlDataSource>
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insertar" />

            </InsertItemTemplate>
        </asp:FormView>

        <asp:SqlDataSource ID="SPRegistroDS" runat="server" ConnectionString="<%$ ConnectionStrings:oretubeConnectionString %>"
            InsertCommand="userRegistro_sp" InsertCommandType="StoredProcedure">
            <InsertParameters>
                <asp:Parameter Name="login" Type="String" />
                <asp:Parameter Name="password" Type="String" />
                <asp:Parameter Name="email" Type="String" />
                <asp:Parameter Name="nombre" Type="String" />
                <asp:Parameter Name="departamento" Type="Byte" />
                <asp:Parameter Direction="Output" Name="k" DbType="Guid" />
            </InsertParameters>
        </asp:SqlDataSource>

        <asp:Label ID="panelMensajes" runat="server" Text=""></asp:Label>

    </form>
</body>
</html>
