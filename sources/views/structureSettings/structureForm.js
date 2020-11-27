import {JetView} from "webix-jet";
import personellCombo from "views/common/personellCombo";
import {roleStorage} from "models/structure_settings/roleStorage";

export default class structureForm extends JetView{
	config(){
		return {view:"form", hidden:true,
			elements:[
				{view:'text', label:'Наименование подразделения', name:'value', labelPosition:"top", required: true},
				{view:"richselect", localId:"role_id", name:"role_id", label:"Роль", labelPosition:"top",options:roleStorage, value:0},
				{view:"checkbox", name: "is_medical", labelRight:'Лечебная часть', labelWidth:0},
				{view:"checkbox", name: "is_have_price", labelRight:'Свой прайс', labelWidth:0},
				{view:'text', label:'Наименование должности', name:'post', labelPosition:"top"},
				{view:'richselect', label:'Тип должности', name:'post_type_id', labelPosition:"top", options:"server/structure_settings.php?cmd=get_post_type"},
				{view:'richselect', label:'Профиль помощи', name:'profile_stomat_care_id', labelPosition:"top", options:"server/structure_settings.php?cmd=get_profile_stomat_care"},
				{view:'datepicker', type:"time", name:"work_begin", localId:"work_begin", label:"Начало работы", labelPosition:"top"},
				{view:'datepicker', type:"time", name:"work_end", label:"Окончание работы", labelPosition:"top", invalidMessage:"Время окончания должно быть позже чем время начала" },
				{cols:[
					personellCombo,
					{view:'icon', icon:'mdi mdi-account-remove-outline', click:() => {this.app.getService('personellCombo').setValue("");}}
				]},
				{view:"checkbox", name: "is_have_schedule", labelRight:'Ведёт приём', labelWidth:0},
				{view:"checkbox", name: "terminal_bool", labelRight:'Без подчиненных', labelWidth:0},
				{view:"checkbox", name: "active", labelRight:'Актуально', labelWidth:0},
				{cols:[
					{view:"button", value:"Сохранить", hotkey: "enter", click: () => {
						const form = this.getRoot();
						if (form.isDirty()){
							if (form.validate()){
								let structure = form.getValues();
								structure.work_begin_int = structure.work_begin.getHours()*60 + structure.work_begin.getMinutes();
								structure.work_end_int = structure.work_end.getHours()*60 + structure.work_end.getMinutes();
								this.app.callEvent("save:structureForm",[structure]);
								//this.view.hide();
							} else	webix.message({ type:"error", text:"Заполните все поля"});
						}
					}},
					{view:"button", value:"Отмена", hotkey: "esc", click: () => {
						this.app.callEvent("cancel:structureForm");
						this.view.hide();
					}}
				]},
				{}
			],
			rules:{
				work_end: (value) => { return value > this.$$("work_begin").getValue(); }
			}
		};
	}

	init(view) {
		this.view = view;

		/*view.getPopup().getList().sync(personellStorage);
		personellStorage.waitData.then(() => {
			view.getPopup().getList().sync(personellStorage);
		});*/

		this.on(this.app, "createRoot:treeControlPanel", () => {
			view.clear();
			view.setDirty(false);
			view.focus('value');
			//view.focus();
			view.show();
		});

		this.on(this.app, "showForm:formPanel", (item) => {
			view.clear();
			//console.log(item);
			item.work_begin = `${(addLeadZero(item.work_begin_int-item.work_begin_int % 60)/60)}:${addLeadZero(item.work_begin_int%60)}`;
			item.work_end = `${addLeadZero((item.work_end_int - item.work_end_int % 60) / 60)}:${addLeadZero(item.work_end_int % 60)}`;
			view.setValues(item);
			view.setDirty(false);
			view.show();
		});

		this.on(this.app, "click:structureTree", (item) => {
			console.log(item);
			item.work_begin = `${(addLeadZero(item.work_begin_int-item.work_begin_int % 60)/60)}:${addLeadZero(item.work_begin_int%60)}`;
			item.work_end = `${addLeadZero((item.work_end_int - item.work_end_int % 60) / 60)}:${addLeadZero(item.work_end_int % 60)}`;
			view.setValues(item);
			view.setDirty(false);
			view.show();
		});
	}

}