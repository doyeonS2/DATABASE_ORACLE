-- 조인 --

/* [연습 문제 1] */
-- 급여가 2000초과인 사원들의 정보를 출력(부서번호, 부서이름, 사원번호, 사원이름, 급여)
-- 오라클 문법과 ANSI 문법으로 구현
SELECT * FROM EMP; 
SELECT * FROM DEPT;

-- 오라클
SELECT D.DEPTNO, D.DNAME, E.EMPNO, E.ENAME, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.SAL > 2000
ORDER BY D.DEPTNO;


-- ANSI


-- NATURAL JOIN


/* [연습 문제 2] */
-- 부서번호, 부서이름, 평균급여, 최대급여, 최소급여, 사원수 출력
-- 오라클 문법과 ANSI 문법으로 구현

-- 오라클

-- ANSI


/* [연습 문제 3] */
-- 모든 부서번호, 부서이름, 사원번호, 사원이름, 직책, 급여를 사원이름순으로 정렬하여 출력
-- 오라클 문법과 ANSI 문법으로 구현

-- RIGHT OUTER JOIN


-- 오라클


-- ANSI


/* [연습 문제 4] */
-- 부서번호(D), 부서이름, 사원번호, 사원이름, 급여, 직속상관의사원번호, 부서번호(E), 최소급여, 최대급여, 급여등급, 상관사원번호, 상관이름
-- 3개의 테이블 (EMP, DEPT, SALGRADE)
