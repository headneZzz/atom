import {JetView} from "webix-jet";
//import oneDayScheduler from "views/doctor/oneDayScheduler";

export default class monthSelectView extends JetView{
	config(){
		return {
			rows:[
				{view:"toolbar", css:this.app.config.shadows,
					css:this.app.config.theme,
					localId:"toolbar",
					//visibleBatch:"default",
					elements:[
						{ view:"icon", icon:"wxi-angle-left", width:40,
							click: () => {
								let datepicker = this.getRoot().queryView("datepicker");
								let d = datepicker.getValue();
								//let date = new Date(d.setDate(d.getDate() - 1));
								let date = new Date(d.setMonth(d.getMonth() - 1));
								datepicker.setValue(date);
								//console.log("---- monthSelectView:monthChanged ", date, this.getFirstDay(date));
								this.app.callEvent("monthSelectView:monthChanged",[this.getFirstDay(date)]);
							}
						},
						{//batch:"default",
							css:"patients_filter",
							localId:"datepicker",
							view: "datepicker",
							type: "month",
							value: new Date(),
							format: "%F %Y",
							on:{
								onChange: (newv) => {
									//console.log("onChange", newv);
									//console.log("=== monthSelectView", newv, this.getFirstDay(newv));
									this.app.callEvent("monthSelectView:monthChanged",[this.getFirstDay(newv)]);
									
								}
							}
						},
						{ view:"icon", icon:"wxi wxi-angle-right", width:40,
							click: () => {
								//console.log(webix.Date);
								let datepicker = this.getRoot().queryView("datepicker");
								const d = datepicker.getValue();
								const date = new Date(webix.Date.add(d, 1, 'month'));
							    datepicker.setValue(date);
							    //console.log("date", date);
							    //console.log("++++ monthSelectView:monthChanged ", date, this.getFirstDay(date));
							    this.app.callEvent("monthSelectView:monthChanged",[this.getFirstDay(date)]);
							}
						}
					]
				}
			]
		}
	}

	init(view) {
		//this.getRoot().queryView("datepicker").setValue = new Date();
		this.app.setService("monthSelectView", {
			getValue : () => {
				//console.log("getValue", this.getRoot().queryView("datepicker").getValue())
				return this.getFirstDay(this.getRoot().queryView("datepicker").getValue());
			}
		});
	}

	ready(view) {
		//console.log("READY monthSelectView:monthChanged ", this.getFirstDay(view.queryView("datepicker").getValue()));
		this.app.callEvent("monthSelectView:monthChanged",[this.getFirstDay(view.queryView("datepicker").getValue())]);
	}
	
	getFirstDay(date){
		return new Date(date.getFullYear(), date.getMonth(), 1);
	}
}
