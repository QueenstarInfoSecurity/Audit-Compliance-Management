
CREATE DATABASE audit_compliance_management;
USE audit_compliance_management;

CREATE TABLE  IF NOT EXISTS Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE  IF NOT EXISTS AuditLog (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    action VARCHAR(50),           
    user_id INT,                  
    old_data TEXT,                
    new_data TEXT,                
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  
    user_actioned_by VARCHAR(100) 
);
INSERT INTO Users (name, email, phone_number) VALUES
('Ali John', 'ali.john@example.com', '1234567890'),
('Brade Ymith', 'brade.ymith@example.com', '2345678901'),
('Charly Border', 'charly.border@example.com', '3456789012'),
('Dia Princes', 'dia.princes@example.com', '4567890123'),
('Ethan Hunt', 'ethan.hunt@example.com', '5678901234'),
('Fiona Galla', 'fiona.galla@example.com', '6789012345'),
('George Clooney', 'george.clooney@example.com', '7890123456'),
('Hanna Monana', 'hanna.monana@example.com', '8901234567'),
('Iva Dro', 'ivan.dro@example.com', '9012345678'),
('Julia Gost', 'julia.gost@example.com', '1234567891');

INSERT INTO AuditLog (action, user_id, old_data, new_data, user_actioned_by)
VALUES 
('INSERT', 101, NULL, '{"name": "Johnny Giol", "email": "john@example.com"}', 'admin'),
('UPDATE', 102, '{"name": "Brade Ymith", "email": "brade.old@example.com"}', '{"name": "Brade Ymith", "email": "brade.new@example.com"}', 'editor'),
('DELETE', 103, '{"name": "Tom Hardy", "email": "tom@example.com"}', NULL, 'admin'),
('INSERT', 104, NULL, '{"name": "Emmanuella Clare", "email": "emmanuella@example.com"}', 'moderator'),
('UPDATE', 105, '{"name": "Michael Brown", "email": "michael.old@example.com"}', '{"name": "Michael Brown", "email": "michael.new@example.com"}', 'admin'),
('DELETE', 106, '{"name": "Anna White", "email": "anna@example.com"}', NULL, 'editor'),
('INSERT', 107, NULL, '{"name": "Chris Evans", "email": "chris@example.com"}', 'admin'),
('UPDATE', 108, '{"name": "Natalie Portman", "email": "natalie.old@example.com"}', '{"name": "Natalie Portman", "email": "natalie.new@example.com"}', 'moderator'),
('DELETE', 109, '{"name": "Robert Downey", "email": "robert@example.com"}', NULL, 'admin'),
('INSERT', 110, NULL, '{"name": "Scarlett Johansson", "email": "scarlett@example.com"}', 'editor');

DELIMITER //
CREATE TRIGGER after_user_insert
AFTER INSERT ON Users
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (action, user_id, new_data, user_actioned_by)
    VALUES ('INSERT', NEW.user_id, CONCAT('Name: ', NEW.name, ', Email: ', NEW.email, ', Phone: ', NEW.phone_number), USER());
END;
DELIMITER ;

DELIMITER //
CREATE TRIGGER after_user_update
AFTER UPDATE ON Users
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (action, user_id, old_data, new_data, user_actioned_by)
    VALUES ('UPDATE', OLD.user_id,
            CONCAT('Old Name: ', OLD.name, ', Old Email: ', OLD.email, ', Old Phone: ', OLD.phone_number),
            CONCAT('New Name: ', NEW.name, ', New Email: ', NEW.email, ', New Phone: ', NEW.phone_number),
            USER());
END;
DELIMITER ;








