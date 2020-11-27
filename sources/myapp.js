import "./styles/app.css";
import {JetApp, EmptyRouter, HashRouter, plugins } from "webix-jet";
import session from "models/session";
import {client} from "helpers/client.js";
import {state} from "helpers/state.js";

webix.i18n.setLocale("ru-RU");
//var format = webix.Date.dateToStr("%Y-%m-%d");
webix.Date.startOnMonday = true;

//console.log(webix.version);
//webix.debug({events: false, size:false});
//webix.debug({events: true, size:true});

export default class app extends JetApp{
	constructor(config){
		let theme = "", shadows = "";
		/*try {
			theme = webix.storage.session.get("doctor_demo_theme");
			shadows = webix.storage.session.get("doctor_demo_shadows");
		}
		catch(err){
			webix.message("You blocked cookies. Themes and shadows won't be restored after page reload.","debug");
		}*/

		const size = () => {
			const screen = document.body.offsetWidth;
			return screen > 1415 ? "wide" : ( screen > 1200 ? "mid" : "small");
		};

		const defaults = {
			id 		: APPNAME,
			version : VERSION,
			router 	: BUILD_AS_MODULE ? EmptyRouter : HashRouter,
			debug 	: !PRODUCTION,
			start 	: "/top/start",
			//start 		: "/login",
			theme		: theme || "",
			shadows		: shadows || "",
			size		: size()
		};

		super({ ...defaults, ...config });

		/*this.use(plugins.User, { 
			model: session,
			afterLogin: "top/start"
		 });*/
		this.use(plugins.User, { model: session });
		this.use(client);
		//this.use(unit);
		this.use(state);

		webix.event(window, "resize", () => {
			const newSize = size();
			if (newSize != this.config.size){
				this.config.size = newSize;
				this.refresh();
			}
		});

		this.attachEvent("app:error:resolve", function() {
			//console.log("app:error:resolve");
			webix.delay(() => this.show("/login"));
		});

	}
}

if (!BUILD_AS_MODULE){
	webix.ready(() => {
		if (!webix.env.touch && webix.env.scrollSize && webix.CustomScroll) webix.CustomScroll.init();
		new app().render();
		//app.use(client);
	});
}
