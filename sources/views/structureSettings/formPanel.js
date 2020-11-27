import {JetView} from "webix-jet";
//import searchField2 from "views/common/searchField2";
import structureForm from "views/structureSettings/structureForm";
//import substructureForm from "views/structureSettings/substructureForm";
import clinicForm from "views/structureSettings/clinicForm";

export default class formPanel extends JetView{
	config(){
		return {rows: [
			//searchField2,
			structureForm,
			//substructureForm,
			{view:'scrollview', localId:'scrollview', body:{rows:[
				{ view:"template", template:"Реквизиты", type:"header" }, 
				clinicForm
			]}, hidden:true},
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
			let item = this.app.getService("structureTree").getSelectedItem();
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

		this.on(this.app, "save:structureForm", () => {
			view.hide();
		});
		
		this.on(this.app, "cancel:structureForm", () => {
			view.hide();
		});

		this.on(this.app, "click:structureTree", (item) => {
			//console.log("click",item);
			view.show();
			if (item.$level == 1) this.$$("scrollview").show(); else this.$$("scrollview").hide();
			
		});
	}
}
