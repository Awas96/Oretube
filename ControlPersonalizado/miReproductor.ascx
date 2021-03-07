<%@ Control Language="VB" AutoEventWireup="false" CodeFile="miReproductor.ascx.vb" Inherits="miReproductor" %>

<video id="videoReproductor" class="video" runat="server" controls="controls">
    <source src='<%= construirPath() %>' type="video/mp4" />
</video>
