/* 서브 쿼리 */
-- SQL문 안에서 작성하는 SELECT 문을 의미
-- SELECT, FROM, WHERE 절 어느 곳이든 올 수 있음
-- 서브 쿼리는 반드시 ()괄호 내에 넣어야 합니다
SELECT * FROM DEPT;
-- 서브 쿼리문 수행 결과와 WHERE절을 비교함. (서브 쿼리문의 수행 결과가 10을 반환함)

SELECT DNAME FROM DEPT
    WHERE DEPTNO = (SELECT DEPTNO 
                    FROM EMP
                    WHERE ENAME = 'KING');
                    
SELECT DNAME FROM DEPT
    WHERE DEPTNO = 10;
    
SELECT DEPTNO
    FROM EMP
    WHERE ENAME = 'KING';
------------------------------------------------------------------------------
-- 서브 쿼리로 JONES의 급여보다 높은 급여를 받는 사원 정보 출력하기
-- 서브 쿼리문 수행 결과로 JONES의 급여를 가지고 옴
SELECT *
    FROM EMP
WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME = 'JONES');

SELECT * FROM EMP;
SELECT SAL FROM EMP WHERE ENAME = 'JONES';

-- EMP 테이블의 사원 정보 중에서 사원 이름이 ALLEN인 사원의 추가 수당보다 많은 추가 수당을 받는 사원 정보 구하기
-- 추가 수당에 대한 비교값을 서브쿼리로부터 가져옴
SELECT *
    FROM EMP
WHERE COMM > (SELECT COMM 
                FROM EMP
                WHERE ENAME = 'ALLEN');
-- 단일행 서브쿼리와 날짜형 데이터
SELECT HIREDATE
    FROM EMP;
    
SELECT *
    FROM EMP
WHERE HIREDATE < (SELECT HIREDATE FROM EMP WHERE ENAME = 'JAMES');

-- 동등조인과 결합해서 사용하기
-- 서브쿼리문을 통해 EMP 테이블의 SAL의 평균 급여를 먼저 구함
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DEPTNO, D.DNAME, D.LOC
    FROM EMP E, DEPT D
    WHERE E.DEPTNO = D. DEPTNO
    AND E.DEPTNO = 20 AND E.SAL > (SELECT AVG(SAL) FROM EMP);

SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DEPTNO, D.DNAME, D.LOC
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D. DEPTNO
    WHERE E.DEPTNO = 20 AND E.SAL > (SELECT AVG(SAL) FROM EMP);
    
SELECT AVG(SAL)
    FROM EMP;
------------------------------------------------------------------------------
-- 실행 결과가 여러개인 다중행 서브쿼리
-- IN : 메인 쿼리의 데이터가 서브쿼리의 결과 중 하나라도 일치하면 TRUE
-- 각 부서에서 제일 급여가 높은 사람을 찾아줌
SELECT * 
    FROM EMP
    WHERE SAL IN (SELECT MAX(SAL) 
                    FROM EMP
                    GROUP BY DEPTNO);
    
SELECT MAX(SAL)
    FROM EMP
    GROUP BY DEPTNO;
    
-----------------------------------------------------------------------------
-- ANY : 메인 쿼리의 조건식을 만족하는 서브 쿼리의 결과가 하나 이상이면 TRUE
-- 서브 쿼리의 결과가 여러개 존재하기 때문에 다중행 연산자 필요 (IN, ANY, ALL, EXISTS)
SELECT EMPNO, ENAME, SAL
    FROM EMP
    WHERE SAL > ANY(SELECT SAL 
                    FROM EMP
                    WHERE JOB = 'SALESMAN');

-- 1600, 1250, 1500

/* 단일행 서브 쿼리 */
    SELECT *
    FROM EMP
    WHERE SAL > (SELECT SAL 
                    FROM EMP
                    WHERE JOB = 'SALESMAN');
-----------------------------------------------------------------------------
-- 30번 부서 사원들의 최대 급여보다 적은 급여를 받는 사원 정보 출력
SELECT *
    FROM EMP
    WHERE SAL < ANY(SELECT SAL
                    FROM EMP
                    WHERE DEPTNO = 30)
    ORDER BY SAL, DEPTNO;
                    
SELECT SAL FROM EMP WHERE DEPTNO = 30; -- 1600, 1250, 2850, 1500, 900
-----------------------------------------------------------------------------
-- 다중행 연산자 ALL : 메인 쿼리의 비교 조건이 서브 쿼리의 여러 검색 결과와 모든 값이 일치하면 TRUE
SELECT SAL FROM EMP WHERE JOB = 'MANAGER';

-- 급여가 서브쿼리의 결과인 매니저 급여보다 모두 큰 경우만 TRUE
SELECT EMPNO, ENAME, SAL
    FROM EMP
    WHERE SAL > ALL(SELECT SAL
                    FROM EMP
                    WHERE JOB = 'MANAGER');
                    
-- 급여가 30번 부서의 급여보다 적은 경우만 TRUE
SELECT *
    FROM EMP
    WHERE SAL < ALL(SELECT SAL
                    FROM EMP
                    WHERE DEPTNO = 30)
    ORDER BY SAL, DEPTNO;
-----------------------------------------------------------------------------
-- EXISTS 연산자 : 서브쿼리의 결과 값이 하나 이상 존재하면 TRUE, 존재하지 않으면 FALSE
-- 결과값이 한개라도 있으면 전체가 TRUE가 됨
SELECT *
    FROM EMP
    WHERE EXISTS (SELECT DNAME
                    FROM DEPT
                    WHERE DEPTNO = 10);
                    
SELECT *
    FROM EMP
    WHERE EXISTS (SELECT DNAME
                    FROM DEPT
                    WHERE DEPTNO = 20);                   
-----------------------------------------------------------------------------
/* 다중열 서브 쿼리 */
-- 서브 쿼리의 결과가 두개 이상의 컬럼으로 반환되어 메인 쿼리에 전달
SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
    WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, SAL
                                FROM EMP
                                WHERE DEPTNO = 30);
                                
SELECT DEPTNO, SAL FROM EMP WHERE DEPTNO = 30;
-----------------------------------------------------------------------------
-- GROUP BY 절이 포함된 다중열 서브쿼리
SELECT *
    FROM EMP
    WHERE (DEPNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
                            FROM EMP
                            GROUP BY DEPTNO);
                            
SELECT DEPTNO, MAX(SAL)
    FROM EMP
    GROUP BY DEPTNO;
-----------------------------------------------------------------------------
/* 시험문제!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
FROM 절 에다가 ORDER BY 절 넣기 !!!!!!!!!!!!!!!!!!!!!!!!! */

/* FROM 절에 사용하는 서브쿼리 */
-- 메인쿼리의 FROM 절을 서브쿼리로 이용하는 방법으로 인라인뷰라고 부릅니다.
-- 사용용도는 테이블이 너무 큰 경우 필요한 행과 열만 사용하고자 할 때
-- 먼저 정렬이 필요한 경우 등에 사용합니다.
-- 하지만 FROM 절에 너무 많은 서브쿼리를 사용하면 가독성이 나빠지고, 성능이 떨어질 수 있습니다.
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
    FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10, 
        (SELECT * FROM DEPT)D
    WHERE E10.DEPTNO = D.DEPTNO;
-----------------------------------------------------------------------------
-- 먼저 정렬이 필요한 경우 : 급여가 높은 사람 3명 출력 (시험문제!!!!!!! 참고!!!!!!!!!!!)
-- ROWNUM : 오라클에서 제공하며 행번호를 매겨준다.
SELECT ROWNUM, ENAME, SAL
    FROM (SELECT * 
        FROM EMP
        ORDER BY SAL DESC)
WHERE ROWNUM <= 3;
-----------------------------------------------------------------------------
/* SELECT 절에 사용하는 서브쿼리 */
-- SELECT 문에서 사용하는 단일행 서브쿼리를 스칼라 서브쿼리라고 합니다.
-- SELECT 절에 명시하는 서브쿼리는 반드시 하나의 결과만 반환하도록 작성해야 합니다.
SELECT * FROM DEPT;            
SELECT * FROM SALGRADE;

SELECT EMPNO, ENAME, JOB, SAL,
        (SELECT GRADE
            FROM SALGRADE
            WHERE EMP.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE,
        DEPTNO,
        (SELECT DNAME
            FROM DEPT
            WHERE EMP.DEPTNO = DEPT.DEPTNO) DNAME
    FROM EMP;
-----------------------------------------------------------------------------
-- 행마다 부서번호가 각 행의 부서번호와 동일한 사원들의 급여 평균을 구해서 반환
-- 사원이름 / 부서번호 / 급여 / 부서의평균
SELECT ENAME, DEPTNO, SAL,
    (SELECT TRUNC(AVG(SAL)) 
        FROM EMP
        WHERE DEPTNO = E.DEPTNO) AS "부서평균급여"
    FROM EMP E;
    
SELECT TRUNC(AVG(SAL))
    FROM EMP
    WHERE DEPTNO = 30;
-----------------------------------------------------------------------------
-- 부서 위치가 NEWYORK 인 경우에 본사, 그외 부서는 분점으로 반환하는 코드 작성
-- CASE문 
SELECT EMPNO, ENAME,
    CASE 
        WHEN DEPTNO = (SELECT DEPTNO
                        FROM DEPT
                        WHERE LOC = 'NEW YORK')
        THEN '본사'
        ELSE '분점'
    END AS 소속
FROM EMP;
-----------------------------------------------------------------------------
/* 연습문제 1 */
-- 전체 사원 중 ALLEN과 같은 직책인 사원들의 사원 정보, 부서 정보를 출력
SELECT E.JOB, E.EMPNO, E.ENAME, E.SAL, E.DEPTNO, D.DNAME
    FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND JOB = (SELECT JOB 
                    FROM EMP 
                WHERE ENAME = 'ALLEN');
                
SELECT E.JOB, E.EMPNO, E.ENAME, S.SAL, D.DEPTNO, D.DNAME
    FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
    AND JOB = (SELECT JOB 
                FROM EMP 
            WHERE ENAME = 'ALLEN');
                
/* 연습문제 2 */      
-- 전체 사원의 평균 급여보다 높은 급여를 받는 사원 정보 출력
-- 단일행 서브쿼리를 묻는 문제 : >, <, =, <=, >-, <>, !=, ^=
SELECT E.EMPNO, E.ENAME, D.DNAME, E.HIREDATE, D.LOC, E.SAL, S.GRADE
    FROM EMP E, DEPT D, SALGRADE S
WHERE D.DEPTNO = E.DEPTNO
    AND E.SAL BETWEEN S.LOSAL AND S.HISAL -- 비등가조인
    AND SAL > (SELECT AVG(SAL)
                FROM EMP)
ORDER BY E.SAL DESC, E.EMPNO;

/* 연습문제 3 */
-- 10번 부서에 근무하는 사원 중 30번 부서에는 존재하지 않는 직책을 가진 정보
-- 다중행 서브쿼리를 묻는 문제 : IN (NOT IN), ANY(하나만 만족), SOME(하나만 만족), ALL(모두 만족해야 함),
-- EXIST : 쿼리의 결과가 하나라도 만족하면 TRUE (하나라도 포함되어 있으면 다 출력)
SELECT E.EMPNO, E.ENAME, E.JOB, D.DEPTNO, D.DNAME, D.LOC
    FROM EMP E, DEPT D
WHERE D.DEPTNO = E.DEPTNO
    AND E.DEPTNO = 10
    AND JOB NOT IN (SELECT DISTINCT JOB
                    FROM EMP
                    WHERE DEPTNO = 30);

/* 연습문제 4 */
-- 직책이 SALESMAN인 사람들의 최고급여보다 높은 사람 출력
-- 다중행 연산자 사용하지 않음
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
    FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL -- 비등가조인 (등가조인과 다르게 범위로 조인을 건다.)
    AND SAL > (SELECT MAX(SAL)
                FROM EMP
                WHERE JOB = 'SALESMAN')
ORDER BY E.EMPNO;

-- 다중행 사용
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
    FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
    AND SAL > ALL (SELECT DISTINCT SAL  -- 직책이 SALESMAN인 모든 사람의 급여보다 큰 경우(ALL은 모두 만족해야 함)
                    FROM EMP
                    WHERE JOB = 'SALESMAN')
ORDER BY E.EMPNO;
-----------------------------------------------------------------------------
