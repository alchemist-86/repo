-- 1
create table salary_audit (
    audit_id      number primary key,
    employee_id   number,
    old_salary    number(8,2),
    new_salary    number(8,2),
    change_date   date
);



create or replace trigger trigger_salary
after update of salary on employees
for each row
begin
    if :old.salary != :new.salary then
        insert into salary_audit (employee_id, old_salary, new_salary, change_date)
        values (:old.employee_id, :old.salary, :new.salary, sysdate);
    end if;
end;
/


-- 2
create or replace trigger trigger_uppercase
before insert or update of department_name on departments
for each row
begin
    if :new.department_name != upper(:new.department_name) then
        raise_application_error(-20001, 'Dept. name must be in uppercase');
    end if;
end;
/


-- 3
create or replace trigger trigger_inserts
before insert on departments
for each row
declare
    v_current_hour number;
begin
    v_current_hour := to_number(to_char(sysdate, 'hh24'));

    if v_current_hour < 12 then
        raise_application_error(-20002, 'inserts into departments table are only allowed during pm');
    end if;
end;
/



