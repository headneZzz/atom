import {JetView} from "webix-jet";

export default class showArchSwitch extends JetView{
	config(){
		return {view:'switch', label:'Архив', 
			labelWidth: 50,
			tooltip:'Показывать элементы находящиеся в архиве',
			value: 0,
			on:{
				onChange:(newv, oldv) => {
					this.app.callEvent("change:showArchSwitch",[newv]);
				}	
			}
		}
	}

	init(view){
		this.app.setService("showArchSwitch", {
			getValue : () => {
				return view.getValue();
			}
		});
	}
}
