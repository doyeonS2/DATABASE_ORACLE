/* 8월 31일 수요일 수업 */

/* 임시 테이블 생성(DDL) */
CREATE TABLE DEPT_TEMP -- 테이블 생성
AS SELECT * FROM DEPT;

SELECT * FROM DEPT_TEMP; -- DEPT_TEMP 테이블 조회
DESC DEPT_TEMP; -- 테이블 데이터 확인하는 명령
DROP TABLE DEPT_TEMP; -- 테이블 삭제(현업에서는 DROP 하면 큰일나요!!ㅜ_ㅜ)

CREATE TABLE DEPT_TEMP
AS SELECT * FROM DEPT;

/* 테이블에 데이터를 추가하는 INSERT */
-- INSERT INTO 테이블이름(테이블열, ....) VALUES (열에 해당하는 데이터...)

-- 포함된 열에 값을 넣지 않고 싶을 때 생략할 수 있고, 값을 입력하는 순서를 정할 수 있음
INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC) VALUES(50, 'DATABASE', 'SEOUL');
INSERT INTO DEPT_TEMP (DEPTNO, LOC) VALUES(60, 'INCHEON');

-- 순서를 테이블의 순서대로 입력해야 함. 값을 생략할 수 없음
INSERT INTO DEPT_TEMP VALUES(70, 'NETWORK', 'BUSAN');
INSERT INTO DEPT_TEMP VALUES(80, 'WEB', NULL); -- 명시적으로 NULL이나 공백이라도 넣어줘야 함
INSERT INTO DEPT_TEMP VALUES(90, 'MOBILE', ''); -- 공백도 NULL로 취급함

-------------------------------------------------------------------------------
CREATE TABLE EMP_TEMP
    AS SELECT * FROM EMP
WHERE 1 != 1; -- 테이블을 복사하는데 데이터는 복사하지 않고 싶을 때 사용하는 방법(WHERE 1 ^= 1; 이나 WHERE 1 <> 1; 로 사용해도 됨)
SELECT * FROM EMP_TEMP;

INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(9001, '나영석', 'PRESIDENT', NULL, '2001/01/31', 9999, 1000, 10);
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(9002, '이은지', 'MANAGER', 9001, '2002-08-31', 6000, 800, 20);
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(9003, '미미', 'MANAGER', 9001, TO_DATE('2010/07/01', 'YYYY/MM/DD'), 5000, 700, 20);
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(9004, '이영지', 'MANAGER', 9001, '2020/07/01', 4500, 900, 20);
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(9005, '안유진', 'MANAGER', 9001, SYSDATE, 4400, 1500, 20);
    
/* 서브쿼리를 이용한 INSERT */
-- VALUES 절을 사용하지 않음
-- 데이터가 추가되는 테이블의 열 개수와 서브쿼리의 열 개수가 일치해야 됨
-- 데이터가 추가되는 테이블의 자료형과 서브쿼리의 자료형도 일치해야 됨
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO
    FROM EMP E, SALGRADE S
    WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL AND S.GRADE = 1;
    
/* 테이블에 있는 데이터 수정하기 (UPDATE) */
-- 회원 정보 변경, 결제 계좌 변경, 내가 쓴 글 변경 등 수정 사항이 발생하는 경우에 해당
-- 테이블에 저장된 데이터의 내용을 변경하고자 하는 경우 사용
-- UPDATE 변경할테이블 SET 변경할열 
UPDATE DEPT_TEMP
    SET LOC = 'SEOUL';
SELECT * FROM DEPT_TEMP;
ROLLBACK; -- TCL 명령어이며 작업을 이전 상태로 되돌리는 것

UPDATE DEPT_TEMP
    SET DNAME = 'DATABASE',
        LOC = 'SEOUL'
    WHERE DEPTNO = 40;
    
UPDATE DEPT_TEMP
    SET DNAME = 'FRONTEND',
        LOC = 'SUWON'
    WHERE DEPTNO = 90;

UPDATE DEPT_TEMP
    SET LOC = 'JEJU'
    WHERE LOC IS NULL;
    
COMMIT; -- 일련의 과정이 다 끝난 다음에 커밋해야 함
    
-------------------------------------------------------------------------------
SELECT * FROM EMP_TEMP;
SELECT * FROM DEPT_TEMP;

-- 사원들의 급여가 5000 이하인 사원들에게 추가 수당(COMM) 2000으로 수정하는 쿼리 작성
UPDATE EMP_TEMP
    SET COMM = 2000
    WHERE SAL <= 5000;
    
-- 서브쿼리를 사용하여 데이터 수정하기
UPDATE DEPT_TEMP
    SET(DNAME, LOC) = (SELECT DNAME, LOC
                            FROM DEPT
                            WHERE DEPTNO = 40)
    WHERE DEPTNO = 10;

-- 테이블에 있는 데이터 삭제하기
DELETE FROM EMP_TEMP
    WHERE JOB = 'PRESIDENT';
    
DELETE FROM EMP_TEMP
    WHERE EMPNO IN (SELECT E.EMPNO
                            FROM EMP_TEMP E, SALGRADE S
                            WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
                            AND S.GRADE = 1 AND DEPTNO = 30);

DELETE FROM EMP_TEMP
    WHERE SAL < 1000;

DELETE FROM EMP_TEMP; -- 테이블 전체 다 지우기

-------------------------------------------------------------------------------
ROLLBACK;

/* 문제 풀기 전에 테이블 복사 */
CREATE TABLE EX_EMP AS SELECT * FROM EMP;
CREATE TABLE EX_DEPT AS SELECT * FROM DEPT;
CREATE TABLE EX_SALGRADE AS SELECT * FROM SALGRADE;

SELECT * FROM EX_EMP;
SELECT * FROM EX_DEPT;
SELECT * FROM EX_SALGRADE;
DESC EX_EMP;

-- 1. EX_DEPT에 50, 60, 70, 80 부서를 등록(INSERT)하세요. (부서 이름과 지역은 마음대로...)
INSERT INTO EX_DEPT VALUES(50, 'DATABASE', 'SEOUL');
INSERT INTO EX_DEPT VALUES(60, 'MOBILE', 'BUSAN');
INSERT INTO EX_DEPT VALUES(70, 'FRONTEND', 'SOKCHO');
INSERT INTO EX_DEPT VALUES(80, 'BACKEND', 'INCHEON');

-- 2. EX_EMP에 8명의 사원 정보를 등록 하세요. (정보는 마음대로..), DEPTNO는 50, 60, 70, 80 중에서 선택
INSERT INTO EX_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(8000, '정은종', 'DANCER', 7566, '20/08/24', 2900, 500, 50);
INSERT INTO EX_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(8001, '이수빈', 'DESIGNER', 7566, '20/12/30', 3100, NULL, 60);
INSERT INTO EX_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(8002, '김도연', 'SINGER', 7369, '20/08/24', 3000, 550, 70);
INSERT INTO EX_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(8003, '정찬호', 'PROGAMER', NULL, '21/02/01', 2800, 600, 80);
INSERT INTO EX_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(8004, '정경수', 'ARTIST', 7566, '21/08/14', 2900, 500, 50);
INSERT INTO EX_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(8005, '최윤정', 'TEACHER', 7369, '22/05/16', 3000, 500, 70);
INSERT INTO EX_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(8006, '김승렬', 'DANCER', 7369, '21/12/31', 5100, 450, 60);
INSERT INTO EX_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
    VALUES(8007, '김성탁', 'WORKER', NULL, '22/09/23', 35000, 200, 80); 

-- 3. EX_EMP에 속한 사원 중 50번 부서에 근무하는 사원들의 평균 급여보다 많은 급여를 받고 있는 사원들을 70번 부서로 이동
UPDATE EX_EMP
    SET DEPTNO = 70
    WHERE SAL > (SELECT AVG(SAL) 
                    FROM EX_EMP 
                    WHERE DEPTNO = 50); 

-- 4. EX_EMP에 속한 사원 중 60번 부서의 사원 중에 입사일이 가장 빠른 사원보다 늦게 입사한 사원의 급여를 10% 인상하고 80번 부서로 이동
UPDATE EX_EMP
    SET SAL = SAL*1.1, 
        DEPTNO = 80
    WHERE HIREDATE > (SELECT MIN(HIREDATE) 
                        FROM EX_EMP 
                        WHERE DEPTNO = 60);

-- 5. EX_EMP에 속한 사원 중 급여 등급이 5인 사원을 삭제
DELETE FROM EX_EMP
    WHERE EMPNO IN (SELECT E.EMPNO 
                    FROM EX_EMP E, EX_SALGRADE S 
                    WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
                    AND S.GRADE = 5);
                    
ROLLBACK;
-------------------------------------------------------------------------------
/* TCL */
CREATE TABLE DEPT_TCL
    AS SELECT * FROM DEPT;
    
SELECT * FROM DEPT_TCL;

INSERT INTO DEPT_TCL VALUES(50, 'DATABASE', 'SEOUL');
UPDATE DEPT_TCL 
    SET LOC = 'BUSAN'
    WHERE DEPTNO = 40;
DELETE FROM DEPT_TCL
    WHERE DNAME='RESEARCH';
    
ROLLBACK;
-------------------------------------------------------------------------------
/* 연습문제 */

SELECT * FROM DEPT;