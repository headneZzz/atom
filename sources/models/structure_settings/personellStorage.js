export const personellStorage = new webix.DataCollection({
	url:"server/structure_settings.php?cmd=get_personell",
	save:"server/structure_settings.php?cmd=update_personell"
});
