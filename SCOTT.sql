DESC EMP; -- EMP 테이블 정보 확인
-- EMPNO : 사원번호, 4자리 정수, 기본키이기 때문에 NULL 값이 올 수 없음
-- ENAME : 10자리 가변 문자열
-- JOB : 직책, 9자리 가변 문자열
-- MGR : 직속상관의 사원번호, 4자리 숫자
-- HIREDATE : 입사일, 날짜형 데이터
-- SAL : 급여, 두자리 소수점을 포함하여 총 7자리 숫자형
-- COMM : 급여 외 추가 수당, 소수점을 포함하여 총 7자리 숫자형
-- DEPTNO : 부서번호, 2자리 숫자
SELECT EMPNO AS 사원번호, ENAME AS 이름, JOB AS 직책, HIREDATE AS 입사일 -- 조회할 열 이름을 나열하면 됨. 콤마 기준
FROM EMP; -- EMP 테이블의 모든 정보를 보여줌, 문장의 끝에는 ;(세미콜론) 붙임
----------------------------------------------------------------------------------------------------
/* 별칭 붙이기 */
SELECT ENAME AS "이 름", SAL AS "$급여" -- 별칭을 붙일 때 AS는 생략 가능, 별칭에 공백이나 특수문자가 포함되면 "" 감싸줘야함
FROM EMP;
----------------------------------------------------------------------------------------------------
SHOW USER -- 현재의 계정을 확인하는 구문
----------------------------------------------------------------------------------------------------
/* 중복을 제거하는 DISTINCT */
SELECT DISTINCT DEPTNO
FROM EMP;
/*두가지 조건에 대한 중복 제거 */
SELECT DISTINCT JOB, DEPTNO
FROM EMP;
-----------------------------------------------------------------------------------------------------
/* 컬럼에 대한 산술 연산자(+, -, *, /) 사용 */
SELECT ENAME 이름, SAL 월급, SAL*12 연봉
FROM EMP;
-----------------------------------------------------------------------------------------------------
/* WHERE : 데이터를 조회할 때 원하는 조건에 맞는 데이터만 조회하고자 할 때 사용하는 구문 */
SELECT ENAME, SAL*12, DEPTNO, HIREDATE, EMPNO AS "empno"
    FROM EMP
-- WHERE DEPTNO = 10; '=' 한개만 사용하면 '같다'라는 의미가 됨
-- WHERE JOB = 'MANAGER';
-- WHERE EMPNO = 7566;
WHERE SAL * 12 = 36000;
-----------------------------------------------------------------------------------------------------
/* 비교 연산자(>, <, >=, <=) 사용 */
SELECT *
    FROM EMP
-- WHERE COMM > 300;
-- WHERE COMM IS NOT NULL;
-- WHERE DOMM > 100;
WHERE HIREDATE > '81/01/01'; -- 입사일이 81/01/01 이후 입사한 사람에 대한 조건
-----------------------------------------------------------------------------------------------------
/* 같지 않음을 표현하는 여러가지 방법 */
SELECT *
    FROM EMP
/* WHERE DEPTNO <> 30; */
WHERE DEPTNO != 30; /* <>, !=. ^=, NOT = */
-----------------------------------------------------------------------------------------------------
/* 비교 연산자와 논리 연산자 함께 사용하기 */
SELECT * 
    FROM EMP
WHERE SAL >= 3000 AND DEPTNO = 20; -- 급여가 3000과 같거나 크고 부서번호 20인 경우

SELECT * 
    FROM EMP
WHERE SAL >= 3000 OR DEPTNO = 20; 

SELECT * 
    FROM EMP
WHERE SAL >= 3000 AND DEPTNO = 20 AND HIREDATE < '82/01/01'; -- 3가지 조건을 다 만족하는 경우
-----------------------------------------------------------------------------------------------------
/* 복습 문제 1 : 급여가 2500이상이고, 직업이 MANAGER인 사원만 나오도록 쿼리 작성 */
SELECT *
    FROM EMP
WHERE SAL >= 2500 AND JOB = 'MANAGER'; 
-----------------------------------------------------------------------------------------------------
/* IN 연산자 : 특정 열에 포함된 데이터를 여러개 조회할 때 사용 */
SELECT *
    FROM EMP
-- WHERE JOB = 'MANAGER' OR JOB = 'SALESMAN' OR JOB = 'CLERK'
WHERE JOB IN('MANAGER', 'SALESMAN', 'CLERK');

SELECT *
    FROM EMP
-- WHERE DEPTNO IN(20, 30); 
WHERE DEPTNO NOT IN(20, 30); -- NOT IN은 포함되어 있지 않은 데이터를 보여줌
-----------------------------------------------------------------------------------------------------
/* 등가 비교 연산자와 AND 연산자를 사용하여 출력하기 */
SELECT *
    FROM EMP
WHERE JOB != 'MANAGER'
    AND JOB ^= 'SALESMAN'
    AND JOB <> 'CLERK'; 

-- IN 연산자 사용으로 변경하기
SELECT *
    FROM EMP
WHERE JOB NOT IN('MANAGER', 'SALESMAN', 'CLERK'); 
-----------------------------------------------------------------------------------------------------
/* BETWEEN A AND B 연산자 : A와 B사이에 존재하는 것을 출력해줌 */
SELECT *
    FROM EMP
WHERE SAL >= 2000 AND SAL <= 3000;

SELECT *
    FROM EMP
WHERE SAL BETWEEN 2000 AND 3000;

SELECT *
    FROM EMP
WHERE SAL NOT BETWEEN 2000 AND 3000; -- A와 B 사이가 아닌 것 출력

SELECT *
    FROM EMP
WHERE EMPNO BETWEEN 7689 AND 9702;

/* 1980년이 아닌 해에 입사한 직원을 조회하기 */
SELECT *
    FROM EMP
WHERE NOT HIREDATE BETWEEN '1980/01/01' AND '1980/12/31'; 
-----------------------------------------------------------------------------------------------------
/* LIKE 절 : 특정 문자 혹은 문자열을 포함하는지 확인할 때 사용 */
-- % : 길이와 상관없이 모든 문자 데이터를 의미(0개 이상의 문자열과 대치됨)
-- _ : 문자 1개를 의미(1개의 문자와 대치됨)

SELECT *
    FROM EMP
WHERE ENAME LIKE '%K%';  -- K를 포함하는 모든 이름 찾기

SELECT *
    FROM EMP
WHERE ENAME LIKE 'K%'; -- K로 시작하는 모든 이름 찾기

/* 사원이름의 두번째 글자가 L인 사원만 출력하기 */
SELECT *
    FROM EMP
WHERE ENAME LIKE '_L%'; -- '_' 한개당 1글자에 대한 문자 대치

SELECT *
    FROM EMP
WHERE ENAME LIKE '__L%'; -- 세번째 글자가 L인 사원 출력됨
-----------------------------------------------------------------------------------------------------
/* 사원 이름에 AM이 포함되어 있는 사원 데이터만 출력하기 */
SELECT *
    FROM EMP
WHERE ENAME LIKE '%AM%';

SELECT *
    FROM EMP
WHERE ENAME NOT LIKE '%AM%'; -- 이름에 AM이 포함되지 않는 사원 출력
-----------------------------------------------------------------------------------------------------
/* %와 _가 문자의 일부에 포함되어 있는 경우에 대한 처리 */
/* ESCAPE로 지정된 '\' 뒤에 오는 '%' 문자열 대치하는 와일드 카드가 아니고 실제로 포함된 데이터로 간주 */
SELECT *
    FROM EMP
WHERE ENAME LIKE '%\%P' ESCAPE '\';
-----------------------------------------------------------------------------------------------------
/* IS NULL 연산자 : NULL 값과 연산을 수행하면 연산 결과를 얻을 수 없음 */
-- NULL? 값이 존재하지 않음을 의미, 확정되지 않은 값을 의미
SELECT ENAME, SAL, SAL*12+COMM AS 연봉에성과급포함, COMM
    FROM EMP
WHERE COMM IS NOT NULL; -- NULL이 아닌 항목을 선택
-----------------------------------------------------------------------------------------------------
/* 직속상관이 있는 사원 데이터만 출력하기 */
SELECT *
    FROM EMP
WHERE MGR IS NOT NULL;
-----------------------------------------------------------------------------------------------------
/* 정렬을 위한 ORDER BY 절 : 기본은 오름차순(ASC), 내림차순(DESC) */
SELECT *
FROM EMP
ORDER BY SAL; -- 기본은 오름차순으로 정렬
ORDER BY SAL ASC; -- 오름차순
ORDER BY SAL DESC; -- 내림차순
-----------------------------------------------------------------------------------------------------
/* 사원 번호 기준 오름차순 정렬 */
SELECT *
    FROM EMP
ORDER BY EMPNO;
-----------------------------------------------------------------------------------------------------
/* 여러 컬럼 기준으로 오름차순 정렬하기 */
SELECT *
    FROM EMP
ORDER BY SAL, ENAME; -- 먼저 SAL 기준으로 정렬하고, 값이 같은 경우 ENAME 기준으로 정렬

SELECT *
    FROM EMP
ORDER BY SAL, ENAME DESC; -- SAL은 오름차순, ENAME은 내림차순으로 정렬
-----------------------------------------------------------------------------------------------------
/* 내림차순과 오름차순 함께 사용하기 */
SELECT * 
    FROM EMP
ORDER BY DEPTNO ASC, SAL DESC;
-----------------------------------------------------------------------------------------------------
/* 별칭과 ORDER BY 함께 사용하기 */
-- ORDER BY 절은 정렬이 꼭 필요한 경우가 아니면 사용 자제, 여기저기 데이터를 기준에 따라 정렬하는 것은 많은 자원을 소모함
SELECT EMPNO 사원번호, ENAME 사원명, SAL 월급, HIREDATE 입사일
    FROM EMP
ORDER BY 월급 DESC, 사원명 ASC;
-----------------------------------------------------------------------------------------------------
/* 연결연산자 || : 문자열을 이어 붙임 */
SELECT ENAME || 'S JOB IS ' ||JOB AS 종업원
    FROM EMP;
-----------------------------------------------------------------------------------------------------
-- 1. 사원이름이 S로 끝나는 사원 데이터를 모두 출력하기 (LIKE 사용)
SELECT *
    FROM EMP
WHERE ENAME LIKE '%S';

-- 2. 30번 부서에서 근무하고 있는 사원 중에 직책이 SALESMAN인 사원의 사원번호, 이름, 직책, 급여, 부서번호를 출력
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
    FROM EMP
WHERE DEPTNO = 30 AND JOB = 'SALESMAN';
-----------------------------------------------------------------------------------------------------
-- 3. 20번, 30번 부서에 근무하고 있는 사원 중 급여(SAL)가 2000 초과인 사원을 두가지 방식의 
-- SELECT 문을 사용하여 사원 번호, 이름, 급여, 부서번호를 출력
SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
WHERE (DEPTNO = 20 OR DEPTNO = 30) AND SAL > 2000;

SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
WHERE DEPTNO IN(20, 30) AND SAL > 2000;
-----------------------------------------------------------------------------------------------------
-- 4. 급여가 2000 이상 3000이하 범위 이외의 값을 가진 데이터만 출력하기 (NOT BETWEEN 사용과 미사용으로 작성)
SELECT *
    FROM EMP
WHERE SAL < 2000 OR SAL > 3000; 

SELECT *
    FROM EMP
WHERE SAL NOT BETWEEN 2000 AND 3000; -- 2000에서 3000사이이므로 2000과 3000 둘 다 포함임
-----------------------------------------------------------------------------------------------------
-- 5. 사원 이름에 E가 포함되어 있는 30번 부서의 사원 중 1000~2000 사이가 아닌 사원 이름, 사원번호, 급여, 부서번호 출력
SELECT ENAME, EMPNO, SAL, DEPTNO
    FROM EMP
WHERE ENAME LIKE '%E%' 
    AND DEPTNO = 30
    AND SAL NOT BETWEEN 1000 AND 2000; 
-----------------------------------------------------------------------------------------------------
-- 6. 추가 수당이 존재하지 않고 상급자가 있고 직책이 MANAGER, CLERK인 사원 중에서 사원 이름의 두번째 글자가 L이 아닌 사원의 정보 출력
SELECT*
    FROM EMP
WHERE COMM IS NULL 
    AND MGR IS NOT NULL
    AND JOB IN('MANAGER', 'CLERK')
    AND ENAME NOT LIKE '_L%';
    
-----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------
/* SCOTT 계정과 연습문제 */

-- 1. EMP테이블에서 COMM 의 값이 NULL이 아닌 정보 조회
SELECT *
    FROM EMP
WHERE COMM IS NOT NULL;

-- 2. EMP테이블에서 커미션을 받지 못하는 직원 조회(COMM이 NULL이거나 0인 경우)
SELECT *
    FROM EMP
WHERE COMM IS NULL OR COMM = 0;

-- 3. EMP테이블에서 관리자가 없는 직원 정보 조회
SELECT *
    FROM EMP
WHERE MGR IS NULL;

-- 4. EMP테이블에서 급여를 많이 받는 직원 순으로 조회(내림차순)
SELECT *
    FROM EMP
ORDER BY SAL DESC;

-- 5. EMP테이블에서 급여가 같을 경우 커미션을 내림차순 정렬 조회
SELECT *
    FROM EMP
ORDER BY SAL DESC, COMM DESC;

-- 6. EMP테이블에서 사원번호, 사원명,직급, 입사일 조회 (단, 입사일을 오름차순 정렬 처리)
SELECT EMPNO, ENAME, JOB, HIREDATE
    FROM EMP
ORDER BY HIREDATE ASC;

-- 7. EMP테이블에서 사원번호, 사원명 조회 (사원번호 기준 내림차순 정렬)
SELECT EMPNO, ENAME
    FROM EMP
ORDER BY EMPNO DESC;

-- 8. EMP테이블에서 사번, 입사일, 사원명, 급여 조회  (부서번호가 빠른 순으로, 같은 부서번호일 때는 최근 입사일 순으로 처리)
SELECT EMPNO, HIREDATE, ENAME, SAL, DEPTNO
    FROM EMP
ORDER BY DEPTNO, HIREDATE DESC;

-- 9. 오늘 날짜에 대한 정보 조회
SELECT SYSDATE
    FROM DUAL;

-- 10. EMP테이블에서 사번, 사원명, 급여 조회  (단, 급여는 100단위까지의 값만 출력 처리하고 급여 기준 내림차순 정렬)
SELECT EMPNO, ENAME, ROUND(SAL, -2)
    FROM EMP
ORDER BY SAL DESC; 

-- 11. EMP테이블에서 사원번호가 홀수인 사원들을 조회
SELECT *
    FROM EMP
WHERE MOD(EMPNO, 2) = 1; 

-- 12. EMP테이블에서 사원명, 입사일 조회 (단, 입사일은 년도와 월을 분리 추출해서 출력)
SELECT ENAME, EXTRACT(YEAR FROM HIREDATE), EXTRACT(MONTH FROM HIREDATE)
    FROM EMP;

-- 13. EMP테이블에서 9월에 입사한 직원의 정보 조회
-- EXTRACT('날짜요소' FROM XX)
SELECT *
    FROM EMP
WHERE HIREDATE LIKE '___09%';

SELECT *
    FROM EMP
WHERE EXTRACT(MONTH FROM HIREDATE) = 9;

-- 14. EMP테이블에서 81년도에 입사한 직원 조회
SELECT *
    FROM EMP
WHERE HIREDATE BETWEEN '1981/01/01' AND '1981/12/31';

SELECT *
    FROM EMP
WHERE EXTRACT(YEAR FROM HIREDATE) = 1981;

-- 15. EMP테이블에서 이름이 'E'로 끝나는 직원 조회
SELECT *
    FROM EMP
WHERE ENAME LIKE '%E';

-- 16. EMP테이블에서 이름의 세 번째 글자가 'R'인 직원의 정보 조회(LIKE 사용)
SELECT *
    FROM EMP
WHERE ENAME LIKE '__R%';

-- 17. EMP테이블에서 사번, 사원명, 입사일, 입사일로부터 40년 되는 날짜 조회
-- ADD_MONTHS() : 날짜에서 숫자(달) 만큼을 이동 시킴
SELECT EMPNO, ENAME, JOB, HIREDATE, ADD_MONTHS(HIREDATE, 12*40)
    FROM EMP;

-- 18. EMP테이블에서 입사일로부터 38년 이상 근무한 직원의 정보 조회 (날짜1 - 날짜2) = 달
SELECT *
    FROM EMP
WHERE MONTH_BETWEEN(SYSDATE, HIREDATE)/12 >= 38;

-- 19. 오늘 날짜에서 년도만 추출
SELECT TO_CHAR(SYSDATE, 'YY') AS 연도
    FROM DUAL; -- 오라클이 설치될 때 만들어지는 임시 테이블
    
-- 20. 이름이 S자로 시작하고 마지막 글자가 T인 사원의 모든 정보를 출력
SELECT *
    FROM EMP
WHERE ENAME LIKE ('S%H');
    
-- 21. 처음의 글자는 관계없고 두번째 글자가 A인 사원의 모든 정보 출력
SELECT *
    FROM EMP
WHERE ENAME LIKE ('_A%');

-- 22. 급여가 1500이상이고 부서가 30번인 사원 중 직책이 MANAGER인 사원의 모든 정보 출력
SELECT *
    FROM EMP
WHERE SAL >= 1500 AND DEPTNO = 30 AND JOB = 'MANAGER';

-- 23. 사원의 모든 정보를 부서 번호에 대해 내림차순, 이름에 대해서 오름차순, 급여에 대해서 내림차순 정렬
SELECT *
    FROM EMP
ORDER BY DEPTNO DESC, ENAME ASC, SAL DESC;

-- 24. 사원번호가 7654와 7782 사이 이외의 사원의 모든 정보 출력
SELECT *
    FROM EMP
WHERE EMPNO NOT BETWEEN 7654 AND 7782;

-- 25. 사원의 모든 정보를 부서 번호에 대해 오름차순 정렬 후 급여가 많은 사원부터 출력
SELECT *
    FROM EMP
ORDER BY DEPTNO ASC, SAL DESC;

-- 26. 직책이 MANAGER가 아니고 부서가 20이 아닌 사원의 모든 정보 출력 
SELECT *
    FROM EMP
WHERE JOB != 'MANAGER' AND DEPTNO != 20;

-- 27. 1981년 4월 1일 이후 입사하고 부서가 30인 사원의 모든 정보 출력
SELECT *
    FROM EMP
WHERE HIREDATE > '1981/04/01' AND DEPTNO = 30;

-- 28. 10번 부서에 모든 사원에게 급여의 13%를 보너스로 지불하기로 함. 10번 부서 사원들의 이름, 급여, 보너스포함금액, 부서번호 출력
SELECT ENAME 이름, SAL 급여, SAL*1.13 총금액, DEPTNO 부서번호
    FROM EMP
WHERE DEPTNO = 10;

-- 29. 모든 사원에 대해서 입사일로부터 90일이 지난 후의 날짜를 계산해서 이름, 입사일, 90일 후의 날짜, 급여를 출력
SELECT ENAME 이름, HIREDATE 입사일, HIREDATE+90 AS "입사일", SAL
    FROM EMP;









