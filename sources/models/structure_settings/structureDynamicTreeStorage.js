//const tc = webix.proto({}, webix.TreeCollection, webix.Undo);

//export const structureDynamicTreeStorage = new tc({ 
export const structureDynamicTreeStorage = new webix.TreeCollection({ 
	url: "server/structure_settings.php?cmd=get_structure_dynamic_tree",
	//undo:true,
	save:{
		url: "server/structure_settings.php?cmd=update_structure_tree",
		/*updateFromResponse:true,
		undoOnError:true,
		on:{
			onAfterSaveError: function(id, status, response){
				webix.message({type:'error',text:response.err_message});
			}
		}*/
	},
	on:{
		/*'onBeforeAdd': function(id,obj,index){
			let maxOrder = 0;
			let optionsArray = this.find(function(item){
				return item.$parent == obj.$parent;
			},false);
			optionsArray.forEach(function(item, index, array) {
				let order = parseInt(item.order)
				if (maxOrder < order) maxOrder = order;
			});
			obj.order = maxOrder + 1;
		}*/
	}
});