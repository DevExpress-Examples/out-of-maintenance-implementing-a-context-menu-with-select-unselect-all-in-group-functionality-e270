<%@ Page Language="vb" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.17.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>Implementing a context menu with "Select / Unselect All In Group" functionality</title>
	<script>
		function onContextMenuItemClick(s, e) {
			if (e.item.name === "SelectAll" || e.item.name === "UnselectAll")
				grid.PerformCallback(e.item.name + "|" + e.elementIndex);
		}
	</script>
</head>
<body>
	<form id="form1" runat="server">
		<dx:ASPxGridView runat="server" ID="grid" ClientInstanceName="grid" OnFillContextMenuItems="grid_FillContextMenuItems" OnContextMenuItemVisibility="grid_ContextMenuItemVisibility"
			AutoGenerateColumns="False" DataSourceID="AccessDataSource1" KeyFieldName="OrderID;ProductID" OnCustomCallback="grid_CustomCallback">
			<SettingsContextMenu Enabled="true" EnableRowMenu="True" />
			<ClientSideEvents ContextMenuItemClick="onContextMenuItemClick" />
			<Styles>
				<GroupRow BackColor="LightBlue" Font-Bold="true" />
				<SelectedRow BackColor="LightCyan" />
			</Styles>
			<SettingsBehavior AutoExpandAllGroups="True" />
			<Columns>
				<dx:GridViewDataTextColumn FieldName="OrderID" GroupIndex="0" />
				<dx:GridViewDataTextColumn FieldName="ProductID" />
				<dx:GridViewDataTextColumn FieldName="UnitPrice" />
				<dx:GridViewDataTextColumn FieldName="Quantity" />
				<dx:GridViewDataTextColumn FieldName="Discount" />
			</Columns>
		</dx:ASPxGridView>
		<asp:AccessDataSource ID="AccessDataSource1" runat="server" DataFile="~/App_Data/nwind.mdb" SelectCommand="SELECT * FROM [Order Details]" />
	</form>
</body>
</html>