Imports DevExpress.Web

Partial Public Class _Default
	Inherits System.Web.UI.Page

	Protected Sub grid_CustomCallback(ByVal sender As Object, ByVal e As ASPxGridViewCustomCallbackEventArgs)
		Dim data() As String = e.Parameters.Split("|"c)
		If data.Length = 2 Then
			SetSelectionCore(Integer.Parse(data(1)), data(0) = "SelectAll")
		End If
	End Sub

	Private Sub SetSelectionCore(ByVal visibleIndex As Integer, ByVal selected As Boolean)
		Dim count As Integer = grid.GetChildRowCount(visibleIndex)
		For i As Integer = 0 To count - 1
			Dim key As Object = grid.GetChildRowValues(visibleIndex, i, "OrderID", "ProductID")
			grid.Selection.SetSelectionByKey(key, selected)
		Next i
	End Sub

	Protected Sub grid_FillContextMenuItems(ByVal sender As Object, ByVal e As ASPxGridViewContextMenuEventArgs)
		If e.MenuType = GridViewContextMenuType.Rows Then
			e.Items.Add("Select All", "SelectAll")
			e.Items.Add("Unselect All", "UnselectAll")
		End If
	End Sub

	Protected Sub grid_ContextMenuItemVisibility(ByVal sender As Object, ByVal e As ASPxGridViewContextMenuItemVisibilityEventArgs)
		If e.MenuType = GridViewContextMenuType.Rows Then
			Dim selectAllItem As GridViewContextMenuItem = e.Items.FindByName("SelectAll")
			Dim unSelectAllItem As GridViewContextMenuItem = e.Items.FindByName("UnselectAll")
			For i As Integer = 0 To grid.VisibleRowCount - 1
				If Not grid.IsGroupRow(i) Then
					e.SetVisible(selectAllItem, i, False)
					e.SetVisible(unSelectAllItem,i, False)
				End If
			Next i
		End If
	End Sub
End Class
