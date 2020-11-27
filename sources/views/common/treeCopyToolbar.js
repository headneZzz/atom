import {JetView} from "webix-jet";
import searchField from "views/common/searchField";
import treeCopyControlPanel from "views/common/treeCopyControlPanel";

export default class medicamentTypeToolbar extends JetView{
	config(){
		return {view:"toolbar",
			elements:[
				searchField,
				treeCopyControlPanel
			]
		}
	}
}
