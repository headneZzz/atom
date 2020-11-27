SELECT * FROM modules;
INSERT INTO modules (module_name, module_file_name, module_title, module_icon)
VALUES ('unitSettings', 'unitSettings', 'Предприятие', 'office-building');

SELECT * FROM roles;
SELECT * FROM module_role;

INSERT INTO module_role (module_id, role_id) VALUES (4, 3), (4, 2);