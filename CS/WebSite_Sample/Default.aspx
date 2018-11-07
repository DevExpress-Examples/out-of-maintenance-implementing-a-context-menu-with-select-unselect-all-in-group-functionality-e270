<%-- BeginRegion Page setup --%>
<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>
<%@ Register Assembly="DevExpress.Web.v13.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.v13.1" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dxwgv" %>
<%@ Register Assembly="DevExpress.Web.v13.1" Namespace="DevExpress.Web.ASPxMenu" TagPrefix="dxm" %>
<%-- EndRegion --%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<title>Untitled Page</title>
<script type="text/javascript">
var __dxSampleVisibleIndex = -1;
function grid_ContextMenu(s, e) {	
	if(e.objectType == "grouprow") {	
		__dxSampleVisibleIndex = e.index;
		menu.ShowAtPos(ASPxClientUtils.GetEventX(e.htmlEvent), ASPxClientUtils.GetEventY(e.htmlEvent));
	}
}
function menu_ItemClick(s, e) {
	grid.PerformCallback(e.item.name + "|" + __dxSampleVisibleIndex);
}
</script>
</head>
<body>
    <form id="form1" runat="server">
		<dxwgv:ASPxGridView runat="server" ID="grid" ClientInstanceName="grid"
			AutoGenerateColumns="False" DataSourceID="AccessDataSource1" KeyFieldName="OrderID" OnCustomCallback="grid_CustomCallback">			
			<Styles>
				<GroupRow BackColor="#FFFF80"></GroupRow>
				<SelectedRow BackColor="Lime"></SelectedRow>
			</Styles>
			<SettingsBehavior AutoExpandAllGroups="True" />
			<Settings ShowGroupPanel="True" />
			<ClientSideEvents ContextMenu="grid_ContextMenu" />
			<%-- BeginRegion Columns --%>
			<Columns>
				<dxwgv:GridViewDataTextColumn FieldName="OrderID" ReadOnly="True" VisibleIndex="0" GroupIndex="0" SortIndex="0" SortOrder="Ascending">
				</dxwgv:GridViewDataTextColumn>
				<dxwgv:GridViewDataTextColumn FieldName="ProductID" ReadOnly="True" VisibleIndex="1">
				</dxwgv:GridViewDataTextColumn>
				<dxwgv:GridViewDataTextColumn FieldName="UnitPrice" VisibleIndex="2">
				</dxwgv:GridViewDataTextColumn>
				<dxwgv:GridViewDataTextColumn FieldName="Quantity" VisibleIndex="3">
				</dxwgv:GridViewDataTextColumn>
				<dxwgv:GridViewDataTextColumn FieldName="Discount" VisibleIndex="4">
				</dxwgv:GridViewDataTextColumn>
			</Columns>
			<%-- EndRegion --%>
		</dxwgv:ASPxGridView>
		<asp:AccessDataSource ID="AccessDataSource1" runat="server" DataFile="~/App_Data/nwind.mdb"
			SelectCommand="SELECT * FROM [Order Details]">
		</asp:AccessDataSource>
		<%-- BeginRegion Menu --%>
		<dxm:ASPxPopupMenu runat="server" ID="menu" ClientInstanceName="menu">
			<Items>
				<dxm:MenuItem Text="Select all in group" Name="sel"></dxm:MenuItem>
				<dxm:MenuItem Text="Unselect all in group" Name="unsel"></dxm:MenuItem>
			</Items>
			<ClientSideEvents ItemClick="menu_ItemClick" />
		</dxm:ASPxPopupMenu>
		<%-- EndRegion --%>	
    </form>
</body>
</html>
