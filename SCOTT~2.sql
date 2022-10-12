-- 그룹 함수 --

/* [연습문제 1번] */
-- EMP 테이블을 이용하여 부서번호, 평균급여, 최고급여, 최저급여, 사원수를 출력
-- 단, 평균 급여를 출력할 때는 소수점 제외하고 각 부서별로 출력
SELECT DEPTNO 부서번호 , TRUNC(AVG(SAL)) 평균급여, MAX(SAL) 최고급여, MIN(SAL) 최저급여, COUNT(*) 사원수
FROM EMP
GROUP BY DEPTNO;

/* [연습문제 2번] */
-- 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원을 출력
SELECT JOB 직책, COUNT(*) 인원
FROM EMP
GROUP BY JOB
    HAVING COUNT(*) >= 3;

/* [연습문제 3번] */
-- 사원들의 입사 연도를 기준으로 부서별로 몇 명이 입사했는지 출력
SELECT TO_CHAR(HIREDATE, 'YYYY') 입사연도, DEPTNO 부서, COUNT(*) 사원수
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO;

/* [연습문제 4번] */
-- 추가 수당을 받는 사원 수와 받지 않는 사원수를 출력 (O, X로 표기 필요)
SELECT NVL2(COMM, 'O', 'X') AS "추가수당", COUNT(*) AS "사원수"
FROM EMP
GROUP BY NVL2(COMM, 'O', 'X');

/* [연습문제 5번] */
-- 각 부서의 입사 연도별 사원 수, 최고 급여, 급여 합, 평균 급여를 출력하고
-- 각 부서별 소계와 총계 출력
SELECT DEPTNO 부서, TO_CHAR(HIREDATE, 'YYYY') 입사연도,  COUNT(*) 사원수, MAX(SAL) 최고급여, SUM(SAL) 급여합, TRUNC(AVG(SAL)) 평균급여
FROM EMP
GROUP BY DEPTNO, TO_CHAR(HIREDATE, 'YYYY')
ORDER BY DEPTNO;

