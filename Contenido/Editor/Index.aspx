<%@ Page Language="VB" MasterPageFile="~/base.master" AutoEventWireup="false" CodeFile="Index.aspx.vb" Inherits="Contenido_Editor_Index" %>

<%@ Register Src="~/controlPersonalizado/miReproductor.ascx" TagPrefix="mr" TagName="miReproductor" %>
<%@ Register Src="~/controlPersonalizado/miImagen.ascx" TagPrefix="mi" TagName="miImagen" %>



<%-- Div video principal --%>
<asp:Content ID="cVideo" ContentPlaceHolderID="CPHContenido1" runat="Server">

    <div class="videoPrincipal">
        <mr:miReproductor ID="videoPrincipal" runat="server" />
        <%-- controlUsuario --%>
    </div>

    <div class="infoVideo">
        <asp:ScriptManager ID="sm" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:FormView ID="fvDatosVideo" runat="server" DataKeyNames="id" DataSourceID="SqlDsVideoPrincipal" DefaultMode="ReadOnly">
                    <ItemTemplate>
                        <p class="infoVideo__text">
                            <asp:Label ID="lblTitulo" runat="server" Text='<%# Eval("titulo") %>' />
                            -
                            <asp:Label ID="lblDescripcion" runat="server" Text='<%# Eval("descripcion") %>' />
                        </p>
                        <p class="infoVideo__text">
                            visualizacion:
                            <asp:Label ID="lblVisualizacion" runat="server" Text='<%# Eval("visualizacion") %>' />
                            -
                            <asp:Label ID="lblFecha" runat="server" Text='<%# Eval("fecha") %>' />
                            <asp:ImageButton ID="imgBtLikes" runat="server" ImageUrl="~/img/likes.jpg" CommandName="Likes" CommandArgument='<%# Eval("id") %>' /><%-- id del video --%>

                            <asp:Label ID="lbLikes" runat="server" Text='<%# Eval("likes") %>' />

                            <asp:ImageButton ID="imgBtNoLikes" runat="server" ImageUrl="~/img/nolikes.jpg" CommandName="NoLikes" CommandArgument='<%# Eval("id") %>' /><%-- id del video --%>
                            <asp:Label ID="lblNoLikes" runat="server" Text='<%# Eval("nolikes") %>' />
                        </p>
                    </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource ID="SqlDsVideoPrincipal" runat="server" ConnectionString="<%$ ConnectionStrings:oretubeConnectionString %>"
                    SelectCommand="SELECT * FROM [Video] WHERE ([url] = @url)">

                    <SelectParameters>
                        <asp:Parameter Name="url" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="votante" Type="Int32" />
                        <asp:Parameter Name="elVideo" Type="Int32" />
                        <asp:Parameter Name="votacion" Type="Boolean" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>


<%-- Div Vídeos verticales lateral derecho --%>
<asp:Content ID="cBarraMenu" ContentPlaceHolderID="CPHAside1" runat="Server">
    <asp:ListView ID="LBSeleccionVideo" runat="server" DataKeyNames="id" DataSourceID="SQLDSSeleccionVideos">
        <ItemTemplate>
            <div class="imagenVideo">

                <mi:miImagen ID="imagenBarraLateral" runat="server" setSrc='<%# Eval("url") %>' />
            </div>

            <div class="infoVideo">
               
                    <asp:Label ID="tituloLabel" runat="server" CssClass="titulo" Text='<%# Eval("titulo") %>' />
                    <asp:Label ID="fechaLabel" runat="server" Text='<%# Eval("fecha") %>' />
                
                <div>
                    <asp:Label ID="visualizacionLabel" runat="server" Text='<%# Eval("visualizacion") %>' />
                    Visualizaciones
                </div>
            </div>

        </ItemTemplate>

    </asp:ListView>
    <asp:SqlDataSource ID="SQLDSSeleccionVideos" runat="server" ConnectionString="<%$ ConnectionStrings:oretubeConnectionString %>"
        SelectCommand="SELECT * FROM [Video] ORDER BY [fecha] DESC"></asp:SqlDataSource>
</asp:Content>
