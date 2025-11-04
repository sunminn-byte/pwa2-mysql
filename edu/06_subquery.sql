-- SubQuery



-- ------------------------
-- WHERE절에서 사용
-- ------------------------

-- 단일 행 서브쿼리
-- D001 부서장의 사번과 이름을 출력

-- 1) 부서장의 사번을 가져온다.
-- SELECT
-- 	emp_id
-- FROM department_managers
-- WHERE
-- 	dept_code = 'D001'
-- 	AND end_at IS NULL
-- ;

-- 2) employees에서 subquery로 담는다
SELECT
	emp_id
	,`name`
FROM employees
WHERE
	emp_id = (
		SELECT emp_id
		FROM department_managers
		WHERE
			dept_code = 'D001'
			AND end_at IS NULL
	)
;

-- 2-1) 별칭을 지정해서 중복되는 column명 앞에 붙이기(emp.emp_id)
SELECT
	emp.emp_id
	,emp.`name`
FROM employees AS emp
WHERE
	emp.emp_id = (
		SELECT depm.emp_id
		FROM department_managers AS depm
		WHERE
			depm.dept_code = 'D001'
			AND depm.end_at IS NULL
	)
;

-- 2-2) 별칭없이 테이블명을 바로 붙여도 됨.(employees.emp_id)
SELECT
	employees.emp_id
	,employees.`name`
FROM employees
WHERE
	employees.emp_id = (
		SELECT department_managers.emp_id
		FROM department_managers
		WHERE
			department_managers.dept_code = 'D001'
			AND department_managers.end_at IS NULL
	)
;

-- 다중 행 서브쿼리
-- 서브쿼리가 2건 이상 반환 될 경우에는
-- 반드시 다중 행 비교연산자(IN, ALL, ANY, SOME, EXISTS 등)을 사용

-- 현재 부서장인 사원의 사번과 이름을 출력
SELECT
	emp.emp_id
	,emp.`name`
FROM employees AS emp
WHERE
	emp.emp_id IN (
		SELECT depm.emp_id
		FROM department_managers AS depm
		WHERE
			depm.end_at IS NULL
	)
;

-- 다중 열 서브쿼리
-- 서브쿼리의 결과가 복수의 컬럼을 반환할 경우,
-- 메인 쿼리의 조건과 동시 비교

-- 현재 D002의 부서장이 해당 부서에 소속된 날짜 출력
SELECT
	department_emps.*
FROM department_emps
WHERE
	(department_emps.emp_id, department_emps.dept_code) IN (
		SELECT
			department_managers.emp_id
			,department_managers.dept_code
		FROM department_managers
		where
			department_managers.dept_code = 'D002'
			AND department_managers.end_at IS NULL
	)
;

-- 연관 서브쿼리
-- 서브쿼리 내에서 메인쿼리의 컬럼이 사용된 서브쿼리

-- 부서장 직을 지냈던 경력이 있는 사원의 정보 출력
SELECT
	employees.*
FROM employees
WHERE
	employees.emp_id IN (
		SELECT department_managers.emp_id
		FROM department_managers
		WHERE
			department_managers.emp_id = employees.emp_id
	)
;



-- ------------------------
-- SELECT절에서 사용
-- ------------------------

-- 사원별 역대 전체 급여 평균
SELECT
	emp.emp_id
	,(
		SELECT ROUND(AVG(sal.salary))
		FROM salaries AS sal
		WHERE emp.emp_id = sal.emp_id
	) AS avg_sal
FROM employees AS emp
;



-- ------------------------
-- FROM절에서 사용
-- ------------------------

SELECT 
	tmp.*
FROM (
	SELECT
		emp.emp_id
		,emp.`name`
	FROM employees AS emp
) AS tmp
;



-- ------------------------
-- INSERT문에서 사용
-- ------------------------

INSERT INTO title_emps (
	emp_id
	,title_code
	,start_at
)
VALUES (
	(SELECT MAX(emp_id) FROM employees)
	,(SELECT title_code FROM titles WHERE title = '사원')
	,DATE(NOW())
);



-- ------------------------
-- UPDATE문에서 사용
-- ------------------------

-- update에서는 서브쿼리에서 동일한 테이블 사용 불가
UPDATE title_emps AS tite_main
SET
	tite_main.end_at = (
		SELECT tite_sub.start_at
		FROM title_emps AS tite_sub
		WHERE tite_sub.title_emp_id = 181447
	)
WHERE
	tite_main.title_emp_id = 60614
;


UPDATE title_emps AS tite_main
SET
	tite_main.end_at = (
		SELECT fire_at
		FROM employees AS emp
		WHERE emp.emp_id = 100000
	)
WHERE
	tite_main.emp_id = 100000
	AND title_main.end_at IS NULL
;