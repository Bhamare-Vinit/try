use workbench;
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (id, name, department, salary) VALUES
(1, 'Vinit', 'IT', 100000),
(2, 'Harsh', 'Engineering', 75000),
(3, 'Sanket', 'Engineering', 72000),
(4, 'Om', 'IT', 165000);

DELIMITER //
-- DECLARE CONTINUE HANDLER FOR SQLEXCEPTION specifies what to do if any SQL error occurs.
CREATE PROCEDURE insert_employee(
    IN emp_id INT,
    IN emp_name VARCHAR(100),
    IN emp_department VARCHAR(100),
    IN emp_salary DECIMAL(10, 2)
)
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Handle the exception here
        SELECT 'An error occurred!';
    END;
    -- Attempt to insert a new employee
    INSERT INTO employees (id, name, department, salary)
    VALUES (emp_id, emp_name, emp_department, emp_salary);
END //
DELIMITER ;

CALL insert_employee(1, 'Mahesh', 'Marketing', 55000);


-- Handling Duplicate Key Error
DELIMITER //
CREATE PROCEDURE insert_to_employee(
    IN emp_id INT,
    IN emp_name VARCHAR(100),
    IN emp_department VARCHAR(100),
    IN emp_salary DECIMAL(10, 2)
)
BEGIN
    DECLARE CONTINUE HANDLER FOR 1062
    BEGIN
        -- Handle duplicate key error (error code 1062)
        SELECT 'Duplicate key error occurred!';
    END;
    INSERT INTO employees (id, name, department, salary)
    VALUES (emp_id, emp_name, emp_department, emp_salary);
END //
DELIMITER ;

CALL insert_to_employee(1, 'Mahesh', 'Marketing', 55000);


-- Handling General SQL Exceptions
DELIMITER //
CREATE PROCEDURE update_employee_salary(
    IN emp_id INT,
    IN new_salary DECIMAL(10, 2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Handle the exception and roll back the transaction
        ROLLBACK;
        SELECT 'An error occurred. Transaction rolled back.';
    END;
    START TRANSACTION;
    UPDATE employees SET salary = new_salary WHERE id = emp_id;
    COMMIT;
END //
DELIMITER ;

CALL update_employee_salary(9, 70000);


-- Handling NOT FOUND Condition
DELIMITER //

CREATE PROCEDURE find_employee(
    IN emp_id INT
)
BEGIN
    DECLARE emp_count INT;

    -- Check if the employee exists
    SELECT COUNT(*) INTO emp_count FROM employees WHERE id = emp_id;

    IF emp_count = 0 THEN
        -- Handle the not found condition
        SELECT 'Employee not found!' AS message;
    ELSE
        -- Retrieve the employee details
        SELECT * FROM employees WHERE id = emp_id;
    END IF;
END //

DELIMITER ;

CALL find_employee(6);