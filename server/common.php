<?php
session_start();//Обьявляем сессию

require_once('connect.php');//Подключение к базе данных
require_once('function.php');//Подключаем необходимые функции

header('Content-type: application/json');

$personell = valid_personell();
$cmd = get_string('cmd',50);

switch($cmd){
	case "search_client":
		search_client();
		break;
	case "get_medical_structure":
		get_medical_structure($personell);
		break;
	case "get_tooth_states":
		get_tooth_states();
		break;
	case "get_tooth_diagnoses":
		get_tooth_diagnoses();
		break;
	case "get_measure":
		get_measure();
		break;
	
	
	default:
		echo '{"status":"error", "message" : "Не указана команда"}';
		//echo "{'status':'error', 'message' : 'Не указана команда'}";
		break;
}

function search_client(){
	if (isset($_REQUEST['filter'])){
		$value = mb_strtolower($_REQUEST['filter']['value'], 'utf8');
		$value = htmlspecialchars(strip_tags($value), ENT_QUOTES);
	}  else $value = "";
	
	if (($value != "" || $value != " " || $value != "  " || $value != "   ") && mb_strlen($value, 'utf8')>=2 ){
		$sql = "SELECT client.client_id AS id, COALESCE(c_surname,'')||' '||COALESCE(c_name,'')||' '||COALESCE(c_patronymic,'') AS value,
				client.c_surname, client.c_name, client.c_patronymic,
				client.birthday AS birthday,  array_to_string(array_agg(phones.phone),',') AS phones, client.male,
				CASE WHEN client.photo IS NULL THEN CASE WHEN client.male THEN 'male.png' ELSE 'female.png' END ELSE client.photo END AS photo
					FROM client LEFT JOIN (
						SELECT client_id, phone FROM client_phone 
					) phones ON (client.client_id = phones.client_id)
			WHERE lower(c_name) LIKE lower('%$value%') OR lower(c_patronymic) LIKE lower('%$value%')
						OR lower(c_surname) LIKE lower('%$value%')
						OR phone LIKE '%$value%'
			GROUP BY client.client_id ORDER BY value;";
		$result = pg_query($sql);
		$nbrows = pg_num_rows($result);

		if ($nbrows>0) {
			//$i=1;
			while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)) $arr[] = $rec;
			echo json_encode($arr);
		} else {
			echo '{"id":0,"value":""}';
		}
	} else {
		echo '{"id":0,"value":""}';
	}
}

function get_medical_structure($personell){
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
}

function get_tooth_states(){
	$sql = "SELECT tooth_states_id AS id, tooth_states AS value, symbol, color, stroke FROM tooth_states ORDER BY tooth_states_order;";
	$result = pg_query($sql);
	$nbrows = pg_num_rows($result);
	if ($nbrows>0) {
		while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)) $arr[] = $rec;
		echo json_encode($arr);
	} else {
		echo '{"status"  : "error", "message" : "Нет состояний зубов"}';
	}
}

function get_tooth_diagnoses(){
	$sql = "SELECT tooth_diagnoses_id AS id, tooth_diagnoses AS value, tooth_states_id, symbol, color, is_all_tooth, is_need_treatment FROM tooth_diagnoses;";
	$result = pg_query($sql);
	$nbrows = pg_num_rows($result);
	if ($nbrows>0) {
		while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)){
			if ($rec['is_all_tooth']== 't') $rec['is_all_tooth'] =  1; else $rec['is_all_tooth'] = 0;
			$arr[] = $rec;
		}
		echo json_encode($arr);
	} else {
		//echo '{"status"  : "error", "message" : "Нет диагнозов"}';
		echo '[]';
	}
}

function get_measure(){
	$sql = "SELECT measure_id AS id, measure AS value, measure_short FROM measure ORDER BY measure;";
	$result = pg_query($sql);
	$nbrows = pg_num_rows($result);
	if ($nbrows>0) {
		while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)){
			$arr[] = $rec;
		}
		echo json_encode($arr);
	} else {
		echo '[]';
	}
}

?>
