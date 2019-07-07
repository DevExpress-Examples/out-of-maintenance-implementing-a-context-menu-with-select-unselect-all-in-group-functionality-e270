using DevExpress.Web;

public partial class _Default : System.Web.UI.Page {

    protected void grid_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e) {
        string[] data = e.Parameters.Split('|');
        if (data.Length == 2)
            SetSelectionCore(int.Parse(data[1]), data[0] == "SelectAll");
    }

    void SetSelectionCore(int visibleIndex, bool selected) {
        int count = grid.GetChildRowCount(visibleIndex);
        for (int i = 0; i < count; i++) {
            object key = grid.GetChildRowValues(visibleIndex, i, "OrderID", "ProductID");
            grid.Selection.SetSelectionByKey(key, selected);
        }
    }

    protected void grid_FillContextMenuItems(object sender, ASPxGridViewContextMenuEventArgs e) {
        if (e.MenuType == GridViewContextMenuType.Rows) {
            e.Items.Add("Select All", "SelectAll");
            e.Items.Add("Unselect All", "UnselectAll");
        }
    }

    protected void grid_ContextMenuItemVisibility(object sender, ASPxGridViewContextMenuItemVisibilityEventArgs e) {
        if (e.MenuType == GridViewContextMenuType.Rows) {
            GridViewContextMenuItem selectAllItem = e.Items.FindByName("SelectAll");
            GridViewContextMenuItem unSelectAllItem = e.Items.FindByName("UnselectAll");
            for (int i = 0; i < grid.VisibleRowCount; i++) {
                if (!grid.IsGroupRow(i)) {
                    e.SetVisible(selectAllItem, i, false);
                    e.SetVisible(unSelectAllItem,i, false);
                }
            }
        }
    }
}
