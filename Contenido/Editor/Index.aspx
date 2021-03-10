<%@ Page Language="VB" MasterPageFile="~/base.master" AutoEventWireup="false" CodeFile="Index.aspx.vb" Inherits="Contenido_Editor_Index" %>

<%@ Register Src="~/controlPersonalizado/miReproductor.ascx" TagPrefix="mr" TagName="miReproductor" %>
<%@ Register Src="~/controlPersonalizado/miImagen.ascx" TagPrefix="mi" TagName="miImagen" %>



<%-- Div video principal --%>
<asp:Content ID="cVideo" ContentPlaceHolderID="CPHContenido1" runat="Server">



    <div class="infoVideo">
        <asp:ScriptManager ID="sm" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:FormView ID="fvDatosVideo" runat="server" DataKeyNames="id" DataSourceID="SqlDsVideoPrincipal" DefaultMode="ReadOnly">
                    <ItemTemplate>
                        <div class="videoPrincipal">
                            <mr:miReproductor ID="videoPrincipal" runat="server" setSrc='<%# Eval("url") %>' />
                        </div>
                        <div class="videoInfo">
                            <div class="info1">
                                <asp:Label ID="lblTitulo" runat="server" CssClass="videoTitulo w-50" Text='<%# Eval("titulo") %>' />
                                <div class="videoLikes w-50">
                                    <div>
                                        <asp:Button ID="imgBtLikes" runat="server" CssClass="far fa-thumbs-up bigger" CommandName="Likes" CommandArgument='<%# Eval("id") %>' />
                                        <asp:Label ID="lbLikes" for="imgbtLikes" runat="server" CssClass="bigger margen" Text='<%# Eval("likes") %>'></asp:Label>
                                    </div>
                                    <div>
                                        <asp:Button ID="imgBtNoLikes" runat="server" CssClass="far fa-thumbs-down bigger" CommandName="NoLikes" CommandArgument='<%# Eval("id") %>' />
                                        <asp:Label ID="lblNoLikes" runat="server" CssClass="bigger " Text='<%# Eval("nolikes") %>'></asp:Label>
                                    </div>
                                </div>
                                <div class="videoFecha w-50">
                                    <asp:Label ID="lblFecha" runat="server" Text='<%# Eval("fecha") %>' /></div>
                                <div class="videoVisualizaciones w-50">
                                    <asp:Label ID="lblVisualizacion" runat="server" Text='<%# Eval("visualizacion") %>' />Visualizaciones </div>
                            </div>
                            <div class="info2">
                                <input id="cb1" type="checkbox" /><label for="cb1">Mostrar mas</label>
                                <div class="videoMas">

                                    <asp:Label ID="lblDescripcion" runat="server" Text='<%# Eval("descripcion") %>' />
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource ID="SqlDsVideoPrincipal" runat="server" ConnectionString="<%$ ConnectionStrings:oretubeConnectionString %>"
                    SelectCommand="SELECT * FROM [Video] WHERE ([url] = @url)">

                    <SelectParameters>
                        <asp:QueryStringParameter Name="url" QueryStringField="vid" Type="String" />
                    </SelectParameters>
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
                <mi:miImagen ID="imagenBarraLateral" runat="server" SetUrl='<%# "~/Contenido/editor/Index.aspx" %>' SetSrc='<%# Eval("url") %>' />
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
