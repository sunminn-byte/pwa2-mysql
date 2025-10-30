-- 테이블 전체 컬럼 조회
SELECT *
FROM employees;

-- 특정 컬럼만 지정하여 조회
SELECT
	name
	,birth
	,hire_at
FROM employees;

-- WHERE 절: 특정 컬럼의 값과 일치한 데이터만 조회(filter)
SELECT *
FROM employees
WHERE
	emp_id = 5
;

-- 이름이 강영화 인 사원 조회
SELECT *
FROM employees
WHERE
	NAME = '강영화'
-- ""는 식별자, ''는 문자열
;

-- 이름이 강영화 이고, 성별이 M인 사원 조회
SELECT *
FROM employees
WHERE
	NAME = '강영화'
	AND gender = 'M'
;