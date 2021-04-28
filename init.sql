CREATE DATABASE IF NOT EXISTS connect_test;
USE connect_test;

CREATE TABLE IF NOT EXISTS user (
  id serial NOT NULL PRIMARY KEY,
  name varchar(100),
  email varchar(200),
  department varchar(200),
  modified timestamp default CURRENT_TIMESTAMP NOT NULL,
  INDEX `modified_index` (`modified`)
);

INSERT INTO user (name, email, department) VALUES ('alice', 'alice@abc.com', 'engineering');
INSERT INTO user (name, email, department) VALUES ('bob', 'bob@abc.com', 'sales');
INSERT INTO user (name, email, department) VALUES ('bob', 'bob@abc.com', 'sales');
INSERT INTO user (name, email, department) VALUES ('bob', 'bob@abc.com', 'sales');
INSERT INTO user (name, email, department) VALUES ('bob', 'bob@abc.com', 'sales');
INSERT INTO user (name, email, department) VALUES ('bob', 'bob@abc.com', 'sales');
INSERT INTO user (name, email, department) VALUES ('bob', 'bob@abc.com', 'sales');
INSERT INTO user (name, email, department) VALUES ('bob', 'bob@abc.com', 'sales');
INSERT INTO user (name, email, department) VALUES ('bob', 'bob@abc.com', 'sales');
INSERT INTO user (name, email, department) VALUES ('bob', 'bob@abc.com', 'sales');
