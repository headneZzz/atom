import {JetView} from "webix-jet";

export default class constantlyToolbar extends JetView{
	config(){
		return {view:"toolbar",
			elements:[
				searchField,
				treeCopyControlPanel
			]
		}
	}
}
