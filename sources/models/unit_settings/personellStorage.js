export const personellStorage = new webix.DataCollection({
	url:"server/unit_settings.php?cmd=get_personell",
	save:"server/unit_settings.php?cmd=update_personell"
});
