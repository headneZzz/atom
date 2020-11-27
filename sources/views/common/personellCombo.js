import {JetView} from "webix-jet";
import {personellStorage} from "models/personellStorage";

export default class personellCombo extends JetView{
	config(){
		return {view:'combo', 
			//localId: "personell_id",
			label:'Сотрудник',
			name:'personell_id',
			labelPosition:"top", 
			options:[{id:1, value:"One"}, 
        	{id:2, value:"Two"}, 
        	{id:3, value:"Three"}]
		};
	}

	init(view) {
		this.view = view;

		view.getPopup().getList().sync(personellStorage);
		//console.log("storage",personellStorage.data.pull);

		personellStorage.waitData.then(() => {
			view.getPopup().getList().sync(personellStorage);
		});

		this.app.setService("personellCombo", {
			getValue : () => {
				return view.getValue();
			},
			setValue : (newv) => {
				return view.setValue(newv);
			}
		});
	}

}