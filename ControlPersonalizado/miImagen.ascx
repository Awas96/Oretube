<%@ Control Language="VB" AutoEventWireup="false" CodeFile="miImagen.ascx.vb" Inherits="miImagen" %>


<asp:ImageButton ID="imVideo" runat="server" CssClass="imagen" PostBackUrl='<%# aniadirRedireccion() %>'  ImageUrl='<%# construirPath() %>' />



