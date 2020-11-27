export const personalTreeStorage = new webix.TreeCollection({
	//url:"server/personal.php?cmd=get_personal_tree",
	save:"server/personal.php?cmd=update_personal_tree",
	/*scheme:{
		$init:function(obj){
			if (obj.work_date){
				//console.log("obj.work_date", obj.work_date);
				obj.work_date = new Date(obj.work_date);	
			} 
		}
	}*/
});
