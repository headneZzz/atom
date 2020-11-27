import {JetView} from "webix-jet";

import constantlyList from "views/tasker/constantlyList";
import urgentlyList from "views/tasker/urgentlyList";
import informingList from "views/tasker/informingList";


export default class tasker extends JetView{
	config(){
		return {
			type:"wide", margin:10, padding:{ top:10, bottom:10, right:10, left:5 },
			rows:[
				taskerToolbar,
				{
					cols:[
						constantlyList,
						{view:"resizer"},
						urgentlyList,
						{view:"resizer"},
						informingList
					]
				}
			]
		}
	}
}