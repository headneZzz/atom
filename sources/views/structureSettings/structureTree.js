import {JetView} from "webix-jet";
//import {structureDynamicTreeStorage} from "models/structure_settings/structureDynamicTreeStorage";
import {structureDynamicTreeStorage} from "models/structure_settings/structureDynamicTreeStorage";
import {personellStorage} from "models/structure_settings/personellStorage";


export default class structureTree extends JetView{
	config(){
		return {view:"tree",
			url:"server/structure_settings.php?cmd=get_structure_dynamic_tree",
			save:"server/structure_settings.php?cmd=update_structure_tree", 
			template: (obj, common) => {
				//console.log(obj);
				let row = common.icon(obj,common) + common.folder(obj,common);
				let string = "";
				if (!obj.terminal_bool) string += obj.value+' - ';
				string += obj.post+' (';
				if(obj.personell_id){
					//console.log(personellStorage.getItem(obj.personell_id));
					string += personellStorage.getItem(obj.personell_id).value;
				} else {
					string += 'вакантна';
				}
				string += ')'
				if (!obj.active) string = '<span style="font-style:italic;">'+string+'</span>';
				return row+string;
			},
			type:{
				folder:function(obj){
					//console.log(obj);
					if(obj.terminal_bool)
						return "<span class='webix_icon mdi mdi-account'></span>";
					if (obj.$level == 1)
						return "<span class='webix_icon mdi mdi-hospital-building'></span>";
					
					/*if(obj.$level == 1)
						return "<span class='webix_icon mdi mdi-folder-open'></span>";*/
					return  "<span class='webix_icon mdi mdi-account-multiple'></span>";
				}
			},
			//data:structureDynamicTreeStorage,
			select: true,
			//filterMode: {openParents:true, level:false, showSubItems:true},
			filterMode: {openParents:false, level:1, showSubItems:true},
			on:{
				onItemClick: (id) => {
					this.app.callEvent("click:structureTree",[this.view.getItem(id)]);
				}
			}
		};
	}

	
	init(view) {
		this.view = view;
		//console.log("structureDynamicTreeStorage1",JSON.stringify(structureDynamicTreeStorage.data.pull));
		/*view.sync(structureDynamicTreeStorage);
		//console.log("structureDynamicTreeStorage2",JSON.stringify(structureDynamicTreeStorage.data.pull));

		structureDynamicTreeStorage.waitData.then(() => {
			//console.log("structureDynamicTreeStorage3",JSON.stringify(structureDynamicTreeStorage.data.pull));
			view.parse(structureDynamicTreeStorage);
			
			//this.filter(null, null);
		});
		*/

		this.on(this.app, "search:searchField", (text) => {
			if (text.length > 0){
				this.filter(text,null);
			}else{
				this.filter();
			}
		});

		this.on(this.app, "change:showArchSwitch", (newv) => {
			//console.log('archive - ',newv);
			this.filter(null,newv);
		});

		this.on(this.app, "save:structureForm", (item) => {
			if (item.id){
				/*structureDynamicTreeStorage.waitSave(function(){
					structureDynamicTreeStorage.updateItem(item.id, item);
				}).then((obj) => {
					this.filter(null, null);

				});*/
				view.updateItem(item.id, item);
			}else{
				/*structureDynamicTreeStorage.waitSave(function(){
					structureDynamicTreeStorage.add(item, -1, item.$parent);
				}).then((obj) => {
					this.filter(null, null);
				}).catch(e => {
					console.log('alarm!');
				});*/
				view.add(item, -1, item.$parent);
			}
		});

		this.on(this.app, "delete:treeControlPanel", () => {
			let selected = view.getSelectedItem();
			if (selected){
				//Проверяем, есть ли у него потомки
				if (selected.$count == 0){
					webix.confirm({
						title:"Подтвердите действие",
						ok:"Да", 
						cancel:"Отменить",
						text:"Вы хотите удалить "+selected.value+"?"
					}).then((result) => {
						/*structureDynamicTreeStorage.waitSave(function() {
							structureDynamicTreeStorage.remove(selected.id);
						}).then((obj) => {
							this.app.callEvent("saved:structureTree");
							this.filter(null, null);
						});*/
						view.remove(selected.id);
					})
				} else {
					webix.message({type:'error', text:'Невозможно удалить, так как содержит другие элементы'});
				}
			} else webix.message({type:'error', text:'Ничего не выбрано'});
		});

		this.app.setService("structureTree", {
			getSelectedItem : () => {
				return view.getSelectedItem();
			}
		});

	}

	filter(text,showArch){
		//console.log("structureDynamicTreeStorage4",JSON.stringify(structureDynamicTreeStorage.data.pull));
		if (!text) text = this.app.getService("searchField").getValue();
		if (!showArch) showArch = this.app.getService("showArchSwitch").getValue();
		if (text.length > 0){
			const pattern = text.toLowerCase();
			this.view.filter(function(obj){return (obj.active||showArch) && obj.value.toLowerCase().indexOf(pattern) >= 0;});
		} else {
			this.view.filter(function(obj){return obj.active||showArch});
		}
		//console.log("structureDynamicTreeStorage5",JSON.stringify(structureDynamicTreeStorage.data.pull));
	}

}