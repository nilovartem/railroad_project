--Таблица Связь, нужна для построения графа станций
CREATE TABLE link (
    id            INTEGER NOT NULL PRIMARY KEY,
    in_id    INTEGER NOT NULL REFERENCES station(id),
    out_id  INTEGER NOT NULL REFERENCES station(id),
    travel_time BINARY_FLOAT NOT NULL 
)
create SEQUENCE sq_link start with 1;
create or replace trigger tg_link
before insert on link
for each row
begin
 select sq_link.Nextval
 into :new.id
 from dual;
end;
create or replace procedure link_insert(p_in_id in int, p_out_id in int,p_travel_time in int)
is
begin
    insert into link (in_id,out_id,travel_time)
        values (p_in_id,p_out_id,p_travel_time);
commit;
end;
create or replace procedure link_update(p_id in int,p_in_id in int, p_out_id in int, p_travel_time)
is
begin
    update link set
		in_id = p_in_id,
		out_id = p_out_id,
        travel_time = p_travel_time
		where
        id = p_id;
commit;
end;
create or replace procedure link_delete(p_id in int)
is
begin
    delete from link
        where
        id = p_id;
commit;
end;