/* 6차 SQL응용 시험 대비 */

-- 1. 사용자 계정을 만들기 위해 관리자 계정으로 접속
-- CREATE USER TEST IDENTIFIED BY TEST1234;
-- USER TEST CREATE SESSION .......: LOGON DENIED
-- 권한 부여 필요 : GRANT CREATE SESSION TO TEST;

-- 2. 
CREATE TABLE DEPARTMENT(
    DEPTCODE NUMBER PRIMARY KEY,
    DEPTNAME VARCHAR2(10) NOT NULL
);

CREATE TABLE EMPLOYEE(
    EMPNO NUMBER PRIMARY KEY,
    EMPNAME VARCHAR2(10) NOT NULL,
    DEPTNO NUMBER REFERENCES DEPARTMENT(DEPTCODE)
);

/* 등가 조인을 대신하는 조인 방식으로 USING 키워드에 조인 기준으로 사용할 열을 명시해야 함 */
SELECT EMPNO, EMPNAME, DEPTNO, DEPTNAME
    FROM EMPLOYEE
JOIN DEPARTMENT USING(DEPTNO); -- 왜 에러가 나는지??가 문제

-- 조인을 걸어야 함
-- 이게 정답!!!!!!!!!!!!!!!!!!
SELECT EMPNO, EMPNAME, DEPTNO, DEPTNAME
    FROM EMPLOYEE JOIN DEPARTMENT
    ON DEPTNO = DEPTCODE;
    
SELECT EMPNO, EMPNAME, DEPTNO, DEPTNAME
    FROM EMPLOYEE, DEPARTMENT
    WHERE DEPTNO = DEPTCODE;
    
--------------------------------------------------------------------
/* 서술형 문제 */

-- 1. NUMBER(3, 2) : 최대 3자릿수에 소수점 이하 2자리 허용

-- 2. DML에서 UPDATE 문에 대해 설명 : 데이터베이스에 등록된 데이터를 수정하기 위해 사용하는 언어

-- 3. DML INSERT : 데이터베이스에 등록된 데이터를 추가하기 위해 사용하는 언어

-- 4. 자료형 CHAR(100) : 고정된 문자열로 100자를 입력받는다는 의미

-- 5. OUTER JOIN에 대해 설명 : 아우터 조인을 사용하는 이유는 기준 테이블의 데이터가 모두 조회(누락 없이)되고, 대상 테이블에 데이터가 있을 경우 해당 컬럼의 값을 가져오기 위해서이다.

-- 6. NVL 함수에 대해 설명하고 BONUS 컬럼에 NULL값이 있을 때 NULL을 0으로 출력
    SELECT NVL(BONUS, 0) FROM EMP;
    
-- 7. DML 중 SELECT 문에 대한 설명 : 데이터베이스에 등록된 데이터를 조회하기 위해 사용하는 언어

-- 8. DML 중 DELETE 문에 대한 설명 : 데이터베이스에 등록된 데이터를 삭제하기 위해 사용하는 언어

-- 9. DML 중 CREATE 문에 대한 설명 : 데이터베이스 테이블(객체)를 생성하는 명령어

-- 10. NVARCHAR에 대한 설명 : 유니코드 문자형을 지원하기 위한 자료형이며 모든 문자를 2BYTE로 처리함

-- 11. 문자열 데이터 '210505'를 '2021년5월5일'로 표현될 수 있도록 SELECT 구문 작성
SELECT TO_CHAR(TO_DATE('210505'),'YYYY"년"MM"월"DD"일"') FROM DUAL;
SELECT TO_CHAR(TO_DATE('210505','YY/MM/DD'), 'YYYY"년"MM"월"DD"일"') FROM DUAL;

-- 12. FORIGEN KEY 제약 조건에 대한 설명 : 
-- 참조하고 있는 테이블의 컬럼 값이 존재하는 값만 허용하는 제약 조건
-- 참조하고 있는 기본 키의 데이터 타입이 일치해야 하고, 외래 키에 참조되고 있는 기본키는 삭제할 수 없음

-- 13. 오라클에서 제공하는 데이터 사전에 대한 설명 : 
-- 데이터베이스의 데이터를 제외한 모든 정보를 가지고 있음
-- 사용자에게는 읽기 전용으로 정보를 제공, DDL 명령이 실행될 때마다 데이터 사전을 조회한다. 사용자의 권한 등의 변경 사항을 반영

-- 14. NOT NULL 제약 조건 : 데이터에 NULL을 허용하지 않는 제약 조건

-- 15. CHAR와 VARCHAR2 자료형의 차이점 기술 : CHAR는 고정길이 문자형이며 최대 2000바이트까지 사용 가능, VARCHAR2는 가변 길이 문자형이며 최대 4000바이트까지 사용 가능

-- 16. INNER JOIN : 조인이 되는 키값을 기준으로 교집합 결과셋을 출력하는 조인 방법으로 각 테이블의 NULL 값을 포함하지 않음

-- 17. PRIMARY 제약 조건 설명 : NULL 값을 가질 수 없고, 중복을 허용하지 않음

-- 18. EMP 테이블에서 사원이름, 입사일, 근무개월수 조회
SELECT ENAME "이름", HIREDATE "입사일", TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) "근무개월수"
FROM EMP;

-- 19. 이미 생성된 EMP 테이블에서 EMP_NAME 컬럼에 UNIQUE 제약 조건 추가
ALTER TABLE EMP ADD UNIQUE(EMP_NAME);

-- 20. 이미 생성된 EMP 테이블에 ENAME 컬럼에 NOT NULL 제약 조건 추가
ALTER TABLE EMP_DDL MODIFY ENAME NOT NULL;

-- 21. 오라클 구문으로 작성된 JOIN을 ANSI 표준 구문으로 변경하기
SELECT E.EMPNO, E.ENAME, E.JOB, D.DNAME, D.LOC, E.SAL
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

-- 22. SQL문의 각 용도 설명 :
-- SELECT :
-- DML :
-- DDL :
-- TCL : 트랜잭션 제어, COMMIT, ROLLBACK

-- 23. RANK() OVER, DENSE_RANK() OVER 함수에 대한 설명
-- RANK() OVER : 동일한 순위 이후 동일한 순위 만큼 건너뛰고 순위 계산
-- DENSE_RANK() OVER : 동일한 순위 이후의 등수를 이후의 순위로 계산

-- 24. 





