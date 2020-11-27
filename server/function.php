<?php
//----------------------------------------------------------------------------------
/**
 * Получает значение строковой переменной из запроса 
 * экранирует ' " \ NULL
 *
 * @param string $name - имя переменной в REQUEST
 * @return string
 */
function get_string($name, $size){
	if (isset($_REQUEST[$name])){
		if(get_magic_quotes_gpc()) $_REQUEST[$name]=stripslashes($_REQUEST[$name]);
		$value = trim(htmlspecialchars(strip_tags(mb_substr($_REQUEST[$name],0,$size)), ENT_QUOTES));
	} else {
		$value = "";
	}
 	return $value;
}

function get_string_quotes($name, $size){
	if (isset($_REQUEST[$name])){
		if(get_magic_quotes_gpc()) $_REQUEST[$name]=stripslashes($_REQUEST[$name]);
		$value = trim(htmlspecialchars(strip_tags(mb_substr($_REQUEST[$name],0,$size)), ENT_NOQUOTES));
	} else {
		$value = "";
	}
 	return $value;
}

/**
 * Получает значение строковой переменной из запроса для postgre
 * экранирует ' " \ 
 * для пустого возвращает null
 *
 * @param string $name - имя переменной в REQUEST
 * @return string
 */
function get_string_null($name, $size){
	if (isset($_REQUEST[$name])){
		if(get_magic_quotes_gpc()) $_REQUEST[$name]=stripslashes($_REQUEST[$name]);
		$value = trim(htmlspecialchars(strip_tags(mb_substr($_REQUEST[$name],0,$size)), ENT_QUOTES));
		if ($value == '') return "null"; else return "'$value'";
	} else {
		return "null";
	}
}

function get_csv_null($name, $size){
	if (isset($_REQUEST[$name])){
		if(get_magic_quotes_gpc()) $_REQUEST[$name]=stripslashes($_REQUEST[$name]);
		$value = trim(htmlspecialchars(strip_tags(mb_substr($_REQUEST[$name],0,$size)), ENT_QUOTES));
		if ($value == '') return "null"; else return "$value";
	} else {
		return "null";
	}
}


/**
 * Возвращает строку из запроса без ограничений по длине
 * Если такой в запросе нет, возвращает  ""
 *
 * @param string $name
 * @return string
 */
function get_long_string($name){
	if (isset($_REQUEST[$name])){
		if(get_magic_quotes_gpc()) $_REQUEST[$name]=stripslashes($_REQUEST[$name]);
		$value = trim(htmlspecialchars(strip_tags($_REQUEST[$name]), ENT_QUOTES));
	} else {
		$value = "";
	}
 	return $value;
}

function get_string_with_tag($name, $size){
	//Получаем строку из запроса с тегами
	if (isset($_REQUEST[$name])){
		if(get_magic_quotes_gpc()) $_REQUEST[$name]=stripslashes($_REQUEST[$name]);
		$value = trim(substr($_REQUEST[$name],0,$size));
	} else {
		$value = "";
	}
 	return $value;
}

function get_string_value($name, $size){
	//Получаем переменную из реквеста, если в реквесте ее нет,
	//то смотрим в переменных сессии, если и там нет, возвращаем ""
	if (isset($_REQUEST[$name])){
		if(get_magic_quotes_gpc()) $_REQUEST[$name]=stripslashes($_REQUEST[$name]);
		$value = trim(htmlspecialchars(strip_tags(substr($_REQUEST[$name],0,$size)), ENT_QUOTES));
		$_SESSION[$name] = $value;
	} else {
		if (isset($_SESSION[$name])) {
			$value = $_SESSION[$name];
		} else {
			$value = "";
		}
 	}
 	return $value;
}

function get_num ($name)  {
	if (isset($_REQUEST[$name])){
		if (is_numeric($_REQUEST[$name])) return intval($_REQUEST[$name]); else return 0;
	} else {
		return 0;
	}
}

function get_num_null ($name)  {
	if (isset($_REQUEST[$name])){
		if (is_numeric($_REQUEST[$name])) return intval($_REQUEST[$name]); else return null;
	} else {
		return null;
	}
}

function get_num_str_null ($name)  {
	if (isset($_REQUEST[$name])){
		if (is_numeric($_REQUEST[$name])) return intval($_REQUEST[$name]); else return 'null';
	} else {
		return 'null';
	}
}

 //Получить числовую переменную из сессии
 function get_num_from_session($name){
	 if(isset($_SESSION[$name])){
		 if (intval($_SESSION[$name]) > 0){
			return intval($_SESSION[$name]);
		 } else {
			return 0;
		}
	 } else {
		return 0;
	}
}

/**
 * Получить переменную типа bool из зпроса
 *принимает параметры как true/false так и 1/0
 *
 * @param string $name
 * @return string
 */
function get_bool_as_string($name){
	if (isset($_REQUEST[$name])){
		if($_REQUEST[$name] == "1" || $_REQUEST[$name] == "t" || $_REQUEST[$name] == "true") return "true"; else return "false";
	} else {
		return "false";
	}
}


/**
 * Получить переменную типа bool из зпроса
 *принимает параметры как true/false так и 1/0
 *
 * @param string $name
 * @return boolean
 */
function get_bool($name){
	//$result = false;
	if (isset($_REQUEST[$name])){
		if($_REQUEST[$name] == "1" || $_REQUEST[$name] == "t" || $_REQUEST[$name] == "true") return true;
		else return false;
		//if($_REQUEST[$name] == "1" || $_REQUEST[$name] == "true" || $_REQUEST[$name] == true) $result = true;
	}
	return false;
}

//Недоделал
function get_float($name)  {
	if (isset($_REQUEST[$name])){
		//if ( is_float($_REQUEST[$name])) return floatval($name); else return 0;
		return floatval($_REQUEST[$name]);
	} else {
		return 0;
	}
}

function get_float_str_null ($name)  {
	if (isset($_REQUEST[$name])){
		if (is_numeric($_REQUEST[$name])) return floatval($_REQUEST[$name]); else return 'null';
	} else {
		return 'null';
	}
}

function get_var_string($name, $size){
	//Получить строку из переменной длинной size
	if (isset($name)){
		if(get_magic_quotes_gpc()) $name=stripslashes($name);
		$value = trim(htmlspecialchars(strip_tags(substr($name,0,$size)), ENT_QUOTES));
	} else {
		$value = "";
	}
 	return $value;
}

/**
 * [split_string преобразовать строку вида (1,2),(2,2),(1,4) в массив значений в скобках со скобками]
 * @param  [type] $input [description]
 * @return [type]        [description]
 */
function split_string($input){
	$output_array = [];
	$output = '';
	$item = null;
	$input = preg_replace('/\s/', '', $input);
	$len = strlen($input);
	for ($i=1; $i<$len; $i++) {
		if ($input[$i-1] != ' ') $output .= $input[$i-1];
		if($input[$i-1].$input[$i] == '),'){
 			array_push($output_array, $output);
 			$output = '';
 			$i++;
 		}
	}
	$output .= $input[$i-1];
	array_push($output_array, $output);
	return $output_array;
}

 //Проверка регистрации пользователя в системе
 function valid_user(){
	if(isset($_SESSION["user"])){
		return intval($_SESSION["user"]["personell_id"]);
	} else {
		echo '{"status": "error", "message":"Ошибка! Пользователь не вошел в систему"}';
		exit();
	}
}

//Проверка регистрации пользователя в системе
function valid_personell($module_name){
	if(isset($_SESSION["user"])){
		if(isset($_SESSION["user"]["modules"])){
			/*print_r($_SESSION["user"]["modules"]);
			echo "====";
			print_r(array_column($_SESSION["user"]["modules"],'id'));
			echo "===========";
			print_r(array_search($module_name, array_column($_SESSION["user"]["modules"],'id')) !== null);*/
			if(array_search($module_name, array_column($_SESSION["user"]["modules"],'id')) !== null) return $_SESSION["user"];
			else{
				echo '{"status": "error", "message":"Ошибка! У пользователя нет права на использование модуля"}';
				exit();
			}
		} else {
			echo '{"status": "error", "message":"Ошибка! У пользователя нет закрепленных модулей"}';
			exit();
		}
	} else {
		echo '{"status": "error", "message":"Ошибка! Пользователь не вошел в систему"}';
		exit();
	}
}

//Проверка на прошедшую дату с лагом
function check_past_str($str_date, $time){
	$date_time = strtotime($str_date);
	if (time() < $date_time+$time ) return true; else return false;
}

 
 /**
  * [Проверка регистрации пользователя в системе и возможности работать с указанным модулем]
  * @return [type] [description]
  */
 function get_access_user($module_name){
	
	if ($module_name !=""){
		$sql = "SELECT modules.module_id AS id FROM modules JOIN module_role ON (modules.module_id = module_role.module_id) 
			JOIN roles ON (roles.role_id = module_role.role_id)
			JOIN user_role ON (roles.role_id = user_role.role_id)
		WHERE modules.module_name='$module_name';";
		$result = pg_query($sql);
		$nbrows = pg_num_rows($result);
		if ($nbrows>0) {
			return true;
		} else {
			echo '{"status": "error", "message":"Ошибка! У вас нет полномочий для доступа к этому модулю"}';
			exit();
		}
	} else {
		return true;
	}
}

function destroy_session() {
	if ( session_id() ) {
		// Если есть активная сессия, удаляем куки сессии,
		setcookie(session_name(), session_id(), time()-60*60*24);
		// и уничтожаем сессию
		session_unset();
		session_destroy();
	}
	return true;
}
/*
function start_session() {
	// Если сессия уже была запущена, прекращаем выполнение и возвращаем TRUE
	// (параметр session.auto_start в файле настроек php.ini должен быть выключен - значение по умолчанию)
	if ( session_id() ) {
		return true;
	}
	else return session_start();
	// Примечание: До версии 5.3.0 функция session_start()возвращала TRUE даже в случае ошибки.
	// Если вы используете версию ниже 5.3.0, выполняйте дополнительную проверку session_id()
	// после вызова session_start()
}
*/
function start_session() {
	// Если сессия уже была запущена, прекращаем сессию и создаем новую
	// (параметр session.auto_start в файле настроек php.ini должен быть выключен - значение по умолчанию)
	if ( session_id() ) {
		destroy_session();
		session_start();
	}
	else return session_start();
	// Примечание: До версии 5.3.0 функция session_start()возвращала TRUE даже в случае ошибки.
	// Если вы используете версию ниже 5.3.0, выполняйте дополнительную проверку session_id()
	// после вызова session_start()
}
/*
function send_alert($adre, $message){
	return pg_query("INSERT INTO alerts (alerts, user_id) VALUES ($message, $user_id);");
}
*/
function get_user_name($user_id){
	$result = pg_query("SELECT user_name FROM users WHERE user_id = $user_id");
	$rec = pg_fetch_array($result, NULL, PGSQL_ASSOC);
	return $rec['user_name'];
}

function getExtension($filename) {
	$path_info = pathinfo($filename);
    return $path_info['extension'];
  }
