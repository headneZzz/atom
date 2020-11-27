webix.protoUI({
	name: "phonelist",
	$allowsClear: true,
	defaults: {
		label: "",
		labelWidth: 80,
		//height: 200,
		value: [],
		swap: false
	},
	//$formElement: true,
	$init: function (cfg) {
		config = webix.extend(this.defaults, cfg, true);
		var value = [];
		for (var i = 0; i < config.value.length; i++) {
			value.push({value: config.value[i]});
		}
		//console.log(value);
		config.rows = [
			{view:'list', id:"list",
				select: false, 
				height:80,
				template:function(obj){
					//console.log(obj);
					if (obj){
						let phone = `<span class='mdi mdi-phone'></span>${obj.phone}`;
						if (obj.remark) phone += ` - ${obj.remark}`;
						return phone+`<span class='mdi mdi-close-circle'></span>`;	
					}		
				},
				on:{
					onFocus:()=>{
						//console.log("i am list and I have focus");
						//this.$$('phone').focus()
						webix.delay(() => this.$$('phone').focus());
					}
				},
				onClick:{
					'mdi-close-circle':function(e, id){
						  //console.log('click!');
						  this.remove(id);
						  return false;
					  }
				  }
			},
			{cols:[
				{view: "text", id:"phone", placeholder:"Номер телефона",
					on:{
						onEnter:() => {
							let phone_code = '8652';
							let phoneInput = this.$$('phone');
							let phoneNumber = phoneInput.getValue().split('-').join('');

							//Введены какие-то символы. Проверяем:
							// - если символов = 10 - длина кода города, то введён городской номер
							// - если символов = 10, то введён федеральный номер, добавляем к нему +7
							// - если символов = 11, то введён федеральный номер без + или с 8, отбрасываем первую цифру, добавляем к нему +7
							// - если символов > 11, но < 16 - введен международный номер, оставляем как есть.
							// - если символов < 10 - длина кода города или > 16 - ошибка
							//если нажали Enter - запись номера без комментария
							// - запись номера без комментария и готовность ввести еще один номер
							// - если нет символов - переходим к следующему разделу формы

							//console.log("phoneNumber.length = "+phoneNumber.length);
							if (phoneNumber.length > 0){
								if (phoneNumber.length == 10 - phone_code.length) this.phoneToAdd = "+7"+phone_code+phoneNumber;
								else if (phoneNumber.length == 10) this.phoneToAdd = "+7"+phoneNumber;
								else if (phoneNumber.length == 11) this.phoneToAdd = "+7"+phoneNumber.substring(1);
								else if (phoneNumber.length > 11 && phoneNumber.length < 16) this.phoneToAdd = phoneNumber;
								else {
									webix.message({type:"error", text:"Введен неправильный номер"});
									this.phoneToAdd = '';
									return false;
								}
								let remark = this.$$('remark');;
								this.$$('list').add({phone: this.phoneToAdd, remark: remark.getValue()});
									//this.blockEvent();
									phoneInput.config.value = phoneInput.getInputNode().value;
									phoneInput.setValue("");
									remark.setValue("");
									this.phoneToAdd = '';
							}else{
								this.callEvent("finish");
								//return true;
							}
						},
						onBlur: (prev_view) => {
							let phone_code = '8652';
							let phoneInput = this.$$('phone');
							let phoneNumber = phoneInput.getValue().split('-').join('');
							//Введены какие-то символы. Проверяем:
							// - если символов = 10 - длина кода города, то введён городской номер
							// - если символов = 10, то введён федеральный номер, добавляем к нему +7
							// - если символов = 11, то введён федеральный номер без + или с 8, отбрасываем первую цифру, добавляем к нему +7
							// - если символов > 11, но < 16 - введен международный номер, оставляем как есть.
							// - если символов < 10 - длина кода города или > 16 - ошибка
							//после этого перенос фокуса к комментарию для телефона
							// - если нет символов - переходим к следующему разделу формы

							if (phoneNumber.length > 0){
								if (phoneNumber.length == 10 - phone_code.length) this.phoneToAdd = "+7"+phone_code+phoneNumber;
								else if (phoneNumber.length == 10) this.phoneToAdd = "+7"+phoneNumber;
								else if (phoneNumber.length == 11) this.phoneToAdd = "+7"+phoneNumber.substring(1);
								else if (phoneNumber.length > 11 && phoneNumber.length < 16) this.phoneToAdd = phoneNumber;
								else {
									webix.message({type:"error", text:"Введен неправильный номер"});
									//phoneInput.focus();
									webix.delay(() => phoneInput.focus());
									this.phoneToAdd = '';
									return false;
								}
							} else {
								this.callEvent("finish");
							}
						},
						onKeyPress: function(code, e){
							//console.log(code);
							//цифры 48-57, стереть 8, del - 46, ТАБ - 9, точка 191, запятая 188, минус 189, ( - 57, ) - 48
							// стрелки - 37, 39, "+" - 187 или 107
							if ((code > 45 && code <58) || code == 8  || code == 37 || code == 39 || code == 9 || code == 189 || code == 107 || code == 187 ) {}
							else return false;
						}
			   		}
				},
				{view: "text", id:"remark", placeholder:"Комментарий",
					on:{
						onBlur: (code, e) => {
							//Введены какие-то символы.
							//Если телефон не пустой, добавляем телефон и комментарий (если он есть). Обнуляем телефон, поля. Переходим к следующему разделу формы
							//Если поле не пустое и нет номера телефона - сообщаем об ошибке, что нужен телефон, переходим в поле телефона

							//console.log(' in remark blur - this.phoneToAdd',this.phoneToAdd);
							let remarkInput = this.$$('remark');
							let remark = remarkInput.getValue();
							let phoneInput = this.$$('phone');
							if (this.phoneToAdd.length > 0){
								this.$$('list').add({phone: this.phoneToAdd, remark: remark});
								this.phoneToAdd = '';
								remarkInput.config.value = remarkInput.getInputNode().value;
								remarkInput.setValue("");
								phoneInput.setValue("");

								this.callEvent("finish");
							} else if (remark.length > 0) {
								webix.message({type:"error", text:"Номер телефона введён неверно"});
								phoneInput.focus();
							}
							/* else {
							webix.message({type:"error", text:"Номер телефона введён неверно"});
							}*/
						},
						onEnter: (code, e) => {
							//console.log(' in remark enter - this.phoneToAdd',this.phoneToAdd);
							//Введены какие-то символы.
							//Если телефон не пустой, добавляем телефон и комментарий (если он есть). Обнуляем телефон. Переходим к добавлению нового телефона
							//Если поле не пустое и нет номера телефона - сообщаем об ошибке, что нужен телефон, переходим в поле телефона
							let remarkInput = this.$$('remark');
							let remark = remarkInput.getValue();
							let phoneInput = this.$$('phone');
							
							if (this.phoneToAdd.length > 0){
								this.$$('list').add({phone: this.phoneToAdd, remark: remark});
								this.phoneToAdd = '';
								remarkInput.config.value = remarkInput.getInputNode().value;
								remarkInput.setValue("");
								phoneInput.setValue("");

							phoneInput.focus();
							} else if (remark.length > 0) {
								webix.message({type:"error", text:"Номер телефона введён неверно"});
								phoneInput.focus();
							}

						}
					}
				},
				{view:'icon', icon:'mdi mdi-plus', tooltip:'Добавить телефон',
					click:()=>{
						//Если телефон не пустой, добавляем телефон и комментарий (если он есть). Обнуляем телефон. Переходим к добавлению нового телефона
						//Если поле не пустое и нет номера телефона - сообщаем об ошибке, что нужен телефон, переходим в поле телефона
						let remarkInput = this.$$('remark');
						let remark = remarkInput.getValue();
						let phoneInput = this.$$('phone');
						
						if (this.phoneToAdd.length > 0){
							this.$$('list').add({phone: this.phoneToAdd, remark: remark});
							this.phoneToAdd = '';
							remarkInput.config.value = remarkInput.getInputNode().value;
							remarkInput.setValue("");
							phoneInput.setValue("");

							phoneInput.focus();
						} else if (remark.length > 0) {
							webix.message({type:"error", text:"Номер телефона введён неверно"});
							phoneInput.focus();
						}
					}
				}
			]}
		]
	
		this.$ready.push(function () {
			this.setValue(config.value);
			//this.setChoices(config.choices);
		});
	},
	
	phoneToAdd: '',
	
	setValue: function(values){
		//console.log("set values",values);
		let list = this.$$('list');
		/*this.phoneToAdd = '';
		list.clearAll(); 
		if (values) list.parse(values);*/

		if (!values) list.clearAll();
		if (values[0] =='('){
			console.log("ok!!!");
		}else if (values[0] =='['){
			list.clearAll();
			list.parse(values);
			console.log("parsed OK");
		}
	},

	getValue: function () {
		//return this.$$('list').serialize();
		let listId = '';
		
		this.$$('list').data.each(function(obj){
			listId += `('${obj.phone}','${obj.remark}'),`;
		});
		if (listId.length > 3) return listId.substring(0, listId.length-1);
		else return undefined;
	},

	/*clear: function () {
		console.log("clear");
		this.$$('list').clearAll(); 
	}*/
	$setValue:function(value){
		this.$$('list').clearAll(); 
		//console.log("$set values",value);
		//this.getInputNode().value = (value||"").toUpperCase();
	},

	focus: function(){
		this.$$('phone').focus();
	}

}, webix.IdSpace, webix.ui.layout);