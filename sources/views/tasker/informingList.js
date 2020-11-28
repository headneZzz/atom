import {JetView} from "webix-jet";
import {taskerTreeStorage} from "models/taskerTreeStorage";
//import {devTypeStorage} from "models/devTypeStorage";

export default class informingList extends JetView{
	config(){
		return {
			view:"list",
			//select:true,
			type:{
				template:'<image class="user_photo" src="data/photos/#photo#" /><div class="text"><span class="username">#task_title#</span><br>#author_name#<br>#task#</div>',
				height:260
			}

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

		this.app.setService('informingList',{
			
		});
	}

	filter(){
		this.getRoot().filter((obj) => {
			//console.log("obj", obj);
			return obj.task_type_id == 3;
		});
		taskerTreeStorage.setCursor(null);
	}

	clearFilter(){
		this.getRoot().filter((obj) => {
			//console.log("obj", obj);
			return obj.task_type_id == 3;
		});
		taskerTreeStorage.setCursor(null);	
	}
}