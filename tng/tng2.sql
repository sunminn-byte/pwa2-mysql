-- 1. 사원의 사원번호, 이름, 직급코드를 출력해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
	,tite.title_code
FROM employees AS emp
	JOIN title_emps AS tite
		ON emp.emp_id = tite.emp_id
			AND tite.end_at IS NULL
;

-- 2. 사원의 사원번호, 성별, 현재 연봉을 출력해 주세요.
SELECT
	emp.emp_id
	,emp.gender
	,sal.salary
FROM employees AS emp
	JOIN salaries AS sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
;

-- 3. 10010 사원의 이름과 과거부터 현재까지 연봉 이력을 출력해 주세요.
SELECT
	emp.`name`
	,sal.*
FROM employees AS emp
	JOIN salaries AS sal
		ON emp.emp_id = sal.emp_id
			AND emp.emp_id = 10010
;

-- 4. 사원의 사원번호, 이름, 소속부서명을 출력해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
	,dep.dept_name
FROM department_emps AS dep_emp
	JOIN employees AS emp
		ON dep_emp.emp_id = emp.emp_id
			AND emp.fire_at IS NULL
	JOIN departments AS dep
		ON dep_emp.dept_code = dep.dept_code
			AND dep_emp.end_at IS NULL
;

-- 5. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees AS emp
	JOIN salaries AS sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
ORDER BY sal.salary DESC
LIMIT 10
;

-- 6. 현재 각 부서의 부서장의 부서명, 이름, 입사일을 출력해 주세요.
SELECT
	dep.dept_code
	,dep.dept_name
	,emp.emp_id
	,emp.`name`
	,emp.hire_at
FROM department_managers AS dep_mng
	JOIN departments AS dep
		ON dep_mng.dept_code = dep.dept_code
			AND dep_mng.end_at IS NULL
	JOIN employees AS emp
		ON dep_mng.emp_id = emp.emp_id
			AND emp.fire_at IS NULL -- D004는 fire_at 값이 있음
;

-- 7. 현재 직급이 "부장"인 사원들의 연봉 평균을 출력해 주세요.
-- 현재 각 부장별 이름, 연봉평균
SELECT
	emp.`name`
	,ROUND(AVG(sal.salary)) AS avg_sal
FROM title_emps AS tit_emp
	JOIN titles AS tit
		ON tit_emp.title_code = tit.title_code
			AND tit.title = '부장'
			AND tit_emp.end_at IS NULL
	JOIN employees AS emp
		ON tit_emp.emp_id = emp.emp_id
			AND emp.fire_at IS NULL
	JOIN salaries AS sal
		ON emp.emp_id = sal.emp_id
GROUP BY sal.emp_id
;

-- 8. 부서장직을 역임했던 모든 사원의 이름과 입사일, 사번, 부서번호를 출력해 주세요.
SELECT
	emp.`name`
	,emp.hire_at
	,emp.emp_id
	,dep_mng.dept_code
FROM department_managers AS dep_mng
	LEFT JOIN employees AS emp
		ON emp.emp_id = dep_mng.emp_id
;

-- 9. 현재 각 직급별 평균연봉 중 60,000,000이상인 직급의 직급명, 평균연봉(정수)를을
--		평균연봉 내림차순으로 출력해 주세요.


-- 10. 성별이 여자인 사원들의 직급별 사원수를 출력해 주세요.










