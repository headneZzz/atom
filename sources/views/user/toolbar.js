import {JetView} from "webix-jet";
import ProfileMenuView from "views/user/profilemenu";
import session from "models/session";
import ThemeSettingsView from "views/user/themesettings";


export default class ToolView extends JetView {
	config(){
		const theme = this.app.config.theme;

		return {
			view:"toolbar",
			css:theme + " webix_shadow_small",
			height:56,
			elements:[
				{view: "icon", icon: "mdi mdi-menu",
					click: function(){
						$$("top:menu").toggle();
					}
				},
				//clinicChoice,
				{},
				{
					paddingY:7,
					rows:[
						{
							margin:8,
							cols:[
								{	view: 'template',
									template:(obj) => {
										//console.log("template toolbar", obj);
										if (!obj.photo) obj.photo = "male.png";
										return '<image class="mainphoto" src="data/photos/'+obj.photo+'" webix_tooltip="Открыть мой профиль">';
									},
									//template: '<image class="mainphoto" src="data/photos/#photo#" webix_tooltip="Открыть мой профиль">',
									width:40, borderless:true, css:"toolbar_photo",
									localId:"user:avatar",
									onClick:{
										"mainphoto":function(){
											this.$scope.profileMenu.showMenu(this.$view);
											return false;
										}
									}
								},
								{
									view:"icon", icon:"mdi mdi-settings",
									tooltip:"Открыть настройки оформления",
									click:function(){
										this.$scope.themeSettings.showPopup(this.$view);
									}
								},
								{
									view:"icon", icon:"mdi mdi-bell",
									badge:4,
									tooltip:"Сообщения и напоминания",
									click:function(){
										//this.$scope.themeSettings.showPopup(this.$view);
									}
								}
							]
						}
					]
				},
				{ width:6 }
			]
		};
	}

	init(){
		//console.log("user toolbar init");

		this.profileMenu = this.ui(ProfileMenuView);
		this.themeSettings = this.ui(ThemeSettingsView);

		const user = this.app.getService("user").getUser();
		console.log("TOOLBAR ===> user.getUser() ->",user);

		this.$$('user:avatar').setValues(user);

		webix.TooltipControl.addTooltip(this.$$("user:avatar").$view);
	}
}
