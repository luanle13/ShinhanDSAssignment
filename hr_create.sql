CREATE TABLE countries
(
    country_id CHAR(2) NOT NULL,
    country_name VARCHAR2(40),
    region_id NUMBER,
    CONSTRAINT countries_pk PRIMARY KEY (country_id)
);

CREATE TABLE departments
(
    department_id NUMBER(4) NOT NULL,
    department_name VARCHAR2(30) NOT NULL,
    manager_id NUMBER(6),
    location_id NUMBER(4),
    CONSTRAINT departments_pk PRIMARY KEY (department_id)
);

CREATE TABLE employees
(
    employee_id NUMBER(6) NOT NULL,
    first_name VARCHAR2(20),
    last_name VARCHAR2(25) NOT NULL,
    email VARCHAR2(25) NOT NULL,
    phone_number VARCHAR2(20),
    hire_date DATE NOT NULL,
    job_id VARCHAR2(10) NOT NULL,
    salary NUMBER(8,2),
    commission_PCT NUMBER(2,2),
    manager_id NUMBER(6),
    department_id NUMBER(4),
    CONSTRAINT employees_pk PRIMARY KEY (employee_id)
);

CREATE TABLE jobs
(
    job_id VARCHAR2(10) NOT NULL,
    job_title VARCHAR2(35) NOT NULL,
    min_salary NUMBER(6),
    max_salary NUMBER(6),
    CONSTRAINT jobs_pk PRIMARY KEY (job_id)
);

CREATE TABLE job_history
(
    employee_id NUMBER(6) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    job_id VARCHAR2(10) NOT NULL,
    department_id NUMBER(4),
    CONSTRAINT jobhistory_pk PRIMARY KEY (employee_id, start_date)
);

CREATE TABLE locations
(
    location_id NUMBER(4) NOT NULL,
    street_address VARCHAR2(40),
    postal_code VARCHAR2(12),
    city VARCHAR2(30) NOT NULL,
    state_province VARCHAR2(25),
    country_id CHAR(2),
    CONSTRAINT locations_pk PRIMARY KEY (location_id)
);

CREATE TABLE regions
(
    region_id NUMBER(4) NOT NULL,
    region_name VARCHAR2(25),
    CONSTRAINT regions_pk PRIMARY KEY (region_id)
);

ALTER TABLE countries 
ADD CONSTRAINT countries_regions_fk 
    FOREIGN KEY (region_id) 
    REFERENCES regions (region_id);

ALTER TABLE locations
ADD CONSTRAINT locations_countries_fk
    FOREIGN KEY (country_id)
    REFERENCES countries (country_id);

ALTER TABLE departments
ADD CONSTRAINT departments_locations_fk
    FOREIGN KEY (location_id)
    REFERENCES locations (location_id);

ALTER TABLE departments
ADD CONSTRAINT departments_employees_fk
    FOREIGN KEY (manager_id)
    REFERENCES employees (employee_id);

ALTER TABLE employees
ADD CONSTRAINT employees_employees_fk
    FOREIGN KEY (manager_id)
    REFERENCES employees (employee_id);

ALTER TABLE employees
ADD CONSTRAINT employees_departments_fk
    FOREIGN KEY (department_id)
    REFERENCES departments (department_id);

ALTER TABLE employees
ADD CONSTRAINT employees_jobs_fk
    FOREIGN KEY (job_id)
    REFERENCES jobs (job_id);

ALTER TABLE job_history
ADD CONSTRAINT jobshistory_jobs_fk
    FOREIGN KEY (job_id)
    REFERENCES jobs (job_id);

ALTER TABLE job_history
ADD CONSTRAINT jobshistory_departments_fk
    FOREIGN KEY (department_id)
    REFERENCES departments (department_id);

ALTER TABLE job_history
ADD CONSTRAINT jobhistory_employees_fk
    FOREIGN KEY (employee_id)
    REFERENCES employees (employee_id);