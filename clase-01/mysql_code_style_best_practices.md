# ✅ MySQL Code Style & Best Practices

## 1. Naming Conventions ✅

### 🔸 Tables
- Use **snake_case**, plural nouns:
  ```sql
  CREATE TABLE users;
  CREATE TABLE user_profiles;
  ```

### 🔸 Columns
- Also use **snake_case**, singular, descriptive:
  ```sql  
  user_id, created_at, email_address
  ```

### 🔸 Primary & Foreign Keys
- Use `id` for primary key  
- Use `[referenced_table]_id` for foreign keys:
  ```sql
  user_id INT,
  FOREIGN KEY (user_id) REFERENCES users(id)
  ```

---
## 2. SQL Keywords ✅
- Write SQL **keywords** in `UPPERCASE` (e.g., `SELECT`, `FROM`, `WHERE`)
- Write **table and column names** in `lowercase` using snake_case
  ```sql
  SELECT id, name FROM users WHERE active = 1;
  ```

## 3. Formatting Style ✅
- Use indentation and line breaks for readability:
  ```sql
  SELECT
      u.id,
      u.name,
      p.bio
  FROM
      users u
      JOIN profiles p ON u.id = p.user_id
  WHERE
      u.active = 1;
  ```

## 4. Data Types ✅
- Prefer appropriate data types:
  - Use INT or BIGINT for IDs.
  - Use VARCHAR(N) with a reasonable length for text.
  - Use DATETIME or TIMESTAMP for date/time.
  - Use BOOLEAN (alias of TINYINT(1)) for true/false.
  - Avoid `ENUM` and `SET` types — prefer lookup tables or constants in code

## 5. Indexes ✅
- Index foreign keys and commonly queried fields:
  ```sql
  CREATE INDEX idx_users_email ON users(email);
  ```
- Do not index columns with low cardinality (e.g., `active`, `is_deleted`) unless they are in composite indexes

## 6. Constraints ✅
- Always use constraints to ensure data integrity:
  - `PRIMARY KEY`: uniquely identifies each row
  - `FOREIGN KEY`: enforces relationships between tables
  - `NOT NULL`: avoids unexpected NULLs
  - `UNIQUE`: prevents duplicate values
  ```sql
  CREATE TABLE users (
      id INT PRIMARY KEY AUTO_INCREMENT,
      email VARCHAR(255) UNIQUE NOT NULL,
      created_at DATETIME NOT NULL
  );
  ```

## 7. Avoid SELECT * ✅
Using `SELECT *` can break apps when columns are added, and may load unnecessary data.
- Always specify columns explicitly:
  ```sql
  SELECT id, name FROM users;
  ```

## 8. Use Aliases Clearly ✅

Use `AS` for readability, even though it's optional in MySQL.

- Bad:
  ```sql
  SELECT a.id, b.name
  FROM users a
  JOIN orders b ON a.id = b.user_id;
  ```
  
- Better:
  ```sql
  SELECT
      users.id,
      orders.name
  FROM
      users
  JOIN
      orders ON users.id = orders.user_id;
  ```
  
- Best:
  ```sql
  SELECT
      u.id AS user_id,
      u.email,
      o.id AS order_id,
      o.total
  FROM
      users AS u
  JOIN
      orders AS o ON u.id = o.user_id
  WHERE
      o.status = 'confirmed';
  ```

## 9. Comment Your Code ✅

- Use comments for complex queries:
  ```sql
  -- Get active users with profile bio
  SELECT u.id, p.bio
  FROM users u
  JOIN profiles p ON u.id = p.user_id
  WHERE u.active = 1;
  ```

## 10. Safe Practices ✅
- Wrap DELETE and UPDATE with WHERE clauses:
  ```sql
  DELETE FROM users WHERE id = 123;
  ```

- Use LIMIT for test queries:
  ```sql
  SELECT * FROM users LIMIT 10;
  ```

## 11. Bonus Tips ✅
- Keep your SQL scripts in version control (e.g., Git)
- Use transactions when updating multiple related tables
  ```sql
  START TRANSACTION;
  UPDATE accounts SET balance = balance - 100 WHERE id = 1;
  UPDATE accounts SET balance = balance + 100 WHERE id = 2;
  COMMIT;
  ```

---

## ✅ Final Thoughts

Following a consistent MySQL coding style improves:
- Readability
- Maintainability
- Collaboration
- Query performance

Stick to these practices across projects to build clean, safe, and efficient database systems.
