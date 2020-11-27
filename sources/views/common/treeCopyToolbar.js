import {JetView} from "webix-jet";
import searchField from "views/common/searchField";
import treeCopyControlPanel from "views/common/treeCopyControlPanel";
import showArchSwitch from "views/common/showArchSwitch";

export default class medicamentTypeToolbar extends JetView{
	config(){
		return {view:"toolbar",
			elements:[
				searchField,
				showArchSwitch,
				treeCopyControlPanel
			]
		}
	}
}
