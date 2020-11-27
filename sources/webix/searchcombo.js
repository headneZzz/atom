webix.protoUI({
	name:"searchcombo",
	$cssName:"combo custom",
	$renderIcon:function(){
		var config = this.config;
		var height = config.aheight - 2*config.inputPadding, padding = (height - 18)/2 -1;
		return `<span style='right:${padding}px;height:${height-padding}px;padding-top:${padding}px;'
			class='webix_input_icon mdi mdi-menu-down'></span>
			<span style='right:28px;height:${height-padding}px;padding-top:${padding}px;'
			class='webix_input_icon mdi mdi-close-circle-outline'></span>`;
	},
	on_click:{
		"mdi-close-circle-outline":function(e, id, node){
			this.setValue();
		}
	},
}, webix.ui.combo);