webix.protoUI({
	name:"photo",
	$allowsClear: true,
	defaults:{
		width:260,
		height:260
	},
	$init(config){
		if (config.value) webix.delay(() => this.setValue(config.value));
	},
	getValue(){
		return this.config.value;
	},
	setValue(value){
		console.log("photos value", value);
		//console.log("setValue in photo", value);
		let height, width;
		height = width = this.config.height;
		if (value){
			this.setHTML(`<img style="height:${height}px;width:${width}px;" src="data/photos/${value}" />`);
		}else{
			this.setHTML('');
		}
		
		this.config.value = value;
	}
}, webix.ui.template);
