-- INDEX 확인
SHOW INDEX FROM employees;

-- 0.031초(INDEX 생성 전)
SELECT * FROM employees WHERE `name` = '주정웅';

-- INDEX 생성
ALTER TABLE employees
ADD INDEX idx_employees_name (`name`) -- 이름(컬럼명)
;

-- 0.000초 (INDEX 생성 후)
SELECT * FROM employees WHERE `name` = '주정웅';

-- INDEX 삭제
ALTER TABLE employees
DROP INDEX idx_employees_name
;