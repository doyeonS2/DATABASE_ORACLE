/* 8월 31일 수업내용 복습하기 */

-- DEPT 테이블을 복사해서 DEPT_TEMP 테이블 만들기
CREATE TABLE DEPT_TEMP
AS SELECT * FROM DEPT;

-- DEPT_TEMP 테이블 조회
SELECT * FROM DEPT_TEMP;

-- DEPT_TEMP 테이블 삭제하기
DROP TABLE DEPT_TEMP;

--------------------------------------------------------

-- <DEPT_TEMP 테이블에 데이터 추가하기>
INSERT INTO DEPT_TEMP(DEPTNO, ENAME, LOC)
            VALUES(50, 'DATABASE', 'SEOUL');
-- 포함된 열에 값을 넣지 않고 싶을 때 생략할 수 있고, 값을 입력하는 순서를 정할 수 있음
INSERT INTO DEPT_TEMP (DEPTNO, LOC) VALUES(70, 'INCHEON');

-- <INSERT문으로 데이터 입력하기(열 지정을 생략할 때)>
INSERT INTO DEPT_TEMP VALUES(60, 'NETWORK', 'BUSAN');
-- 순서를 테이블의 순서대로 입력해야 함. 값을 생략할 수 없음
INSERT INTO DEPT_TEMP VALUES(80, 'WEB', NULL); -- 명시적으로 NULL이나 공백이라도 넣어줘야 함
INSERT INTO DEPT_TEMP VALUES(90, 'MOBILE', ''); -- 공백도 NULL로 취급함

--------------------------------------------------------

-- <테이블에 날짜 데이터 입력하기>
-- EMP 테이블을 복사해서 EMP_TEMP 테이블 만들기
CREATE TABLE EMP_TEMP
    AS SELECT * 
        FROM EMP 
        WHERE 1 != 1; -- 테이블은 복사하면서 데이터는 복사하고 싶지 않을 때 사용(WHERE 1 ^= 1; 이나 WHERE 1 <> 1; 로 사용해도 됨)
-- INSERT문 입력하기
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
            VALUES(1011, '윤지성', 'LEADER', NULL, '1991/03/08', 3500, 200, 10); -- 날짜 데이터 YYYY/MM/DD 형식
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
            VALUES(1012, '하성운', 'SINGER', 1011, '1994-03-22', 3200, 250, 20);-- 날짜 데이터 YYYY-MM-DD 형식
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
            VALUES(1013, '황민현', 'SINGER', 1011, TO_DATE('1995/08/09', 'YYYY/MM/DD'), 4000, 250, 20); -- TO_DATE 함수 사용하여 날짜 데이터 입력
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
            VALUES(1014, '옹성우', 'ACTOR', 1011, SYSDATE, 3000, 300, 30); -- SYSDATE 사용하여 날짜 데이터 입력
-- EMP_TEMP 테이블 조회
SELECT * FROM EMP_TEMP;

--------------------------------------------------------

-- <서브 쿼리를 이용한 INSERT>
-- VALUES절은 사용하지 않음
-- 데이터가 추가되는 테이블의 열 개수와 서브쿼리의 열 개수가 일치해야 됨
-- 데이터가 추가되는 테이블의 자료형과 서브쿼리의 자료형도 일치해야 됨
INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
        SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO
        FROM EMP E, SALGRADE S
        WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
            AND S.GRADE = 1;
            
--------------------------------------------------------

-- <테이블에 있는 데이터 수정하기(UPDATE)>

-- DEPT 테이블을 복사해서 DEPT_TEMP2 테이블 만들기
CREATE TABLE DEPT_TEMP2
AS SELECT * FROM DEPT;

-- DEPT_TEMP2 테이블 조회
SELECT * FROM DEPT_TEMP2;

-- UPDATE문의 기본 사용법
UPDATE 변경할테이블
    SET 변경할열 = 데이터입력;
    
-- 데이터 전체 수정하기
UPDATE DEPT_TEMP2
    SET LOC = 'SEOUL';
    
-- 수정한 결과를 되돌리고 싶을 때
ROLLBACK;

-- 데이터 일부분만 수정하기
UPDATE DEPT_TEMP2
    SET DNAME = 'DATABASE',
        LOC = 'SEOUL'
    WHERE DEPTNO = 40;
    
-- 문제 풀어보기
-- EMP_TEMP 테이블의 사원들 중에서 급여가 2500 이하인 사원만 추가 수당을 50으로 수정하는 코드 작성
UPDATE EMP_TEMP
    SET COMM = 50
    WHERE SAL <= 2500;

-- <서브쿼리를 사용하여 데이터 수정하기>
-- DEPT_TEMP2 테이블의 부서이름과 지역을 변경하는데, 
-- DEPT 테이블의 부서번호가 40인 사람들의 부서이름과 지역을 가져와서 
-- DEPT_TEMP2 테이블의 부서번호가 40인 사람들의 데이터를 수정
UPDATE DEPT_TEMP2
    SET (DNAME, LOC) = (SELECT DNAME, LOC 
                        FROM DEPT 
                        WHERE DEPTNO = 40)
    WHERE DEPTNO = 40;

--------------------------------------------------------

-- <테이블에 있는 데이터 삭제하기(DELETE)>

-- EMP 테이블을 복사해서 EMP_TEMP2 테이블 만들기
CREATE TABLE EMP_TEMP2
AS SELECT * FROM EMP;

-- EMP_TEMP2 테이블 조회
SELECT * FROM EMP_TEMP2;

-- DELETE문의 기본 사용법
DELETE FROM 테이블이름
    WHERE 삭제할 데이터를 선별하기 위한 조건식; -- 생략할 경우 모든 데이터 삭제
    
-- 데이터 일부분만 삭제하기
DELETE FROM EMP_TEMP2
    WHERE JOB = 'MANAGER';
    
-- <서브쿼리를 사용하여 데이터 삭제하기>
-- WHERE절에 서브쿼리를 사용하여 데이터 일부만 삭제하기
-- SALGRADE 테이블을 조인한 서브쿼리의 결과 값을 활용하여,
-- EMP_TEMP2 테이블에서 급여 등급이 3등급(급여가 1401~2000)인 30번 부서의 사원들만 삭제
DELETE EMP_TEMP2
    WHERE EMPNO IN(SELECT E.EMPNO 
                     FROM EMP_TEMP2 E, SALGRADE S
                     WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
                     AND S.GRADE = 3
                     AND DEPTNO = 30);

-- 데이터 전체 삭제
DELETE FROM EMP_TEMP2;

-- 문제 풀어보기
-- EMP_TEMP 테이블에서 급여가 3000 이하인 사원을 삭제하는 코드 작성
DELETE EMP_TEMP
    WHERE SAL < = 3000;

--------------------------------------------------------

/* 연습문제 */

-- <다음 SQL문을 복사하여 한 번에 한 문장씩 실행하고 문제 풀어보기>
CREATE TABLE EX_EMP AS SELECT * FROM EMP;
CREATE TABLE EX_DEPT AS SELECT * FROM DEPT;
CREATE TABLE EX_SALGRADE AS SELECT * FROM SALGRADE;

-- 1. EX_DEPT 테이블에 50, 60, 70, 80를 등록하는 SQL문을 작성
SELECT * FROM EX_DEPT;

INSERT INTO EX_DEPT(DEPTNO, DNAME, LOC) VALUES(50, 'DRAMA', 'SUWON');
INSERT INTO EX_DEPT(DEPTNO, DNAME, LOC) VALUES(60, 'RAP', 'YONGIN');
INSERT INTO EX_DEPT(DEPTNO, DNAME, LOC) VALUES(70, 'VOCAL', 'SOKCHO');
INSERT INTO EX_DEPT(DEPTNO, DNAME, LOC) VALUES(80, 'WRITER', 'INCHEON');

-- 2. EX_EMP 테이블에 다음 8명의 사원 정보를 등록하는 SQL문을 작성
SELECT * FROM EX_EMP;

INSERT INTO EX_EMP
    VALUES(8000, '정은종', 'DANCER', 7566, '20/08/24', 2900, 500, 50);
INSERT INTO EX_EMP
    VALUES(8001, '이수빈', 'DESIGNER', 7566, '20/12/30', 3100, NULL, 60);
INSERT INTO EX_EMP
    VALUES(8002, '김도연', 'SINGER', 7369, '20/08/24', 3000, 550, 70);
INSERT INTO EX_EMP
    VALUES(8003, '정찬호', 'PROGAMER', NULL, '21/02/01', 2800, 600, 80);
INSERT INTO EX_EMP
    VALUES(8004, '정경수', 'ARTIST', 7566, '21/08/14', 2900, 500, 50);
INSERT INTO EX_EMP
    VALUES(8005, '최윤정', 'TEACHER', 7369, '22/05/16', 3000, 500, 70);
INSERT INTO EX_EMP
    VALUES(8006, '김승렬', 'DANCER', 7369, '21/12/31', 5100, 450, 60);
INSERT INTO EX_EMP
    VALUES(8007, '김성탁', 'WORKER', NULL, '22/09/23', 35000, 200, 80); 

-- 3. EX_EMP에 속한 사원 중 50번 부서에 근무하는 사원들의 평균 급여보다 많은 급여를 받고 있는 사원들을 70번 부서로 이동
UPDATE EX_EMP
    SET DEPTNO = 70
    WHERE SAL > (SELECT AVG(SAL)
                    FROM EX_EMP
                    WHERE DEPTNO = 50);

-- 4. EX_EMP에 속한 사원 중 60번 부서의 사원 중에 입사일이 가장 빠른 사원보다 늦게 입사한 사원의 급여를 10% 인상하고 80번 부서로 이동
UPDATE EX_EMP
    SET SAL = SAL*1.0
        DEPTNO = 80
    WHERE HIREDATE > (SELECT MIN(HIREDATE)
                        FROM EX_EMP
                        WHERE DEPTNO = 60);

-- 5. EX_EMP에 속한 사원 중 급여 등급이 5인 사원을 삭제
DELETE FROM EX_EMP
    WHERE SAL = (SELECT SAL 
                    FROM EX_EMP E, SALGRADE S 
                    WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL 
                    AND GRADE = 5);



    