import {JetView} from "webix-jet";

export default class searchField2 extends JetView{
	config(){
		return {
			view:'search', //hidden: true,
			keyPressTimeout:1000,
			on: {
				onTimedKeyPress: () => {
					//console.log('press - ', this.view.getValue());
					this.app.callEvent("search:searchField2",[this.view.getValue()]);
				}
			}
		}
	}

	init(view){
		this.view = view;

		this.app.setService("searchField2", {
			getValue : () => {
				return view.getValue();
			},
			show: () => {
				view.show();
			},
			hide: () => {
				view.hide();
			}
		});
	}
}
