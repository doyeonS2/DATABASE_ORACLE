/* 5차 데이터베이스 시험 대비 */

-- 1. 사용자 계정 만드는 방법은 SYSTEM이나 SYS 계정으로 계정을 만들 수 있음
-- CREATE USER TEST IDENTIFIED BY 1234; : 계정을 만드는 방법
-- GRANT RESOURCE : 테이블 생성 권한
-- GRANT CONNECT : 사용자에 대한 DB 접속 권한

-- 2. 부서코드(10 또는 20)에 대한 조건이 일치하고, 급여가 3000이상이고, 보너스 있고, 직책 이름에 _ 앞에 세글자가 있는 사원의 ENAME, EMPNO, DEPTNO, SAL 조회
SELECT ENAME, EMPNO, DEPTNO, SAL
    FROM EMP
    WHERE (DEPTNO = 10 OR DEPTNO = 20) -- OR 조건을 괄호로 묶음
    AND SAL >= 3000 -- 급여가 3000 이상이 되는 조건
    AND COMM IS NOT NULL -- 보너스가 있는 사원에 대한 조건
    AND JOB LIKE '___\_%' ESCAPE '\'; -- 와일드카드 문자 처리
    
-- 3. NULL에 대한 비교
SELECT * FROM EMP -- NULL에 대한 비교는 비교연산자 사용 불가하고 IS NULL / IS NOT NULL로 조건 처리
    WHERE COMM IS NULL
    AND MGR IS NOT NULL;
    
--------------------------------------------------------------
-- 서술형 문제 해결 시나리오

-- 1. NUMBER(3, 2) :  총 길이가 3이고 이 중 소수점 이하 표시가 2자리를 의미

-- 2. DDL(DATA DEFINITION LANGUAGE) : 테이블을 생성(CREATE), 변경(ALTER), 제거(DROP)하는 일을 수행하는 언어

-- 3. DML(DATA MANIPULATION LANGUAGE) : 데이터를 삽입(INSERT), 변경(UPDATE), 삭제(DELETE)하는 등의 데이터를 조작하는 언어

-- 4. DML 중에 INSERT : 데이터베이스에 데이터를 추가하기 위해 사용하는 언어

-- 5. CHAR(100) : 고정 문자열 자료형을 의미하며, 100BYTE의 고정된 문자열을 할당

-- 6. SELECT에서 OUTER JOIN 이란 : 조인하는 테이블에서 한쪽에는 데이터가 있고, 다른 한쪽에는 데이터가 없는 경우 모두 출력하는 방법

-- 7. NVL 함수 : 컬럼에 NULL이 포함되어 있을 때 두번째 매개변수의 값으로 변환하여 출력하는 함수, NVL(COMM, 0)

-- 8. SELECT 문에 대해 설명 : 데이터베이스의 데이터를 조회하기 위한 언어

-- 9. DML 중 DELETE 에 대해 설명 : 데이터베이스의 데이터를 삭제하기 위한 언어

-- 10. DDL 중 CREATE : 데이터베이스의 테이블(객체)을 생성하는 언어

-- 11. 데이터 타입 중 NVARCHAR : 유니코드 문자를 지원하기 위한 자료형이며, 한글이 2BYTE 크기로 할당됨

-- 12. 문자열 데이터를 '210505' -> '2021년5월5일'
SELECT TO_CHAR(TO_DATE('210505','YY/MM/DD'), 'YYYY"년"MM"월"DD"일"') FROM DUAL;

-- 13. FOREIGN KEY 제약 조건 : 서로 다른 테이블간의 관게를 정의하는데 사용하는 제약 조건
     -- 참조하고 있는 기본 키의 데이터 타입과 일치해야 하며, 외래키에 참조되고 있는 기본키는 삭제할 수 없음

-- 14. NOT NULL 제약 조건: 데이터에 NULL을 허용하지 않는 제약 조건

-- 15. 오라클에서 제공하는 데이터 사전에 대한 설명
     -- 데이터베이스의 데이터를 제외한 모든 정보가 저장되어 있음. 내용을 변경하기 위한 권한은 시스템이 가지고 있고, 사용자는 읽기 전용 테이블

-- 16. CHAR와 VARCHAR2의 차이점 설명 : CHAR는 고정길이 문자형이며 최대 2000바이트까지 사용 가능
     -- VARCHAR는 가변 길이 문자형이며 최대 4000바이트까지 사용 가능

-- 17. INNER JOIN : 조인이 되는 키값을 기준으로 교집합 결과셋을 출력하는 조인 방법으로 NULL 값을 포함하지 않음

-- 18. PRIMARY 제약 조건 : NULL을 허용하지 않음, 중복도 허용하지 않음

-- 19. 근무 개월수를 조회하는 SELECT문 작성
SELECT ENAME, HIREDATE "입사일", TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) "근무개월수"
FROM EMP;

-- 20. 이미 생성된 EMP테이블에서 ENAME 컬럼에 UNIQUE 제약 조건 추가하는 쿼리 작성
-- 제약 조건 추가
ALTER TABLE EMP ADD UNIQUE(ENAME);
-- 제약 조건 삭제
ALTER TABLE EMP DROP UNIQUE(ENAME);
-- 제약 조건 변경
ALTER TABLE EMP MODIFY ENAME UNIQUE;
ALTER TABLE EMP ADD CONSTRAINT EMP_UQ_TEST UNIQUE(ENAME);

-- 21. 이미 생성된 EMP 테이블 안에 있는 MGR을 NULL 제약 조건 추가
ALTER TABLE EMP MODIFY MGR CONSTRAINT EMP_MGR_NN NOT NULL;

-- 22. 오라클 조인을 ANSI 표준 구문으로 변경하기
SELECT E.EMPNO, E.ENAME, E.JOB, E.DEPTNO, D.DNAME, D.LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO;
    
-- JOIN ~ ON
SELECT E.EMPNO, E.ENAME, E.JOB, E.DEPTNO, D.DNAME, D.LOC
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO;
    
-- JOIN ~ USING
SELECT E.EMPNO, E.ENAME, E.JOB, E.DEPTNO, D.DNAME, D.LOC
    FROM EMP E JOIN DEPT D USING (DEPTNO);
    
-- 23. SQL의 각 용도를 설명하시오.
  -- SELECT :
  -- DML :
  -- DDL :
  -- TCL(TRANSCTION CONTROL LANGUAGE) :  트랜잭션 제어, COMMIT, ROLLBACK

-- 24. RANK() OVER 함수 : 동일한 순위 이후의 등수를 동일한 인원수 만큼 건너뛰고 순위 계산

-- 25. RANK() OVER 함수와 DENSE_RANK() OVER 함수
  -- DENSE_RANK() OVER : 동일한 순위 이후의 등수를 이후의 순위로 계산
