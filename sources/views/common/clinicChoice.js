import {JetView} from "webix-jet";
import {clinicStorage} from "models/clinicStorage";

export default class clinicChoice extends JetView{
	config(){
		return {view:'richselect',
			label:'Клиника', 
			labelWidth: 60,
			options:[],
			//value:5,
			//tooltip:'Показывать элементы находящиеся в архиве',
			on:{
				onChange:(newv, oldv) => {
					this.app.callEvent("change:clinicChoice",[newv]);
				}
			}
		}
	}

	init(view){
		/*clinicStorage.load("server/main.php?cmd=get_clinic", {
			success:(text, data, http_request) =>{
				console.log("clinicStorage",clinicStorage.data.pull);
				view.sync(clinicStorage);
			}
		});*/
		//view.parce("server/main.php?cmd=get_clinic");
		webix.ajax("server/main.php?cmd=get_clinic").then(function(data){
			//console.log(data.json()[0]);
			view.define("options", data.json());
			view.refresh();
		});
		

		this.app.setService("clinicChoice", {
			getValue : () => {
				return view.getValue();
			}
		});
	}
}
