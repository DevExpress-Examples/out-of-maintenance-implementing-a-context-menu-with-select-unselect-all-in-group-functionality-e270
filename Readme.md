<!-- default file list -->
*Files to look at*:

* [Default.aspx](./CS/WebSite_Sample/Default.aspx) (VB: [Default.aspx](./VB/WebSite_Sample/Default.aspx))
* [Default.aspx.cs](./CS/WebSite_Sample/Default.aspx.cs) (VB: [Default.aspx.vb](./VB/WebSite_Sample/Default.aspx.vb))
<!-- default file list end -->
# Implementing a context menu with "Select / Unselect All In Group" functionality
<!-- run online -->
**[[Run Online]](https://codecentral.devexpress.com/e270/)**
<!-- run online end -->
The example shows how to select/unselect all rows in child rows of a group by adding two custom items to the ASPxGridView's Context Menu.

## Steps to implement:

1. Enable Context Menu in ASPxGridView with the [SettingsContextMenu.Enabled][1] and enable it for row elements with with [EnableRowMenu][2] = true.
```aspx
 <SettingsContextMenu Enabled="true" EnableRowMenu="True" />
```
2. Handle the server-side [ASPxGridView.FillContextMenuItems][3] event and add two items, "SelectAll" and "UnselectAll".
```csharp
protected void grid_FillContextMenuItems(object sender, ASPxGridViewContextMenuEventArgs e) {
        if (e.MenuType == GridViewContextMenuType.Rows) {
            e.Items.Add("Select All", "SelectAll");
            e.Items.Add("Unselect All", "UnselectAll");
        }
    }
```
*VB.NET example: [Default.aspx.vb](./VB/WebSite_Sample/Default.aspx.vb)*

3. Hide these items for non-group rows in the [ASPxGridView.ContextMenuItemVisibility][10] event handler. For this, check each row with the [ASPxGridView.IsGroupRow][4] method and call [e.SetVisible][5], if this condition returns false.
```csharp
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
```
*VB.NET example: [Default.aspx.vb](./VB/WebSite_Sample/Default.aspx.vb)*

4. Handle the client-side [ASPxClientGridView.ContextMenuItemClick][6] event. If a clicked item has the "SelectAll" or "UnselectAll" name, send a callback ([ASPxClienGridView.PerformCallback][7]) and pass e.elementIndex and the item name as parameters.
```aspx
<ClientSideEvents ContextMenuItemClick="onContextMenuItemClick" />
```
```javascript
function onContextMenuItemClick(s, e) {
            if (e.item.name === "SelectAll" || e.item.name === "UnselectAll")
                s.PerformCallback(e.item.name + "|" + e.elementIndex);
}
```

5. Handle the server-side [ASPxGridView.CustomCallback][8] event and get these parameters. Use these parameters to get current group row's child row keys and use the [ASPxGridView.SetSelectionByKey][9] method to select/unselect the child rows.
```csharp
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
```
*VB.NET example: [Default.aspx.vb](./VB/WebSite_Sample/Default.aspx.vb)*

[1]: https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxGridViewContextMenuSettings.Enabled
[2]: https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxGridViewContextMenuSettings.EnableRowMenu
[3]: https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxGridView.FillContextMenuItems
[4]: https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxGridView.IsGroupRow(System.Int32)
[5]: https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxGridViewContextMenuItemVisibilityEventArgs.SetVisible(DevExpress.Web.GridViewContextMenuItem-System.Boolean)
[6]: https://docs.devexpress.com/AspNet/js-ASPxClientGridView.ContextMenuItemClick
[7]: https://docs.devexpress.com/AspNet/js-ASPxClientGridView.PerformCallback(args)
[8]: https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxGridView.CustomCallback
[9]: https://documentation.devexpress.com/AspNet/DevExpress.Web.Data.WebDataSelection.SetSelectionByKey.method
[10]: https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxGridView.ContextMenuItemVisibility

