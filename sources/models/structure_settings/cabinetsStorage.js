export const cabinetsStorage = new webix.DataCollection({
	url:"server/structure_settings.php?cmd=get_cabinets",
	save:"server/structure_settings.php?cmd=update_cabinets"
});
