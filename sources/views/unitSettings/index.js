import {JetView} from "webix-jet";
import treeCopyToolbar from "views/common/treeCopyToolbar";
import unitTree from "views/unitSettings/unitTree";
import formPanel from "views/unitSettings/formPanel";

export default class unitSettings extends JetView{
	config(){
		return {view:'layout', 
			rows:[
				treeCopyToolbar,
				{view:'accordion', multi:true,
					cols:[
						{body:unitTree},
						{hidden: true, body:formPanel}
					]
				}
			]
		};
	}
}