
Imports System.Data.SqlClient

Partial Class Contenido_Editor_Index
    Inherits System.Web.UI.Page

    Private Sub Contenido_Editor_Index_Init(sender As Object, e As EventArgs) Handles Me.Init
        FVSubirVideo.ChangeMode(FormViewMode.Insert)
        Response.Write(Session("dUsuario").Rows.Item(0).Item(0).ToString)
    End Sub


    Private Sub FVSubirVideo_ItemInserting(sender As Object, e As FormViewInsertEventArgs) Handles FVSubirVideo.ItemInserting
        If FUVideoSubir.FileName.Contains(".mp4") Then
            Try
                SqlDSSubirVideo.InsertParameters.Item("fecha").DefaultValue = DateTime.Now()
                SqlDSSubirVideo.InsertParameters.Item("duracion").DefaultValue = "01:00"
                SqlDSSubirVideo.InsertParameters.Item("duracion").DefaultValue = "01:00"
                SqlDSSubirVideo.InsertParameters.Item("visualizacion").DefaultValue = 0
                SqlDSSubirVideo.InsertParameters.Item("likes").DefaultValue = 0
                SqlDSSubirVideo.InsertParameters.Item("nolikes").DefaultValue = 0
                SqlDSSubirVideo.InsertParameters.Item("url").DefaultValue = Split(FUVideoSubir.FileName, ".")(0)
                SqlDSSubirVideo.InsertParameters.Item("usuario").DefaultValue = Session("dUsuario").Rows.Item(0).Item(0).ToString
                SqlDSSubirVideo.InsertParameters.Item("departamento").DefaultValue = 1 'Por falta de tiempo no hare los departamentos

            Catch ex As Exception
                Response.Write(Session("dUsuario").Rows.Item(0).Item(0).ToString)
            End Try
        Else
            e.Cancel = True
        End If


    End Sub

    Private Sub FVSubirVideo_ItemInserted(sender As Object, e As FormViewInsertedEventArgs) Handles FVSubirVideo.ItemInserted
        Dim Directorio = "/deposit/0/"
        Dim appPath = Request.PhysicalApplicationPath

        If FUVideoSubir.HasFile Then
            Dim DirectorioGuardar = appPath & Directorio + Server.HtmlEncode(FUVideoSubir.FileName)
            FUVideoSubir.SaveAs(DirectorioGuardar)
        End If
        Response.Redirect("index.aspx")
    End Sub

    Private Sub FVSubirVideo_ItemCommand(sender As Object, e As FormViewCommandEventArgs) Handles FVSubirVideo.ItemCommand
        Dim comando As String = e.CommandName.ToString
        If comando = "Cancel" Then
            Response.Redirect("index.aspx")
        End If
    End Sub
End Class