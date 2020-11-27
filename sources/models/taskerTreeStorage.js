export const taskerTreeStorage = new webix.TreeCollection({
	url:"server/tasker.php?cmd=get_task_tree",
	save:"server/tasker.php?cmd=update_task_tree",
	/*scheme:{
		$init:function(obj){
			if (obj.work_date){
				//console.log("obj.work_date", obj.work_date);
				obj.work_date = new Date(obj.work_date);	
			} 
		}
	}*/
});
