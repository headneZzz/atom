//const JetApp = webix.jet.JetApp;
import {JetView} from "webix-jet";
import {devTypeStorage} from "models/devTypeStorage";

export default class devFilterList extends JetView{
	config(){
		return {
			view:'list',
			minHeight: 120,
			hidden: true,
			layout:"x",
			template:"{common.is_show()} #dev_type#",
			type:{
				is_show:function(obj){
					if (obj.is_show) {
						return "<span class='check webix_icon wxi-checkbox-marked'></span>";
					}else{
						return "<span class='check webix_icon wxi-checkbox-blank'></span>";
					}
				}
			},
			onClick:{
				"check": (e, id) => {
					var item = this.getRoot().getItem(id);
					item.is_show = item.is_show?0:1;
					this.getRoot().updateItem(id, item);
					this.app.getService('tabelTable').update();
				}
			},
			data:[]
			//url:'server/tabel.php?cmd=get_dev_type'
		}
	}

	init(view) {
		//console.log(webix.version);
		//view.parse(devTypeStorage);
		devTypeStorage.waitData.then(() => {
			view.parse(devTypeStorage);
		});

		this.app.setService('devFilterList',{
			show: () => {
				if(view.isVisible()) view.hide(); else view.show();
			}
		});
	}
		
}