CREATE DATABASE IF NOT EXISTS employee_db;
USE employee_db;

CREATE TABLE IF NOT EXISTS employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

INSERT INTO employees (name, position, salary) VALUES ('John Doe', 'Engineer', 70000.00);
INSERT INTO employees (name, position, salary) VALUES ('Jane Smith', 'Manager', 90000.00);

CREATE USER 'db_user'@'127.0.0.1' IDENTIFIED BY 'Passw0rd';
GRANT ALL PRIVILEGES ON employee_db.* TO 'db_user'@'127.0.0.1';
FLUSH PRIVILEGES;