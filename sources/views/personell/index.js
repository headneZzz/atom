import {JetView} from "webix-jet";
//import medicalStructureSelect from "views/cabinets/medicalStructureSelect";
import personellList from "views/personell/personellList";
import personellForm from "views/personell/personellForm";
//import roleList from "views/personell/roleList";
//import roleForm from "views/personell/roleForm";
//import moduleList from "views/personell/moduleList";

export default class personell extends JetView{
	config(){
		/*return {view:'layout', type:"wide", margin:10, padding:{ top:10, bottom:10, right:10, left:5 },
			cols:[
				personellList,
				personellForm
			]
		};*/
		return {  
			rows:[
				{
					view:"segmented", id:'tabbar', value: 'View1', multiview:true, options: [
						{ value: 'Работники', id: 'personell'},
						{ value: 'Роли', id: 'roles'}
					]
				},
				{ id:"mymultiview",
					cells:[
						{id:"personell",
							cols:[
								personellList,
								personellForm
							]
						},
						/*{id:"roles",
							cols:[
								{rows:[
									roleList,
									moduleList
								]},
								roleForm
							]}*/
					]
				}
			]
		}
	}
}