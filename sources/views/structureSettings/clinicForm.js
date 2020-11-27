import {JetView} from "webix-jet";
import {requisitesStorage} from "models/structure_settings/requisitesStorage";

export default class clinicForm extends JetView{
	config(){
		return {view:"form",
			hidden: true,
			elements: [
				{
					view: "text",
					name: "org_code",
					label: "Код организации",
					labelPosition: "top"
				},
				{
					view: "text", required: true,
					name: "org_name",
					labelPosition: "top",
					label: "Полное наименование"
				},
				{
					view: "text",
					name: "org_name_short",
					label: "Краткое наименование",
					labelPosition: "top"
				},
				{
					view: "textarea",
					name: "adress_reg",
					labelPosition: "top",
					label: "Юридический адрес",
					height: 200
				},
				{
					view: "textarea",
					name: "adress_fact",
					label: "Фактический адрес",
					labelPosition: "top",
					height: 200
				},
				{
					view: "text",
					name: "inn ",
					labelPosition: "top",
					label: "ИНН"
				},
				{
					view: "text",
					name: "kpp ",
					labelPosition: "top",
					label: "КПП"
				},
				{
					view: "text",
					name: "okpo ",
					labelPosition: "top",
					label: "ОКПО"
				},
				{
					view: "text",
					name: "ogrn ",
					labelPosition: "top",
					label: "ОГРН"
				},
				{
					view: "text",
					name: "attestat_number",
					labelPosition: "top",
					label: "Номер аттестата"
				},
				{
					view: "text",
					name: "director_name",
					labelPosition: "top",
					label: "Ф.И.О. руководителя организации"
				},
				{
					view: "text",
					name: "director_post",
					labelPosition: "top",
					label: "Наименование должности руководителя"
				},
				{
					view: "text",
					name: "director_phone",
					labelPosition: "top",
					label: "Номер служебного телефона руководителя"
				},
				{
					view: "text",
					name: "director_email",
					labelPosition: "top",
					label: "Адрес официальной электронной почты руководителя"
				},
				{cols:[
					{view:"button", value:"Сохранить", hotkey: "enter", click: () => {
						if (this.view.isDirty()){
							if (this.view.validate()){
								//this.app.callEvent("save:structureForm",[this.view.getValues()]);
								//this.view.hide();
								let requisites = this.view.getValues();
								console.log("requisites0",requisites);
								if (requisites.id) requisitesStorage.updateItem(requisites.id, requisites);
								else requisitesStorage.add(requisites);
								//this.view.hide();
							} else	webix.message({ type:"error", text:"Заполните все поля"});
						}
					}}/*,
					{view:"button", value:"Отмена", hotkey: "esc", click: () => {
						this.app.callEvent("cancel:structureForm");
						//this.view.hide();
					}}*/
				]},
			]
		};
	}

	init(view) {
		this.view = view;

		this.on(this.app, "click:structureTree", (item) => {
			console.log("click",item);
			if (item.$level == 1){
				//let requisites = {};
				//console.log("requisites0",requisites);
				//console.log("requisitesStorage data", requisitesStorage.data.pull);
				let requisites = requisitesStorage.find(function(obj){return obj.structure_id == item.id}, true);
				console.log("requisites1",requisites);
				//if (requisites) view.setValues(requisites);
				if (!requisites){
					let requisites = {structure_id: item.id};
					console.log("requisites2",requisites);
					view.setValues(requisites);
				} else view.setValues(requisites);
				
				view.show();	
			} else view.hide();
		});
	}

}