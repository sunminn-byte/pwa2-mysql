--  DB 생성
CREATE DATABASE mydb;
-- 생성 후 스키마에서 새로고침해야 보임

--  DB 선택
USE mydb;

-- DB 삭제
DROP DATABASE mydb;
-- 삭제 후 스키마에서 새로고침해야 안보임

-- DDL의 문법 : CREATE(생성), ALTER(수정), DROP(삭제)
-- 스키마는 구조, 틀이라는 뜻
-- DDL은 이력을 남기지 않음. 삭제하면 복구 불가능



-- ------------------------
-- 테이블 생성
-- ------------------------

-- BIGINT UNSIGNED : 양수만(1~ )
-- VARCHAR() : 요즘엔 30~50자 설정(외국인)
-- NOT NULL : NULL 비허용(필수)
--	COMMENT : 주석(설명)
-- DEFAULT CURRENT_TIMESTAMP() : NOW()는 테이블생성 시간이 들어가기때문에 사용 불가

-- CREATE TABLE 테이블명 (
CREATE TABLE users(
	--	컬럼명 타입(크기) PRIMARY KEY AUTO_INCREMENT
	--	PK에는 NOT NULL이 기본 포함되어 있음
	id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT
	,`name` VARCHAR(50) NOT NULL COMMENT '이름'
	,gender CHAR(1) NOT NULL COMMENT 'F=여자, M=남자, N=선택안함'
	,created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,deleted_at DATETIME
)
-- ENGINE=INNODB -- default값
-- CHARSET=UTF8MB4 -- default값
-- COLLATE=UTF8MB4_BIN -- 정렬순서 설정(대소문자 구분), 잘 안씀
;

-- 게시글 테이블
-- column : pk, 유저번호, 제목, 내용, 작성일, 수정일, 삭제일
CREATE TABLE posts(
	id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT
	,user_id BIGINT UNSIGNED NOT NULL
	,title VARCHAR(50) NOT NULL
	,content VARCHAR(1000) NOT NULL
	,created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,deleted_at DATETIME
);



-- ------------------------
-- 테이블 수정
-- ------------------------

-- FK 추가방법
-- ALTER TABLE [테이블명]
-- ADD CONSTRAINT [Constraint명]
-- FOREIGN KEY (Constraint 부여 컬럼명)
-- REFERENCES 참조테이블명(참조테이블 컬럼명)
-- [ON DELETE 동작 / ON UPDATE 동작];

-- FK 추가
ALTER TABLE posts
ADD CONSTRAINT fk_posts_user_id -- [이름지정] fk_테이블명_컬럼명
FOREIGN KEY (user_id) -- fk를 부여할 (컬럼명)
REFERENCES users(id) -- 참조할 테이블명(컬럼명)
;

-- FK 삭제
ALTER TABLE posts
DROP CONSTRAINT fk_posts_user_id
;

-- 컬럼 추가
ALTER TABLE posts
ADD COLUMN image VARCHAR(100)
;

-- 컬럼 제거
ALTER TABLE posts
DROP COLUMN image
;

-- 컬럼 수정
-- 주로 데이터타입 수정할 때
ALTER TABLE users
MODIFY COLUMN gender VARCHAR(10) NOT NULL COMMENT '남자, 여자, 미선택'
;

-- AUTO_INCREMENT 값 변경
ALTER TABLE users AUTO_INCREMENT = 10; -- 10부터 시작



-- ------------------------
-- 테이블 삭제
-- ------------------------

DROP TABLE posts;
DROP TABLE users;



-- ------------------------
-- 테이블의 모든 데이터 삭제
-- ------------------------

-- 복구 방법이 없으므로 되도록 사용x
-- TRUNCATE TABLE 테이블명;