export const roleStorage = new webix.DataCollection({
	url: "server/personell.php?cmd=get_role_list",
	save: "server/personell.php?cmd=update_role_list"
});