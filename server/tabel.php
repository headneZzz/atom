<?php
session_start();//Обьявляем сессию

require_once('connect.php');//Подключение к базе данных
require_once('function.php');//Подключаем необходимые функции

header('Content-type: application/json');

$personell = valid_personell('tabel2');

//$personell_id = valid_user();
//get_access_user("clientLayout");

$cmd = get_string('cmd',30);
//echo '<pre>'; print_r($cmd); echo '</pre>';

switch($cmd){
	case 'get_subject':
		get_subject($personell);
		break;
	case 'get_personell':
		get_personell($personell);
		break;
	case 'get_dev_type':
		get_dev_type();
		break;
	case 'get_work_day_tree':
		get_work_day_tree($personell);
		break;
	case 'get_tabel_tree':
		get_tabel_tree($personell);
		break;
	case 'get_developments':
		get_developments($personell);
		break;
	case 'update_developments':
		update_developments($con);
		break;
	case 'update_work_day_tree':
		update_work_day_tree($con);
		break;
	case 'add_development':
		add_development($con);
		break;
	case 'add_dev_data':
		add_dev_data($con, $personell);
		break;
	case 'remove_development':
		remove_development($con, $personell);
		break;
	default:
		echo '{"status":"error", "message" : "Не указана команда"}';
		//echo "{'status':'error', 'message' : 'Не указана команда'}";
		break;
}


function get_subject($personell){
	$sql = "SELECT subject_id AS id, subject AS value FROM subject;";
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

function get_personell($personell){
	$sql = "SELECT personell_id AS id, p_surname||' '||p_name AS value FROM personell;";
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

function get_dev_type(){
	/*$sql = "
		SELECT dev_type_id AS id, dev_type AS value, dev_type, dev_type_short,
			cell_style, font_style, true AS is_selected
		FROM dev_type;";*/
	$sql = "
		SELECT dev_type_id AS id, dev_type AS value, dev_type, dev_type_short,
			cell_border, cell_bgcolor, is_personell, font_style, param_measure,
			param_default_value, is_show, is_int_param
		FROM dev_type;";
	//echo $sql;
	$result = pg_query($sql);
	$nbrows = pg_num_rows($result);
	if ($nbrows>0) {
		while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)) $arr[] = $rec;
		$message = json_encode($arr);
		$message = str_replace('"t"', 'true', $message);
		$message = str_replace('"f"', 'false', $message);
		echo $message;
	} else {
		echo '[]';
	}
}


function get_tabel_tree($personell){
	$subject_id = get_num('subject_id');
	$start_date = get_string('start_date',10);
	$sql = "
		SELECT personell.personell_id AS id, p_surname||' '||p_name AS name,
			string_agg('\"'||wp.dday||'\":'||wp.data, ',') AS days
		FROM personell 
			INNER JOIN (
				SELECT personell_id, date_part('day', dev_date) AS dday, json_agg(developments .*) AS data
				FROM developments
				WHERE subject_id = $subject_id AND dev_date >= '$start_date'::date and dev_date < '$start_date'::date + interval '1 month'
				GROUP BY dev_date, personell_id
			) wp ON (personell.personell_id = wp.personell_id)
		GROUP BY personell.personell_id;";
	//echo $sql;
	$result = pg_query($sql);
	$nbrows = pg_num_rows($result);
	$message = '';
	if ($nbrows > 0) {
		while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)){
			//$rec['data'] = json_decode($rec['data']);
			//$rec = 
			//$arr[] = $rec;
			$message .= '{"id":"'.$rec['id'].'","name":"'.$rec['name'].'",'.$rec['days'].'},';
		}
		$message = rtrim($message, ',');
		echo "[$message]";
		//$message = json_encode($arr);
		//$message = str_replace('[null]', '[]', $message);
		//$message = str_replace('"t"', 'true', $message);
		//$message = str_replace('"f"', 'false', $message);
		//echo $message;
	}else echo "[]";
}


function get_developments($personell){
	$subject_id = get_num('subject_id');
	$start_date = get_string('start_date',10);
	$sql = "
		SELECT developments_id AS id, personell_id, dev_date, date_part('day', dev_date) AS dday,
			subject_id, developments.dev_type_id, 
			CASE WHEN dev_type.is_int_param THEN param::int ELSE param END AS param
		FROM developments
			LEFT JOIN dev_type ON (developments.dev_type_id = dev_type.dev_type_id)
		WHERE subject_id = $subject_id AND dev_date >= '$start_date'::date and dev_date < '$start_date'::date + interval '1 month';";
	//echo $sql;
	$result = pg_query($sql);
	$nbrows = pg_num_rows($result);
	$message = '';
	if ($nbrows > 0) {
		while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)){
			//$rec['data'] = json_decode($rec['data']);
			$arr[] = $rec;
		}
		$message = json_encode($arr);
		//$message = str_replace('[null]', '[]', $message);
		$message = str_replace('"t"', 'true', $message);
		$message = str_replace('"f"', 'false', $message);
		echo $message;
	}else echo "[]";
}

function update_developments($con){
	$webix_operation = get_string('webix_operation',10);
	$developments_id = get_num('id');
	$personell_id = get_num('personell_id');
	$dev_date = get_string('dev_date',10);
	$subject_id = get_num('subject_id');
	$dev_type_id = get_num('dev_type_id');
	$param = get_float('param');
	
			
	$fields = '(personell_id, dev_date, subject_id, dev_type_id, param)';
	$values = "($personell_id, '$dev_date', $subject_id, $dev_type_id, $param)";
	
	switch($webix_operation){
		case 'insert':
			$sql = "INSERT INTO developments $fields VALUES $values RETURNING developments_id AS id;";
			break;
		case 'update':
			$sql = "UPDATE developments SET $fields = $values WHERE developments_id = $developments_id;";
			break;
		case 'delete':
			$sql = "DELETE FROM developments WHERE developments_id = $developments_id;";
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
	}
}


/*
function update_work_day_tree($con){
	//$id = get_string('id',12);
	//if (strlen($id) > 2) list($level, $item_id) = explode('.', $id);
	//$parent = get_string('parent',12);
	//if (strlen($parent) > 2) list($level, $parent_id) = explode('.', $parent);
	//else die('[]');
	$dumm = get_bool("dumm");
	if ($dumm) die('{"status":"success"}');

	$webix_operation = get_string('webix_operation',10);
	$developments_id = get_num('developments_id');
	$personell_id = get_num('personell_id');
	$dev_date = get_string('dev_date',10);
	$subject_id = get_num('subject_id');
	$dev_type_id = get_num('dev_type_id');
	$param = get_float('param');
	
			
	$fields = '(personell_id, dev_date, subject_id, dev_type_id)';
	$values = "($personell_id, '$dev_date', $subject_id, $dev_type_id)";
	
	switch($webix_operation){
		case 'insert':
			$sql = "INSERT INTO developments $fields VALUES $values RETURNING developments_id;";
			break;
		case 'update':
			$sql = "UPDATE $datatable SET $fields = $values WHERE developments_id = $developments_id;";
			break;
		case 'delete':
			$sql = "DELETE FROM developments WHERE developments_id = $developments_id;";
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
	}
}
*/
function add_development($con){
	$personell_id = get_num('personell_id');
	$dev_date = get_string('month',8).get_string('day',2);
	$subject_id = get_num('subject_id');
	$dev_type_id = get_num('dev_type_id');
	$param = get_float('param');
				
	$fields = '(personell_id, dev_date, subject_id, dev_type_id)';
	$values = "($personell_id, '$dev_date', $subject_id, $dev_type_id)";
	
	$sql = "INSERT INTO developments $fields VALUES $values RETURNING developments_id;";
	
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
	}
}

function add_dev_data($con, $personell){
	$values = get_string_quotes('values',2048);
				
	$fields = '(personell_id, dev_date, subject_id, dev_type_id, param)';
	//$values = "($personell_id, '$dev_date', $subject_id, $dev_type_id, $param)";
	
	$sql = "
		INSERT INTO developments $fields 
		VALUES $values RETURNING developments_id AS id, personell_id, dev_date,
			date_part('day', dev_date) AS dday, subject_id, dev_type_id, param;";
	$result = pg_query($sql);
	$nbrows = pg_num_rows($result);
	$message = '';
	if ($nbrows > 0) {
		while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)){
			//$rec['data'] = json_decode($rec['data']);
			$arr[] = $rec;
		}
		$message = json_encode($arr);
		//$message = str_replace('[null]', '[]', $message);
		$message = str_replace('"t"', 'true', $message);
		$message = str_replace('"f"', 'false', $message);
		echo $message;
	}else echo "[]";
}

function remove_development($con, $personell){
	$developments_id = get_num('developments_id');
				
	$sql = "DELETE FROM developments WHERE developments_id = $developments_id;";
	$rec = [];
	//echo $sql;
	if ($sql != '') {
		if (pg_send_query($con, $sql)){
			$result = pg_get_result($con);
			if ($result){
				$state = pg_result_error_field($result, PGSQL_DIAG_SQLSTATE);
				if ($state == 0){
					/*$rec = pg_fetch_array($result, NULL, PGSQL_ASSOC);
					$rec['status'] = 'success';
					$rec['message'] = 'Изменения внесены';
					$rec['sql'] = $sql;*/
					get_tabel_tree($personell);
				}else{
					//Какая-то жопа
					$rec['status'] = 'error';
					$rec['message'] = pg_last_error();
					if ($state == 23503) $rec['err_message'] = 'Нельзя удалить, элемент используется в другом месте';
					if ($state == 23505) $rec['err_message'] = 'Дублирование элемента';
					$rec['sql'] = $sql;
					$rec["state"] = $state;
					echo json_encode($rec);
				}
			}
		}
		//echo json_encode($rec);
	}
}



?>
