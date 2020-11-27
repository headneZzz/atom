import {JetView} from "webix-jet";
//import oneDayScheduler from "views/doctor/oneDayScheduler";

export default class subjectSelect extends JetView{
	config(){
		return {
			view:"richselect",
			label:"Объект",
			//labelPosition: 'top',
			options:'server/tabel.php?cmd=get_subject',
			on:{
				'onChange': (newv) => {
					this.app.getService('developmentsList').load(newv);
				}
			}
		}
	}

	init(view) {
		//this.getRoot().queryView("datepicker").setValue = new Date();
		this.app.setService("subjectSelect", {
			getValue : () => {
				return view.getValue();
			}
		});
	}
}
