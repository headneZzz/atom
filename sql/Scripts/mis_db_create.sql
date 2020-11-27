--ALTER USER projecter WITH SUPERUSER; 
--CREATE EXTENSION btree_gist;
 /*

drop table client;

drop table personell;
drop table gender;
drop table c_doc_type;
drop table module_role;
drop table roles;
drop table modules;

*/

--CREATE ROLE projecter NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN PASSWORD '1qaz2wsx';


CREATE TABLE roles (
	role_id SERIAL PRIMARY KEY,
	role_name VARCHAR(64) UNIQUE,
	role_alias VARCHAR(64)
);

CREATE TABLE modules (
	 module_id SERIAL PRIMARY KEY,
	 module_name VARCHAR(64) UNIQUE,
	 module_file_name VARCHAR(64) UNIQUE,
	 module_title VARCHAR(64) UNIQUE,
	 module_icon VARCHAR(64) UNIQUE 
);

create table personell(
	personell_id SERIAL PRIMARY KEY,
	p_name varchar(100),--Имя
	p_patronymic varchar(100), --Отчество
	p_surname varchar(100), --Фамилия
	role_id integer REFERENCES roles(role_id),
	personell_id_barcode CHAR(48),
	p_login VARCHAR(30) UNIQUE,
	p_passwd VARCHAR(32),
	male boolean default true,
	create_date timestamp DEFAULT NOW(),
	update_date timestamp,
	birthday date,
	create_personell_id integer REFERENCES personell(personell_id),
	update_personell_id integer REFERENCES personell(personell_id),
	address varchar(150),
	email varchar(100),
	photo varchar(255),
	active boolean DEFAULT TRUE
);


CREATE TABLE module_role (
 module_role_id SERIAL PRIMARY KEY,
 module_id integer REFERENCES modules(module_id),
 role_id integer REFERENCES roles(role_id),
 UNIQUE (module_id, role_id)
);

INSERT INTO roles (role_name) VALUES ('Сотрудник');
INSERT INTO roles (role_name) VALUES ('Руководитель');



INSERT INTO personell (role_id, p_name, p_patronymic, p_surname,  p_login, p_passwd) VALUES (1, 'Роман', 'Юрьевич', 'Зайцев', 'Роман', md5('123'));
INSERT INTO personell (role_id, p_name, p_patronymic, p_surname,  p_login, p_passwd) VALUES (2, 'Юрий', 'Федорович', 'Зайцев', 'Юрий', md5('123'));
INSERT INTO personell (role_id, p_name, p_patronymic, p_surname,  p_login, p_passwd) VALUES (1, 'Валерий', 'Юрьевич', 'Ежов', 'Валера', md5('123'));
INSERT INTO personell (role_id, p_name, p_patronymic, p_surname,  p_login, p_passwd) VALUES (1, 'Виталий', 'Юрьевич', 'Куницин', 'Виталий', md5('123'));

INSERT INTO personell (role_id, p_name, p_patronymic, p_surname,  p_login, p_passwd) 
	VALUES (1, 'Александр', 'Васильевич', 'Козьев', 'АВ', md5('123')),
	(1, 'Владимир', 'Васильевич', 'Собакин', 'ВВ', md5('123')),
	(1, 'Александр', 'Григорьевич', 'Кулик', 'АГ', md5('123')),
	  (1, 'Артём', 'Николаевич', 'Змеев', 'АН', md5('123')),
	  (1, 'Владимир', '', 'Гадн', 'ВП', md5('123')),
	  (1, 'Игорь', 'Николаевич', 'Сельчуков', 'ИНС', md5('123')),
	  (1, 'Иван', 'Викторович', 'Сергеев', 'ИВС', md5('123')),
	  (1, 'Максим', 'Григорьевич', 'Гресь', 'МГГ', md5('123')),
	  (1, 'Алексей', 'Александрович', 'Павлиди', 'ААП', md5('123')),
	  (1, 'Алексей', '', 'Панамарёв', 'АП', md5('123'));

/*create table post_type(
	post_type_id SERIAL primary key,
	post_type varchar(25) UNIQUE,
	itr boolean
);
insert into post_type (post_type, itr) values ('Руководитель', true);
insert into post_type (post_type, itr) values ('Инженер', false);
insert into post_type (post_type, itr) values ('Монтажник', true);*/

DROP table unit;
create table unit(
	unit_id SERIAL PRIMARY KEY,
	unit varchar(100),--Наименование отдела
	post varchar(100),--Наименование должности
	p_unit_id integer references unit(unit_id), --Ссылка на старшую структуру
	--post_type_id int references post_type(post_type_id),
	personell_id integer REFERENCES personell(personell_id),
	terminal_bool boolean DEFAULT true,
	itr boolean,
	active boolean DEFAULT false
);
--SELECT * FROM personell;

INSERT INTO unit (unit, post, p_unit_id, personell_id, itr, active) VALUES ('ООО Сигнал-Ст', 'Директор', NULL, 2, true, true);
INSERT INTO unit (unit, post, p_unit_id, personell_id, itr, active) VALUES ('ООО Сигнал-Ст', 'Прораб', 1, 4, TRUE, true);
INSERT INTO unit (unit, post, p_unit_id, personell_id, itr, active) VALUES ('ООО Сигнал-Ст', 'Инженер', 1, 1, TRUE, true);
--INSERT INTO unit (unit, post, p_unit_id, personell_id, itr, active) VALUES ('ООО Сигнал-Ст', 'Главный инженер', 1, 1, TRUE, true);
INSERT INTO unit (unit, post, p_unit_id, personell_id, itr, active) VALUES ('ООО Сигнал-Ст', 'Водитель', 1, 3, TRUE, true);
--INSERT INTO unit (unit, post, p_unit_id, personell_id, itr, active) VALUES ('ООО Сигнал-Ст', 'Монтажник', 1, 3, TRUE, true);

--INSERT INTO module_role (role_id, module_id) VALUES (1,1);
--Объект на котором производятся работы
CREATE TABLE subject (
	subject_id SERIAL PRIMARY KEY,
	subject VARCHAR(250) UNIQUE,
	adress VARCHAR(250)
);
--SELECT * FROM subject;
INSERT INTO subject (subject) VALUES ('Красная поляна');
INSERT INTO subject (subject) VALUES ('Сокольское');

CREATE TABLE contractor (
	contractor_id SERIAL PRIMARY KEY,
	contractor VARCHAR(50) UNIQUE
);
INSERT INTO contractor (contractor) VALUES ('Сигнал-Ст');
INSERT INTO contractor (contractor) VALUES ('ИП Козьев');
INSERT INTO contractor (contractor) VALUES ('ИП Щукин');

CREATE TABLE contragent (
	contragent_id SERIAL PRIMARY KEY,
	contragent VARCHAR(50) UNIQUE
);
INSERT INTO contragent (contragent) VALUES ('арт');

--Проект, к проекту идёт спецификация
--DROP TABLE project;
CREATE TABLE project (
	project_id SERIAL PRIMARY KEY,
	project VARCHAR(250) UNIQUE,
	subject_id integer REFERENCES subject(subject_id),
	--contractor_id integer REFERENCES contractor(contractor_id),
	--contragent_id integer REFERENCES contragent(contragent_id),
	is_finished boolean DEFAULT FALSE
	--amount numeric(12,2)
);
INSERT INTO project (project, subject_id) VALUES ('СКС', 3);
INSERT INTO project (project, subject_id) VALUES ('Телевидение', 3);
INSERT INTO project (project, subject_id) VALUES ('Проектирование', 3);
INSERT INTO project (project, subject_id) VALUES ('Электрика', 3);
INSERT INTO project (project, subject_id) VALUES ('Заземление', 3);
--SELECT * FROM project;

CREATE TABLE measure (
	measure_id SERIAL PRIMARY KEY,
	measure VARCHAR(50) UNIQUE,
	measure_short VARCHAR(15)
);
INSERT INTO measure (measure, measure_short) VALUES ('штуки','шт');
INSERT INTO measure (measure, measure_short) VALUES ('пачка','пач');
INSERT INTO measure (measure, measure_short) VALUES ('коробка','кор');
INSERT INTO measure (measure, measure_short) VALUES ('метр','м');
INSERT INTO measure (measure, measure_short) VALUES ('упаковка','уп');
INSERT INTO measure (measure, measure_short) VALUES ('килограмм','кг');
INSERT INTO measure (measure, measure_short) VALUES ('грамм','г');
INSERT INTO measure (measure, measure_short) VALUES ('миллиграмм','мг');
INSERT INTO measure (measure, measure_short) VALUES ('литр','л');
INSERT INTO measure (measure, measure_short) VALUES ('миллилитр','мл');

--DROP TABLE goods;
CREATE TABLE goods (
	goods_id SERIAL PRIMARY KEY,
	goods VARCHAR(250) UNIQUE,
	measure_id integer REFERENCES measure(measure_id),
	art varchar(50),
	code varchar(50)
);

--INSERT INTO goods (goods, art, code, measure_id) VALUES ('','','',SELECT measure_id FROM measure_id WHERE measure_short = lower(''));
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Кабель  UTP, Cat.6A','BC6-4GY','BC6-4GY', measure_id FROM measure WHERE measure_short = lower('м');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'ИКБ-Т-А8-6,0','ИКБ-Т-А8-6,0','ИКБ-Т-А8-6,0',measure_id FROM measure WHERE measure_short = lower('м');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Лоток перфорированный 200х80х3000мм DKC/S5 Combitech','35304ZL','35304ZL',measure_id FROM measure WHERE measure_short = lower('м');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Лоток 100х80х3000мм DKC/S5 Combitech','35302HDZ','35302HDZ',measure_id FROM measure WHERE measure_short = lower('м');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Труба гофрированная ПВХ 20 мм','91920','91920',measure_id FROM measure WHERE measure_short = lower('м');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Труба гофрированная ПВХ 25 мм с протяжкой легкая серая','91925','91925',measure_id FROM measure WHERE measure_short = lower('м');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Труба гофрированная ПВХ 32','91932','91932',measure_id FROM measure WHERE measure_short = lower('м');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Труба гофрированная ПВХ 40 мм','91940','91940',measure_id FROM measure WHERE measure_short = lower('м');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Труба гофрированная двустенная 50 мм с протяжкой с муфтой красная (100м)','121950','9741793',measure_id FROM measure WHERE measure_short = lower('м');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Держатель с защелкой 20 мм для труб (51020)','51020','51020',measure_id FROM measure WHERE measure_short = lower('шт');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Держатель с защелкой 40 мм для труб (51020)','51040','51040',measure_id FROM measure WHERE measure_short = lower('шт');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Держатель с защелкой 32 мм для труб (51020)','51032','51032',measure_id FROM measure WHERE measure_short = lower('шт');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Коммутационная панель модульная 19" 1U, 24 порта типа Keystone, незагруж., промарк. Cat.6A','24U-HDMMP- C6A','24U-HDMMP- C6A',measure_id FROM measure WHERE measure_short = lower('шт');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Розеточный модуль типа Keystone Cat.6A,','KJ458-C6A','KJ458-C6A',measure_id FROM measure WHERE measure_short = lower('шт');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Розетка RJ45 двухмодульная','','',measure_id FROM measure WHERE measure_short = lower('шт');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Коннектор RJ45 UTP, категории 6','16B-U5-03BL','16B-U5-03BL',measure_id FROM measure WHERE measure_short = lower('шт');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Шкаф напольный Hyperline TTB-4288-AS-RAL9004','TTB-4288-AS-RAL9004','TTB-4288-AS-RAL9004',measure_id FROM measure WHERE measure_short = lower('шт');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Полка стационарная, глубина 650 мм, с боковым креплением, нагрузка до 20 кг, для шкафов серии TTB, TTR, TTC2, 485х650мм (ШхГ), цвет черный','TSH3L-650-RAL9004','TSH3L-650-RAL9004',measure_id FROM measure WHERE measure_short = lower('шт');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Кабельный организатор пластиковый с крышкой, 19", 1U','CM-1U-PL-COV','CM-1U-PL-COV',measure_id FROM measure WHERE measure_short = lower('шт');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Металлический вертикальный кабельный организатор с крышкой 42U, для шкафов TTB, TTC2 шириной 800 мм, черный','CMV-42U-ML','CMV-42U-ML',measure_id FROM measure WHERE measure_short = lower('шт');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Блок розеток для 19" шкафов, горизонтальный, с выключателем с подсветкой, 8 розеток Schuko (10А), 250В, без кабеля питания, входная розетка IEC 60320 C14, 482.6х44.4х44.4мм (ШхВхГ)','SHE19-8SH-S-IEC','SHE19-8SH-S-IEC',measure_id FROM measure WHERE measure_short = lower('шт');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Модуль вентиляторный потолочный с 2-мя вентиляторами для установки в шкафы серий TTC2, TTB и TWB, с подшипниками и крепежными элементами, цвет черный','TFAB-T2FR-RAL9004','TFAB-T2FR-RAL9004',measure_id FROM measure WHERE measure_short = lower('шт');

INSERT INTO goods (goods, art, code, measure_id) SELECT 'Кабель коаксиальный DG113 ZH','','',measure_id FROM measure WHERE measure_short = lower('м');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Оконечный мультисвич polytron PSG 908 P','9268070','9268070',measure_id FROM measure WHERE measure_short = lower('шт');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Оптический преобразователь Euro Fibre Virtual Quattro','','',measure_id FROM measure WHERE measure_short = lower('шт');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Оптический делитель  OSF 300','','',measure_id FROM measure WHERE measure_short = lower('шт');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Розетка SAT-TV оконечная','','',measure_id FROM measure WHERE measure_short = lower('шт');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'F-коннектор','','',measure_id FROM measure WHERE measure_short = lower('шт');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Патчкорд оптический FC/UPC SM 3m','','',measure_id FROM measure WHERE measure_short = lower('шт');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Патчкорд оптический FC/UPC-SC/UPC SM 3 метра','','',measure_id FROM measure WHERE measure_short = lower('шт');
INSERT INTO goods (goods, art, code, measure_id) SELECT 'Патчкорд оптический SC/UPC 3m','','',measure_id FROM measure WHERE measure_short = lower('шт');




--DROP TABLE specification;
CREATE TABLE specification (
	specification_id SERIAL PRIMARY KEY,
	project_id integer REFERENCES project(project_id),
	goods_id integer REFERENCES goods(goods_id),
	is_ordered boolean DEFAULT FALSE,
	is_finished boolean DEFAULT FALSE,
	amount numeric(12,3)
);

-------INSERT INTO specification (project_id, goods_id, amount) SELECT 1, goods_id, FROM goods WHERE lower(goods) = lower('');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 2, 14, 7238 ;
--INSERT INTO specification (project_id, goods_id, amount) SELECT 2, goods_id,270 FROM goods WHERE lower(goods) = lower('ИКБ-Т-А8-6,0');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 2, goods_id,35 FROM goods WHERE lower(goods) = lower('Лоток перфорированный 200х80х3000мм DKC/S5 Combitech');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 2, goods_id,86 FROM goods WHERE lower(goods) = lower('Лоток 100х80х3000мм DKC/S5 Combitech');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 2, goods_id,295 FROM goods WHERE lower(goods) = lower('Труба гофрированная ПВХ 20 мм');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 2, goods_id,34 FROM goods WHERE lower(goods) = lower('Труба гофрированная ПВХ 25 мм с протяжкой легкая серая');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 2, goods_id,19 FROM goods WHERE lower(goods) = lower('Труба гофрированная ПВХ 32');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 2, goods_id,9 FROM goods WHERE lower(goods) = lower('Труба гофрированная ПВХ 40 мм');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 2, goods_id,250 FROM goods WHERE lower(goods) = lower('Труба гофрированная двустенная 50 мм с протяжкой с муфтой красная (100м)');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 2, goods_id,68 FROM goods WHERE lower(goods) = lower('Держатель с защелкой 20 мм для труб (51020)');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 2, goods_id,4 FROM goods WHERE lower(goods) = lower('Держатель с защелкой 40 мм для труб (51020)');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 2, goods_id,4 FROM goods WHERE lower(goods) = lower('Держатель с защелкой 32 мм для труб (51020)');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 2, goods_id,2 FROM goods WHERE lower(goods) = lower('Держатель с защелкой 20 мм для труб (51020)');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 2, goods_id,6 FROM goods WHERE lower(goods) = lower('Коммутационная панель модульная 19" 1U, 24 порта типа Keystone, незагруж., промарк. Cat.6A');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 2, 27,120;
--INSERT INTO specification (project_id, goods_id, amount) SELECT 2, goods_id,35 FROM goods WHERE lower(goods) = lower('Розетка RJ45 двухмодульная');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 2, goods_id,50 FROM goods WHERE lower(goods) = lower('Коннектор RJ45 UTP, категории 6');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 2, goods_id,1 FROM goods WHERE lower(goods) = lower('Шкаф напольный Hyperline TTB-4288-AS-RAL9004');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 2, 31,2;
--INSERT INTO specification (project_id, goods_id, amount) SELECT 2, goods_id,7 FROM goods WHERE lower(goods) = lower('Кабельный организатор пластиковый с крышкой, 19", 1U');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 2, goods_id,2 FROM goods WHERE lower(goods) = lower('Металлический вертикальный кабельный организатор с крышкой 42U, для шкафов TTB, TTC2 шириной 800 мм, черный');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 2, goods_id,1 FROM goods WHERE lower(goods) = lower('Блок розеток для 19" шкафов, горизонтальный, с выключателем с подсветкой, 8 розеток Schuko (10А), 250В, без кабеля питания, входная розетка IEC 60320 C14, 482.6х44.4х44.4мм (ШхВхГ)');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 2, 35,1;

--INSERT INTO specification (project_id, goods_id, amount) SELECT 3, goods_id,426 FROM goods WHERE lower(goods) = lower('Кабель коаксиальный DG113 ZH');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 3, goods_id,30 FROM goods WHERE lower(goods) = lower('Кабель  UTP, Cat.6A');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 3, goods_id,1 FROM goods WHERE lower(goods) = lower('Оконечный мультисвич polytron PSG 908 P');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 3, goods_id,2 FROM goods WHERE lower(goods) = lower('Оптический преобразователь Euro Fibre Virtual Quattro');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 3, goods_id,1 FROM goods WHERE lower(goods) = lower('Оптический делитель  OSF 300');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 3, goods_id,7 FROM goods WHERE lower(goods) = lower('Розетка SAT-TV оконечная');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 3, goods_id,23 FROM goods WHERE lower(goods) = lower('F-коннектор');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 3, goods_id,2 FROM goods WHERE lower(goods) = lower('Патчкорд оптический FC/UPC SM 3m');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 3, goods_id,4 FROM goods WHERE lower(goods) = lower('Патчкорд оптический FC/UPC-SC/UPC SM 3 метра');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 3, goods_id,1 FROM goods WHERE lower(goods) = lower('Патчкорд оптический SC/UPC 3m');
--INSERT INTO specification (project_id, goods_id, amount) SELECT 3, goods_id,2 FROM goods WHERE lower(goods) = lower('Розетка RJ45 двухмодульная');


SELECT goods, amount FROM specification LEFT JOIN goods USING (goods_id) WHERE project_id = 3 ORDER BY goods_id;
SELECT goods_id, goods FROM goods ORDER BY goods;
--DELETE FROM goods WHERE goods_id = 59;

--Договор, к договору идет смета. Договор относится к проекту, в том числе и договор на проектирование
-- у договора есть оплаты и есть смета. Если есть допник - то это тоже договор, 
--Один договор может включать несколько проектов? - нет, это будет проект - проектирование
--DROP TABLE contract;
CREATE TABLE contract (
	contract_id SERIAL PRIMARY KEY,
	contract VARCHAR(250),
	contract_number VARCHAR(50),
	contract_date date,
	project_id integer REFERENCES project(project_id),
	contractor_id integer REFERENCES contractor(contractor_id),
	contragent_id integer REFERENCES contragent(contragent_id),
	is_finished boolean DEFAULT FALSE,
	amount numeric(12,2),
	file VARCHAR(250) UNIQUE
);
SELECT * FROM contractor;
SELECT * FROM contragent;
SELECT * FROM project;

INSERT INTO contract (project_id, contract, contractor_id, contragent_id, amount) VALUES (4, 'Разработка проектов систем сильных и слабых токов Бассейна', 1, 1, 477278.45);
INSERT INTO contract (project_id, contract, contractor_id, contragent_id, amount) VALUES (2, 'Монтаж СКС  "Бассейн" ', 1, 1, 3091534.76);
INSERT INTO contract (project_id, contract, contractor_id, contragent_id, amount) VALUES (3, 'Монтаж  системы телевидения "Бассейн"', 1, 1, 233179);
INSERT INTO contract (project_id, contract, contractor_id, contragent_id, amount) VALUES (5, 'Монтаж электропроводки для розеток и освещения 0, 1-го, 2-го и технического этажей', 1, 1, 6693630.11);
INSERT INTO contract (project_id, contract, contractor_id, contragent_id, amount) VALUES (5, 'Подогрев 1-го и 2-го этажей', 1, 1, 577343.27);
INSERT INTO contract (project_id, contract, contractor_id, contragent_id, amount) VALUES (5, 'Подогрев', 2, 1, 453428.78);
INSERT INTO contract (project_id, contract, contractor_id, contragent_id, amount) VALUES (5, 'Монтаж этажных щитов', 3, 1, 2027252.18);
INSERT INTO contract (project_id, contract, contractor_id, contragent_id, amount) VALUES (5, 'Монтаж магистрального лотка и силовых кабелей', 3, 1, 2320041.03);
INSERT INTO contract (project_id, contract, contractor_id, contragent_id, amount) VALUES (5, 'Монтаж  ВРУ бассейна', 1, 1, 3255905.42);
INSERT INTO contract (project_id, contract, contractor_id, contragent_id, amount) VALUES (5, 'Заземление и уравнивание потенциалов внутри здания', 2, 1, 1066677.15);


--Смета
--DROP TABLE estimate;
CREATE TABLE estimate (
	estimate_id SERIAL PRIMARY KEY,
	contract_id integer REFERENCES contract(contract_id),
	specification_id integer REFERENCES specification(specification_id),
	goods_id integer REFERENCES goods(goods_id),
	--is_ordered boolean DEFAULT FALSE,
	--is_finished boolean DEFAULT FALSE,
	amount numeric(12,3),
	price_goods numeric(12,2),
	price_job numeric(12,2)
);

INSERT INTO (contract_id, goods_id, amount, price) 2, (SELECT goods_id FROM goods WHERE lower(goods) = lower(''));
--Прокладка кабеля в гофро трубе по стенам и потолкам и конструкциям
INSERT INTO goods (goods, measure_id) VALUES ('F-коннектор', (SELECT measure_id FROM measure WHERE lower(measure) = lower('м'))) 
ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id;


WITH goods_ins AS (
	INSERT INTO goods (goods, measure_id) VALUES ('Прокладка кабеля в гофро трубе по стенам и потолкам и конструкциям',
	(SELECT measure_id FROM measure WHERE lower(measure) = lower('м')))
	ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id
)
INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 340, NULL, 150 FROM goods_ins;

SELECT * FROM estimate
DELETE FROM estimate

/*
WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('
Прокладка кабеля в гофро трубе по стенам и потолкам и конструкциям
',(SELECT measure_id FROM measure WHERE lower(measure) = lower('
м
'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 340, NULL, 150 FROM goods_ins;
*/

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Прокладка кабеля UTP, Cat.6A по лотку',(SELECT measure_id FROM measure WHERE lower(measure) = lower('м'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 3900, null, 50.00 FROM goods_ins;
WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Кабель на основе витой пары Cat.6A, U/UTP, 4 пары, не содержит галогенов, LSHF, 305 м (цена за 1 м)',(SELECT measure_id FROM measure WHERE lower(measure) = lower('м'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 8540,74.70, null FROM goods_ins;
WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Прокладка кабеля UTP, Cat.6A в гофротрубе по стенам и потолкам',(SELECT measure_id FROM measure WHERE lower(measure) = lower('м'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 4640, null, 150.00 FROM goods_ins;
WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Труба гофрированная ПВХ 20 мм с протяжкой легкая серая (100м)',(SELECT measure_id FROM measure WHERE lower(measure) = lower('м'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 300,10.60, null FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Труба гофрированная ПВХ 25 мм с протяжкой легкая серая (50м)',(SELECT measure_id FROM measure WHERE lower(measure) = lower('м'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 100,17.00, null FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Труба гофрированная ПВХ 32 мм с протяжкой легкая серая (25м)',(SELECT measure_id FROM measure WHERE lower(measure) = lower('м'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 25,24.20, null FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Труба гофрированная ПВХ 40 мм с протяжкой легкая серая (20м)',(SELECT measure_id FROM measure WHERE lower(measure) = lower('м'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 20,32.80, null FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Труба гофрированная ПВХ 50 мм с протяжкой легкая серая (30м)',(SELECT measure_id FROM measure WHERE lower(measure) = lower('м'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 270,51.80, null FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Держатель с защелкой 20 мм для труб',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 750,3.20, null FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Держатель с защелкой 25 мм для труб',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 250,4.16, null FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Держатель с защелкой 32 мм для труб',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 62,6.11, null FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Держатель с защелкой 40 мм для труб',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 50,14.12, null FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Прокладка кабеля ИКБ-Т-А8-6,0 по лотку',(SELECT measure_id FROM measure WHERE lower(measure) = lower('м'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 270, null, 50.00 FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Кабель ИКБ-Т-А8-6,0',(SELECT measure_id FROM measure WHERE lower(measure) = lower('м'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 270,39.24, null FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Терминирование разъемов патч-панели',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 120, null, 350.00 FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Коммутационная панель модульная 19" 1U, 24 порта типа Keystone, незагруж., промарк. Cat.6A',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 6,2000.00, null FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Розеточный модуль типа Keystone экран. Cat.6A, RJ45/110, T568A/B, серия MT',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 144,495.00, null FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Установка и терминирование розетки RJ-45 Cat-6А (розетки RG 45х2)',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 70, null, 500.00 FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Розеточный модуль типа Keystone экран. Cat.6A, RJ45/110, T568A/B, серия MT',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 70,495.00, null FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Установка и терминирование конектора RJ-45',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 50, null, 0.00 FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Разъем RJ-458P8C под витую пару категория 6 универсальный 100 шт',(SELECT measure_id FROM measure WHERE lower(measure) = lower('уп'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 1,2044.00, null FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Сборка и установка шкафа',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 1,5500.00, null FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Шкаф напольный 19-дюймовый 42U 2055x800х800мм передняя стеклянная дверь со стальными перфорированными боковинами задняя двер',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 1,58677.00, null FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Полка стационарная усиленная 19" глубина 650 мм',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 2,2298.00, null FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Организатор кабельный с пластиковыми кольцами и крышкой 19 1U',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 7,762.00, null FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Организатор кабельный металлический вертикальный с крышкой 42U для шкафов TTC/TSC шириной 800 черный',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 2,4741.00, null FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Блок розеток для 19" шкафов горизонтальный 8 розеток',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 1,2748.00, null FROM goods_ins;
WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Модуль вентиляторный потолочный с 2-мя вентиляторами для установки в шкафы серий TTC2, TTB и TWB, с подшипникам',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 2,3842.00, null FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Прокладка кабеля в гофро трубе по стенам и потолкам и конструкциям',(SELECT measure_id FROM measure WHERE lower(measure) = lower('м'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 340, null, 150.00 FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Труба гофрированная двустенная 50 мм с протяжкой с муфтой красная (100м)',(SELECT measure_id FROM measure WHERE lower(measure) = lower('м'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 300,91.50, null FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('ИКБ-Т-А8-6,0',(SELECT measure_id FROM measure WHERE lower(measure) = lower('м'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 340,39.23, null FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Сварка оптического кабеля',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 24, null, 600.00 FROM goods_ins;
WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Терминирование разъемов патч-панели',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 48, null, 250.00 FROM goods_ins;

WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Лоток FMT1 оптический для модульных патч-панелей CFAPPBL под 1 держатель (FMT1)',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 3, 13003.00, null FROM goods_ins;
WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Патч-панель CFAPPBL1 19д для установки до 4 адаптерных панелей FAP / FMP прямая',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 3,2943.00, null FROM goods_ins;
WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Панель для 6 SC дуплексных одномодовых оптических адаптеров (FAP6WBUDSCZ)',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 4,19100.00, null FROM goods_ins;
WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Кассета ВО сварных соединений, 12 поз.',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 4,8000.00, null FROM goods_ins;
WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Термоусаживаемая гильза (КДЗС), 60мм, уп-ка 10шт.',(SELECT measure_id FROM measure WHERE lower(measure) = lower('уп'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 3,39.00, null FROM goods_ins;
WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Держатель сплайс-кассет PANDUIT FSTHE FST6, до 4 кассет для FMT, размеры 44,5x115,8x204,7 мм',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 4,2780.00, null FROM goods_ins;
WITH goods_ins AS (INSERT INTO goods (goods, measure_id) VALUES ('Пигтейл SM 9/125 (OS2) SC/APC 1 м LSZH',(SELECT measure_id FROM measure WHERE lower(measure) = lower('шт'))) ON CONFLICT (goods) DO UPDATE SET goods = EXCLUDED.goods RETURNING goods_id) INSERT INTO estimate (contract_id, goods_id, amount, price_goods, price_job) SELECT 2, goods_ins.goods_id, 24,110.00, null FROM goods_ins;


SELECT goods FROM estimate LEFT JOIN goods USING (goods_id);

SELECT * FROM subject;
SELECT * FROM personell;

DROP TABLE work_plan;
CREATE TABLE work_plan (
	work_plan_id SERIAL PRIMARY KEY,
	personell_id integer REFERENCES personell(personell_id),
	work_date date,
	subject_id integer REFERENCES subject(subject_id),
	UNIQUE(personell_id, work_date, subject_id)
);

INSERT INTO work_plan (personell_id, work_date, subject_id) VALUES (2, '2020-10-26', 3);
INSERT INTO work_plan (personell_id, work_date, subject_id) VALUES (2, '2020-10-27', 4);
INSERT INTO work_plan (personell_id, work_date, subject_id) VALUES (2, '2020-10-29', 3);
INSERT INTO work_plan (personell_id, work_date, subject_id) VALUES (2, '2020-10-30', 3);
INSERT INTO work_plan (personell_id, work_date, subject_id) VALUES (2, '2020-10-31', 4);

INSERT INTO work_plan (personell_id, work_date, subject_id) VALUES (1, '2020-10-26', 3);
INSERT INTO work_plan (personell_id, work_date, subject_id) VALUES (1, '2020-10-29', 3);
INSERT INTO work_plan (personell_id, work_date, subject_id) VALUES (1, '2020-10-31', 3);

INSERT INTO work_plan (personell_id, work_date, subject_id) VALUES (4, '2020-10-26', 4);
INSERT INTO work_plan (personell_id, work_date, subject_id) VALUES (4, '2020-10-27', 4);
INSERT INTO work_plan (personell_id, work_date, subject_id) VALUES (4, '2020-10-31', 4);


/*SELECT  generate_series('2020-10-26'::timestamp, date '2020-10-26' + interval '1 month' - interval '1 day', '1 day') days
		
SELECT  p_surname||' '||p_name, json_agg(work_plan.*)
FROM work_plan LEFT JOIN personell ON (work_plan.personell_id = personell.personell_id)
WHERE subject_id = 3 AND work_date >= '2020-10-01'::date and work_date < '2020-10-01'::date + interval '1 month'
GROUP BY personell.personell_id*/



CREATE TABLE dev_group (
	dev_group_id SERIAL PRIMARY KEY,
	dev_group VARCHAR(250) UNIQUE
);

DROP TABLE dev_type;
CREATE TABLE dev_type (
	dev_type_id SERIAL PRIMARY KEY,
	dev_type VARCHAR(250) UNIQUE,
	dev_type_short varchar(10),
	--cell_style varchar(120),
	font_style varchar(120),
	cell_border varchar(100),
	cell_bgcolor varchar(100),
	param_measure varchar(12),
	param_default_value numeric(12,2),
	is_int_param boolean DEFAULT true
);
--ALTER TABLE dev_type ADD COLUMN is_int_param boolean DEFAULT true;
--ALTER TABLE dev_type ADD COLUMN cell_bgcolor varchar(100);
--ALTER TABLE dev_type ADD COLUMN is_show boolean DEFAULT false;
--ALTER TABLE dev_type ADD COLUMN param_measure varchar(12);
--ALTER TABLE dev_type ADD COLUMN param_default_value numeric(12,2);

SELECT * FROM dev_type;
UPDATE dev_type SET param_measure = 'час' WHERE dev_type_id = 1;
UPDATE dev_type SET param_measure = 'руб' WHERE dev_type_id = 4;

UPDATE dev_type SET param_default_value = '8' WHERE dev_type_id = 1;
UPDATE dev_type SET param_default_value = '500' WHERE dev_type_id = 4;


INSERT INTO dev_type (dev_type, dev_type_short, cell_style, font_style) 
VALUES ('Явка', 'Я', 'background-color: #3CB371;', null),
	('Отпуск', 'О', 'background-color: yellow;', null),
	('Отгул', 'Ог', 'background-color: YellowGreen;', null),
	('Командировочные', 'К', NULL, 'color: DarkRed;');

INSERT INTO dev_type (dev_type, dev_type_short) 
VALUES ('Выходной', 'в');

INSERT INTO dev_type (dev_type,  cell_border) 
VALUES ('Пожелания', 'RGBA(255, 127, 80, 0.5)');

SELECT * FROM dev_type;
UPDATE dev_type SET is_show=true WHERE dev_type_id IN (5, 1, 4);

--RGBA(60, 179, 113, 0.5)
--SELECT * FROM dev_type;
--SELECT dev_type, dev_type_short, cell_style, font_style FROM dev_type

--developments события
CREATE TABLE developments (
	developments_id SERIAL PRIMARY KEY,
	personell_id integer REFERENCES personell(personell_id),
	dev_date date,
	subject_id integer REFERENCES subject(subject_id),
	dev_type_id integer REFERENCES dev_type(dev_type_id),
	param numeric(12,2),
	UNIQUE(personell_id, dev_date, dev_type_id)
);

ALTER TABLE developments ADD CONSTRAINT UNIQUE 
--SELECT * FROM personell;

--INSERT INTO developments (personell_id, dev_date, subject_id, dev_type_id) VALUES (1, '2020-11-01', 4, 1),(1, '2020-11-02', 4, 1),(1, '2020-11-03', 4, 1)
--INSERT INTO developments (personell_id, dev_date, subject_id, dev_type_id) VALUES (4, '2020-11-02', 4, 1),(4, '2020-11-03', 4, 1)

SELECT  personell.personell_id AS id, p_surname||' '||p_name AS name, json_agg(wp.*) AS data
		FROM personell INNER JOIN (
			SELECT dev_date AS id, personell_id, json_agg(developments.*) AS data
			FROM developments
			WHERE subject_id = $subject_id AND dev_date >= '2020-11-01'::date and dev_date < '2020-11-01'::date + interval '1 month'
			GROUP BY personell_id, dev_date
		) AS wp ON (personell.personell_id = wp.personell_id)
		GROUP BY personell.personell_id
		ORDER BY name;


--DELETE FROM developments WHERE subject_id = 4;



/*SELECT days::date AS id, doc_work_time.work_begin, doc_work_time.work_end, json_agg(app.*) AS appointments
FROM generate_series('$date'::timestamp, date '$date' + interval '1 month' - interval '1 day', '1 day') days
	LEFT JOIN doc_work_time ON (days::date = doc_work_time.work_date AND doc_work_time.structure_id = $structure_id)
	LEFT JOIN (
		SELECT appointments.app_id AS id, appointments.app_id AS app_id, client.client_id AS client_id,
			CASE WHEN client.photo IS NULL THEN CASE WHEN client.male THEN 'male.png' ELSE 'female.png' END ELSE client.photo END AS photo, male,
			client.c_surname,client.c_name,client.c_patronymic, appointments.app_date AS app_date,
			appointments.app_begin_int AS app_begin_int, appointments.app_end_int AS app_end_int,
			appointments.app_remark AS app_remark, appointments.app_status_id AS app_status_id,
			app_status.app_status AS app_status, app_status.app_status_color AS color, app_status.app_status_icon AS app_status_icon
		FROM appointments 
			LEFT JOIN client USING (client_id) 
			LEFT JOIN app_status USING (app_status_id)
		WHERE appointments.structure_id = $structure_id ORDER BY appointments.app_begin_int
	) AS app ON (days::date = app.app_date)
WHERE doc_work_time.structure_id = $structure_id OR doc_work_time.structure_id IS NULL
GROUP BY days, work_begin, work_end
ORDER BY days;
*/

SELECT personell.personell_id AS id, p_surname||' '||p_name AS name,
			string_agg('\"'||wp.dday||'\":'||wp.data, ',') AS days
		FROM personell 
			INNER JOIN (
				SELECT personell_id, date_part('day', dev_date) AS dday, json_agg(developments .*) AS data
				FROM developments
				WHERE subject_id = $subject_id AND dev_date >= '2020-11-01'::date and dev_date < '2020-11-01'::date + interval '1 month'
				GROUP BY dev_date, personell_id
			) wp ON (personell.personell_id = wp.personell_id)
		GROUP BY personell.personell_id
	
		
SELECT * FROM personell;		
SELECT * FROM dev_type;

SELECT * FROM developments
WHERE dev_date >= '2020-11-01'::date and dev_date < '2020-11-01'::date + interval '1 month' AND personell_id = 12
		
	
UPDATE developments SET (personell_id, dev_date, subject_id, dev_type_id) = (7, '2020-11-27', 0, 4) WHERE developments_id = 323;
	
	
		
		







