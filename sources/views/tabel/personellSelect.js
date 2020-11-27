import {JetView} from "webix-jet";
import {personellStorage} from "models/personellStorage";

export default class personellSelect extends JetView{
	config(){
		return {
			hidden: true,
			cols:[
				{
					label:'Сотрудник',
					labelWidth: 120,
					view:"combo",
					//options:'server/work_time_planner.php?cmd=get_personell'
					options:[]
				},
				{view:"icon", icon:"mdi mdi-plus", click:() =>{
					this.app.getService('tabelTable').addPersonell(this.getValue());
					this.getRoot().hide();
				}}
			]
		}
	}

	init(view) {
		this.getRoot().queryView("combo").getList().parse(personellStorage);

		this.app.setService("personellSelect", {
			getValue : () => {
				return this.getValue();
			},
			show: () => {
				if(view.isVisible()) view.hide(); else view.show();
			}
		});
	}

	getValue() {
		let combo = this.getRoot().queryView("combo");
		return {id:combo.getValue(), value: combo.getText()};
	}
}
