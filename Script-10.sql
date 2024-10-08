CREATE TABLE HEIGHT_INFO AS
SELECT STUDNO , NAME , HEIGHT 
FROM STUDENT
WHERE 1=0;

--DROP TABLE WEIGHT_INFO;
CREATE TABLE WEIGHT_INFO AS
SELECT STUDNO , NAME , HEIGHT  WEIGHT 
FROM STUDENT
WHERE 1=0;

SELECT * FROM HEIGHT_INFO;
SELECT * FROM WEIGHT_INFO;

TRUNCATE TABLE HEIGHT_INFO;
TRUNCATE TABLE WEIGHT_INFO;

-- 2학년 이상의 학생, HEIGHT_INFO에는 학번, 이름, 키, WEIGHT_INFO에는 학번 이름 체중을 입력
INSERT ALL
INTO HEIGHT_INFO VALUES(STUDNO, NAME, HEIGHT)
INTO WEIGHT_INFO VALUES(STUDNO, NAME, 	WEIGHT)
SELECT * FROM STUDENT s WHERE GRADE >= '2';

-- 2학년 이상의 학생, HEIGHT_INFO에는 학번, 이름, 키, WEIGHT_INFO에는 학번 이름 체중을 입력
-- INSER ALL CONDITIONAL
-- HEIGHT_INFO 에는 키 170이상만
-- WEIGHT_INFO 에는 체중 70이상만
INSERT FIRST
WHEN HEIGHT >= 170 THEN
	INTO HEIGHT_INFO VALUES(STUDNO, NAME, HEIGHT)
WHEN WEIGHT >= 70 THEN	
	INTO WEIGHT_INFO VALUES(STUDNO, NAME, 	WEIGHT)
SELECT STUDNO, NAME, HEIGHT, WEIGHT FROM STUDENT s WHERE GRADE >= '2';

-- PIVOTING
CREATE TABLE SALES (
	SALES_NO NUMBER,
	WEEK_NO NUMBER,
	SALES_MON NUMBER,
	SALES_TUE NUMBER,
	SALES_WED NUMBER,
	SALES_THU NUMBER,
	SALES_FRI NUMBER
);

CREATE TABLE SALES_DATA (
	SALES_NO NUMBER,
	WEEK_NO NUMBER,
	DAY_NO NUMBER,
	SALES NUMBER
);

INSERT INTO SALES VALUES (1101, 4, 100, 150, 80, 60, 120);
INSERT INTO SALES VALUES (1102, 5, 300, 300, 230, 120, 150);


--TRUNCATE TABLE SALES_DATA;

INSERT ALL
INTO SALES_DATA VALUES (SALES_NO, WEEK_NO, 1, SALES_MON)
INTO SALES_DATA VALUES (SALES_NO, WEEK_NO, 2, SALES_TUE)
INTO SALES_DATA VALUES (SALES_NO, WEEK_NO, 3, SALES_WED)
INTO SALES_DATA VALUES (SALES_NO, WEEK_NO, 4, SALES_THU)
INTO SALES_DATA VALUES (SALES_NO, WEEK_NO, 5, SALES_FRI)
SELECT * FROM SALES;

SELECT * FROM SALES;

SELECT 
	SALES_NO, 
	WEEK_NO,
	MAX(DECODE(DAY_NO, 1, SALES)) M,
	MAX(DECODE(DAY_NO, 2, SALES)) T,
	MAX(DECODE(DAY_NO, 3, SALES)) W,
	MAX(DECODE(DAY_NO, 4, SALES)) TH,
	MAX(DECODE(DAY_NO, 5, SALES)) F
FROM SALES_DATA
GROUP BY SALES_NO, WEEK_NO
ORDER BY 1;

-- 교수번호 9903인 교수의 직급을 부교수로 수정
SELECT * FROM PROFESSOR WHERE PROFNO = 9903;

-- 교수번호 9903인 교수의 직급을 전임교수로, 아이디를 'littlePascal'로, 급여를 20올린 데이터로 수정
UPDATE PROFESSOR SET 
	POSITION = '전임교수' ,
	USERID = 'litPascal' ,
	SAL = SAL + 20
WHERE PROFNO = 9903;

-- 컴퓨터공학과 소속 학생 데이터 삭제
DELETE 
FROM STUDENT 
WHERE DEPTNO = (
	SELECT DEPTNO FROM DEPARTMENT WHERE DNAME = '컴퓨터공학과'
);

SELECT * FROM  STUDENT;

CREATE TABLE T_STU AS
SELECT * FROM STUDENT;

DROP TABLE STUDENT;

RENAME T_STU TO STUDENT;

-- PROFESSOR_TEMP 테이블 생성, 교수 직급만 가져와서 생성
CREATE TABLE PROFESSOR_TEMP AS
SELECT * FROM PROFESSOR p WHERE POSITION = '교수';

SELECT * FROM PROFESSOR_TEMP;

UPDATE PROFESSOR_TEMP SET 
	POSITION = '명예교수';
	
INSERT INTO PROFESSOR_TEMP VALUES (9999, '김도경', 'arom21', '전임강사', 200, SYSDATE, 10, 101);


MERGE INTO PROFESSOR p 
	USING PROFESSOR_TEMP PT
	ON (P.PROFNO = PT.PROFNO)
WHEN MATCHED THEN 
	UPDATE SET p.POSITION = PT.POSITION
-- UPDATE
WHEN NOT MATCHED THEN
	INSERT VALUES(PT.PROFNO, PT.NAME, PT.USERID, PT.POSITION, PT.SAL, PT.HIREDATE, PT.COMM, PT.DEPTNO);
-- INSERT

SELECT * FROM PROFESSOR;
DELETE FROM PROFESSOR p WHERE POSITION = '명예교수';

-- SEQUENCE
-- 게시판 용 테이블 생성
DROP TABLE BOARD;

CREATE TABLE BOARD (
	NO NUMBER PRIMARY KEY,
	TITLE VARCHAR(4000),
	CONTENT CLOB,
	WRITER VARCHAR(1000),
	REGDATE DATE DEFAULT SYSDATE
);
CREATE SEQUENCE SEQ_BOARD;

INSERT INTO BOARD (NO, TITLE, CONTENT, WRITER) VALUES (2, '제목', '내용', '새똥이');

SELECT ROWNUM, B.* FROM BOARD B;

COMMIT;

INSERT INTO BOARD (NO, TITLE, CONTENT, WRITER)

SELECT SEQ_BOARD.NEXTVAL NO, TITLE, CONTENT, WRITER FROM BOARD;