#Region "Using"

Imports Microsoft.VisualBasic
Imports System
Imports System.Data
Imports System.Configuration
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
#End Region

Partial Public Class _Default
	Inherits System.Web.UI.Page

	Protected Sub grid_CustomCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridViewCustomCallbackEventArgs)
		Dim data As String() = e.Parameters.Split("|"c)
		If data.Length = 2 Then
			SetSelectionCore(Integer.Parse(data(1)), data(0) = "sel")
		End If
	End Sub

	Private Sub SetSelectionCore(ByVal index As Integer, ByVal value As Boolean)
		Dim startLevel As Integer = grid.GetRowLevel(index)
		Dim count As Integer = grid.VisibleRowCount
		For i As Integer = 1 + index To count - 1
			grid.Selection.SetSelection(i, value)
			If grid.GetRowLevel(i) <= startLevel Then
				Exit For
			End If
		Next i
	End Sub
End Class
