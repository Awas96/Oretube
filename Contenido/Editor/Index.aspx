<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Index.aspx.vb" Inherits="Contenido_Editor_Index" %>

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
        <header>
            <asp:ImageButton ID="imgBt1" CssClass="timlogo" runat="server" ImageUrl="~/imagenes/logo.png" />
            <div class="nav-modal">
                <div class="blob"></div>
                <nav>
                    <ul>
                       
                        <li><a runat="server" id="TituloNombreUsuario">Usuario</a></li>
                        <li><a runat="server">Logueado como Editor</a></li>
                        <li><asp:LinkButton CssClass="text-center" runat="server" ID="BtnSalir" Text="Salir de la Aplicacion"></asp:LinkButton></li>
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
        <section>
            <h1>Welcome to Oretube!</h1>

        </section>
    </form>
</body>
</html>
