import {JetView} from "webix-jet";
import {developmentsStorage} from "models/developmentsStorage";
import {devTypeStorage} from "models/devTypeStorage";

export default class developmentsList extends JetView{
	config(){
		return {
			gravity:0.3,
			view:'list',
			minHeight: 120,
			select: true,
			template: (obj) => {
				//console.log("obj", obj);
				let cssCell = '';
				let dev_type = devTypeStorage.getItem(obj.dev_type_id);
				if (dev_type.cell_bgcolor) cssCell += ` background-color:${dev_type.cell_bgcolor};"`;
				if (dev_type.cell_border) cssCell += ` border:${dev_type.cell_border};"`;
				return `<div style="${cssCell}"><span style="${dev_type.font_style}">${dev_type.dev_type}</span> ${(obj.param)?obj.param+' '+dev_type.param_measure:''}</div>`;
			},
			data:[]
		}
	}

	init(view) {
		view.sync(developmentsStorage);
		
		developmentsStorage.attachEvent("onBindUpdate", (data, key) => {
			console.log("onBindUpdate");
			this.filter();
		});
		developmentsStorage.waitData.then(() => {
			console.log("waitData");
			this.clearFilter();
		});
		
		this.clearFilter();
		
		this.on(this.app,"monthSelectView:monthChanged", date => {
			let subjectId = this.app.getService('subjectSelect').getValue();
			this.app.getService('tabelTable').changeMonth(date);
			if (subjectId) this.load(format(date), subjectId);
		});

		this.app.setService('developmentsList',{
			showDay: (day, personellId) => {
				//console.log("day, personellId", day, personellId);
				this.personellId = personellId;
				this.dday = day;
				this.filter();
				//this.app.getService('devForm').clear();
			},
			load: (subjectId) => {
				this.load(format(this.app.getService('monthSelectView').getValue()), subjectId);
			},
			filter: () => {
				this.filter();
			},
			clearFilter: () => {
				console.log("DO clearFilter");
				this.clearFilter();
			}
		});
	}

	load(date, subjectId){
		developmentsStorage.clearAll();
		developmentsStorage.load(`server/tabel.php?cmd=get_developments
			&subject_id=${subjectId}
			&start_date=${date}
			`).
		then((data)=>{
			this.app.getService('tabelTable').show();
			this.clearFilter();
		});
		//this.app.getService('devForm').clear();
		//this.clearFilter();
	}

	filter(){
		//console.log("this.personellId", this.personellId);
		//console.log("this.dday", this.dday);
		this.getRoot().filter((obj) => {
			return obj.dday == this.dday && obj.personell_id == this.personellId;
		});
		developmentsStorage.setCursor(null);
	}

	clearFilter(){
		this.personellId = 0;
		this.dday = 0;
		this.getRoot().filter(function(obj){
			return false;
		});
		developmentsStorage.setCursor(null);
	}
}