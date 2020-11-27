import {JetView} from "webix-jet";
import {taskerTreeStorage} from "models/taskerTreeStorage";
//import {devTypeStorage} from "models/devTypeStorage";

export default class urgentlyList extends JetView{
	config(){
		return {
			view:"list"
		}
	}

	init(view) {
		view.sync(taskerTreeStorage);
		
		taskerTreeStorage.attachEvent("onBindUpdate", (data, key) => {
			console.log("onBindUpdate");
			this.filter();
		});
		
		taskerTreeStorage.waitData.then(() => {
			console.log("waitData");
			this.clearFilter();
		});
		
		this.clearFilter();

		this.app.setService('urgentlyList',{
			
		});
	}

	filter(){
		this.getRoot().filter((obj) => {
			return obj.message_type == 2;
		});
		taskerTreeStorage.setCursor(null);
	}

	clearFilter(){
		
	}
}