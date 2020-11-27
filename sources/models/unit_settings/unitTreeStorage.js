//const tc = webix.proto({}, webix.TreeCollection, webix.Undo);

//export const unitTreeStorage = new tc({ 
export const unitTreeStorage = new webix.TreeCollection({ 
	url: "server/unit_settings.php?cmd=get_unit_tree",
	//undo:true,
	save:{
		url: "server/unit_settings.php?cmd=update_unit_tree",
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
		'onAfterLoad': function(){
			console.log('onAfterLoad');
		},
		'onBindRequest': function(){
			console.log('onBindRequest');
		},
		'onLoadError': function(){
			console.log('onLoadError');
		}
	}
});