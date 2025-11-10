-- 2025-11-07 정선민_DB_문제.hwp 파일 참고

-- 1. 모든 직원의 이름과 입사일을 조회하세요.
SELECT
	`name`
	,hire_at
FROM employees
ORDER BY `name`, hire_at ASC
;

-- 2. 'd005' 부서에 속한 모든 직원의 직원 ID를 조회하세요.
-- 나
SELECT
	emp_id
FROM department_emps
WHERE
	dept_code = 'D005'
	AND end_at IS NULL
ORDER BY emp_id ASC
;
-- 선생님
SELECT
	depe.emp_id
FROM department_emps depe
	JOIN employees emp
		ON depe.emp_id = emp.emp_id
		AND emp.fire_at IS NULL
WHERE
	depe.end_at IS NULL
	AND depe.dept_code = 'D005'
;

-- 3. 1995년 1월 1일 이후에 입사한 모든 직원의 정보를
-- 입사일 순서대로 정렬하여 조회하세요.
SELECT
	*
FROM employees
WHERE
	hire_at >= '1995-01-01'
ORDER BY hire_at ASC
;

-- 4. 각 부서별로 몇 명의 직원이 있는지 계산하고,
-- 직원 수가 많은 부서부터 순서대로 보여주세요.
SELECT
	dept_code
-- ,COUNT(dept_code) AS count_dept_emp -- 나
	,COUNT(*) AS count_dept_emp -- 선생님('*' 사용하는게 더 안전함)
-- 	()안에 *면 null포함, 특정컬럼이면 null미포함
FROM department_emps
WHERE
	end_at IS NULL
GROUP BY dept_code
ORDER BY count_dept_emp DESC
;

-- 5. 각 직원의 현재 연봉 정보를 조회하세요.
SELECT
	emp_id
	,salary
FROM salaries
WHERE
	end_at IS NULL
ORDER BY emp_id ASC
;

-- 6. 각 직원의 이름과 해당 직원의 현재 부서 이름을 함께 조회하세요.
SELECT
	emp.`name`
	,dep.dept_name
FROM employees AS emp
	JOIN department_emps AS dep_emp
		ON emp.emp_id = dep_emp.emp_id
			AND emp.fire_at IS NULL
			AND dep_emp.end_at IS NULL
	JOIN departments AS dep
		ON dep_emp.dept_code = dep.dept_code
		AND dep.end_at IS NULL -- 부서명이 변경되는 등의 경우가 발생할 수 있음
ORDER BY emp.emp_id ASC
;

-- 7. '마케팅부' 부서의 현재 매니저의 이름을 조회하세요.
SELECT
	emp.`name`
FROM departments AS dep
	JOIN department_managers AS dep_mng
		ON dep.dept_code = dep_mng.dept_code
			AND dep.dept_name = '마케팅부'
			AND dep.end_at IS NULL -- 선생님
			AND dep_mng.end_at IS NULL
	JOIN employees AS emp
		ON dep_mng.emp_id = emp.emp_id
			AND emp.fire_at IS NULL
;

-- 8. 현재 재직 중인 각 직원의 이름, 성별, 직책(title)을 조회하세요.
SELECT
	emp.`name`
	,emp.gender
	,tit.title
FROM employees AS emp
	JOIN title_emps AS tit_emp
		ON emp.emp_id = tit_emp.emp_id
			AND emp.fire_at IS NULL
			AND tit_emp.end_at IS NULL
	JOIN titles AS tit
		ON tit.title_code = tit_emp.title_code
ORDER BY emp.`name` ASC
;

-- 9. 현재 가장 높은 연봉을 받는 상위 5명의 직원 ID와 연봉을 조회하세요.
SELECT
	sal.emp_id
	,sal.salary
FROM employees AS emp
	JOIN salaries AS sal
		ON emp.emp_id = sal.emp_id
			AND emp.fire_at IS NULL
			AND sal.end_at IS NULL
ORDER BY sal.salary DESC
LIMIT 5
;

-- 10. 각 부서의 현재 평균 연봉을 계산하고, 평균 연봉이 6000만 이상인 부서만 조회하세요.
SELECT
	dep_emp.dept_code
	,AVG(sal.salary) AS avg_sal
FROM department_emps AS dep_emp
	JOIN salaries AS sal
		ON dep_emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
			AND dep_emp.end_at IS NULL
GROUP BY dep_emp.dept_code
	HAVING avg_sal >= 60000000
;

-- 실제 시험에서는 프로그램없이 연필로 직접 작성해야 함.
-- 실제 시험에서는 문제에서 요구한 것만 작성해야 함.

-- 11. 아래 구조의 테이블을 작성하는 SQL을 작성해 주세요.
-- USE mydb; -- 문제에서 요구하지 않음
CREATE TABLE users(
	userid INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
	,username VARCHAR(30) NOT NULL
	,authflg CHAR(1) DEFAULT '0'
	,birthday DATE NOT NULL
	,created_at DATETIME DEFAULT CURRENT_TIMESTAMP()
);

-- 12. 위에서 만든 테이블에 아래 데이터를 입력해 주세요.
-- 나
INSERT INTO users(
	username
	,birthday
)
VALUES(
	'그린'
	,'2024-01-26'
);
-- 선생님
-- 시험에서는 default값도 작성해줘야 함.
INSERT INTO users(
	username
	,authflg
	,birthday
	,created_at
)
VALUES(
	'그린'
	,'0'
	,'2024-01-26'
	,NOW()
);

-- 13. 위에서 만든 레코드를 아래 데이터로 갱신해 주세요.
UPDATE users
SET
	username = '테스터'
	,authflg = '1'
	,birthday = '2007-03-01'
WHERE
	userid = 1 -- pk로 주기
;

-- 14. 12에서 만든 레코드를 삭제해 주세요.
DELETE FROM users
WHERE
	userid = 1
;

-- 15. 11에서 만든 테이블에 아래 Column을 추가해 주세요.
ALTER TABLE users
ADD COLUMN addr VARCHAR(100) NOT NULL DEFAULT '-'
;

-- 16. 11에서 만든 테이블을 삭제해 주세요.
DROP TABLE users;

-- 17.아래 테이블에서 유저명, 생일, 랭크명을 출력해 주세요.
-- 문제에서 요구하지 않음
-- USE mydb;
-- 
-- CREATE TABLE users(
-- 	userid INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
-- 	,username VARCHAR(30) NOT NULL
-- 	,authflg CHAR(1) DEFAULT '0'
-- 	,birthday DATE NOT NULL
-- 	,created_at DATETIME DEFAULT CURRENT_TIMESTAMP()
-- );
-- 
-- CREATE TABLE rankmanagement(
-- 	rankid INT UNSIGNED PRIMARY KEY AUTO_INCREMENT
-- 	,userid INT UNSIGNED NOT NULL
-- 	,rankname VARCHAR(10) NOT NULL
-- );
-- 
-- ALTER TABLE rankmanagement
-- ADD CONSTRAINT fk_rankmanagement_userid
-- FOREIGN KEY (userid)
-- REFERENCES users(userid)
-- ;
-- 
-- INSERT INTO users(
-- 	username
-- 	,birthday
-- )
-- VALUES(
-- 	'green'
-- 	,'2024-01-26'
-- );
-- 
-- INSERT INTO rankmanagement(
-- 	userid
-- 	,rankname
-- )
-- VALUES(
-- 	1
-- 	,'manager'
-- );

SELECT
	users.username
	,users.birthday
	,rankmanagement.rankname
FROM users
	JOIN rankmanagement
		ON users.userid = rankmanagement.userid
;