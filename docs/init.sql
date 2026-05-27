CREATE DATABASE IF NOT EXISTS horse_racing_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE horse_racing_db;

CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255),
    role ENUM('ADMIN', 'HORSE_OWNER', 'JOCKEY', 'REFEREE', 'SPECTATOR') NOT NULL DEFAULT 'SPECTATOR',
    license_number VARCHAR(50),
    experience_years INT,
    weight DECIMAL(5,2),
    is_active BOOLEAN DEFAULT TRUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE horses (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    breed VARCHAR(50),
    age INT,
    gender ENUM('MALE', 'FEMALE') NOT NULL,
    weight DECIMAL(6,2),
    status ENUM('ACTIVE', 'INJURED', 'RETIRED') DEFAULT 'ACTIVE',
    description TEXT,
    owner_id BIGINT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE tournaments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    location VARCHAR(200),
    status ENUM('UPCOMING', 'REGISTRATION_OPEN', 'ONGOING', 'COMPLETED', 'CANCELLED') DEFAULT 'UPCOMING',
    prize_pool DECIMAL(15,2) DEFAULT 0,
    max_participants INT DEFAULT 20,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE races (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    race_number INT NOT NULL,
    tournament_id BIGINT NOT NULL,
    race_datetime DATETIME NOT NULL,
    distance DECIMAL(8,2) NOT NULL,
    track_type VARCHAR(50),
    status ENUM('SCHEDULED', 'IN_PROGRESS', 'FINISHED', 'CANCELLED') DEFAULT 'SCHEDULED',
    weather VARCHAR(50),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (tournament_id) REFERENCES tournaments(id) ON DELETE CASCADE
);

CREATE TABLE registrations (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    tournament_id BIGINT NOT NULL,
    horse_id BIGINT NOT NULL,
    jockey_id BIGINT,
    owner_id BIGINT NOT NULL,
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('PENDING', 'APPROVED', 'REJECTED') DEFAULT 'PENDING',
    entry_fee DECIMAL(10,2) DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (tournament_id) REFERENCES tournaments(id),
    FOREIGN KEY (horse_id) REFERENCES horses(id),
    FOREIGN KEY (jockey_id) REFERENCES users(id),
    FOREIGN KEY (owner_id) REFERENCES users(id)
);

CREATE TABLE race_results (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    race_id BIGINT NOT NULL,
    horse_id BIGINT NOT NULL,
    jockey_id BIGINT NOT NULL,
    position INT,
    finish_time TIME,
    status ENUM('PENDING', 'CONFIRMED', 'DISQUALIFIED') DEFAULT 'PENDING',
    notes TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (race_id) REFERENCES races(id),
    FOREIGN KEY (horse_id) REFERENCES horses(id),
    FOREIGN KEY (jockey_id) REFERENCES users(id)
);

CREATE TABLE bets (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    race_id BIGINT NOT NULL,
    horse_id BIGINT NOT NULL,
    bet_amount DECIMAL(12,2) NOT NULL,
    bet_type VARCHAR(20) DEFAULT 'WIN',
    odds DECIMAL(8,2),
    status ENUM('PENDING', 'WON', 'LOST', 'CANCELLED') DEFAULT 'PENDING',
    payout DECIMAL(12,2) DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (race_id) REFERENCES races(id),
    FOREIGN KEY (horse_id) REFERENCES horses(id)
);

CREATE TABLE prizes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    tournament_id BIGINT,
    race_id BIGINT,
    position INT NOT NULL,
    prize_amount DECIMAL(12,2) NOT NULL,
    winner_id BIGINT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (tournament_id) REFERENCES tournaments(id),
    FOREIGN KEY (race_id) REFERENCES races(id),
    FOREIGN KEY (winner_id) REFERENCES users(id)
);

CREATE TABLE revenue_reports (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    report_date DATE NOT NULL,
    total_bets DECIMAL(15,2) DEFAULT 0,
    total_prizes DECIMAL(15,2) DEFAULT 0,
    revenue DECIMAL(15,2) DEFAULT 0,
    tournament_id BIGINT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (tournament_id) REFERENCES tournaments(id)
);

INSERT INTO users (username, email, password, full_name, role) VALUES
('admin', 'admin@horseracing.com', '$2a$10$dummyhashforbcryptpasswordencoding', 'System Admin', 'ADMIN');
