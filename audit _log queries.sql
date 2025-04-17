SELECT * FROM audit_compliance_management.auditlog;
INSERT INTO Users (name, email, phone_number) -- Testing the triggers
VALUES ('Alu Hoty', 'alu@example.com', '1234567890');

-- verifying the table if it has recoreded the insert
SELECT * FROM AuditLog WHERE action = 'INSERT' ORDER BY timestamp DESC;  

-- updating record 
SELECT * FROM audit_compliance_management.auditlog;
UPDATE Users
SET email = 'alu.hoty@example.com'
WHERE name = 'Alu Hoty';

-- Deleting user 
SELECT * FROM audit_compliance_management.auditlog;
DELETE FROM Users
WHERE user_id = 1;

SELECT * FROM AuditLog ORDER BY timestamp DESC;

-- Generating  report of all changes made by a specific user
SELECT * FROM AuditLog
WHERE user_actioned_by = 'admin'  
ORDER BY timestamp DESC;

-- Generating report of changes over a specific period 
SELECT * FROM AuditLog
WHERE timestamp BETWEEN '2023-09-01' AND '2023-09-30'
ORDER BY timestamp DESC;

GRANT audit_reader TO 'root'@'localhost';
SET ROLE audit_reader;
SELECT * FROM INFORMATION_SCHEMA.APPLICABLE_ROLES WHERE GRANTEE = "'root'@'localhost'";






