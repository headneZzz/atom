import {JetView} from "webix-jet";
import treeCopyToolbar from "views/common/treeCopyToolbar";
import structureTree from "views/structureSettings/structureTree";
import formPanel from "views/structureSettings/formPanel";

export default class structureSettings extends JetView{
	config(){
		return {view:'layout', 
			rows:[
				treeCopyToolbar,
				{view:'accordion', multi:true,
					cols:[
						{body:structureTree},
						{hidden: true, body:formPanel}
					]
				}
			]
		};
	}
}