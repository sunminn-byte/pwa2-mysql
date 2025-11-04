-- JOIN 문
-- 두개 이상의 테이블을 묶어서 하나의 결과 집합으로 출력



-- ------------------------
-- INNER JOIN
-- ------------------------

-- 복수의 테이블이 공통적으로 만족하는 레코드를 출력
-- 교집합

-- 전 사원의 사번, 이름, 현재 급여를 출력해주세요.
SELECT
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees AS emp
	JOIN salaries AS sal -- INNER JOIN에서 INNER생략됨
		ON emp.emp_id = sal.emp_id -- ON 연결할
			AND sal.end_at IS NULL
ORDER BY emp.emp_id ASC
;
-- ON은 그대로 두고, AND는 WHERE에 적어도 동일하게 작동함
SELECT
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees AS emp
	JOIN salaries AS sal -- INNER JOIN에서 INNER생략됨
		ON emp.emp_id = sal.emp_id -- ON 연결할
WHERE sal.end_at IS NULL -- AND는 WHERE에 적어도 동일하게 작동함
ORDER BY emp.emp_id ASC
;

-- 재직중인 사원의 사번, 이름, 생일, 부서명
-- 1) 소속부서테이블과 부서테이블 먼저 연결
-- 2) 1)에서 사원테이블 연결
-- 조건은 ON아래의 AND에 각각 적어도 되고, WHERE로 한번에 빼도 됨

SELECT
	depe.emp_id
	,emp.`name`
	,emp.birth
	,dept.dept_name
FROM department_emps AS depe
	JOIN departments AS dept
		ON depe.dept_code = dept.dept_code
			AND depe.end_at IS NULL
	JOIN employees AS emp
		ON depe.emp_id = emp.emp_id
			AND emp.fire_at IS NULL
;

SELECT
	depe.emp_id
	,emp.`name`
	,emp.birth
	,dept.dept_name
FROM department_emps AS depe
	JOIN departments AS dept
		ON depe.dept_code = dept.dept_code
	JOIN employees AS emp
		ON depe.emp_id = emp.emp_id
WHERE
	depe.end_at IS NULL
	AND emp.fire_at IS NULL
;



-- ------------------------
-- LEFT JOIN
-- ------------------------

SELECT
	emp.*
	,sal.*
FROM employees AS emp
	LEFT JOIN salaries AS sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
;



-- ------------------------
-- UNION
-- ------------------------

-- 두개 이상의 쿼리의 결과를 합쳐서 출력
-- UNION			(중복 레코드 제거)
-- UNION ALL	(중복 레코드 제거 안함)
SELECT * FROM employees WHERE emp_id IN(1, 3)
UNION
SELECT * FROM employees WHERE emp_id IN(3, 6)
;



-- ------------------------
-- SELF JOIN
-- ------------------------

-- 같은 테이블끼리 JOIN
SELECT
	emp.emp_id AS junior_id
	,emp.`name` AS junior_name
	,supemp.emp_id AS supervisor_id
	,supemp.`name` AS supervisor_name
FROM employees AS emp
	JOIN employees AS supemp
		ON	emp.sup_id = supemp.emp_id
		AND emp.sup_id IS NOT NULL
;