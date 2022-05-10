CREATE OR REPLACE VIEW view_link (--�������� �।�⠢�����
--�⮫���
    ID,
    in_station_name,
    out_station_name,
    travel_time
) AS
    SELECT --����, ����� �� �롨ࠥ� �� ⠡���
        LINK.ID,
        STATION.NAME      AS "InStationName",--���������� �ᥢ������
        STATION.NAME    AS "OutStationName",--���������� �ᥢ������
        LINK.TRAVEL_TIME
    FROM--�������� �� ⠡����, �� ������ ������� ���祭��
    STATION,
    LINK

    WHERE STATION.ID = LINK.IN_ID AND STATION.ID = LINK.OUT_ID;

CREATE OR REPLACE VIEW view_direction_plan (--�������� �।�⠢�����
--�⮫���
    id,
    stationname,
    directionname
) AS
    SELECT --����, ����� �� �롨ࠥ� �� ⠡���
        direction_plan.id,
        station.name      AS "StationName",--���������� �ᥢ������
        direction.name    AS "DirectionName"--���������� �ᥢ������
    FROM--�������� �� ⠡����, �� ������ ������� ���祭��
        direction_plan,
        direction,
        station
    WHERE--�᫮��� �뢮��
            direction.id = direction_plan.direction_id
        AND station.id = direction_plan.station_id;

Create or Replace View v1 As Select * from Link;