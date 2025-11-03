-- INSERT 문
-- 신규 데이터를 저장하기 위해 사용하는 문

INSERT INTO employees(
-- 	emp_id (pk는 auto increment 적용되기 때문에 따로 설정x)
	`name`
	,birth
	,gender
	,hire_at
	,fire_at
	,sup_id
	,created_at
	,updated_at
	,deleted_at
)
VALUES(
	'박병주'
	,'2000-01-01'
	,'M'
	,'2025-10-31'
	,NULL
	,NULL
	,NOW()
	,NOW()
	,NULL
);

SELECT *
FROM employees
WHERE
	`name` = '박병주'
	AND birth = '2000-01-01'
	AND hire_at = '2025-10-31'
;

-- 자신의 연봉 데이터를 넣어 주세요.
INSERT INTO salaries(
	emp_id
	,salary
	,start_at
-- 	기본값이 있으면 설정 안해도 됨(NULL, CURRENT TIMESTAMP 등)
	,end_at
	,created_at
	,updated_at
	,deleted_at
)
VALUES(
	100005
	,50000000
	,'2025-10-31' -- ,NOW()
-- 	기본값이 있으면 설정 안해도 됨(NULL, CURRENT TIMESTAMP 등)
	,NULL
	,NOW()
	,NOW()
	,NULL
);

SELECT *
FROM salaries
WHERE
	emp_id = 100005
;

-- SELECT INSERT (지금은 안씀)
-- select의 결과를 insert함(순서와 개수 일치시켜야 함)
INSERT INTO salaries (
	emp_id
	,salary
	,start_at
)
SELECT
	emp_id
	,50000000
	,created_at
FROM employees
WHERE
	`name` = '박병주'
	AND birth = '2000-01-01'
	AND hire_at = '2025-10-31'
;