ALTER TABLE ZONE
ADD color VARCHAR2(7)

EXECUTE ZONE_UPDATE(P_ID  => 1 /*IN NUMBER(38)*/,P_NAME  => 'Северная зона оплаты' /*IN VARCHAR2*/,P_PRICE  => 10, P_COLOR => '#80aaff' /*IN NUMBER*/)
EXECUTE ZONE_UPDATE(P_ID  => 2 /*IN NUMBER(38)*/,P_NAME  => 'Южная зона оплаты' /*IN VARCHAR2*/,P_PRICE  => 20, P_COLOR => '#ff6666' /*IN NUMBER*/)
EXECUTE ZONE_UPDATE(P_ID  => 21 /*IN NUMBER(38)*/,P_NAME  => 'Западная зона оплаты' /*IN VARCHAR2*/,P_PRICE  => 30, P_COLOR => '#33cc33' /*IN NUMBER*/)