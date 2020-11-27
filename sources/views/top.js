import {JetView, plugins} from "webix-jet";
//import clinicChoice from "views/common/clinicChoice";
//import toolbar from "views/user/toolbar";
import mainMenu from "views/mainMenu";

export default class TopView extends JetView{
	config(){
		
		

		var ui = { //type:"clean", paddingX:5, css:"app_layout",
			rows:[
				//00000000000000000000000000000000000000000000000000000toolbar,
				
				{ cols:[
				  mainMenu,
				  { $subview:true }
				]}
			]
		};


		return ui;
	}
	init(view){
		//this.use(plugins.Menu, "top:menu");
	}
	
}