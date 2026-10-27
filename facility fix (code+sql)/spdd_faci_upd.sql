-- SPDD FACI UPD - University Facility Issue Reporting System
-- Import this file in phpMyAdmin (XAMPP). It matches config.php.
-- Database: spdd_faci_upd

CREATE DATABASE IF NOT EXISTS spdd_faci_upd
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE spdd_faci_upd;

CREATE TABLE IF NOT EXISTS departments (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  description VARCHAR(255) DEFAULT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_departments_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS categories (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  description VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_categories_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(120) NOT NULL,
  username VARCHAR(60) NOT NULL,
  email VARCHAR(160) NOT NULL,
  phone VARCHAR(30) DEFAULT NULL,
  password VARCHAR(255) NOT NULL,
  role ENUM('student','teacher','admin','department') NOT NULL DEFAULT 'student',
  department_id INT UNSIGNED DEFAULT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_users_username (username),
  UNIQUE KEY uq_users_email (email),
  KEY idx_users_department (department_id),
  CONSTRAINT fk_users_department FOREIGN KEY (department_id)
    REFERENCES departments(id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS issues (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id INT UNSIGNED NOT NULL,
  category_id INT UNSIGNED NOT NULL,
  department_id INT UNSIGNED DEFAULT NULL,
  title VARCHAR(150) NOT NULL,
  description TEXT NOT NULL,
  building VARCHAR(120) NOT NULL,
  floor VARCHAR(60) NOT NULL,
  room VARCHAR(80) NOT NULL,
  photo VARCHAR(255) DEFAULT NULL,
  priority ENUM('Low','Medium','High') NOT NULL DEFAULT 'Medium',
  status ENUM('Pending','Assigned','In Progress','Resolved') NOT NULL DEFAULT 'Pending',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_issues_status (status),
  KEY idx_issues_user (user_id),
  KEY idx_issues_category (category_id),
  KEY idx_issues_department (department_id),
  CONSTRAINT fk_issues_user FOREIGN KEY (user_id)
    REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_issues_category FOREIGN KEY (category_id)
    REFERENCES categories(id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_issues_department FOREIGN KEY (department_id)
    REFERENCES departments(id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS issue_status_history (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  issue_id INT UNSIGNED NOT NULL,
  status ENUM('Pending','Assigned','In Progress','Resolved') NOT NULL,
  note TEXT DEFAULT NULL,
  updated_by INT UNSIGNED DEFAULT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_history_issue (issue_id),
  KEY idx_history_user (updated_by),
  CONSTRAINT fk_history_issue FOREIGN KEY (issue_id)
    REFERENCES issues(id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_history_user FOREIGN KEY (updated_by)
    REFERENCES users(id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS reviews (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  issue_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  rating TINYINT UNSIGNED NOT NULL,
  comment VARCHAR(1000) DEFAULT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_reviews_issue (issue_id),
  KEY idx_reviews_user (user_id),
  CONSTRAINT chk_reviews_rating CHECK (rating BETWEEN 1 AND 5),
  CONSTRAINT fk_reviews_issue FOREIGN KEY (issue_id)
    REFERENCES issues(id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_reviews_user FOREIGN KEY (user_id)
    REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO departments (name, description) VALUES
 ('Electrical', 'Electrical equipment, lighting and wiring'),
 ('Plumbing', 'Water supply, taps and drainage'),
 ('IT Support', 'Network, Wi-Fi and computer support'),
 ('Civil Maintenance', 'Building, doors, windows and furniture maintenance'),
 ('Cleaning', 'Cleaning and sanitation')
ON DUPLICATE KEY UPDATE description = VALUES(description);

INSERT INTO categories (name, description) VALUES
 ('Electrical', 'Lights, fans and wiring'),
 ('Plumbing', 'Water and drainage'),
 ('Furniture', 'Chairs, desks and fixtures'),
 ('Network / IT', 'Network and computer problems'),
 ('Cleaning', 'Cleaning and sanitation'),
 ('Building / Civil', 'Building maintenance'),
 ('Other', 'Other facility issues')
ON DUPLICATE KEY UPDATE description = VALUES(description);

-- Admin and department login accounts are generated by index.php on first visit.
-- Default local demo credentials are listed in README.txt.
