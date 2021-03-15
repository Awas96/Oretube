<%@ Control Language="VB" AutoEventWireup="false" CodeFile="miImagen.ascx.vb" Inherits="miImagen" %>


<asp:ImageButton ID="imVideo" runat="server" CssClass="imagen" PostBackUrl='<%# aniadirRedireccion() %>'  ImageUrl='<%# construirPath() %>' />

<asp:SqlDataSource ID="sqldsUpdateVideo" runat="server" ConnectionString="<%$ ConnectionStrings:oretubeConnectionString %>" 
    UpdateCommand="UPDATE [Video] SET [visualizacion] = @visualizacion WHERE [url] = @url">
    
    <UpdateParameters>
        <asp:Parameter Name="visualizacion" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>

