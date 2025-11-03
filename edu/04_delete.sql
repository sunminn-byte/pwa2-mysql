-- DELETE 문
-- 기존 데이터를 삭제하기 위해 사용하는 문
-- 잘 사용 안 함

DELETE FROM salaries
WHERE
	emp_id = 100005 -- UPDATE문처럼 where절 먼저 작성해서 실수 방지
;

DELETE FROM employees
WHERE
	emp_id = 100005
;