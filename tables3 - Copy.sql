create database project;
use project;

CREATE TABLE `project`.`student` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email_id` VARCHAR(45) NOT NULL,
  `PRN` VARCHAR(45) NOT NULL,
  `phone_no` VARCHAR(45) NOT NULL,
  `coordinator_id` VARCHAR(45) NOT NULL,
  `dob` DATE NOT NULL,
  `address` INT NULL,
  PRIMARY KEY (`student_id`));

CREATE TABLE `project`.`calender` (
  `calender_date` DATE NOT NULL,
  `week_number` INT NOT NULL,
  `day_of_week` INT NOT NULL,
  PRIMARY KEY (`calender_date`));

CREATE TABLE `project`.`coordinator` (
  `coordinator_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `phone_no` INT NOT NULL,
  `email_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`coordinator_id`));

CREATE TABLE `project`.`address` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `line_1` VARCHAR(45) NOT NULL,
  `line_2` VARCHAR(45) NULL,
  `landmark` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `pincode` INT NOT NULL,
  PRIMARY KEY (`address_id`));


ALTER TABLE `project`.`student` 
ADD INDEX `address_id_idx` (`address` ASC) VISIBLE;
;
ALTER TABLE `project`.`student` 
ADD CONSTRAINT `address_id`
  FOREIGN KEY (`address`)
  REFERENCES `project`.`address` (`address_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


CREATE TABLE `project`.`faculty` (
  `faculty_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email_id` VARCHAR(45) NOT NULL,
  `phone_no` INT NOT NULL,
  `subject_id` INT NOT NULL,
  PRIMARY KEY (`faculty_id`));


CREATE TABLE `project`.`course` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NOT NULL,
  `faculty_id` INT NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `student_id`
    FOREIGN KEY (`student_id`)
    REFERENCES `project`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


ALTER TABLE `project`.`course` 
ADD INDEX `faculty_id_idx` (`faculty_id` ASC) VISIBLE;
;
ALTER TABLE `project`.`course` 
ADD CONSTRAINT `faculty_id`
  FOREIGN KEY (`faculty_id`)
  REFERENCES `project`.`faculty` (`faculty_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


CREATE TABLE `project`.`notice` (
  `notice_id` INT NOT NULL AUTO_INCREMENT,
  `coordinator_id` INT NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`notice_id`),
  INDEX `coordinator_id_idx` (`coordinator_id` ASC) VISIBLE,
  CONSTRAINT `coordinator_id`
    FOREIGN KEY (`coordinator_id`)
    REFERENCES `project`.`coordinator` (`coordinator_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE `project`.`subject` (
  `subject_id` INT NOT NULL AUTO_INCREMENT,
  `subject_name` VARCHAR(45) NOT NULL,
  `theory_marks` INT NOT NULL,
  `practical_marks` INT NOT NULL,
  `faculty_id` INT NOT NULL,
  PRIMARY KEY (`subject_id`),
  INDEX `faculty_id_idx` (`faculty_id` ASC) VISIBLE,
  CONSTRAINT ``
    FOREIGN KEY (`faculty_id`)
    REFERENCES `project`.`faculty` (`faculty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


ALTER TABLE `project`.`faculty` 
ADD CONSTRAINT `faculty_subject_id`
  FOREIGN KEY (`subject_id`)
  REFERENCES `project`.`subject` (`subject_id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

CREATE TABLE `project`.`syllabus` (
  `syllabus_id` INT NOT NULL AUTO_INCREMENT,
  `subject_id` INT NOT NULL,
  `topic_id` INT NOT NULL,
  `topic_name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`syllabus_id`),
  INDEX `subject_id_idx` (`subject_id` ASC) VISIBLE,
  CONSTRAINT `subject_id`
    FOREIGN KEY (`subject_id`)
    REFERENCES `project`.`subject` (`subject_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE `project`.`schedule` (
  `schedule_id` INT NOT NULL AUTO_INCREMENT,
  `subject_id` INT NOT NULL,
  `calender_date` DATE NOT NULL,
  `start_time` TIME NOT NULL,
  `end_time` TIME NOT NULL,
  `faculty_id` INT NOT NULL,
  `link` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`schedule_id`),
  INDEX `subject_id_idx` (`subject_id` ASC) VISIBLE,
  INDEX `faculty_id_idx` (`faculty_id` ASC) VISIBLE,
  INDEX `calender_date_idx` (`calender_date` ASC) VISIBLE,
  CONSTRAINT `schedule_subject_id`
    FOREIGN KEY (`subject_id`)
    REFERENCES `project`.`subject` (`subject_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `schedule_faculty_id`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `project`.`faculty` (`faculty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `schedule_calender_date`
    FOREIGN KEY (`calender_date`)
    REFERENCES `project`.`calender` (`calender_date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

ALTER TABLE `project`.`syllabus` 
DROP PRIMARY KEY,
ADD PRIMARY KEY (`syllabus_id`, `topic_id`);
;


CREATE TABLE `project`.`quiz` (
  `quiz_id` INT NOT NULL AUTO_INCREMENT,
  `question` VARCHAR(200) NOT NULL,
  `answer` VARCHAR(45) NOT NULL,
  `option_1` VARCHAR(45) NOT NULL,
  `option_2` VARCHAR(45) NOT NULL,
  `option_3` VARCHAR(45) NOT NULL,
  `option_4` VARCHAR(45) NOT NULL,
  `topic_id` INT NOT NULL,
  PRIMARY KEY (`quiz_id`),
  INDEX `topic_id_idx` (`topic_id` ASC) VISIBLE,
  CONSTRAINT `topic_id`
    FOREIGN KEY (`topic_id`)
    REFERENCES `project`.`syllabus` (`syllabus_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
