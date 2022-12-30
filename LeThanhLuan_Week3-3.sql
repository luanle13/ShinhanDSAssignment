-- Bài 1: Lệnh CREATE PROCEDURE
-- 1
CREATE OR REPLACE PROCEDURE dept_info
    (id_dept IN departments.department_id%TYPE, department OUT departments%ROWTYPE)
IS
BEGIN 
    SELECT * INTO department FROM departments 
        WHERE department_id = id_dept;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No data found');
END;

-- 2
CREATE OR REPLACE PROCEDURE add_job
    (id_job IN jobs.job_id%TYPE, title_job IN jobs.job_title%TYPE)
IS 
BEGIN 
    INSERT INTO jobs (job_id, job_title) VALUES (id_job, title_job);
    EXCEPTION 
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Index duplication');
END;

-- 3
CREATE OR REPLACE PROCEDURE update_comm
    (id_employee IN employees.employee_id%TYPE)
IS 
BEGIN 
    UPDATE employees SET commission_pct = commission_pct * 1.05 
        WHERE employee_id = id_employee; 
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No data found');
END;

-- 4
CREATE OR REPLACE PROCEDURE add_emp
    (
        emp_id IN employees.employee_id%TYPE, 
        emp_firstname IN employees.first_name%TYPE, 
        emp_lastname IN employees.last_name%TYPE, 
        emp_email IN employees.email%TYPE, 
        emp_phonenumber IN employees.phone_number%TYPE, 
        emp_hiredate IN employees.hire_date%TYPE, 
        emp_jobid IN employees.job_id%TYPE, 
        emp_salary IN employees.salary%TYPE, 
        emp_commission_pct IN employees.commission_pct%TYPE, 
        emp_manager_id IN employees.manager_id%TYPE, 
        emp_department_id IN employees.department_id%TYPE
    )
IS
BEGIN 
    INSERT INTO employees 
    (
        employee_id, 
        first_name, 
        last_name,
        email, 
        phone_number, 
        hire_date, 
        job_id, 
        salary, 
        commission_pct, 
        manager_id, 
        department_id
    )
    VALUES 
    ( 
        emp_id, 
        emp_firstname, 
        emp_lastname, 
        emp_email, 
        emp_phonenumber, 
        emp_hiredate, 
        emp_jobid, 
        emp_salary, 
        emp_commission_pct, 
        emp_manager_id, 
        emp_department_id
    );
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Data duplication found, inserts have been rolled back');
END;

-- 5
CREATE OR REPLACE PROCEDURE delete_emp
    (emp_id IN employees.employee_id%TYPE)
IS 
BEGIN 
    DELETE FROM employees WHERE employee_id = emp_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No data found');
END;

-- 6
CREATE OR REPLACE PROCEDURE find_emp
IS 
    CURSOR get_list_employees
    IS
        SELECT 
            employees.employee_id, 
            employees.first_name,
            employees.last_name,
            employees.email,
            employees.phone_number,
            employees.hire_date,
            employees.job_id,
            employees.salary,
            employees.commission_PCT,
            employees.manager_id,
            employees.department_id
        FROM employees
            JOIN jobs
            ON employees.job_id = jobs.job_id
        WHERE jobs.min_salary < employees.salary 
            AND jobs.max_salary > employees.salary;
BEGIN 
    FOR emp IN get_list_employees
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            emp.employee_id || 
            '|' || emp.first_name ||
            '|' || emp.last_name ||
            '|' || emp.email ||
            '|' || emp.phone_number ||
            '|' || emp.hire_date ||
            '|' || emp.job_id ||
            '|' || emp.salary ||
            '|' || emp.commission_pct ||
            '|' || emp.manager_id ||
            '|' || emp.department_id
        );
    END LOOP;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No data found');
END;

-- 7
CREATE OR REPLACE PROCEDURE update_comm
IS 
    temp_salary employees.salary%TYPE;
BEGIN 
    FOR emp IN (SELECT * FROM employees)
    LOOP
        IF (MONTHS_BETWEEN(TRUNC(CURRENT_DATE), TRUNC(emp.hire_date)) / 12) > 2 
        THEN
            temp_salary := emp.salary + 200;
        ELSIF (MONTHS_BETWEEN(TRUNC(CURRENT_DATE), TRUNC(emp.hire_date)) / 12) < 2 
            AND (MONTHS_BETWEEN(TRUNC(CURRENT_DATE), TRUNC(emp.hire_date)) / 12) > 1 
        THEN
            temp_salary := emp.salary + 100;
        ELSIF (MONTHS_BETWEEN(TRUNC(CURRENT_DATE), TRUNC(emp.hire_date)) / 12) = 1 
        THEN
            temp_salary := emp.salary + 50;
        ELSE
            temp_salary := emp.salary;
        END IF;

        UPDATE employees
        SET salary = temp_salary WHERE employee_id = emp.employee_id;
    END LOOP;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No data found');
END;

-- 8
CREATE OR REPLACE PROCEDURE job_his
    (emp_id IN employees.employee_id%TYPE)
IS 
    CURSOR get_list_job_history
    IS
        SELECT * from job_history WHERE employee_id = emp_id;
BEGIN 
    FOR job_his IN get_list_job_history
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            job_his.employee_id ||
            '|' || job_his.start_date ||
            '|' || job_his.end_date ||
            '|' || job_his.job_id ||
            '|' || job_his.department_id
        );
    END LOOP;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No data found');
END;

-- Bài 2: Lệnh CREATE FUNCTION
-- 1
CREATE OR REPLACE FUNCTION sum_salary(id_department IN departments.department_id%TYPE)
RETURN employees.salary%TYPE
IS 
    total_salary employees.salary%TYPE;
BEGIN 
    SELECT SUM(salary) INTO total_salary
    FROM employees WHERE id_department = employees.department_id;
    IF total_salary IS NULL
    THEN
        RETURN 0;
    ELSE
        RETURN total_salary;
    END IF;
END;

-- 2
CREATE OR REPLACE FUNCTION name_con(id_country IN countries.country_id%TYPE)
RETURN countries.country_name%TYPE
IS
    name_country countries.country_name%TYPE;
BEGIN 
    SELECT country_name INTO name_country
    FROM countries 
    WHERE country_id = id_country;
    RETURN name_country;

    EXCEPTION 
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No data found');
END;

-- 3
CREATE OR REPLACE FUNCTION annual_comp(
    input_salary IN employees.salary%TYPE, 
    input_comp IN employees.commission_pct%TYPE
)
RETURN NUMBER
IS 
    output_comp NUMBER;
BEGIN 
    IF input_salary IS NULL THEN
        RETURN 0;
    END IF;
    IF input_comp IS NULL THEN
        output_comp := input_salary * 12;
    ELSE
        output_comp := input_salary * 12 + (input_comp * input_salary * 12);
    END IF;
    RETURN output_comp;
END;

-- 4
CREATE OR REPLACE FUNCTION avg_salary(
    input_department_id IN employees.employee_id%TYPE
)
RETURN employees.salary%TYPE
IS
    output_average employees.salary%TYPE;
BEGIN 
    SELECT AVG(salary) INTO output_average
    FROM employees
    WHERE department_id = input_department_id;
    
    IF output_average IS NULL THEN
        RETURN 0;
    ELSE
        RETURN output_average;
    END IF;
END;

-- 5
CREATE OR REPLACE FUNCTION time_work(
    input_emp_id IN employees.employee_id%TYPE
)
RETURN NUMBER
IS 
    output NUMBER;
    temp_emp employees%ROWTYPE;
BEGIN 
    SELECT * INTO temp_emp
    FROM employees
    WHERE employee_id = input_emp_id;

    output := MONTHS_BETWEEN(TRUNC(CURRENT_DATE), TRUNC(temp_emp.hire_date));
    RETURN output;

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No data found');
END;

-- Bài 3: Lệnh CREATE TRIGGER
-- 1
CREATE OR REPLACE TRIGGER date_hire_emp
BEFORE INSERT OR UPDATE
    ON employees
    FOR EACH ROW
DECLARE
BEGIN 
    IF TRUNC(:new.hire_date) > TRUNC(CURRENT_DATE)
    THEN
        RAISE_APPLICATION_ERROR(-20000, 'hire_date cannot be greater than current date');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Success');
    END IF;
END;

-- 2
CREATE OR REPLACE TRIGGER min_max_salary
BEFORE INSERT OR UPDATE
    ON jobs
    FOR EACH ROW
DECLARE
BEGIN
    IF :new.min_salary >= :new.max_salary 
    THEN
        RAISE_APPLICATION_ERROR(-20000, 'min_salary must be less than max_salary');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Success');
    END IF;
END;

-- 3
CREATE OR REPLACE TRIGGER start_date_job_history
BEFORE INSERT OR UPDATE 
    ON job_history
    FOR EACH ROW
DECLARE
BEGIN 
    IF TRUNC(:new.start_date) > TRUNC(:new.end_date)
    THEN
        RAISE_APPLICATION_ERROR(-20000, 'start_date cannot be greater than end_date');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Success');
    END IF;
END;

-- 4
CREATE OR REPLACE TRIGGER salary_and_comm
BEFORE UPDATE
    ON employees
    FOR EACH ROW
DECLARE
BEGIN 
    IF (:new.salary < :old.salary) OR (:new.commission_pct < :old.commission_pct)
    THEN
        RAISE_APPLICATION_ERROR(-20000, 'salary and comission_pct cannot be less than old ones');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Success');
    END IF;
END;