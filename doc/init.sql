CREATE DATABASE review_db DEFAULT CHARACTER SET utf8mb4;

USE review_db;

CREATE TABLE test(test_id varchar(20)
				, test_pw varchar(30)
);

INSERT INTO test VALUES("a", "1234");

SELECT *
FROM test
;