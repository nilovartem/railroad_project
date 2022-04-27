CREATE TABLE zone (
    id     INTEGER NOT NULL CONSTRAINT zone_pk PRIMARY KEY,
	name   varchar(50) not null,
    price  NUMBER(5, 2) not null CONSTRAINT zone_price CHECK(price >= 0)
);
create SEQUENCE sq_zone start with 1;
create or replace trigger tg_zone
before insert on zone
for each row
begin
 select sq_zone.Nextval
 into :new.id
 from dual;
end;
create or replace procedure zone_insert(p_name in varchar,p_price in NUMBER)
is
begin
    insert into zone (name,price)
        values (p_name,p_price);
commit;
end;
create or replace procedure zone_update(p_id in int,p_name in varchar,p_price in NUMBER)
is
begin
    update zone set
		name = p_name,
		price = p_price
		where
        id = p_id;
commit;
end;
create or replace procedure zone_delete(p_id in int)
is
begin
    delete from zone
        where
        id = p_id;
commit;
end;
--создание таблицы поезд
CREATE TABLE train (
    id        INTEGER NOT NULL CONSTRAINT train_pk PRIMARY KEY,
    name 	  VARCHAR2(20) NOT NULL
)

create SEQUENCE sq_train start with 1;
create or replace trigger tg_train
before insert on train
for each row
begin
 select sq_train.Nextval
 into :new.id
 from dual;
end;

create or replace procedure train_insert(p_name in varchar)
is
begin
    insert into train (name)
        values (p_name);
commit;
end;
create or replace procedure train_update(p_id in int,p_name in varchar)
is
begin
    update train set
		name = p_name
		where
        id = p_id;
commit;
end;
create or replace procedure train_delete(p_id in int)
is
begin
    delete from train
        where
        id = p_id;
commit;
end;
--Таблица Direction
CREATE TABLE direction (
    id        INTEGER NOT NULL CONSTRAINT direction_pk PRIMARY KEY,
    name 	  VARCHAR2(50) NOT NULL
)

create SEQUENCE sq_direction start with 1;
create or replace trigger tg_direction
before insert on direction
for each row
begin
 select sq_direction.Nextval
 into :new.id
 from dual;
end;

create or replace procedure direction_insert(p_name in varchar)
is
begin
    insert into direction (name)
        values (p_name);
commit;
end;
create or replace procedure direction_update(p_id in int,p_name in varchar)
is
begin
    update direction set
		name = p_name
		where
        id = p_id;
commit;
end;
create or replace procedure direction_delete(p_id in int)
is
begin
    delete from direction
        where
        id = p_id;
commit;
end;
--Таблица Маршрут

CREATE TABLE route (
    id            INTEGER NOT NULL CONSTRAINT route_pk PRIMARY KEY,
    route_date    DATE NOT NULL,
    name          VARCHAR2(100) NOT NULL,
    train_id      INTEGER NOT NULL REFERENCES train(id),
    direction_id  INTEGER NOT NULL REFERENCES direction(id)
)

create SEQUENCE sq_route start with 1;
create or replace trigger tg_route
before insert on route
for each row
begin
 select sq_route.Nextval
 into :new.id
 from dual;
end;

create or replace procedure route_insert(p_route_date in date, p_name in varchar, p_train_id in integer, p_direction_id in integer)
is
begin
    insert into route (route_date,name,train_id,direction_id)
        values (p_route_date,p_name,p_train_id,p_direction_id);
commit;
end;
create or replace procedure route_update(p_id in int,p_route_date in date, p_name in varchar, p_train_id in integer, p_direction_id in integer)
is
begin
    update route set
		route_date = p_route_date,
		name = p_name,
		train_id = p_train_id,
		direction_id = p_direction_id
		where
        id = p_id;
commit;
end;
create or replace procedure route_delete(p_id in int)
is
begin
    delete from route
        where
        id = p_id;
commit;
end;
--Таблица Station
CREATE TABLE station (
    id       INTEGER NOT NULL CONSTRAINT station_pk PRIMARY KEY,
    name     VARCHAR2(60) NOT NULL,
    zone_id  INTEGER NOT NULL REFERENCES zone(id)	
)
create SEQUENCE sq_station start with 1;
create or replace trigger tg_station
before insert on station
for each row
begin
 select sq_station.Nextval
 into :new.id
 from dual;
end;

create or replace procedure station_insert(p_name in varchar,p_zone_id in int)
is
begin
    insert into station (name,zone_id)
        values (p_name,p_zone_id);
commit; 
end;
create or replace procedure station_update(p_id in int,p_name in varchar,p_zone_id in int)
is
begin
    update station set
		name = p_name,
		zone_id = p_zone_id
		where
        id = p_id;
commit;
end;
create or replace procedure station_delete(p_id in int)
is
begin
    delete from station
        where
        id = p_id;
commit;
end;
--Таблица Point
CREATE TABLE point (
    id              INTEGER NOT NULL CONSTRAINT point_pk PRIMARY KEY,
    arrival_time    varchar(5) not null CONSTRAINT point_arrival_time check(arrival_time like '__:__'),
    departure_time  varchar(5) not null CONSTRAINT point_departure_time check(departure_time like '__:__'),
    station_id      INTEGER NOT NULL REFERENCES station(id),
    route_id        INTEGER NOT NULL REFERENCES route(id)
)

create SEQUENCE sq_point start with 1;
create or replace trigger tg_point
before insert on point
for each row
begin
 select sq_point.Nextval
 into :new.id
 from dual;
end;

create or replace procedure point_insert(p_arrival_time in varchar,p_departure_time in varchar, p_station_id in integer, p_route_id in integer)
is
begin
    insert into point (arrival_time,departure_time,station_id,route_id)
        values (p_arrival_time,p_departure_time,p_station_id,p_route_id);
commit;
end;
create or replace procedure point_update(p_id in int,p_arrival_time in varchar,p_departure_time in varchar, p_station_id in integer, p_route_id in integer)
is
begin
    update point set
		arrival_time = p_arrival_time,
		departure_time = p_departure_time,
		station_id = p_station_id,
		route_id = p_route_id
		where
        id = p_id;
commit;
end;
create or replace procedure point_delete(p_id in int)
is
begin
    delete from point
        where
        id = p_id;
commit;
end;
--Таблица Ticket
CREATE TABLE ticket (
    id                    INTEGER NOT NULL PRIMARY KEY,
    price                 NUMBER(5, 2) NOT NULL,
    purchase_date         DATE NOT NULL,
    arrival_station_id    INTEGER NOT NULL REFERENCES station(id),
    departure_station_id  INTEGER NOT NULL REFERENCES station(id)
)
create SEQUENCE sq_ticket start with 1;
create or replace trigger tg_ticket
before insert on ticket
for each row
begin
 select sq_ticket.Nextval
 into :new.id
 from dual;
end;

create or replace procedure ticket_insert(p_price in number, p_purchase_date in date, p_arrival_station_id in int, p_departure_station_id in int)
is
begin
    insert into ticket (price,purchase_date,arrival_station_id,departure_station_id)
        values (p_price,p_purchase_date,p_arrival_station_id,p_departure_station_id);
commit;
end;
create or replace procedure ticket_update(p_id in int,p_price in number, p_purchase_date in date, p_arrival_station_id in int, p_departure_station_id in int)
is
begin
    update ticket set
		price = p_price,
		purchase_date = p_purchase_date,
		arrival_station_id = p_arrival_station_id,
		departure_station_id = p_departure_station_id
		where
        id = p_id;
commit;
end;
create or replace procedure ticket_delete(p_id in int)
is
begin
    delete from ticket
        where
        id = p_id;
commit;
end;
--Таблица Cхема направлений
CREATE TABLE direction_plan (
    id            INTEGER NOT NULL PRIMARY KEY,
    station_id    INTEGER NOT NULL REFERENCES station(id),
    direction_id  INTEGER NOT NULL REFERENCES direction(id)
)
create SEQUENCE sq_direction_plan start with 1;
create or replace trigger tg_direction_plan
before insert on direction_plan
for each row
begin
 select sq_direction_plan.Nextval
 into :new.id
 from dual;
end;

create or replace procedure direction_plan_insert(p_station_id in int, p_direction_id in int)
is
begin
    insert into direction_plan (station_id,direction_id)
        values (p_station_id,p_direction_id);
commit;
end;
create or replace procedure direction_plan_update(p_id in int,p_station_id in int, p_direction_id in int)
is
begin
    update direction_plan set
		station_id = p_station_id,
		direction_id = p_direction_id
		where
        id = p_id;
commit;
end;
create or replace procedure direction_plan_delete(p_id in int)
is
begin
    delete from direction_plan
        where
        id = p_id;
commit;
end;
--функции
CREATE OR REPLACE FUNCTION get_ticket_price(f_id_first_station in int,f_id_second_station in int)
RETURN NUMBER
IS
ticket_price NUMBER(5,2);
first_id_zone INTEGER;
second_id_zone INTEGER;
first_price_zone NUMBER;
second_price_zone NUMBER;
BEGIN
    SELECT zone_id into first_id_zone from station where id = f_id_first_station;
    SELECT zone_id into second_id_zone from station where id = f_id_second_station;
    SELECT price into first_price_zone from zone where id = first_id_zone;
    SELECT price into second_price_zone from zone where id = second_id_zone;
    SELECT GREATEST(first_price_zone,second_price_zone) into ticket_price FROM DUAL;
    RETURN (ticket_price);
END; 

--Получить количество маршрутов для определенного поезда
CREATE OR REPLACE FUNCTION get_routes_count(f_id_train in int)
RETURN INTEGER
IS
routes_count INTEGER;
BEGIN
    SELECT COUNT(*) into routes_count FROM route where train_id = f_id_train;
    RETURN (routes_count); 
END;
--Получить количество станций на направлении
CREATE OR REPLACE FUNCTION get_stations_count(f_id_direction in int)
RETURN INTEGER
IS
station_count INTEGER;
BEGIN
    SELECT COUNT(*) into station_count FROM direction_plan where direction_id = f_id_direction;
    RETURN (station_count); 
END;
--Поиск направления по станции
CREATE OR REPLACE FUNCTION get_direction_name(f_id_station in int)
RETURN VARCHAR
IS
direction_name VARCHAR(100);
selected_direction_id INTEGER;
BEGIN
    SELECT direction_id into selected_direction_id from direction_plan where station_id = f_id_station;
    SELECT name into direction_name from direction where id = selected_direction_id;
    RETURN (direction_name); 
END;
--Получить количество точек маршрутов, добавить время прибытия и отправления
CREATE OR REPLACE FUNCTION get_route_points_count(f_id_route in int)
RETURN INTEGER
IS
points_count INTEGER;
BEGIN
    SELECT COUNT(*) into points_count FROM point where route_id = f_id_route;
    RETURN (points_count); 
END;
