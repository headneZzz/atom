import {JetView} from "webix-jet";

export default class taskerToolbar extends JetView{
	config(){
		return {view:"toolbar",
			elements:[
				//searchField,
				//treeCopyControlPanel
				{view:"search"}
			]
		}
	}
}
