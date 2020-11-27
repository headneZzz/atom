import {JetView} from "webix-jet";

import devFilterList from "views/tabel/devFilterList";
import monthSelectView from "views/tabel/monthSelectView";
import subjectSelect from "views/tabel/subjectSelect";
import personellSelect from "views/tabel/personellSelect";
import devForm from "views/tabel/devForm";
import developmentsList from "views/tabel/developmentsList";
import tabelTable from "views/tabel/tabelTable";

export default class tabel extends JetView{
	config(){
		return {
			type:"wide", margin:10, padding:{ top:10, bottom:10, right:10, left:5 },
			rows:[
				{view: 'form', cols:[
					//{view:"toggle", type:"icon", icon:'mdi mdi-filter'},
					{view:'icon', icon:'mdi mdi-filter', click:()=> {this.app.getService('devFilterList').show();}},
					{gravity: 0.2},
					monthSelectView,
					{gravity: 0.2},
					subjectSelect,
					{view:'icon', icon:'mdi mdi-account-plus-outline', click:()=> {this.app.getService('personellSelect').show();}},
				]},
				devFilterList,
				personellSelect,
				tabelTable,
				{ view:"resizer" },
				{cols:[
					developmentsList,
					//{gravity: 0.2},
					devForm
				]}
			]
		}
	}
}