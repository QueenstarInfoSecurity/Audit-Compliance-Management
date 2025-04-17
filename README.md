# Audit-Compliance-Management
A simple SQL-based system designed to manage user records while ensuring transparency and tranceability through an audit logging mechanism. This project demonstrates how to automatically log INSERT, UPDATE and DELETE actions using triggers and maintain a clear change for compliance auditing purpose.

# Project Structure
This database includes the following components:

### 1. **Database Creation**
```sql
CREATE DATABASE audit_compliance_management;
USE audit_compliance_management;
```

### 2. **Tables**

#### Users Table
Stores basic user details such as name, email, phone number, and timestamps for creation and updates.
```sql
CREATE TABLE  IF NOT EXISTS Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```
#### Auditlog Table
Captures a history of actions performed on the `Users` table including what was changed, who performed the action, and when.
```sql
CREATE TABLE  IF NOT EXISTS AuditLog (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    action VARCHAR(50),           
    user_id INT,                  
    old_data TEXT,                
    new_data TEXT,                
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  
    user_actioned_by VARCHAR(100) 
);
```
### 3. **Sample Data**

#### Users
Insert samples into the system.
```sql
INSERT INTO Users (name, email, phone_number) VALUES
('Ali John', 'ali.john@example.com', '1234567890'),

('Brade Ymith', 'brade.ymith@example.com', '2345678901'),

('Charly Border', 'charly.border@example.com', '3456789012');
```

#### Audit Logs
Includes example records representing historical user actions.
```sql
INSERT INTO AuditLog (action, user_id, old_data, new_data, user_actioned_by)
VALUES 
('INSERT', 101, NULL, '{"name": "Johnny Giol", "email": "john@example.com"}', 'admin'),

('UPDATE', 102, '{"name": "Brade Ymith", "email": "brade.old@example.com"}', '{"name": "Brade Ymith", "email": "brade.new@example.com"}', 'editor'),

('DELETE', 103, '{"name": "Tom Hardy", "email": "tom@example.com"}', NULL, 'admin');
```

### 4. **Triggers**
#### After Insert Trigger
Automatically logs user creation with key details.
```sql
CREATE TRIGGER after_user_insert
AFTER INSERT ON Users
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (action, user_id, new_data, user_actioned_by)
    VALUES ('INSERT', NEW.user_id, CONCAT('Name: ', NEW.name, ', Email: ', NEW.email, ', Phone: ', NEW.phone_number), USER());
END;
```

#### After Update Trigger
Captures the before and after state when a user record is updated.
```sql
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
```

## Features
- Robust **user management**
- Transparent **audit trail** with detailed change history
- Automatic logging via **SQL triggers**
- User-friendly schema and structure

## Getting Started
1. Copy and run the SQL script in a MySQL-compatible environment.
2. Perform user insert/update operations and observe auto-generated logs in the `AuditLog` table.

## Use Cases
- Regulatory and Compliance tracking
- Security audits
- Internal system change monitoring
- Data integrity and traceability

## Future Improvement
- Role-based access control
- Web-based front-end dashboard
- Advanced filtering and reporting on audit logs
- Email notifications on critical actions


## License
  Licensed under the MIT lincense.
