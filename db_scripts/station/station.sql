EXECUTE STATION_INSERT(P_NAME  => 'Казанский вокзал', P_ZONE_ID  => 2)
EXECUTE STATION_INSERT(P_NAME  => 'Ярославский вокзал', P_ZONE_ID  => 2)
EXECUTE STATION_INSERT(P_NAME  => 'Ленинградский вокзал', P_ZONE_ID  => 2)
EXECUTE STATION_INSERT(P_NAME  => 'Комсомольская', P_ZONE_ID  => 2)

EXECUTE STATION_UPDATE(P_ID  => 2 /*IN NUMBER(38)*/, P_NAME  => 'Столбовая' /*IN VARCHAR2*/, P_ZONE_ID  => 41 /*IN NUMBER(38)*/)
EXECUTE STATION_UPDATE(P_ID  => 25 /*IN NUMBER(38)*/, P_NAME  => 'Пл. 66 км' /*IN VARCHAR2*/, P_ZONE_ID  => 41 /*IN NUMBER(38)*/)
EXECUTE STATION_UPDATE(P_ID  =>  /*IN NUMBER(38)*/, P_NAME  => P_ /*IN VARCHAR2*/, P_ZONE_ID  => 41 /*IN NUMBER(38)*/)


--Площадь Трех вокзалов

EXECUTE STATION_UPDATE(P_ID  => 27 /*IN NUMBER(38)*/, P_NAME  => 'Казанский вокзал' /*IN VARCHAR2*/, P_ZONE_ID  => 43 /*IN NUMBER(38)*/)
EXECUTE STATION_UPDATE(P_ID  => 28 /*IN NUMBER(38)*/, P_NAME  => 'Ярославский вокзал', P_ZONE_ID  => 43 /*IN NUMBER(38)*/)
EXECUTE STATION_UPDATE(P_ID  => 29 /*IN NUMBER(38)*/, P_NAME  => 'Ленинградский вокзал' /*IN VARCHAR2*/, P_ZONE_ID  => 43 /*IN NUMBER(38)*/)
EXECUTE STATION_UPDATE(P_ID  => 30 /*IN NUMBER(38)*/, P_NAME  => 'Комсомольская' /*IN VARCHAR2*/, P_ZONE_ID  => 43 /*IN NUMBER(38)*/)
EXECUTE STATION_UPDATE(P_ID  => 26 /*IN NUMBER(38)*/, P_NAME  => 'Москва-Каланчевская' /*IN VARCHAR2*/, P_ZONE_ID  => 43 /*IN NUMBER(38)*/)
