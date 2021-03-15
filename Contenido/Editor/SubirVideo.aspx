<%@ Page Language="VB" MasterPageFile="~/base.master" AutoEventWireup="false" CodeFile="SubirVideo.aspx.vb" Inherits="Contenido_Editor_Index" %>



<%-- Div video principal --%>
<asp:Content ID="cVideo" ContentPlaceHolderID="CPHContenido1" runat="Server">
    <div class="form-group" style="margin: auto; padding: 1em; display: flex; flex-direction: column; margin: 0 atto; background-color: aliceblue;">
        <h1>Subir Video</h1>
        <div>
            <label class="col-form-label">Subida: </label>
            <div>
                <asp:FileUpload ID="FUVideoSubir" CssClass="mb-4" runat="server" />
            </div>
            <asp:RequiredFieldValidator ID="RFVVideo" runat="server" ControlToValidate="FUVideoSubir" ErrorMessage="Campo Obligatorio"></asp:RequiredFieldValidator>
            <div>
            </div>
        </div>
        <asp:FormView ID="FVSubirVideo" runat="server" DataKeyNames="id" DataSourceID="SqlDSSubirVideo">

            <InsertItemTemplate>
                <div>
                    <label class="col-form-label">Título: </label>
                    <asp:TextBox ID="tituloTextBox" CssClass="form-control " runat="server" Text='<%# Bind("titulo") %>' />
                </div>
                <asp:RequiredFieldValidator ID="RFVTitulo" runat="server" ControlToValidate="tituloTextBox" ErrorMessage="Campo Obligatorio"></asp:RequiredFieldValidator>

                <div>
                    <label class="c">Descripción: </label>
                    <asp:TextBox ID="descripcionTextBox" CssClass="form-control " runat="server" Text='<%# Bind("descripcion") %>' />
                </div>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tituloTextBox" ErrorMessage="Campo Obligatorio"></asp:RequiredFieldValidator>

                <div>
                    <label class="col-form-label">Etiquetas: </label>
                    <asp:TextBox ID="etiquetasTextBox" CssClass="form-control" runat="server" Text='<%# Bind("etiquetas") %>' />
                </div>
                <div class="mt-5">
                    <asp:LinkButton ID="InsertButton" runat="server" CssClass="btn btn-info" CausesValidation="True" CommandName="Insert" Text="Subir" />
                    <asp:LinkButton ID="InsertCancelButton" runat="server" CssClass="btn btn-danger" CausesValidation="False" CommandName="Cancel" Text="Cancelar" />
                </div>

                <asp:Label ID="UploadSatusLabel" runat="server"></asp:Label>
            </InsertItemTemplate>

        </asp:FormView>
        <asp:SqlDataSource ID="SqlDSSubirVideo" runat="server"
            ConnectionString="<%$ ConnectionStrings:oretubeConnectionString %>"
            InsertCommand="INSERT INTO [Video] ([titulo], [fecha], [descripcion], [duracion], [etiquetas], [visualizacion], [likes], [nolikes], [url], [usuario], [departamento]) VALUES (@titulo, @fecha, @descripcion, @duracion, @etiquetas, @visualizacion, @likes, @nolikes, @url, @usuario, @departamento)">
            <InsertParameters>
                <asp:Parameter Name="titulo" Type="String" />
                <asp:Parameter Name="fecha" Type="DateTime" />
                <asp:Parameter Name="descripcion" Type="String" />
                <asp:Parameter Name="duracion" Type="String" />
                <asp:Parameter Name="etiquetas" Type="String" />
                <asp:Parameter Name="visualizacion" Type="Int32" />
                <asp:Parameter Name="likes" Type="Int32" />
                <asp:Parameter Name="nolikes" Type="Int32" />
                <asp:Parameter Name="url" Type="String" />
                <asp:Parameter Name="usuario" Type="Int32" />
                <asp:Parameter Name="departamento" Type="Byte" />
            </InsertParameters>

        </asp:SqlDataSource>

    </div>

</asp:Content>

