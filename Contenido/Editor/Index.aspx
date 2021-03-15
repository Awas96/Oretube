<%@ Page Language="VB" MasterPageFile="~/base.master" AutoEventWireup="false" CodeFile="Index.aspx.vb" Inherits="Contenido_Editor_Index" %>

<%@ Register Src="~/controlPersonalizado/miReproductor.ascx" TagPrefix="mr" TagName="miReproductor" %>
<%@ Register Src="~/controlPersonalizado/miImagen.ascx" TagPrefix="mi" TagName="miImagen" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>


<%-- Boton Subir video --%>
<asp:Content ID="CHeader" ContentPlaceHolderID="CPHMenu" runat="Server">
    <li>
         <asp:LinkButton CssClass="text-center" runat="server" ID="BtnSubir" PostBackUrl="~/Contenido/Editor/SubirVideo.aspx" Text=""><i class="fas fa-upload"></i> Subir Video</asp:LinkButton>              
    </li>
</asp:Content>

<%-- Div video principal --%>
<asp:Content ID="cVideo" ContentPlaceHolderID="CPHContenido1" runat="Server">



    <div class="infoVideo">
        <asp:ScriptManager ID="sm" runat="server">
        </asp:ScriptManager>
        <asp:FormView ID="fvDatosVideo" runat="server" DataKeyNames="id" DataSourceID="SqlDsVideoPrincipal">
            <ItemTemplate>
                <div class="videoPrincipal">
                    <mr:miReproductor ID="videoPrincipal" runat="server" setSrc='<%# Eval("url") %>' />
                </div>
                <div class="videoInfo">
                    <div class="info1">

                        <asp:Label ID="lblTitulo" runat="server" CssClass="videoTitulo w-50" Text='<%# Eval("titulo") %>' />

                        <asp:UpdatePanel ID="UpdPanel" class="videoLikes w-50" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                            <ContentTemplate>
                                <div>
                                    <asp:LinkButton ID="imgBtLikes" runat="server" OnClick="imgBtLikes_Click"> <i style="color: black" class="far fa-thumbs-up bigger"></i></asp:LinkButton>
                                    <asp:Label ID="lbLikes" for="imgbtLikes" runat="server" CssClass="bigger margen" Text='<%# buscarLikes(1) %>'></asp:Label>
                                </div>
                                <div>
                                    <asp:LinkButton ID="imgBtNoLikes" runat="server" CssClass="manitaAbajo" OnClick="imgBtNoLikes_Click">  <i style="color: black" class="far fa-thumbs-down bigger"></i> </asp:LinkButton>
                                    <asp:Label ID="lblNoLikes" runat="server" CssClass="bigger " Text='<%# buscarLikes(0) %>'></asp:Label>
                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="imgBtLikes" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>

                        <%--  --%>

                        <div class="videoFecha w-50">
                            <asp:Label ID="lblFecha" runat="server" Text='<%# Format(Eval("fecha"), "short date") %>' />
                        </div>
                        <div class="videoVisualizaciones w-50">
                            <asp:Label ID="lblVisualizacion" runat="server" Text='<%# Eval("visualizacion") %>' />
                            Visualizaciones
                        </div>
                    </div>
                    <div class="info2">
                        <input id="cb1" type="checkbox" class="hidden" /><label for="cb1" class="boton1 btn btn-info"> <i class=" botonIcono fas fa-caret-down bigger"></i>Mostrar descripción</label>
                        <div class="videoMas">

                            <asp:Label ID="lblDescripcion" CssClass="desc hidden" runat="server" Text='<%# Eval("descripcion") %>' />
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:FormView>
        <asp:SqlDataSource ID="SQLDSVotar" runat="server" ConnectionString="<%$ ConnectionStrings:oretubeConnectionString %>"
            SelectCommand="SELECT * FROM [Video] WHERE ([url] = @url)"
            UpdateCommand="votar_sp" UpdateCommandType="StoredProcedure">
            <SelectParameters>
                <asp:QueryStringParameter Name="url" QueryStringField="vid" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="votante" Type="Int32" />
                <asp:Parameter Name="elVideo" Type="Int32" />
                <asp:Parameter Name="votacion" Type="Boolean" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDsVideoPrincipal" runat="server" ConnectionString="<%$ ConnectionStrings:oretubeConnectionString %>"
            SelectCommand="SELECT * FROM [Video] WHERE ([url] = @url)">

            <SelectParameters>
                <asp:QueryStringParameter Name="url" QueryStringField="vid" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SQLDSVotosUsuarios" runat="server"
            ConnectionString="<%$ ConnectionStrings:oretubeConnectionString %>"
            UpdateCommand="UPDATE [Video] SET [likes] = @likes, [nolikes] = @nolikes WHERE [url] = @url">


            <UpdateParameters>

                <asp:QueryStringParameter Name="url" QueryStringField="vid" Type="String" />
                <asp:Parameter Name="likes" Type="Int32" />
                <asp:Parameter Name="nolikes" Type="Int32" />

            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
    <hr />
</asp:Content>
<%-- Div para Comentarios --%>
<asp:Content ID="cComentarios" ContentPlaceHolderID="CPHContenido2" runat="Server">




 

    <div>
        <%-- Leer Comentarios de gente --%>
        <asp:FormView ID="FVEscribirComentario" CssClass="w-100" runat="server" DataKeyNames="id" DataSourceID="SQLDSEscribirComentaro">
               
            <InsertItemTemplate>
                <p><i class="far fa-comments"></i>Comentarios: </p>
                <div class="comentar">
                    <label>Hacer Comentario:</label>
                    <asp:TextBox ID="textoTextBox" CssClass="comentarTexto" runat="server" Text='<%# Bind("texto") %>' />
                   <asp:LinkButton ID="InsertButton" CssClass="btn btn-secondary anchuraBoton" runat="server" CausesValidation="True" CommandName="Insert" Text="Aceptar" />
                </div>
            </InsertItemTemplate>


        </asp:FormView>
        <asp:SqlDataSource ID="SQLDSEscribirComentaro" runat="server" ConnectionString="<%$ ConnectionStrings:oretubeConnectionString %>"
            InsertCommand="INSERT INTO [Comentario] ([fecha], [texto], [usuario], [video]) VALUES (@fecha, @texto, @usuario, @video)">

            <InsertParameters>
                <asp:Parameter Name="fecha" Type="DateTime" />
                <asp:Parameter Name="texto" Type="String" />
                <asp:Parameter Name="usuario" Type="Int32" />
                <asp:Parameter Name="video" Type="Int32" />
            </InsertParameters>

        </asp:SqlDataSource>
    </div>
    <%-- Leer Comentarios de gente --%>
    <div>
        <asp:ListView ID="LVComentarios" runat="server" DataSourceID="SQLDSComentario">
            <EmptyDataTemplate>
                <span>No hay comentarios.</span>
            </EmptyDataTemplate>

            <ItemTemplate>

                <div class="comentario small">
                    <div class="comentarioCabecera">
                        <asp:Label ID="loginLabel" CssClass="font-weight-bold bigger" runat="server" Text='<%# Eval("login") %>' />
                        <asp:Label ID="fechaLabel" CssClass="" runat="server" Text='<%# Format(Eval("fecha"), "short date") %>' />
                    </div>
                    <div class="comentarioCuerpo">
                        <asp:Label ID="textoLabel" runat="server" Text='<%# Eval("texto") %>' />
                    </div>
                </div>

            </ItemTemplate>
            <LayoutTemplate>
                <div id="itemPlaceholderContainer" runat="server" style="">
                    <span runat="server" id="itemPlaceholder" />
                </div>
                <div style="">
                    <asp:DataPager ID="DataPager1" runat="server">
                        <Fields>
                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ButtonCssClass="btn btn-secondary" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                            <asp:NumericPagerField />
                            <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ButtonCssClass="btn btn-secondary" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                        </Fields>
                    </asp:DataPager>
                </div>
            </LayoutTemplate>
            <SelectedItemTemplate>

                <br />
                </span>
            </SelectedItemTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="SQLDSComentario" runat="server" ConnectionString="<%$ ConnectionStrings:oretubeConnectionString %>" SelectCommand="SELECT Comentario.fecha, Comentario.texto, Comentario.usuario, Usuario.login FROM Comentario INNER JOIN Video ON Comentario.video = Video.id INNER JOIN Usuario ON Comentario.usuario = Usuario.id WHERE (Video.url = @video) GROUP BY Comentario.fecha, Comentario.texto, Comentario.usuario, Usuario.login">
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="" Name="video" QueryStringField="vid" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>

<%-- Div Vídeos verticales lateral derecho --%>
<asp:Content ID="cBarraMenu" ContentPlaceHolderID="CPHAside1" runat="Server">
    <asp:ListView ID="LBSeleccionVideo" runat="server" DataKeyNames="id" DataSourceID="SQLDSSeleccionVideos">
        <ItemTemplate>
            <div class="asideContent">
                <div class="imagenVideo">
                    <mi:miImagen ID="imagenBarraLateral" runat="server" SetUrl='<%# "~/Contenido/editor/Index.aspx" %>' SetSrc='<%# Eval("url") %>' />
                </div>
                <div class="infoVideo small">
                    <asp:Label ID="tituloLabel" runat="server" CssClass="titulo font-weight-bold" Text='<%# Eval("titulo") %>' />
                    <asp:Label ID="fechaLabel" runat="server" Text='<%# Format(Eval("fecha"), "short date") %>' />
                    <div>
                        <asp:Label ID="visualizacionLabel" runat="server" Text='<%# Eval("visualizacion") %>' />
                        Visualizaciones
               
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:ListView>
    <asp:SqlDataSource ID="SQLDSSeleccionVideos" runat="server" ConnectionString="<%$ ConnectionStrings:oretubeConnectionString %>"
        SelectCommand="SELECT Video.id, Video.titulo, Video.fecha, Video.descripcion, Video.duracion, Video.etiquetas, Video.visualizacion, Video.likes, Video.nolikes, Video.url, Video.usuario, Video.departamento FROM Video INNER JOIN Usuario ON Video.usuario = Usuario.id AND Video.departamento = Usuario.departamento ORDER BY Video.fecha DESC">
    </asp:SqlDataSource>
</asp:Content>

