SELECT SAL
FROM EMP;

SELECT SUM(SAL)
FROM EMP;

SELECT ENAME, SAL
FROM EMP;

-- 결과를 표시하기 위해서 그룹으로 묶어줌
SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO;

/* 합계 구하기 */
SELECT SUM(DISTINCT SAL), -- DISTINCT : 중복 제거
    SUM(SAL)
FROM EMP;

SELECT DEPTNO, SUM(SAL), SUM(NVL(COMM, 0))
FROM EMP
GROUP BY DEPTNO;

/* 데이터 개수를 구해주는 COUNT 함수 */
SELECT DEPTNO, COUNT(*)
    FROM EMP
GROUP BY DEPTNO;

SELECT COUNT(*)
    FROM EMP
WHERE DEPTNO = 30;

-- NULL이 아닌 경우를 구해서 수당 받는 사람 인원 구하기
-- COUNT도 연산처리를 하기 때문에 NULL은 연산 불가 
-- WHERE COMM IS NOT NULL; 안 넣어도 똑같이 출력
SELECT COUNT(COMM)
    FROM EMP
WHERE COMM IS NOT NULL;

SELECT COUNT(COMM)
    FROM EMP;
    
-------------------------------------------------------------------------------
SELECT MAX(SAL)
    FROM EMP
WHERE DEPTNO = 10;

SELECT MIN(SAL)
    FROM EMP
WHERE DEPTNO = 10;
-------------------------------------------------------------------------------
SELECT MAX(HIREDATE) -- 제일 최근 입사자
    FROM EMP
WHERE DEPTNO = 20;
-------------------------------------------------------------------------------
-- GROUP BY를 사용해서 결과 출력
SELECT DEPTNO, AVG(SAL)
    FROM EMP
WHERE DEPTNO = 30
GROUP BY DEPTNO;

SELECT DEPTNO, AVG(SAL)
    FROM EMP
GROUP BY DEPTNO;

SELECT DEPTNO, ROUND(AVG(SAL))
    FROM EMP
GROUP BY DEPTNO;

-- GROUP BY 절 없이 출력 한다면??
SELECT ROUND(AVG(SAL), 2) "10번 결과"
    FROM EMP
WHERE DEPTNO = 10;
SELECT ROUND(AVG(SAL), 2) "20번 결과"
    FROM EMP
WHERE DEPTNO = 20;
SELECT ROUND(AVG(SAL), 2) "30번 결과"
    FROM EMP
WHERE DEPTNO = 30;

SELECT ROUND(AVG(SAL), 2) "10번 결과" FROM EMP WHERE DEPTNO = 10
UNION ALL
SELECT ROUND(AVG(SAL), 2) "20번 결과" FROM EMP WHERE DEPTNO = 20
UNION ALL
SELECT ROUND(AVG(SAL), 2) "30번 결과" FROM EMP WHERE DEPTNO = 30;
-------------------------------------------------------------------------------
/* 부서 번호 및 직책별 평균 급여로 정렬하기 */
SELECT DEPTNO, JOB, ROUND(AVG(SAL), 2)
    FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

/* 부서 코드, 급여 합계, 부서 평균, 인원수 순 정렬 */
SELECT DEPTNO 부서코드, SUM(SAL) 합계, ROUND(AVG(SAL), 2) 평균, COUNT(*) 인원수
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;
-------------------------------------------------------------------------------
/* HAVING 절 */
-- GROUP BY 절 에서만 사용할 수 있고 조건을 제한하는 용도로 사용됨
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
    HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO;
-------------------------------------------------------------------------------
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
-- WHERE AVG(SAL) >= 2000 : 그룹(집계) 함수에서는 WHERE 절 사용 안됨
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;
-------------------------------------------------------------------------------
/* WHERE 절과 HAVING 절 모두를 사용하는 경우 */
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
WHERE SAL <= 3000 -- 먼저 출력행에 대해서 조건을 통해 제한을 함
GROUP BY DEPTNO, JOB
    HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO, JOB;
-------------------------------------------------------------------------------
-- HAVING 절을 사용하여 EMP 테이블의 부서별 직책의 평균 급여가 500이상인 
-- 사원들의 부서 번호, 직책, 부서, 평균 급여 출력
SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
    HAVING AVG(SAL) >= 500
ORDER BY DEPTNO, JOB;
-------------------------------------------------------------------------------
/* [연습문제 1번] */
-- EMP 테이블을 이용하여 부서번호, 평균급여, 최고급여, 최저급여, 사원수를 출력
-- 단, 평균 급여를 출력할 때는 소수점 제외하고 각 부서별로 출력
SELECT DEPTNO, 
    TRUNC(AVG(SAL)) AS AVR_SAL, 
    MAX(SAL) AS MAX_SAL, 
    MIN(SAL) AS MIN_SAL,
    COUNT(*) AS CNT
    FROM EMP
GROUP BY DEPTNO;

/* [연습문제 2번] */
-- 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원을 출력
SELECT JOB, COUNT(*)
    FROM EMP
GROUP BY JOB
    HAVING COUNT(*) >= 3;

/* [연습문제 3번] */
-- 사원들의 입사 연도를 기준으로 부서별로 몇 명이 입사했는지 출력
SELECT TO_CHAR(HIREDATE, 'YYYY') AS HIRE_DATE, DEPTNO, COUNT(*) AS CNT
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO;

/* [연습문제 4번] */
-- 추가 수당을 받는 사원 수와 받지 않는 사원수를 출력 (O, X로 표기 필요)
SELECT NVL2(COMM, 'O', 'X') AS EXIST_COMM,
    COUNT(*) AS CNT
FROM EMP
GROUP BY NVL2(COMM, 'O', 'X');

/* [연습문제 5번] */
-- 각 부서의 입사 연도별 사원 수, 최고 급여, 급여 합, 평균 급여를 출력하고
-- 각 부서별 소계와 총계 출력
SELECT DEPTNO, 
    TO_CHAR(HIREDATE, 'YYYY') AS HIRE_YEAR,
    COUNT(*) AS CNT,
    MAX(SAL) AS MAX_SAL,
    SUM(SAL) AS SUM_SAL,
    AVG(SAL) AS AVG_SAL
FROM EMP
GROUP BY DEPTNO, TO_CHAR(HIREDATE, 'YYYY')
ORDER BY DEPTNO;
-------------------------------------------------------------------------------
/* 집합 */
-- UNION : SQL문의 결과에 대한 합집합을 반환, 중복 제거
-- UNION ALL : 중복제거를 하지 않음
-- INTERSECT : 교집합, 둘 다 포함된 결과를 반환
-- MINUS : 차집합, 앞에서 뒤를 뺀 결과

-- 합집합
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10
UNION 
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 20;

-- 교집합
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL > 1000
INTERSECT
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL < 2000;

-- 차집합
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
MINUS
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL < 2000;
-------------------------------------------------------------------------------
/* 조인 */
SELECT *
    FROM EMP, DEPT
    WHERE EMP.DEPTNO = DEPT.DEPTNO
ORDER BY EMPNO;

-- 등가 조인(EQUI JOIN) : 테이블을 연결한 후 출력 행을 각 테이블의 특정 열에 일치한 데이터를 기준으로 선정하는 방식
-- 가장 많이 사용되는 조인 방식
-- 오라클 방식
SELECT E.EMPNO 사원번호, E.ENAME 사원이름, D.DEPTNO 부서번호, D.DNAME 부서이름, D.LOC 부서위치
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
ORDER BY D.DEPTNO, E.EMPNO;

SELECT E.EMPNO 사원번호, E.ENAME 사원이름, D.DEPTNO 부서번호, D.DNAME 부서이름, LOC 부서위치 -- LOC는 앞에 D 안붙여도됨(유일한 값이기 때문)
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
ORDER BY D.DEPTNO, E.EMPNO;
-- ANSI 방식
SELECT E.EMPNO, E.ENAME, D.DNAME, LOC
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
ORDER BY D.DEPTNO, E.EMPNO;
-------------------------------------------------------------------------------
-- WHERE 절에 조건식을 추가하여 출력 범위 설정
-- 오라클 방식
SELECT E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME, D.LOC
    FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND SAL >= 3000;

-- ANSI 방식
SELECT E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME, D.LOC
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO 
WHERE SAL >= 3000;
-------------------------------------------------------------------------------
/* 연습문제 */
-- EMP 테이블에 별칭을 E로, DEPT 테이블 별칭을 D로 하여 다음과 같이 등가 조인을 했을 때 급여가 2500 이하이고,
-- 사원번호가 9999 이하인 사원의 정보를 출력
SELECT E.EMPNO 사원번호, E.ENAME 사원이름, E.SAL 급여, D.DEPTNO 부서번호, D.DNAME 부서이름, D.LOC 부서위치
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D.DEPTNO
        AND E.SAL <= 2500
        AND E.EMPNO <= 9999
ORDER BY E.EMPNO;

-- ANSI
SELECT E.EMPNO 사원번호, E.ENAME 사원이름, E.SAL 급여, D.DEPTNO 부서번호, D.DNAME 부서이름, D.LOC 부서위치
    FROM EMP E JOIN DEPT D 
    ON E.DEPTNO = D.DEPTNO
    WHERE E.SAL <= 2500 AND E.EMPNO <= 9999
ORDER BY E.EMPNO;
-------------------------------------------------------------------------------
-- 비등가 조인 : 동일 컬럼이 없이 다른 조건을 사용하여 조인할 때 사용함. 비등가 조인은 자주 사용되지 않음
SELECT E.ENAME, E.SAL, S.GRADE
    FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- ANSI
SELECT E.ENAME, E.SAL, S.GRADE
    FROM EMP E JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;
-------------------------------------------------------------------------------
/* 자체 조인 */
-- 자기 자신과 자신이 조인을 하는 것
-- 사원 정보와 해당 사원의 직속 상관의 사원 정보를 나란히 출력하고자 할 때 사용
SELECT * FROM EMP;

SELECT E1.EMPNO, E1.ENAME, E1.MGR,
    E2.EMPNO AS "상관의사원번호",
    E2.ENAME AS "상관의이름"
    FROM EMP E1, EMP E2
    WHERE E1.MGR = E2.EMPNO;
    
-- ANSI
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
    E2.EMPNO AS "상관의사원번호",
    E2.ENAME AS "상관의이름"
    FROM EMP E1 JOIN EMP E2
    ON E1.MGR = E2.EMPNO;
-------------------------------------------------------------------------------
/* 외부 조인 */
-- 동등(INNER)조인의 경우 한쪽 컬럼에 대한 값이 없다면 해당 행이 조회되지 않습니다.
-- 외부 조인은 내부 조인과 다르게 누락되는 행을 출력하기 위해서 사용
-- 아우터 조인을 사용하는 이유는 기준 테이블의 데이터가 모두 조회됨
-- LEFT OUTER JOIN : 왼쪽에 기술된 테이블의 컬럼수를 기준으로 JOIN
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
    E2.EMPNO AS "상관의사원번호",
    E2.ENAME AS "상관의이름"
    FROM EMP E1, EMP E2
    WHERE E1.MGR = E2.EMPNO(+)
    ORDER BY E1.EMPNO;

-- ANSI
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
    E2.EMPNO AS "상관의사원번호",
    E2.ENAME AS "상관의이름"
    FROM EMP E1 LEFT OUTER JOIN EMP E2
    ON E1.MGR = E2.EMPNO(+)
    ORDER BY E1.EMPNO;
-------------------------------------------------------------------------------
-- RIGHT OUTER JOIN 
SELECT E.ENAME, D.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO(+)= D.DEPTNO
ORDER BY E.DEPTNO;

SELECT E.ENAME, D.DEPTNO, D.DNAME
FROM EMP E RIGHT OUTER JOIN DEPT D
ON E.DEPTNO(+)= D.DEPTNO
ORDER BY E.DEPTNO;

-- NATURAL JOIN
-- 동등 조인과 비슷하지만 WHERE 조건절없이 조인함. 자주 사용 안함
-- 두 테이블에 동일한 이름을 갖는 컬럼은 모두 조인됨
-- 내부적으로 DEPTNO열을 기준으로 등가 조인됨
SELECT EMPNO, ENAME, DNAME
    FROM EMP NATURAL JOIN DEPT;

-- NATURAL JOIN은 ANSI 문법    
SELECT E.EMPNO, E.ENAME, E.JOB, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO, DNAME, D.LOC -- 두 테이블 다 DEPTNO가 있는데 앞에 한쪽 테이블 소속인지를 붙여서는 안됨
FROM EMP E NATURAL JOIN DEPT D
ORDER BY DEPTNO, E.EMPNO;

-- ANSI / JOIN ~ USING
-- 동등조인과 유사하며 동등 조인을 대신해서 사용 가능
-- NATURAL JOIN이 자동으로 조인 기준열을 지정하는 것과 달리 USING 키워드에 조인 기준으로 사용할 열을 명시
-- FROM TALE1 JOIN TABLE2 USING(조인에 사용할 기준열)
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, DEPTNO, D.DNAME, D.LOC
    FROM EMP E JOIN DEPT D USING(DEPTNO)
    WHERE SAL >= 3000
ORDER BY DEPTNO, E.EMPNO;
-------------------------------------------------------------------------------
-- FULL OUTER JOIN 
-- 양쪽 테이블 모두 OUTER JOIN 대상에 포함(어느쪽에 NULL을 포함하더라도 모두 출력)
SELECT E.ENAME, E.DEPTNO, D.DEPTNO, D.DNAME
FROM EMP E FULL OUTER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
ORDER BY E.DEPTNO;
-------------------------------------------------------------------------------
/* [연습 문제 1] */
-- 급여가 2000초과인 사원들의 정보를 출력(부서번호, 부서이름, 사원번호, 사원이름, 급여)
-- 오라클 문법과 ANSI 문법으로 구현
SELECT * FROM EMP; 
SELECT * FROM DEPT;

-- 오라클
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.EMPNO, E.SAL
    FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND E.SAL > 2000
ORDER BY D.DEPTNO;

-- ANSI
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.EMPNO, E.SAL
    FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO AND E.SAL > 2000
ORDER BY D.DEPTNO;

-- NATURAL JOIN
SELECT DEPTNO, D.DNAME, E.ENAME, E.EMPNO, E.SAL
    FROM EMP E NATURAL JOIN DEPT D
WHERE E.SAL > 2000
ORDER BY DEPTNO;

/* [연습 문제 2] */
-- 부서번호, 부서이름, 평균급여, 최대급여, 최소급여, 사원수 출력
-- 오라클 문법과 ANSI 문법으로 구현

-- 오라클
SELECT D.DEPTNO, D.DNAME, 
    TRUNC(AVG(SAL)) AS "평균 급여",
    MAX(SAL) AS "최대 급여",
    MIN(SAL) AS "최소 급여",
    COUNT(*) AS "사원수"
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
GROUP BY D.DEPTNO, D.DNAME;

-- ANSI
SELECT D.DEPTNO, D.DNAME, 
    TRUNC(AVG(SAL)) AS "평균 급여",
    MAX(SAL) AS "최대 급여",
    MIN(SAL) AS "최소 급여",
    COUNT(*) AS "사원수"
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
GROUP BY D.DEPTNO, D.DNAME;

/* [연습 문제 3] */
-- 모든 부서번호, 부서이름, 사원번호, 사원이름, 직책, 급여를 사원이름순으로 정렬하여 출력
-- 오라클 문법과 ANSI 문법으로 구현

-- RIGHT OUTER JOIN
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.JOB, E.SAL
    FROM EMP E RIGHT OUTER JOIN DEPT D -- 채우는 쪽이 플러스
    ON E.DEPTNO = D.DEPTNO
ORDER BY D.DEPTNO, E.ENAME;

-- 오라클
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.JOB, E.SAL
    FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY D.DEPTNO, E.ENAME;

-- ANSI
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.JOB, E.SAL
    FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
ORDER BY D.DEPTNO, E.ENAME;

/* [연습 문제 4] */
-- 부서번호(D), 부서이름, 사원번호, 사원이름, 급여, 직속상관의사원번호, 부서번호(E), 최소급여, 최대급여, 급여등급, 상관사원번호, 상관이름
-- 3개의 테이블 (EMP, DEPT, SALGRADE)
SELECT * FROM SALGRADE; 

SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.SAL, E.MGR, E.DEPTNO, S.LOSAL, S.HISAL, S.GRADE, 
E.EMPNO "상관번호", E2.ENAME "상관이름"
FROM EMP E, DEPT D, SALGRADE S, EMP E2
WHERE E.DEPTNO(+) = D.DEPTNO
AND E.SAL BETWEEN S.LOSAL AND S.HISAL
AND E.MGR = E2.EMPNO
ORDER BY D.DEPTNO, E.EMPNO;
