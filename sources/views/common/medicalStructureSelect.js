import {JetView} from "webix-jet";
import {medicalStructureStorage} from "models/common/medicalStructureStorage";

export default class medicalStructureSelect extends JetView{
	config(){
		return {view:"combo", label:"Отделение", labelWidth: 100, options:medicalStructureStorage,
			value:'0',
			on:{
				onChange: (newv) => {
					//console.log("medicalStructureSelect onChange", newv);
					this.app.callEvent("change:medicalStructureSelect", [newv]);
					this.app.getService("state").setUnit(medicalStructureStorage.getItem(newv));
				}	
			}
		};
	}

	//Так как изменения вносятся в другой сторидж, то этот надо перезагрузить
	/*urlChange(view, url){
		medicalStructureStorage.clearAll();
		medicalStructureStorage.load("server/common.php?cmd=get_medical_structure");
		
		//manipulationTreeStorage.clearAll(true);
		//manipulationTreeStorage.load(manipulationTreeStorage.data.url);
	}*/


	init(view) {
		//console.log("medicalStructureSelect init");
		medicalStructureStorage.clearAll();
		medicalStructureStorage.load("server/common.php?cmd=get_medical_structure")
		.then((data)=>{
			//Уже установлена структура, с которой работают?
			let unit = this.app.getService("state").getUnit();
			//console.log("unit",unit);
			if (unit){
				//view.blockEvent();
				view.setValue(unit.id);
				//view.unblockEvent();
			}
		});

		//При переключении между клиниками стоит переключить доступные отделения
		this.on(this.app, "change:structureChoice", (structure) => {
			//console.log("change:structureChoice");
			medicalStructureStorage.clearAll(true);
			medicalStructureStorage.load(medicalStructureStorage.data.url);
		});

		this.app.setService("medicalStructureSelect", {
			getValue : () => {
				//console.log('service medicamentList from medicament type');
				return view.getValue();
			}
		});
	}
}