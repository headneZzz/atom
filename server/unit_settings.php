<?php
session_start();//Обьявляем сессию

require_once('connect.php');//Подключение к базе данных
require_once('function.php');//Подключаем необходимые функции

header('Content-type: application/json');

//error_reporting(E_ALL & ~E_WARNING);


$user_id = 1;
//$user_id = valid_user();
//get_access_user("clientLayout");

$cmd = get_string('cmd',50);

switch($cmd){
	case "get_unit_tree":
		get_unit_tree();
		break;
	case "get_unit_dynamic_tree":
		get_unit_dynamic_tree();
		break;
	case 'update_unit_tree':
		update_unit_tree($con);
		break;
	case "get_role":
		get_role();
		break;
	case "get_profile_stomat_care":
		get_profile_stomat_care();
		break;
	case "get_personell":
		get_personell();
		break;
	case "update_personell":
		update_personell($con);
		break;
	case "get_post_type":
		get_post_type();
		break;
	case "get_requisites":
		get_requisites();
		break;
	case "update_requisites":
		update_requisites($con);
		break;
	case "get_cabinets":
		get_cabinets();
		break;
	case "update_cabinets":
		update_cabinets($con);
		break;
	

	default:
		echo '{"status":"error", "message" : "Не указана команда"}';
		//echo "{'status':'error', 'message' : 'Не указана команда'}";
		break;
}


function get_unit_tree(){
	$sql = "WITH RECURSIVE c AS (
    SELECT unit_id AS id, p_unit_id, unit AS value, terminal_bool, is_medical, is_have_price, personell_id, post, role_id, active, post_type_id, 1 as lvl
    FROM unit
    WHERE unit_id = 1 AND p_unit_id IS NULL
	  UNION ALL
	    SELECT unit.unit_id AS id, unit.p_unit_id, unit.unit  AS value, unit.terminal_bool, unit.is_medical, unit.is_have_price, unit.personell_id, unit.post, unit.role_id, unit.active, unit.post_type_id, c.lvl + 1 as lvl
	    FROM unit 
	    JOIN c ON unit.p_unit_id = c.id
	),
	maxlvl AS (
	  SELECT max(lvl) maxlvl FROM c
	),
	j AS (
	    SELECT c.*, json '[]' AS data
	    FROM   c, maxlvl
	    WHERE  lvl = maxlvl
	  UNION ALL
	    SELECT   (c).*, array_to_json(array_agg(j) || array(
	      SELECT r FROM   (SELECT l.*, json '[]' AS data
			FROM   c l, maxlvl
			WHERE  l.p_unit_id = (c).id
				AND    l.lvl < maxlvl
				AND NOT EXISTS (SELECT 1 FROM c lp WHERE  lp.p_unit_id = l.id)) r)) AS data
	    FROM (SELECT c, j FROM c JOIN j ON j.p_unit_id = c.id) v
	    GROUP BY v.c
	)
	SELECT row_to_json(j) root
	FROM   j
	WHERE  lvl = 1;";

	$result = pg_query($sql);
	$nbrows = pg_num_rows($result);
	if ($nbrows>0) {
		/*while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)){
			$rec['data'] = json_decode($rec['data']);
			if ($rec['active'] == 't') $rec['active'] = true; else $rec['active'] = false;
			if ($rec['terminal_bool'] == 't') $rec['terminal_bool'] = true; else $rec['terminal_bool'] = false;
			$arr[] = $rec;
		}
		$message = json_encode($arr);
		$message = str_replace("[null]", '[]', $message);
		*/
		$rec = pg_fetch_array($result, NULL, PGSQL_ASSOC);
		echo $rec['root'];
	} else {
		echo '[]';
	}
}

function get_unit_dynamic_tree(){
	$parent_id = get_num('parent');
	if ($parent_id > 0) $where = "unit.p_unit_id = $parent_id";
		else $where = "unit.p_unit_id IS NULL";
	$sql = "
		SELECT unit.unit_id AS id, unit.p_unit_id, unit.unit AS value, unit.terminal_bool, unit.personell_id, unit.post, 
			unit.active, unit.work_begin, unit.work_end,
			CASE WHEN COUNT (chld.unit_id) > 0 THEN true ELSE false END AS webix_kids 
		FROM unit 
			LEFT JOIN unit chld ON (unit.unit_id = chld.p_unit_id)
	    WHERE  $where
	    GROUP BY unit.unit_id;";

	$result = pg_query($sql);
	$nbrows = pg_num_rows($result);
	$arr['parent'] = $parent_id;
	if ($nbrows>0) {
		while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)){
			/*if ($rec['active'] == 't') $rec['active'] = true; else $rec['active'] = false;
			if ($rec['terminal_bool'] == 't') $rec['terminal_bool'] = true; else $rec['terminal_bool'] = false;
			if ($rec['is_medical'] == 't') $rec['is_medical'] = true; else $rec['is_medical'] = false;
			if ($rec['is_have_price'] == 't') $rec['is_have_price'] = true; else $rec['is_have_price'] = false;
			if ($rec['is_have_schedule'] == 't') $rec['is_have_schedule'] = true; else $rec['is_have_schedule'] = false;
			if ($rec['webix_kids'] == 't') $rec['webix_kids'] = true; else $rec['webix_kids'] = false;*/
			$arr['data'][] = $rec;	
		}
		$message = json_encode($arr);
		$message = str_replace("[null]", '[]', $message);
		$message = str_replace('"t"', 'true', $message);
		$message = str_replace('"f"', 'false', $message);
	} else {
		$message = '[]';
	}
	echo $message;
}

function update_unit_tree($con){
	$id = get_string('id',12);
	//$parent = get_string('parent',12);
	
	/*$sibling = get_bool('sibling');
	$sibling_id = get_string('sibling_id', 12);
	if (strlen($sibling_id) > 2) list($slevel, $sibling_id) = explode('.', $sibling_id);
	*/
	$active = get_bool_as_string('active');
	//$order = get_num_str_null('order');
	
	$webix_operation = get_string('webix_operation',10);
	$message = '[{status:"error", message:"Не сформирована команда"}]';
	$sql = '';

	$p_unit_id = get_num_str_null('parent');
	if ($p_unit_id == 'null') $p_unit_id = 1;
	$unit = get_string('value',250);
	$post = get_string('post',250);
	$terminal_bool = get_bool_as_string('terminal_bool');
	$personell_id = get_num_str_null('personell_id');
	//$role_id = get_num('role_id');
	$work_begin = get_string('work_begin',5);
	$work_end = get_string('work_end',5);
	
	$fields = '(active, unit, post, personell_id, p_unit_id, terminal_bool, work_begin, work_end)';
	$values = "($active, '$unit', '$post', $personell_id, $p_unit_id, $terminal_bool, '$work_begin', '$work_end')";
			
	switch($webix_operation){
		case 'insert':
			$sql = 'INSERT INTO unit '.$fields.' VALUES '.$values.' RETURNING unit_id AS id;';
			break;
		case 'update':
			$sql = 'UPDATE unit SET '.$fields.' = '.$values.' WHERE unit_id = '.$id.' RETURNING unit_id AS id;';
			break;
		case 'delete':
			$sql = 'DELETE FROM unit WHERE unit_id = '.$id.' RETURNING unit_id AS id;';
			break;
		default:
			$message = '{"status":"error", "message" : "Не указана операция"}';
			break;
	}

	//echo $sql;
	if ($sql != '') {
		if (pg_send_query($con, $sql)){
			$result = pg_get_result($con);
			if ($result){
				$state = pg_result_error_field($result, PGSQL_DIAG_SQLSTATE);
				if ($state == 0){
					$rec = pg_fetch_array($result, NULL, PGSQL_ASSOC);
					//$rec['id'] = $level.'.'.$rec['id'];
					$rec['status'] = 'success';
					$rec['message'] = 'Изменения внесены';
					$rec['sql'] = $sql;
				}else{
					//Какая-то жопа
					$rec['status'] = 'error';
					$rec['message'] = pg_last_error();
					if ($state == 23503) $rec['err_message'] = 'Нельзя удалить, элемент используется в другом месте';
					if ($state == 23505) $rec['err_message'] = 'Дублирование элемента';
					$rec['sql'] = $sql;
					$rec["state"] = $state;
				}
			}
		}
		echo json_encode($rec);
	} else echo $message;
}

function get_role(){
	$sql = "SELECT role_id AS id, role_name AS value FROM roles;";
	$result = pg_query($sql);
	$nbrows = pg_num_rows($result);
	if ($nbrows>0) {
		while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)) $arr[] = $rec;
		echo json_encode($arr);
	} else {
		echo '[]';
	}
}

function get_profile_stomat_care(){
	$sql = "
		SELECT profile_stomat_care_id AS id, profile_stomat_care AS value 
		FROM profile_stomat_care 
		WHERE active;";
	$result = pg_query($sql);
	$nbrows = pg_num_rows($result);
	if ($nbrows>0) {
		while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)) $arr[] = $rec;
		echo json_encode($arr);
	} else {
		echo '[]';
	}
}

function get_personell(){
	$sql = "
		SELECT personell_id AS id, p_name, p_patronymic, p_surname, COALESCE(p_surname,'Не представился')||' '||COALESCE(substring(p_name from 1 for 1),'')||'.'||COALESCE(substring(p_patronymic from 1 for 1),'') AS value, 
			personell_id_barcode, p_login, photo, birthday, email, male,
			CASE WHEN photo IS NULL THEN CASE WHEN male THEN 'male.png' ELSE 'female.png' END ELSE photo END AS photo,
			active 
		FROM public.personell ";

	$search= get_string('search',20);
	if (strlen($search) > 2){
		$sql .= " WHERE lower(p_name) LIKE lower('%$search%') OR lower(p_patronymic) LIKE lower('%$search%')
				OR lower(p_surname) LIKE lower('%$search%') ORDER BY p_surname;";
	}else{
		$sql .= " ORDER BY p_surname;";
	}
	$result = pg_query($sql);
	$nbrows = pg_num_rows($result);
	if ($nbrows>0) {
		while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)){
			if ($rec['active'] == 't') $rec['active'] = true; else $rec['active'] = false;
			$arr[] = $rec;
		}
		echo json_encode($arr);
	} else {
		echo '[]';
	}
}

function update_personell($con){
	//print_r($_REQUEST);
	$id = get_num('id');
	//$personell = get_string('value', 30);
	$p_name = get_string('p_name',50);
	$p_patronymic = get_string('p_patronymic',50);
	$p_surname = get_string('p_surname',50);
	$p_login = get_string('p_login',50);
	$p_passwd = get_string('p_passwd',50);
	
	//$role_id = get_num('role_id');
	$active = get_bool_as_string('active');
	
	$photo = get_string_null('photo',250);
	$birthday = get_string_null('birthday',10);
	$email = get_string('email',100);
	$male = get_bool_as_string('male');

	$webix_operation = get_string('webix_operation',10);
	$message = '';

	$sql = '';
	if ($p_passwd == ''){
		$fields = '(p_name, p_patronymic, p_surname, p_login, photo, birthday, email, male, active)';
		$values = "('$p_name', '$p_patronymic', '$p_surname', '$p_login', $photo, $birthday::date, '$email', $male, $active)";	
	}else{
		$fields = '(p_name, p_patronymic, p_surname, p_login, photo, birthday, email, male, active, p_passwd)';
		$values = "('$p_name', '$p_patronymic', '$p_surname', '$p_login', $photo, $birthday::date, '$email', $male, $active, md5('$p_passwd'))";	
	}
	
	
	switch($webix_operation){
		case 'insert':
			$sql = 'INSERT INTO personell '.$fields.' VALUES '.$values.' RETURNING personell_id AS id;';
			break;
		case 'update':
			$sql = 'UPDATE personell SET '.$fields.' = '.$values.' WHERE personell_id = '.$id.' RETURNING personell_id AS id;';
			break;
		case 'delete':
			$sql = 'DELETE FROM personell WHERE personell_id = '.$id.' RETURNING personell_id AS id;';
			break;
		default:
			$message = '{"status":"error", "message" : "Не указана операция"}';
			break;
	}
	//echo $sql;
	if ($sql != '') {
		if (pg_send_query($con, $sql)){
			$result = pg_get_result($con);
			if ($result){
				$state = pg_result_error_field($result, PGSQL_DIAG_SQLSTATE);
				if ($state == 0){
					$rec = pg_fetch_array($result, NULL, PGSQL_ASSOC);
					$rec['status'] = 'success';
					$rec['message'] = 'Изменения внесены';
				}else{
					//Какая-то жопа
					$rec['status'] = 'error';
					$rec['message'] = pg_last_error();
					if ($state == 23503) $rec['err_message'] = 'Нельзя удалить, элемент используется в другом месте';
					if ($state == 23505) $rec['err_message'] = 'Дублирование элемента';
					$rec['sql'] = $sql;
					$rec["state"] = $state;
				}
			}
		}
		echo json_encode($rec);
	} else echo $message;
}

function get_post_type(){
	$sql = "SELECT post_type_id AS id, post_type AS value FROM post_type ORDER BY value;";
	$result = pg_query($sql);
	$nbrows = pg_num_rows($result);
	if ($nbrows>0) {
		while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)) $arr[] = $rec;
		echo json_encode($arr);
	} else {
		echo '[]';
	}
}

function get_requisites(){
	$sql = "SELECT requisites_id AS id, * FROM requisites;";
	$result = pg_query($sql);
	$nbrows = pg_num_rows($result);
	if ($nbrows>0) {
		while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)) $arr[] = $rec;
		echo json_encode($arr);
	} else {
		echo '[]';
	}
}

function update_requisites($con){
	$webix_operation = get_string('webix_operation',10);
	$message = '[{status:"error", message:"Не сформирована команда"}]';
	$sql = '';

	$id = get_string('id',12);
	$unit_id = get_num('unit_id');
	
	$org_code = get_string('org_code',20);
	$org_name = get_string('org_name',500);
	$org_name_short = get_string('org_name_short',200);
	$adress_reg = get_string('adress_reg',200);
	$adress_fact = get_string('adress_fact',200);
	$okpo = get_string('okpo',25);
	$inn = get_string('inn',25);
	$kpp = get_string('kpp',25);
	$ogrn = get_string('ogrn',25);
	$attestat_number = get_string('attestat_number',25);
	$director_name = get_string('director_name',100);
	$director_post = get_string('director_post',100);
	$director_phone = get_string('director_phone',12);
	$director_email = get_string('director_email',50);
	
	$fields = '(unit_id, org_code, org_name, org_name_short, adress_reg, adress_fact, okpo, inn, kpp, ogrn, attestat_number, director_name, director_post, director_phone, director_email)';
	$values = "($unit_id, '$org_code', '$org_name', '$org_name_short', '$adress_reg', '$adress_fact', '$okpo', '$inn', '$kpp', '$ogrn', '$attestat_number', '$director_name', '$director_post', '$director_phone', '$director_email')";
			
	switch($webix_operation){
		case 'insert':
			$sql = 'INSERT INTO requisites '.$fields.' VALUES '.$values.' RETURNING requisites_id AS id;';
			break;
		case 'update':
			$sql = 'UPDATE requisites SET '.$fields.' = '.$values.' WHERE requisites_id = '.$id.' RETURNING requisites_id AS id;';
			break;
		case 'delete':
			$sql = 'DELETE FROM requisites WHERE requisites_id = '.$id.' RETURNING requisites_id AS id;';
			break;
		default:
			$message = '{"status":"error", "message" : "Не указана операция"}';
			break;
	}

	//echo $sql;
	if ($sql != '') {
		if (pg_send_query($con, $sql)){
			$result = pg_get_result($con);
			if ($result){
				$state = pg_result_error_field($result, PGSQL_DIAG_SQLSTATE);
				if ($state == 0){
					$rec = pg_fetch_array($result, NULL, PGSQL_ASSOC);
					//$rec['id'] = $level.'.'.$rec['id'];
					$rec['status'] = 'success';
					$rec['message'] = 'Изменения внесены';
					$rec['sql'] = $sql;
				}else{
					//Какая-то жопа
					$rec['status'] = 'error';
					$rec['message'] = pg_last_error();
					if ($state == 23503) $rec['err_message'] = 'Нельзя удалить, элемент используется в другом месте';
					if ($state == 23505) $rec['err_message'] = 'Дублирование элемента';
					$rec['sql'] = $sql;
					$rec["state"] = $state;
				}
			}
		}
		echo json_encode($rec);
	} else echo $message;
	

}

function get_cabinets(){
	$sql = "SELECT cabinet_id AS id, unit_id, cabinet_num, cabinet, number_of_workplaces FROM cabinet;";
	$result = pg_query($sql);
	$nbrows = pg_num_rows($result);
	if ($nbrows>0) {
		while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)) $arr[] = $rec;
		echo json_encode($arr);
	} else {
		echo '[]';
	}
}

function update_cabinets($con){
	$webix_operation = get_string('webix_operation',10);
	$message = '[{status:"error", message:"Не сформирована команда"}]';
	$sql = '';

	$id = get_num('id');
	$unit_id = get_num('unit_id');
	
	
	$cabinet_num = get_string('cabinet_num',20);
	$cabinet = get_string('cabinet',120);
	$number_of_workplaces = get_num_str_null('number_of_workplaces');
	
	$fields = '(unit_id, cabinet_num, cabinet, number_of_workplaces)';
	$values = "($unit_id, '$cabinet_num', '$cabinet', $number_of_workplaces)";
			
	switch($webix_operation){
		case 'insert':
			$sql = 'INSERT INTO cabinet '.$fields.' VALUES '.$values.' RETURNING cabinet_id AS id;';
			break;
		case 'update':
			$sql = 'UPDATE cabinet SET '.$fields.' = '.$values.' WHERE cabinet_id = '.$id.' RETURNING cabinet_id AS id;';
			break;
		case 'delete':
			$sql = 'DELETE FROM cabinet WHERE cabinet_id = '.$id.' RETURNING cabinet_id AS id;';
			break;
		default:
			$message = '{"status":"error", "message" : "Не указана операция"}';
			break;
	}

	//echo $sql;
	if ($sql != '') {
		if (pg_send_query($con, $sql)){
			$result = pg_get_result($con);
			if ($result){
				$state = pg_result_error_field($result, PGSQL_DIAG_SQLSTATE);
				if ($state == 0){
					$rec = pg_fetch_array($result, NULL, PGSQL_ASSOC);
					//$rec['id'] = $level.'.'.$rec['id'];
					$rec['status'] = 'success';
					$rec['message'] = 'Изменения внесены';
					$rec['sql'] = $sql;
				}else{
					//Какая-то жопа
					$rec['status'] = 'error';
					$rec['message'] = pg_last_error();
					if ($state == 23503) $rec['err_message'] = 'Нельзя удалить, элемент используется в другом месте';
					if ($state == 23505) $rec['err_message'] = 'Дублирование элемента';
					$rec['sql'] = $sql;
					$rec["state"] = $state;
				}
			}
		}
		echo json_encode($rec);
	} else echo $message;
	

}



?>
