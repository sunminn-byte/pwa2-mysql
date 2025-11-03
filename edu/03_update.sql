-- UPDATE 문
-- 기존 데이터를 수정하기 위해 사용하는 문

-- SELECT *
-- FROM employees
-- WHERE
-- 	emp_id = 100005
-- ;

UPDATE employees
SET
	fire_at = NOW()
	,deleted_at = NOW()
WHERE
	emp_id = 100005 -- where절 필수
;

-- 나의 연봉을 3,000만원으로 변경
-- 원래는 기존 데이터의 end_at 수정 후, 새로운 행을 추가 해야 함
UPDATE salaries
SET
	salary = 30000000
WHERE
-- 	emp_id = 100005 -- 그냥 수정한다면 emp_id가 아닌 sal_id에 수정해야 함
	sal_id = 1022176
;

-- emp_id = 100000 인 사람의 연봉을 바꾸기위해 sal_id가 아닌 아래의 조건으로 찾아냄
SELECT *
FROM salaries
WHERE
	emp_id = 100000
	AND end_at IS NULL
;