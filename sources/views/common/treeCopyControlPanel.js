import {JetView} from "webix-jet";

export default class treeCopyControlPanel extends JetView{
	config(){
		return {cols:[
			{view:'icon', icon:'mdi mdi-folder-plus-outline', tooltip:'Новый основной элемент',
				click:()=>{
					this.app.callEvent("createRoot:treeControlPanel");
				}
			},
			{view:'icon', icon:'mdi mdi-content-copy', tooltip:'Скопировать манипуляцию',
				click:()=>{
					this.app.callEvent("copy:treeControlPanel");
				}
			},
			{view:'icon', icon:'mdi mdi-plus', tooltip:'Новый подчиненный элемент',
				click:()=>{
					this.app.callEvent("createSlave:treeControlPanel");
				}
			},
			{view:'icon', icon:'wxi-trash', tooltip:'Удалить выбранный',
				click:()=>{
					this.app.callEvent("delete:treeControlPanel");
				}
			}
		]}
	}
}
