CREATE OR REPLACE VIEW view_link (--Создание представления
--Столбцы
    ID,
    in_station_name,
    out_station_name,
    travel_time
) AS
    SELECT --Поля, которые мы выбираем из таблиц
        LINK.ID,
        STATION.NAME      AS "InStationName",--Добавление псевдонима
        STATION.NAME    AS "OutStationName",--Добавление псевдонима
        LINK.TRAVEL_TIME
    FROM--Указание на таблицы, из которых берутся значения
    STATION,
    LINK

    WHERE STATION.ID = LINK.IN_ID AND STATION.ID = LINK.OUT_ID;

CREATE OR REPLACE VIEW view_direction_plan (--Создание представления
--Столбцы
    id,
    stationname,
    directionname
) AS
    SELECT --Поля, которые мы выбираем из таблиц
        direction_plan.id,
        station.name      AS "StationName",--Добавление псевдонима
        direction.name    AS "DirectionName"--Добавление псевдонима
    FROM--Указание на таблицы, из которых берутся значения
        direction_plan,
        direction,
        station
    WHERE--Условия вывода
            direction.id = direction_plan.direction_id
        AND station.id = direction_plan.station_id;

Create or Replace View v1 As Select * from Link;