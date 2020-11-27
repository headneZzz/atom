import {JetView} from "webix-jet";
//import searchField2 from "views/common/searchField2";
import unitForm from "views/unitSettings/unitForm";
//import subunitForm from "views/unitSettings/subunitForm";
//import clinicForm from "views/unitSettings/clinicForm";

export default class formPanel extends JetView{
	config(){
		return {rows: [
			//searchField2,
			unitForm,
			//subunitForm,
			//{view:'scrollview', body:{}},
			{gravity:0.01}
			]
		};
	}

	init(view) {
		this.on(this.app, "createRoot:treeControlPanel", () => {
			view.show();
		});

		this.on(this.app, "createSlave:treeControlPanel", () => {
			console.log("createSlave:treeControlPanel");
			let item = this.app.getService("unitTree").getSelectedItem();
			console.log("createSlave:treeControlPanel", item);
			if (!item){
				webix.message({type:'error', text:'Выберите параметр'});
				return false;
			}
			view.show();	
			this.app.callEvent("showForm:formPanel",[{$level:item.$level+1,$parent:item.id}]);
		});

		this.on(this.app, "delete:treeControlPanel", () => {
			view.hide();
		});

		this.on(this.app, "save:unitForm", () => {
			view.hide();
		});
		
		this.on(this.app, "cancel:unitForm", () => {
			view.hide();
		});

		this.on(this.app, "click:unitTree", (item) => {
			console.log("click",item);
			view.show();
			//if (item.$level == 1) this.$$("scrollview").show(); else this.$$("scrollview").hide();
			
		});
	}
}
