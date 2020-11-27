import {JetView} from "webix-jet";
import {devTypeStorage} from "models/devTypeStorage";
import {developmentsStorage} from "models/developmentsStorage";

export default class devForm extends JetView{
	config(){
		return {
			view:'form',
			elements:[
				{
					name:'dev_type_id',
					view:"combo", labelWidth:0,
					options:[],
					invalidMessage:"Вид активности не может быть пустым",
					required: true
				},
				{label:'Параметр', view:'text', name:'param'},
				{ view:"button", label:"Сохранить", 
					click: () => {
						let form = this.getRoot();
						//if (!form.isDirty()) return;
						if (!form.validate()) return;

						console.log("all clear!!!");

						let values = form.getValues();
						console.log("values", values);
						
						//редактирование или новое?
						if (values.id > 0 && this.single) form.save();
						else{
							let selectedCells = this.app.getService('tabelTable').getSelectedId();
							console.log("selectedCells", selectedCells);
							console.log("selectedCells", selectedCells.length);
							
							let subjectId = this.app.getService('subjectSelect').getValue();
							let firstDate = format(this.app.getService('monthSelectView').getValue());
							let monthYear = firstDate.substring(0, firstDate.length - 2);
							if (selectedCells.length == 0){
								webix.message({type:'error', text:'Не выбран день'});
								return;
							}
							if (selectedCells.length == 1){
								values.personell_id = selectedCells[0].row;
								values.dev_date = monthYear+selectedCells[0].column;
								values.subject_id = subjectId;
								values.dday = selectedCells[0].column;
								
								developmentsStorage.waitSave( () => {
									developmentsStorage.add(values);
								})
								.then((data) => {
									if (data.status == 'success'){
										this.app.getService('tabelTable').addOneDev(developmentsStorage.getItem(data.id));
										this.app.getService('developmentsList').filter();
									}
								});
							}else{
								let strValues = '';
								selectedCells.forEach((cell) => {
									//console.log("cell", cell);
									let param = (values.param)?values.param:'null';
									strValues += `(${cell.row},'${monthYear+cell.column}',${subjectId},${values.dev_type_id},${values.param}),`;
									
									//data += 
								});
								strValues = strValues.substring(0, strValues.length - 1);
								//console.log("values", values);
								webix.ajax().post("server/tabel.php?cmd=add_dev_data", {
									values: strValues,
									subject_id: subjectId,
									start_date: firstDate
								})
								.then((data) => {
									data = data.json();
									developmentsStorage.parse(data);
									console.log("developmentsStorage", developmentsStorage.data.pull);
									this.app.getService('developmentsList').clearFilter();
									
									this.app.getService('tabelTable').show();
									//console.log("data", data);
									/*view.clearAll();
									view.parse(data);
									view.adjustRowHeight();
									view.render();*/
								});
							}
							
						}

					}
				},
				{view:"button", label:"Очистить",
					click: () => {
						this.getRoot().clear();
					}
				}
			]/*,
			rules:{
				dev_type_id: (value) => { return value > this.$$("work_begin").getValue(); }
			}*/
		}
	}

	init(view) {
		view.bind(developmentsStorage);

		view.queryView("combo").getList().sync(devTypeStorage);
		
		this.app.setService("devForm", {
			setValues : (val) => {
				view.setValues(val);
			},
			clear : () => {
				view.clear();
			},
			setSingle : (val) => {
				this.single = val;
			}
		});
	}

	/*getValue() {
		let combo = this.getRoot().queryView("combo");
		if (this.getRoot().queryView("checkbox").getValue()) return {id: combo.getValue(), value: combo.getText(), param: this.getRoot().queryView("text").getValue()};
		else return null;
	}*/
}
