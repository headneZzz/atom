import {JetView} from "webix-jet";

export default class searchField extends JetView{
	config(){
		return {
			view:'search', //hidden: true,
			keyPressTimeout:1000,
			on: {
				onTimedKeyPress: () => {
					//console.log('press - ', this.view.getValue());
					this.app.callEvent("search:searchField",[this.view.getValue()]);
				}
			}
		}
	}

	init(view){
		this.view = view;

		this.app.setService("searchField", {
			getValue : () => {
				return view.getValue();
			}
		});
	}
}
