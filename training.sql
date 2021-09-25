DROP DATABASE IF EXISTS `strength_training`;

CREATE DATABASE IF NOT EXISTS `strength_training`;

USE `strength_training`;

CREATE TABLE IF NOT EXISTS `muscles` (
    muscle_id SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    muscle_name VARCHAR(30)
)ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE utf8_spanish_ci;


CREATE TABLE IF NOT EXISTS `rutines_log` (
    rutine_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    rutine_name VARCHAR(30),
    `start_date` DATE DEFAULT (CURRENT_DATE),
    rutine_description TEXT
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE utf8_spanish_ci;


CREATE TABLE IF NOT EXISTS `movements_patterns` (
    mov_pattern_id SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    movement_name VARCHAR(50) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE utf8_spanish_ci;


CREATE TABLE IF NOT EXISTS `trainings_classifications` (
    training_class_id SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    RM_percentage DECIMAL(3, 2),
    CONSTRAINT rm_constraint CHECK(RM_percentage BETWEEN 0 AND 1),
    type_class_RIR DECIMAL(2, 1) NOT NULL,
    type_class_name VARCHAR(30) NOT NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE utf8_spanish_ci;


CREATE TABLE IF NOT EXISTS `tbl_RIR` (
    rir_id SMALLINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    RIR DECIMAL(2, 1) NOT NULL,
    rir_repetitions SMALLINT UNSIGNED NOT NULL,
    rir_percentage DECIMAL(4, 3) NOT NULL,
    CONSTRAINT rm_rir_constraint CHECK(rir_percentage BETWEEN 0 AND 1)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;


CREATE TABLE IF NOT EXISTS `exercises` (
    exercise_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    exercise_name VARCHAR(100) NOT NULL,
    muscle_id SMALLINT UNSIGNED NOT NULL,
    mov_pattern_id SMALLINT UNSIGNED NOT NULL,
    corporal_section ENUM('Core', 'Tren inferior', 'Tren superior'),
    exercise_is_compound ENUM('Aislamiento', 'Multiarticular'),
    CONSTRAINT muscle_fk FOREIGN KEY (muscle_id)
        REFERENCES `muscles` (muscle_id) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT mov_pattern_fk FOREIGN KEY (mov_pattern_id)
        REFERENCES `movements_patterns` (mov_pattern_id) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE utf8_spanish_ci;


CREATE TABLE IF NOT EXISTS `rutines_diaries` (
    diary_rutine_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `date` DATE DEFAULT (CURRENT_DATE),
    rutine_id INTEGER UNSIGNED NOT NULL,
    session_number SMALLINT UNSIGNED NOT NULL,
    diary_notes TEXT,
    CONSTRAINT rutine_fk FOREIGN KEY (rutine_id)
        REFERENCES `rutines_log` (rutine_id) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE = MyISAM DEFAULT CHARSET = utf8 COLLATE utf8_spanish_ci;


CREATE TABLE IF NOT EXISTS registers (
    register_id INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    diary_rutine_id INTEGER UNSIGNED NOT NULL,
    exercise_id INTEGER UNSIGNED NOT NULL,
    resting_time DECIMAL(4, 1),
    weight_used DECIMAL(6, 2),
    register_repetitions SMALLINT UNSIGNED,
    register_RIR DECIMAL(2, 1) DEFAULT 3,
    register_note TEXT
) ENGINE = MyISAM DEFAULT CHARSET = utf8;