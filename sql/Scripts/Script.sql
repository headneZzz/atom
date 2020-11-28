SELECT * FROM modules;
INSERT INTO modules (module_name, module_file_name, module_title, module_icon)
VALUES ('tasker', 'tasker', 'Задачи', ' comment-check-outline');

INSERT INTO modules (module_name, module_file_name, module_title, module_icon)
VALUES ('dashboard', 'dashboard', 'Даш', 'monitor-dashboard');


SELECT * FROM roles;
SELECT * FROM module_role;



INSERT INTO module_role (module_id, role_id) VALUES (6, 3), (6, 2);

SELECT * FROM unit;

SELECT * FROM unit;
ALTER TABLE unit ADD COLUMN work_begin time;
ALTER TABLE unit ADD COLUMN work_end time;

DROP TABLE task_type;
CREATE TABLE task_type(
	task_type_id SERIAL PRIMARY KEY,
	task_type varchar(50)  UNIQUE
);

INSERT INTO task_type (task_type) VALUES ('Постоянные'),('Внеплановые'),('Информирование');

DROP TABLE personell_group;
CREATE TABLE personell_group(
	personell_group_id SERIAL PRIMARY KEY,
	personell_group varchar(50) UNIQUE
);

INSERT INTO personell_group (personell_group) VALUES ('Начальники участков'),('Электрики'),('Руководство');

DROP TABLE priority;
CREATE TABLE priority(
	priority_id SERIAL PRIMARY KEY,
	priority varchar(50) UNIQUE
);

INSERT INTO priority (priority) VALUES ('Срочно'),('Обычно'),('Низкий');

DROP TABLE job_type;
CREATE TABLE job_type(
	job_type_id SERIAL PRIMARY KEY,
	job_type varchar(50) UNIQUE
);

INSERT INTO job_type (job_type) VALUES ('Хозяйственная'),('Административная'),('Другая');


CREATE TABLE task(
	task_id SERIAL PRIMARY KEY,
	author_id int REFERENCES personell(personell_id),
	personell_id int REFERENCES personell(personell_id),
	personell_group_id int REFERENCES personell_group(personell_group_id),
	task_type_id int REFERENCES task_type(task_type_id),
	priority_id int REFERENCES priority(priority_id),
	task_title varchar(200),
	task varchar,
	init_date timestamp,
	deadline_date timestamp
);

DROP TABLE task_state;
CREATE TABLE task_state(
	task_state_id SERIAL PRIMARY KEY,
	task_state varchar(50) UNIQUE
);

INSERT INTO task_state (task_state) VALUES ('Доставлено'),('Прочитано'),('В работе'),('Выполнено');


CREATE TABLE task_answer(
	task_answer_id SERIAL PRIMARY KEY,
	task_id int REFERENCES task(task_id),
	personell_id int REFERENCES personell(personell_id),
	answer varchar,
	answer_date timestamp
);

CREATE TABLE task_answer_state(
	task_answer_state_id SERIAL PRIMARY KEY,
	task_answer_id int REFERENCES task_answer(task_answer_id),
	task_state_id int REFERENCES task_state(task_state_id),
	state_date timestamp
);


CREATE TABLE task_files(
	task_files_id SERIAL PRIMARY KEY,
	task_id int REFERENCES task(task_id),
	file_name varchar
);

CREATE TABLE answer_files(
	answer_files_id SERIAL PRIMARY KEY,
	task_answer_id int REFERENCES task_answer(task_answer_id),
	file_name varchar
);

SELECT * FROM answer_files;

