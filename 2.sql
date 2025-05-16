-- Check
-- A

create or replace procedure transfer_emp (emp_id in number,new_dept in varchar2) is
  d_id departments.department_id%type;
  c number;
begin
  select count(*) into c from departments where department_name = new_dept;

  if c = 0 then
    dbms_output.put_line('Error: Dept "' || new_dept || '" not found');
    return;
  end if;

  select department_id into d_id from departments where department_name = new_dept;

  update employees set department_id = d_id where employee_id = emp_id;

  dbms_output.put_line('Emp ' || emp_id || ' moved to dept ' || new_dept);
end;
/


-- B

create or replace package emp_pkg is
  type emp_rec is record (
    ename varchar2(100),
    mname varchar2(100),
    job varchar2(100),
    ysal number,
    perf varchar2(10)
  );

  type emp_tab is table of emp_rec;
end;
/
create or replace function get_emp_perf
return emp_pkg.emp_tab pipelined
as
begin
  for r in (
    select
      e.first_name || ' ' || e.last_name ename,
      nvl(m.first_name || ' ' || m.last_name, 'No Manager') mname,
      j.job_title job,
      e.salary * 12 ysal,
      case
        when e.salary * 12 >= 120000 then 'High'
        when e.salary * 12 >= 60000 then 'Average'
        else 'Low'
      end perf
    from employees e
    left join employees m on e.manager_id = m.employee_id
    join jobs j on e.job_id = j.job_id
  ) loop
    pipe row(emp_pkg.emp_rec(r.ename, r.mname, r.job, r.ysal, r.perf));
  end loop;

  return;
end;
/

select * from table(get_emp_perf());
