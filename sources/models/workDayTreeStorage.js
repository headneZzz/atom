export const workDayTreeStorage = new webix.TreeCollection({
	//url:"server/main.php?cmd=get_structure",
	/*save:{
		"insert": "server/work_time_planner.php?cmd=update_plan_tree",
		"delete": "server/work_time_planner.php?cmd=update_plan_tree"
	},*/
	save:"server/tabel.php?cmd=update_work_day_tree",
	scheme:{
		$init:function(obj){
			if (obj.work_date){
				//console.log("obj.work_date", obj.work_date);
				obj.work_date = new Date(obj.work_date);	
			} 
		}
	}
});
