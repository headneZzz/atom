<?php
session_start();//Обьявляем сессию

require_once('connect.php');//Подключение к базе данных
require_once('function.php');//Подключаем необходимые функции

header('Content-type: application/json');

$personell = valid_personell('personell');

//$personell_id = valid_user();
//get_access_user("clientLayout");

$cmd = get_string('cmd',30);
//echo '<pre>'; print_r($cmd); echo '</pre>';

switch($cmd){
	case 'get_personell':
		get_personell();
		break;
	case 'update_personel_list':
		update_personel_list();
		break;
	case "upload_photo":
		upload_photo();
		break;
	case "get_role_list":
		get_role_list();
		break;
	case "update_role_list":
		update_role_list();
		break;
	
	default:
		echo '{"status":"error", "message" : "Не указана команда"}';
		//echo "{'status':'error', 'message' : 'Не указана команда'}";
		break;
}

function get_personell(){
	$sql = "
	SELECT personell_id AS id, p_surname||' '||p_name AS value,
		p_surname, p_name, p_patronymic, p_login, role_id, photo
	FROM personell;";
	//echo $sql;
	$result = pg_query($sql);
	$nbrows = pg_num_rows($result);
	if ($nbrows>0) {
		while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)) $arr[] = $rec;
		echo json_encode($arr);
	} else {
		echo '[]';
	}
}

function update_personel_list(){
	$webix_operation = get_string('webix_operation',10);
	
	$item_id = get_string('id',12);
	//$cashbox_name = get_string('cashbox_name',250);
	$p_name = get_string('p_name',50);
	$p_patronymic = get_string('p_patronymic',50);
	$p_surname = get_string('p_surname',50);
	$p_login = get_string('p_login',50);
	$p_passwd = get_string('p_passwd',50);
	
	$role_id = get_num('role_id');
	$active = get_bool_as_string('active');
	
	$photo = get_string_null('photo',250);
	$birthday = get_string_null('birthday',10);
	$email = get_string('email',100);
	$male = get_bool_as_string('male');
	
	
	if ($p_passwd == ''){
		$fields = '(p_name, p_patronymic, p_surname, p_login, role_id, photo, birthday, email, male, active)';
		$values = "('$p_name', '$p_patronymic', '$p_surname', '$p_login', $role_id, $photo, $birthday::date, '$email', $male, $active)";	
	}else{
		$fields = '(p_name, p_patronymic, p_surname, p_login, role_id, photo, birthday, email, male, active, p_passwd)';
		$values = "('$p_name', '$p_patronymic', '$p_surname', '$p_login', $role_id, $photo, $birthday::date, '$email', $male, $active, md5('$p_passwd'))";	
	}
	
	
	switch($webix_operation){
		case 'insert':
			$sql = 'INSERT INTO personell '.$fields.' VALUES '.$values.' RETURNING personell_id AS id;';
			break;
		case 'update':
			$sql = 'UPDATE personell SET '.$fields.' = '.$values.' WHERE personell_id = '.$item_id.' RETURNING personell_id AS id;';
			break;
		case 'delete':
			$sql = 'DELETE FROM personell WHERE personell_id = '.$item_id.' RETURNING personell_id AS id;';
			break;
		default:
			$message = '{"status":"error", "message" : "Не указана операция"}';
			break;
	}
	$result = pg_query($sql);
	$nbrows = pg_num_rows($result);
	
	if ($nbrows>0) {
		while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)) $arr[] = $rec;
		$message = json_encode($arr);
		//$message = str_replace("[null]", '[]', $message);
		$message = str_replace('"t"', 'true', $message);
		$message = str_replace('"f"', 'false', $message);
	} else {
		$message = '[]';
	}
	echo $message;
}

function upload_photo(){
	$file = $_FILES['upload']; //getting a file object
 
	if ($file['error'] !== UPLOAD_ERR_OK) {
	   die("{'status':'error', 'message':'Upload failed with error code". $file['error']."'}");
	}

	$info = getimagesize($file['tmp_name']);
	if ($info === FALSE) {
	   die("{'status':'error', 'message':'Не могу определить тип загруженного файла'}");
	}

	if (($info[2] !== IMAGETYPE_GIF) && ($info[2] !== IMAGETYPE_WEBP) && ($info[2] !== IMAGETYPE_JPEG) && ($info[2] !== IMAGETYPE_PNG)) {
	   die("{'status':'error', 'message':'Загруженный файл не gif/jpeg/png'}");
	}

	$destination = $_SERVER['DOCUMENT_ROOT'].'/data/photos';
	
	$ext = pathinfo($file['name'], PATHINFO_EXTENSION);
	
	$new_name = md5(strtotime('now')).'_'.md5($file['name']).".".$ext;
	$filename = $destination."/".$new_name; //set destination

	move_uploaded_file($file["tmp_name"], $filename); //move files
	echo '{ "status": "server", "fname":"'.$new_name.'", "fpath":"'.$filename.'" }';
}

function get_role_list(){
	$sql = "
		SELECT role_id AS id, role_name AS value
		FROM roles;";
	
	$result = pg_query($sql);
	$nbrows = pg_num_rows($result);
	
	if ($nbrows>0) {
		while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)) $arr[] = $rec;
		$message = json_encode($arr);
		//$message = str_replace("[null]", '[]', $message);
		//$message = str_replace('"t"', 'true', $message);
		//$message = str_replace('"f"', 'false', $message);
	} else {
		$message = '[]';
	}
	echo $message;
}

function update_role_list(){
	$webix_operation = get_string('webix_operation',10);
	
	$item_id = get_string('id',12);
	//$role_name = get_string('role_name',250);
	$role_name = get_string('value',250);
	
	$datatable = 'roles';
	$fields = '(role_name)';
	$values =  "('$role_name')";
	switch($webix_operation){
		case 'insert':
			$sql = 'INSERT INTO '.$datatable.' '.$fields.' VALUES '.$values.' RETURNING '.$datatable.'_id AS id;';
			break;
		case 'update':
			$sql = 'UPDATE '.$datatable.' SET '.$fields.' = '.$values.' WHERE '.$datatable.'_id = '.$item_id.' RETURNING '.$datatable.'_id AS id;';
			break;
		case 'delete':
			$sql = 'DELETE FROM '.$datatable.' WHERE '.$datatable.'_id = '.$item_id.' RETURNING '.$datatable.'_id AS id;';
			break;
		default:
			$message = '{"status":"error", "message" : "Не указана операция"}';
			break;
	}
	$result = pg_query($sql);
	$nbrows = pg_num_rows($result);
	
	if ($nbrows>0) {
		while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)) $arr[] = $rec;
		$message = json_encode($arr);
		//$message = str_replace("[null]", '[]', $message);
		//$message = str_replace('"t"', 'true', $message);
		//$message = str_replace('"f"', 'false', $message);
	} else {
		$message = '[]';
	}
	echo $message;
}



?>
