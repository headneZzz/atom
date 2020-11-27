import {JetView} from "webix-jet";
import {developmentsStorage} from "models/developmentsStorage";
import {devTypeStorage} from "models/devTypeStorage";
import {personellStorage} from "models/personellStorage";
import {tabelStorage} from "models/tabelStorage";


export default class tabelTable extends JetView{
	config(){
		return {
			view:'datatable',
			fixedRowHeight:false,
			rowLineHeight:22, rowHeight:22,
			css:"webix_header_border webix_data_border",
			columns:[],
			data:[],
			select:"cell",
			multiselect:true,
			blockselect:true,
			//areaselect:true,
			//hover:'myhover',
			on:{
				/*onItemClick: (id, e, node) => {
					if ((id.column ^ 0) === id.column){
						//this.app.getService('dayDevList').showDay(this.getRoot().data.getItem(id)[id.column]);	
						this.app.getService('developmentsList').showDay(id.column, id.row);	
					}	
				},*/
				onAfterSelect: (selection, preserve) => {
					//console.log("selection, preserve", selection, preserve);
					if (preserve) return;
					if ((selection.column ^ 0) === selection.column){
						//this.app.getService('dayDevList').showDay(this.getRoot().data.getItem(selection)[selection.column]);	
						this.app.getService('developmentsList').showDay(selection.column, selection.row);	
					}	
				},
				onBeforeSelect(id){
					if (id.column === "value") return false;
				},
				onSelectChange:() => {
					const selection = this.getRoot().getSelectedId(true);
      				if(selection.length == 1) this.app.getService('devForm').setSingle(true);
      				else this.app.getService('devForm').setSingle(false);
				}
			}
		};
	}

	init(view){
		console.log("tabeltable init");
		

		this.app.setService('tabelTable',{
			getSelectedId: () => {
				//console.log("service getSelectedId start");
				return view.getSelectedId(true);
			},
			show: () => {
				console.log("DO tabelTable show");
				tabelStorage.clearAll();
				developmentsStorage.data.each((dev) => {
					//Есть в стори такой работник?
					let item = tabelStorage.getItem(dev.personell_id);
					if (item){
						//Есть ли уже этот день?
						if (dev.dday in item){
							item[dev.dday].push(dev);
						}else{
							item[dev.dday] = [dev];
						}
					}else{
						let pers = webix.copy(personellStorage.getItem(dev.personell_id));
						let newId = tabelStorage.add(pers);
						item = tabelStorage.getItem(newId);
						item[dev.dday] = [dev];
					}
				});
				view.clearAll();
				view.parse(tabelStorage);
				view.adjustRowHeight();
				view.render();
			},
			update: () => {
				view.adjustRowHeight();
				view.render();
			},
			addPersonell: (personell) => {
				console.log("personell", personell);
				if (personell.id < 1){
					webix.message({type:'error', text:'Для начала  определитесь с персонажем'});
					return;
				}
				//Прооверим, есть ли в списке такой персонаж
				if (!this.app.getService('subjectSelect').getValue()){
					webix.message({type:'error', text:'Для начала  определитесь с объектом'});
					return;
				}
				let newPers = view.getItem(personell.id);
				console.log("newPers", newPers);
				if (newPers){
					webix.message({type:'error', text:'Такой персонаж есть в этой сказке'});
					return;
				}
				webix.dp(view).off();
				view.add({id:personell.id, value: personell.value});
				webix.dp(view).on();
				view.adjustRowHeight();
				view.render();
			},
			addOneDev: (dev) => {
				//console.log("in TABLE dev", dev);
				let item = view.getItem(dev.personell_id);
				//console.log("item", item);
				if (dev.dday in item){
					item[dev.dday].push(dev);
				}else{
					item[dev.dday] = [dev];
				}
				
				view.adjustRowHeight();
				view.render();
			},
			changeMonth: (date) => {
				view.clearAll();
				let newdate = new Date(date);
				let month = newdate.getMonth();
				let days = ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'];
				let columns = [{id:'value', header:"ФИО", fillspace:5, sort:"string", select: false}];
				
				while (newdate.getMonth() == month) {
					let day = newdate.getDate();
					let dow = newdate.getDay();
					//columns.push({id: day, header: day+'<br>'+days[newdate.getDay()], width:20});
					columns.push({
						id: day,
						header: [day,days[dow]],
						fillspace:1,
						//css:'{"border-right":"2px solid black", "border-left":"2px solid black"}',
						cssFormat:(value, config, row, col) =>{
							let cssCell = {};
							if (dow == 0 || dow == 6) cssCell['border-left'] = '2px solid gray';
							if (config[col]){
								config[col].forEach((dev) => {
									let dev_type = devTypeStorage.getItem(dev.dev_type_id);
									if (dev_type.is_show){
										if (dev_type.cell_bgcolor) cssCell['background-color'] = dev_type.cell_bgcolor;//+' !important';
										//if (dev_type.cell_border) cssCell.border = dev_type.cell_border;
									}
								});
							}
							return cssCell;
						},
						template: (obj, common, value,config) => {
							//console.log("=========== Template START!!!");
							//debugger;
							let innerHTML = '';
							if (obj[config.id]){
								obj[config.id].forEach((dev) => {
									let dev_type = devTypeStorage.getItem(dev.dev_type_id);
									if (dev_type.dev_type_short && dev_type.is_show) innerHTML += `<span style="${dev_type.font_style}">${dev_type.dev_type_short}</span> `;
								});
									
							}
							return innerHTML;
						}
					});
					//this.lastDay = date.getDate();
					newdate.setDate(newdate.getDate() + 1);
				}
				//console.log("columns", columns);
				view.config.columns = columns;
				view.refreshColumns();
			},
			toExcel:() => {
				webix.toExcel(view, {filterHTML:true});
			}
		});

	}

	
	
}