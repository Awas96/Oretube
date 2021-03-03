
Imports System.Data.SqlClient
Imports System.IO
Imports System.Net.Mail

Partial Class Registro
    Inherits System.Web.UI.Page

    Private Sub Registro_Load(sender As Object, e As EventArgs) Handles Me.Load
        fvOretube.ChangeMode(FormViewMode.Insert)
    End Sub

    Private Sub SPRegistroDS_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SPRegistroDS.Inserted

        Dim email As TextBox = fvOretube.FindControl("emailTextBox")
        Dim ruta As String
        ruta = "http://172.21.240.32/oretube/activacion.aspx?K="
        Dim clave = e.Command.Parameters("@k").Value.ToString


        Dim cuerpo As String = "para validar el usuario pincha en el enlace a continuacion..." & ruta & clave & "(Solo funcional en Clase)"
        Response.Write("clave : " & clave & "<br>")

        EnviarEmail(email.Text, "Email de Activacion para Oretube!", cuerpo)
    End Sub

    Private Sub SPRegistroDS_Inserting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SPRegistroDS.Inserting
        If (Esta(e.Command.Parameters("@login").Value)) Then
            e.Cancel = True
            Throw New Exception("El usuario ya existe!")
        End If
    End Sub

    Private Sub fvOretube_ItemInserted(sender As Object, e As FormViewInsertedEventArgs) Handles fvOretube.ItemInserted
        If e.Exception IsNot Nothing Then

            panelMensajes.Text = e.Exception.Message

            e.ExceptionHandled = True

            e.KeepInInsertMode = True
        Else

            panelMensajes.Text = "Añadido Correctamente"
            e.KeepInInsertMode = True
        End If

    End Sub



    Public Function EnviarEmail(ByVal direccion As String, ByVal asunto As String, ByVal mensaje As String, ByVal ParamArray adjuntos() As String) As Boolean 'Los ParamArray son opcionales
        Dim ok As Boolean = True
        Try
            If Not Regex.IsMatch(direccion, "^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$") Then Throw New System.Exception()

            Dim origen As MailAddress = New MailAddress("AwasCorreoPrueba@gmail.com", "Activacion de usuario para app de Libreria!") ' La cuenta de correo no tiene porque ser la misma que la utilizada en el cliente SMTP.
            Dim destino As MailAddress = New MailAddress(direccion)

            Dim mail As New MailMessage(origen, destino) With {.Subject = asunto, .Body = mensaje}

            Dim cliente As SmtpClient = New SmtpClient("smtp.gmail.com") 'Para gmail "smtp.gmail.com" y hotmail/Outlook/live "smtp.office365.com"
            With cliente
                .Credentials = New System.Net.NetworkCredential("AwasCorreoPrueba@gmail.com", "eradeprueba")
                .Port = 587 'Para gmail "587" y hotmail/Outlook/live "587"
                .EnableSsl = True 'Para gmail(SSL/TLS) "True" y hotmail/Outlook/live(STARTTLS) "True"
            End With

            If adjuntos.Count <> 0 Then
                For Each archivo As String In adjuntos
                    If Not File.Exists(archivo) Then Throw New System.Exception()
                    mail.Attachments.Add(New Attachment(archivo))
                Next
            End If

            cliente.Send(mail)
        Catch ex As Exception
            Response.Write(ex)
            ok = False
        End Try
        Return ok
    End Function





    <System.Web.Services.WebMethod>
    Public Function Esta(ByVal login As String) As Boolean
        Dim ok = True

        Dim cnx As New SqlConnection With {
           .ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("oretubeConnectionString").ConnectionString
    }
        Dim sentencia As String = "select login from Usuario where login=@login"
        Dim cmd As New SqlCommand(sentencia, cnx)
        cmd.Parameters.AddWithValue("@login", login)

        Try
            cnx.Open()
            Dim resultado As String = cmd.ExecuteScalar()
            If String.IsNullOrEmpty(resultado) Then ok = False


        Catch ex As Exception

        Finally
            cnx.Close()
        End Try
        Return ok
    End Function




End Class
