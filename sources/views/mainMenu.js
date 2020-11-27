import {JetView, plugins} from "webix-jet";
//import {JetView} from "webix-jet";


export default class mainMenu extends JetView{
	config(){
		return { view: "sidebar",
			id:"top:menu",
			collapsed:true,
			data: [
				/*{ value:"Старт", id:"start", icon:"mdi mdi-stop" },
				{ value:"Табель", id:"tabel", icon:"mdi mdi-calendar-multiple-check" },
				{ value:"Работники", id:"personell", icon:"mdi mdi-account" },*/
				//{ id:"logout", value:"Выйти", icon:"mdi mdi-logout" }
			],
			on:{
				onItemClick:id => {
					if (id === "logout"){
						this.show("/login");
						return false;
					}else{
						return true;
					}
				}
			}
		};
	}

	init(view) {
		view.parse(this.app.getService('user').getUser().modules);
		view.add({ id:"logout", value:"Выйти", icon:"mdi mdi-logout" });
		this.use(plugins.Menu, "top:menu");
	}
}