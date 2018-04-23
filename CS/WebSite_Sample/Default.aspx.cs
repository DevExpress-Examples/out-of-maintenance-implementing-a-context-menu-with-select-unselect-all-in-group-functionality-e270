#region Using
using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
#endregion

public partial class _Default : System.Web.UI.Page {

	protected void grid_CustomCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs e) {
		string[] data = e.Parameters.Split('|');
		if(data.Length == 2)
			SetSelectionCore(int.Parse(data[1]), data[0] == "sel");
	}

	void SetSelectionCore(int index, bool value) {
		int startLevel = grid.GetRowLevel(index);
		int count = grid.VisibleRowCount;
		for(int i = 1 + index; i < count; i++) {
			grid.Selection.SetSelection(i, value);
			if(grid.GetRowLevel(i) <= startLevel)
				break;
		}
	}
}
