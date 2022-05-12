--Объявление процедуры
CREATE OR REPLACE FUNCTION get_stations_count--Имя функции
(f_id_direction in int)--Входные параметры функции
RETURN INTEGER--Тип возвращаемого значения
IS
station_count INTEGER;--Возвращаемое значение
BEGIN
    SELECT COUNT(*) into station_count FROM direction_plan where direction_id = f_id_direction;
    RETURN (station_count); --Точка выхода из функции
END;
--Выполнение процедуры
select get_stations_count(F_ID_DIRECTION  => 1 /*IN NUMBER(38)*/) from dual

