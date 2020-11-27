<?php
require_once('function.php');//Подключаем необходимые функции
//Обьявляем сессию
start_session();
require_once('connect.php');//Подключение к базе данных


header('Content-type: application/json');

// common helper
function toJson($data){
	echo json_encode($data, true);
}


//get current session status
if (isset($_GET["status"])){
	if (isset($_SESSION["user"])) toJson($_SESSION["user"]); else toJson(null);
//logout
} else if (isset($_GET["logout"])){
	$_SESSION["user"] = null;
//login
} else {
	$user = get_string("user",30);
	$pass = get_string("pass",32);

	$sql = "
		SELECT personell_id, COALESCE(p_name, '')||' '||COALESCE(p_surname, '') AS personell_name,
			photo, role_id
		FROM personell 
		WHERE lower(p_login)=lower('$user') AND p_passwd=md5('$pass') AND active;";
	//echo $sql;
	$result = pg_query($sql);
	$nbrows = pg_num_rows($result);
	if ($nbrows>0) {
		$rec = pg_fetch_array($result, NULL, PGSQL_ASSOC);

		$user = [
			"name" => $rec['personell_name'],
			"personell_id" => $rec['personell_id'],
			"photo" => $rec['photo'],
			"role_id" => $rec['role_id'],
			"role" => "",
			//"clinic_id" => 0,
			"unit_id" => 0,
			"chief_unit_id" => 0,
			"subordinate_units" => 'null',
			"modules" => []
		];
		//Получим список модулей, к которым есть доступ
		$sql = "
			SELECT modules.module_id, module_name AS id, module_file_name, module_title AS value, 'mdi mdi-'||module_icon AS icon
			FROM module_role
				INNER JOIN modules ON (module_role.module_id = modules.module_id)
			WHERE role_id = ".$user['role_id'].';';
		$result = pg_query($sql);
		$nbrows = pg_num_rows($result);
		if ($nbrows>0) {
			while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)){
				$user['modules'][] = $rec;
			}
		}

		//Выясним должность юзера
		$sql = "WITH RECURSIVE r AS (
				SELECT unit_id, p_unit_id, personell_id, terminal_bool, CAST (array[unit_id] AS INTEGER []) AS path
					FROM unit WHERE unit_id = 1
					UNION
					SELECT a.unit_id, a.p_unit_id, a.personell_id, a.terminal_bool, CAST ( r.path || a.unit_id AS INTEGER [])
					FROM unit AS a JOIN r ON a.p_unit_id = r.unit_id
			)
			SELECT r.path[2] AS org_id, r.unit_id as id, unit.unit||' '||ps.unit||' '||ps.post AS value,
				CASE WHEN r.terminal_bool THEN r.p_unit_id ELSE r.unit_id END AS chief_unit_id
			FROM r 
			LEFT JOIN personell ON (r.personell_id = personell.personell_id) 
			LEFT JOIN unit ON (r.path[2] = unit.unit_id)
			LEFT JOIN unit ps ON (r.unit_id = ps.unit_id)
			WHERE r.personell_id = ".$user['personell_id'].";";
		//echo $sql;		
		$result = pg_query($sql);
		$nbrows = pg_num_rows($result);
		if ($nbrows>0) {
			while($rec = pg_fetch_array($result, NULL, PGSQL_ASSOC)){
				$user['units'][] = $rec;
			}
		} else {
			$user['units'] = null;
		}
		$_SESSION["user"] = $user;
		toJson($user);	
	} else {
		toJson(null);
	}
}