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
-- 	,sal.* -- 나
	,sal.start_at -- 선생님
	,sal.end_at
	,sal.salary
FROM employees AS emp
	JOIN salaries AS sal
		ON emp.emp_id = sal.emp_id
			AND emp.emp_id = 10010
ORDER BY sal.start_at ASC -- 선생님 추가(정렬은 필수로 사용)
;

-- 4. 사원의 사원번호, 이름, 소속부서명을 출력해 주세요.
SELECT
	emp.emp_id
	,emp.`name`
	,dep.dept_name
FROM department_emps AS dep_emp
	JOIN employees AS emp
		ON dep_emp.emp_id = emp.emp_id
			AND dep_emp.end_at IS NULL
-- 			AND emp.fire_at IS NULL -- '재직중'요청이 없으므로 필요없음
	JOIN departments AS dep
		ON dep_emp.dept_code = dep.dept_code
;

-- 5. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요.
-- 나 (속도 느림)
SELECT
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees AS emp
	JOIN salaries AS sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
			AND emp.fire_at IS NULL -- 선생님 추가(안정성을 위해 end_at, fire_at 함께 사용)
ORDER BY sal.salary DESC
LIMIT 10
;
-- 선생님 (subquery로 속도 개선)
SELECT
	emp.emp_id
	,emp.`name`
	,tmp_sal.salary
FROM employees AS emp
	JOIN (
		SELECT
			sal.emp_id
			,sal.salary
		FROM salaries AS sal
		WHERE
			sal.end_at IS NULL
		ORDER BY sal.salary DESC
		LIMIT 10
	) tmp_sal
		ON emp.emp_id = tmp_sal.emp_id
ORDER BY tmp_sal.salary DESC
;

-- 6. 현재 각 부서의 부서장의 부서명, 이름, 입사일을 출력해 주세요.
SELECT
-- 	dep.dept_code,
	dep.dept_name
-- 	,emp.emp_id
	,emp.`name`
	,emp.hire_at
FROM department_managers AS dep_mng
	JOIN departments AS dep
		ON dep_mng.dept_code = dep.dept_code
			AND dep_mng.end_at IS NULL
	JOIN employees AS emp
		ON dep_mng.emp_id = emp.emp_id
			AND emp.fire_at IS NULL -- D004는 fire_at 값이 있음
ORDER BY dep.dept_code ASC -- 선생님 추가 정렬
;

-- 7. 현재 직급이 "부장"인 사원들의 연봉 평균을 출력해 주세요.
SELECT
	AVG(sal.salary) AS avg_sal
FROM titles AS tit
	JOIN title_emps AS tit_emp
		ON tit.title_code = tit_emp.title_code
			AND tit.title = '부장'
			AND tit_emp.end_at IS NULL
	JOIN salaries AS sal
		ON tit_emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL
;

-- 7-1. 현재 각 부장별 이름, 연봉평균
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
GROUP BY sal.emp_id, emp.`name` -- 표준문법을 맞추기 위해 emp.`name` 추가함
;
-- 위의 GROUP BY 표준문법 오류를 회피하기 위한 방법
SELECT
	emp.`name`
	,sub_salaries.avg_sal
FROM employees AS emp
	JOIN (
		--	부장인 직급의 salary정보와 emp_id를 반환하는 정보
		SELECT
			sal.emp_id
			,AVG(sal.salary) AS avg_sal
		FROM title_emps AS tit_emp
			JOIN titles AS tit
				ON tit_emp.title_code = tit.title_code
					AND tit.title = '부장'
					AND tit_emp.end_at IS NULL
			JOIN salaries AS sal
				ON sal.emp_id = tit_emp.emp_id
		GROUP BY sal.emp_id
	) AS sub_salaries
		ON emp.emp_id = sub_salaries.emp_id
			AND emp.fire_at IS NULL
;

-- 8. 부서장직을 역임했던 모든 사원의 이름과 입사일, 사번, 부서번호를 출력해 주세요.
SELECT
	emp.`name`
	,emp.hire_at
	,emp.emp_id
	,dep_mng.dept_code
FROM department_managers AS dep_mng
	JOIN employees AS emp
		ON emp.emp_id = dep_mng.emp_id
;

-- 9. 현재 각 직급별 평균연봉 중 60,000,000이상인 직급의 직급명, 평균연봉(정수)를을
--		평균연봉 내림차순으로 출력해 주세요.
SELECT
	tit.title
	,CEILING(AVG(sal.salary)) AS avg_sal -- 돈과 관련된건 ROUND(반올림)말고 CEILING(올림)
FROM title_emps AS tit_emp
	JOIN salaries AS sal
		ON tit_emp.emp_id = sal.emp_id
			AND tit_emp.end_at IS NULL
			AND sal.end_at IS NULL
	JOIN titles AS tit
		ON tit_emp.title_code = tit.title_code
GROUP BY tit.title
	HAVING avg_sal >= 60000000
ORDER BY avg_sal DESC
;

-- 10. 성별이 여자인 사원들의 직급별 사원수를 출력해 주세요.
SELECT
	tit_emp.title_code
	,COUNT(tit_emp.title_code) AS count_code
FROM employees AS emp
	JOIN title_emps AS tit_emp
		ON emp.emp_id = tit_emp.emp_id
			AND emp.gender = 'F'
			AND emp.fire_at IS NULL -- 선생님 추가
			AND tit_emp.end_at IS NULL
GROUP BY tit_emp.title_code
ORDER BY tit_emp.title_code ASC
;
-- F, M 모두 표시
SELECT
	tit_emp.title_code
	,emp.gender
	,COUNT(*) AS cnt_emp
FROM employees AS emp
	JOIN title_emps AS tit_emp
		ON emp.emp_id = tit_emp.emp_id
			AND emp.fire_at IS NULL -- 선생님 추가
			AND tit_emp.end_at IS NULL
GROUP BY tit_emp.title_code, emp.gender
ORDER BY tit_emp.title_code ASC, emp.gender ASC
;
-- 10번 문제 확인용
SELECT *
FROM employees
WHERE
	emp_id IN (91757, 1997, 24868)
;
SELECT
	*
FROM title_emps
	JOIN employees
		ON title_emps.emp_id = employees.emp_id
			AND employees.gender = 'F'
			AND title_emps.end_at IS NULL
			AND title_emps.title_code = 'T004'
;