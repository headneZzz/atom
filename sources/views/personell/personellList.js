import {JetView} from "webix-jet";
import {personellStorage} from "models/personellStorage";

export default class personellList extends JetView{
	config(){
		return { view:"list", select:true,
			template:"#p_surname# #p_name#",
			on:{
				onAfterSelect: function(id){
					personellStorage.setCursor(id);
				}
			}
		};
	}

	init(view) {
		view.data.sync(personellStorage);
	}
}