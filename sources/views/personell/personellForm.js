import {JetView} from "webix-jet";
import {personellStorage} from "models/personellStorage";
import roleSelect from "views/personell/roleSelect";
import photo from "webix/photo";

export default class personellForm extends JetView{
	config(){
		return { view:"form",
			elements:[
				{cols:[
					{},
					{view:"photo",
						name:"photo",
						localId:"photo",
						css:"form_photo",
						borderless:true,
						width:260,
						height:260
					},
					{}
				]},
				{view:"uploader",
					multiple:false,
					upload:"server/personell.php?cmd=upload_photo",
					label:'Загрузить',
					//width:130,
					align:'center',
					on: {
						onUploadComplete: (response) => {
							webix.message("Файл загружен");
							console.log("response.fname", response.fname);
							this.$$("photo").setValue(response.fname);
							
							//this.$$("photo").setValue(response.fpath);

						}
					}
				},
				{view:'text', label:'Имя', name:'p_name'},
				{view:'text', label:'Отчество', name:'p_patronymic'},
				{view:'text', label:'Фамилия', name:'p_surname'},
				{view:"datepicker", name:"birthday",
					label:"Дата рождения", //labelPosition:"top",
					placeholder:"Кликните для выбора",
					editable:true,
					type: "date", stringResult: true
				},
				{view:'text', label:'Логин', name:'p_login'},
				{view:'text', label:'Пароль', name:'p_passwd'},
				roleSelect,
				{view:"checkbox", name: "active", labelRight:'Актуально', labelWidth:0},
				{view:"button", label:"Сохранить",
					click: () => {
						let form = this.getRoot();
						let values = form.getValues();
						if (values.id) form.save();
						else personellStorage.add(values, 0);
					}
				},
				{ view:"button", value:"Удалить",
					click: () => {
						personellStorage.remove(form.getValues().id);
					}
				},
				{view:"button", label:"Очистить",
					click: () => {
						this.getRoot().clear();
					}
				},
				{}
			]
		}
	}

	init(view){
		view.bind(personellStorage);
	}
}
