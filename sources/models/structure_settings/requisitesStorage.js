export const requisitesStorage = new webix.DataCollection({
	url:"server/structure_settings.php?cmd=get_requisites",
	save:"server/structure_settings.php?cmd=update_requisites"
});
