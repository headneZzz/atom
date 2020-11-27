export const personellStorage = new webix.DataCollection({
	url:"server/personell.php?cmd=get_personell",
	save: "server/personell.php?cmd=update_personel_list"
});
