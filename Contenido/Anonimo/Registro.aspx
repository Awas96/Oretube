<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Registro.aspx.vb" Inherits="Registro" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Home</title>
    <link href="../../Content/bootstrap.min.css" rel="stylesheet" />
    <link href="../../Content/header.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-3.0.0.min.js"></script>
    <script src="../../Scripts/bootstrap.js"></script>
    <script src="../../Scripts/bootstrap.min.js"></script>
    <script src="../../Scripts/popper.min.js"></script>
    <script src="../../Scripts/fontawesome.js"></script>
    <script src="../../Scripts/header.js"></script>
    <script src="../../Content/fontawesome.css"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-group">
            <header>
                <asp:ImageButton ID="imgBt1" CssClass="timlogo" runat="server" ImageUrl="~/imagenes/logo.png" />
                <div class="nav-modal">
                    <div class="blob"></div>
                    <nav>
                        <ul>

                            <li><a runat="server" id="TituloNombreUsuario">Anonimo</a></li>
                           
                               
                    </nav>
                </div>
                <div class="head">
                    <a href="#" class="tile socialmedia"><i class="fa fa-facebook-official"></i></a>
                    <a href="#" class="tile socialmedia"><i class="fa fa-instagram"></i></a>
                    <a href="#" class="tile socialmedia"><i class="fa fa-twitter-square"></i></a>
                    <div class="tile burger">
                        <div class="meat">
                            <div class="line one"></div>
                            <div class="line two"></div>
                            <div class="line three"></div>
                        </div>
                    </div>
                </div>
            </header>
            <section style="margin:auto;width:20%; padding: 1em; background-color:aliceblue;">
                <asp:FormView ID="fvOretube" runat="server" DataSourceID="SPRegistroDS">
                    <InsertItemTemplate>
                        login:
                <asp:TextBox ID="usuarioTextBox" CssClass="form-control" runat="server" Text='<%# Bind("login") %>' />
                        <asp:RequiredFieldValidator ID="rfvUsuario" runat="server" ControlToValidate="usuarioTextBox" ErrorMessage="Introduzca su nombre de usuario."></asp:RequiredFieldValidator>

                        <br />
                        password:
                <asp:TextBox ID="passwordTextBox" CssClass="form-control" TextMode="Password" runat="server" Text='<%# Bind("password") %>' />
                        <asp:RequiredFieldValidator ID="rfvPassword" CssClass="form-control" runat="server" ControlToValidate="passwordTextBox" EnableTheming="True" ErrorMessage="Introuzca su contraseña."></asp:RequiredFieldValidator>


                        Repita su contraseña:
                <asp:TextBox ID="passwordTextBox2" CssClass="form-control" TextMode="Password" runat="server" />
                        <asp:RequiredFieldValidator ID="rfvPasswor2" runat="server" ControlToValidate="passwordTextBox2" EnableTheming="True" ErrorMessage="Repita su contraseña."></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="cvPassword" runat="server" ControlToCompare="passwordTextBox2" ControlToValidate="passwordTextBox" ErrorMessage="Las contraseñas no coinciden."></asp:CompareValidator>

                        <br />
                        email:
                <asp:TextBox ID="emailTextBox" CssClass="form-control" runat="server" Text='<%# Bind("email") %>' />
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="emailTextBox" ErrorMessage="Introduzca su dirección de correo electrónico."></asp:RequiredFieldValidator>

                        <br />
                        nombre:
                <asp:TextBox ID="nombreTextBox" CssClass="form-control" runat="server" Text='<%# Bind("nombre") %>' />
                        <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="nombreTextBox" ErrorMessage="Introduzca su nombre y apellidos."></asp:RequiredFieldValidator>

                        <br />
                        departamento:              
                <asp:DropDownList ID="ddlDepartamento" CssClass="form-control" runat="server" DataSourceID="SqlDsDepartamento" AppendDataBoundItems="True" DataTextField="nombre" DataValueField="id" SelectedValue='<%# Bind("departamento") %>'>
                    <asp:ListItem Text="Elige departamento" Value="" />
                </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvDepartamento" runat="server" ErrorMessage="Elige un departamento" ControlToValidate="ddlDepartamento" ForeColor="red"></asp:RequiredFieldValidator>
                        <asp:SqlDataSource ID="SqlDsDepartamento" runat="server" ConnectionString="<%$ ConnectionStrings:oretubeConnectionString %>" SelectCommand="SELECT * FROM [Departamento]"></asp:SqlDataSource>
                        <br />
                        <asp:LinkButton ID="InsertButton" CssClass="btn btn-primary" runat="server" CausesValidation="True" CommandName="Insert" Text="Insertar" />
                       

                    </InsertItemTemplate>
                </asp:FormView>
                 <asp:LinkButton ID="LbSalir" CssClass="btn btn-danger" runat="server" CausesValidation="False"  Text="Salir" />
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
            </section>
        </div>
    </form>

</body>
</html>
