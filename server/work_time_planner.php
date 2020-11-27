<?php
session_start();//Обьявляем сессию

require_once('connect.php');//Подключение к базе данных
require_once('function.php');//Подключаем необходимые функции

header('Content-type: application/json');

$personell = valid_personell();

//$personell_id = valid_user();
//get_access_user("clientLayout");

$cmd = get_string('cmd',30);

switch($cmd){
	case 'get_subject':
		get_subject($personell);
		break;
	case 'get_personell':
		get_personell($personell);
		break;
	case 'get_plan_day_list':
		get_plan_day_list($personell);
		break;
	case 'update_plan_tree':
		update_plan_tree($con);
		break;
	


	

	default:
		echo '{"status":"error", "message" : "Не указана команда"}';
		//echo "{'status':'error', 'message' : 'Не указана команда'}";
		break;
}

/*function get_subject($personell){
	if (isset($personell['chief_structure_id']) && isset($personell['subordinate_units'])){
		$sql = "WITH RECURSIVE r AS ( SELECT structure_id AS id, p_structure_id, structure AS value, is_have_price, personell_id
			FROM structure WHERE structure_id = ".$personell['chief_structure_id']."
			UNION
			SELECT a.structure_id AS id, a.p_structure_id, a.structure AS value, a.is_have_price, a.personell_id
			FROM structure AS a JOIN r ON a.p_structure_id = r.id
		)
		SELECT * FROM r WHERE is_have_price AND id IN (".$personell['subordinate_units'].") ORDER BY value;";
		//echo $sql;
		$result = pg_query($sql);
		$nbrows = pg_num_rows($result);
		if ($nbrows>0) {
			while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)) $arr[] = $rec;
			echo json_encode($arr);
		} else {
			echo '[]';
		}
	}else echo '[]';
}*/

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

function get_plan_day_list($personell){
	$subject_id = get_num('subject_id');
	$start_date = get_string('start_date',10);
	$sql = "
		SELECT  personell.personell_id AS id, p_surname||' '||p_name AS name, json_agg(wp.*) AS data
		FROM personell INNER JOIN (
			SELECT '2.'||work_plan_id AS id, work_plan_id, personell_id, work_date
			FROM work_plan
			WHERE subject_id = $subject_id AND work_date >= '$start_date'::date and work_date < '$start_date'::date + interval '1 month'
		) AS wp ON (personell.personell_id = wp.personell_id)
		GROUP BY personell.personell_id
		ORDER BY name;";
	//echo $sql;
	$result = pg_query($sql);
	$nbrows = pg_num_rows($result);
	if ($nbrows > 0) {
		while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)){
			$rec['data'] = json_decode($rec['data']);
			$arr[] = $rec;
		}
		$message = json_encode($arr);
		$message = str_replace('[null]', '[]', $message);
		//$message = str_replace('"t"', 'true', $message);
		//$message = str_replace('"f"', 'false', $message);
		echo $message;
	}else echo "[]";
}

/*function get_work_time_list($personell){
	$structure_id = get_num('structure_id');
	//Проверим, что данное подразделение можно смотреть
	$list_structures = explode(',',$personell['subordinate_units']);
	if (array_search($structure_id,$list_structures) === false) exit();

	$sql = "SELECT work_time_list_id AS id, work_time_list AS value FROM work_time_list WHERE structure_id =$structure_id ORDER BY work_time_list;";
	//echo $sql;
	$result = pg_query($sql);
	$nbrows = pg_num_rows($result);
	if ($nbrows > 0) {
		while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)) $arr[] = $rec;
		//$arr = pg_fetch_array($result, NULL, PGSQL_ASSOC);
		echo json_encode($arr);
	}else echo "[]";
}*/


function update_plan_tree($con){
	$id = get_string('id',12);
	if (strlen($id) > 2) list($level, $item_id) = explode('.', $id);
	$webix_operation = get_string('webix_operation',10);
	//$datatable = 'work_plan';
	$work_plan_id = get_num('work_plan_id');
	$personell_id = get_num('personell_id');
	$subject_id = get_num('subject_id');
	$work_date_str = get_string('work_date_str',10);
			
	$fields = '(personell_id, work_date, subject_id)';
	$values = "($personell_id, '$work_date_str', $subject_id)";
	
	switch($webix_operation){
		case 'insert':
			$sql = "INSERT INTO work_plan $fields VALUES $values RETURNING '2.'||work_plan_id AS id, work_plan_id;";
			break;
		case 'update':
			$sql = "UPDATE $datatable SET $fields = $values WHERE work_plan_id = $work_plan RETURNING '2.'||work_plan_id AS id;";
			break;
		case 'delete':
			$sql = "DELETE FROM work_plan WHERE work_plan_id = $item_id;";
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

/*function update_plan_tree($con){
	$id = get_string('id',12);
	$parent = get_string('parent',12);
	
	$webix_operation = get_string('webix_operation',10);
	$message = '[{status:"error", message:"Не сформирована команда"}]';

	if (strlen($parent) > 2) list($plevel, $parent_id) = explode('.', $parent);
	else {
		$parent_id = 0;
		$level = 0;
		$plevel = 0;
	}
	if (strlen($id) > 2) list($level, $item_id) = explode('.', $id);
	else {
		$item_id = 0;
		$level = $plevel+1;
	}

	$sql = '';

	switch($level){
		case '2':
			$datatable = 'work_plan';
			$personell_id = get_num('personell_id');
			$subject_id = get_num('subject_id');
			//$item_id = get_num('work_plan_id');
			$work_date_str = get_string('work_date_str',10);
			
			$fields = '(personell_id, work_date, subject_id)';
			$values = "($personell_id, '$work_date_str', $subject_id)";
			break;
		
		default:
			$message = '[{status:"error", message:"Нет такого уровня"}]';
	}

	switch($webix_operation){
		case 'insert':
			$sql = "INSERT INTO $datatable $fields VALUES $values RETURNING ".$datatable."_id AS id;";
			break;
		case 'update':
			$sql = "UPDATE $datatable SET $fields = $values WHERE ".$datatable."_id = $item_id RETURNING ".$datatable."_id AS id;";
			break;
		case 'delete':
			$sql = "DELETE FROM doc_formula_medicament WHERE formula_medicament_id = $item_id;";
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
					$rec['id'] = $level.'.'.$rec['id'];
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
	}
}*/

?>
