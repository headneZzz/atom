import {roleStorage} from "models/roleStorage";

import {JetView} from "webix-jet";
export default class roleSelect extends JetView{
	config(){
		return {
			label:'Роль',
			name: 'role_id',
			//view: "richselect", 
			view: "combo", 
			options:[],
			/*on:{
				onChange: (newv, oldv) => {
					this.app.callEvent("onChange:roleSelect",[newv]);
				}
			}*/
		}
	}

	init(view){
		
		roleStorage.waitData.then(() => {
			/*view.getList().data.sync(roleStorage, function(){
				this.filter(function(obj) {
					return obj.is_active;
				});
			});*/
			view.getList().data.sync(roleStorage);
		});
		
		this.app.setService("roleSelect", {
			getValue: () => view.getValue(),
			getItem: () => {
				let roleId = view.getValue();
				//console.log("roleId", roleId);
				return view.getList().getItem(roleId);
				
			}
		});
	}
}
