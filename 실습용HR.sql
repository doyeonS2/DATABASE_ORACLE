SHOW USER;
------------------------------------------------------------------------------
SELECT *
FROM EMPLOYEES;
------------------------------------------------------------------------------
SELECT FIRST_NAME, INSTR(FIRST_NAME, 'E', 1, 1)
FROM employees;
------------------------------------------------------------------------------

/* HR 연습 문제 */

-- 1. EMPLOYEES 테이블에서 King의 정보를 소문자로 검색하고 사원번호, 성명, 담당업무(소문자로),부서번호를 출력하라.
SELECT EMPLOYEE_ID, LOWER(FIRST_NAME)||' '||LOWER(LAST_NAME), LOWER(JOB_ID), DEPARTMENT_ID
    FROM EMPLOYEES
WHERE LOWER(LAST_NAME) = 'king';

-- 2. EMPLOYEES 테이블에서 King의 정보를 대문자로 검색하고 사원번호, 성명, 담당업무(대문자로),부서번호를 출력하라.
SELECT EMPLOYEE_ID, LOWER(FIRST_NAME)||' '||LOWER(LAST_NAME), UPPER(JOB_ID), DEPARTMENT_ID
    FROM EMPLOYEES
WHERE UPPER(LAST_NAME) = 'KING';

-- 3. DEPARTMENTS 테이블에서 부서번호와 부서이름, 위치번호를 합하여 출력하도록 하라.
SELECT * FROM DEPARTMENTS;

SELECT DEPARTMENT_ID || ' ' || DEPARTMENT_NAME || ' ' || LOCATION_ID
FROM DEPARTMENTS;

-- 4. EMPLOYEES 테이블에서 이름의 첫 글자가 ‘K’ 보다 크고 ‘Y’보다 적은 사원의 정보를
-- 사원번호, 이름, 업무, 급여, 부서번호를 출력하라.
-- 단 이름순으로 정렬하여라.
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY, DEPARTMENT_ID
    FROM EMPLOYEES
WHERE SUBSTR(FIRST_NAME, 1, 1) > 'K' AND SUBSTR(FIRST_NAME, 1, 1) < 'Y'
ORDER BY FIRST_NAME;

-- 5. EMPLOYEES 테이블에서 20번 부서 중 이름의 길이 및 급여의 자릿수를 
-- 사원번호, 이름, 이름의 자릿수(LENGTH), 급여, 급여의 자릿수를 출력하라.
-- LENGTHB는 BYTE 혼동하지 말자!
SELECT EMPLOYEE_ID, FIRST_NAME, LENGTH(FIRST_NAME), SALARY, LENGTH(SALARY)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 20; 

-- LENGTH('문자열') : 자리수 반환, LENGTHB('문자열') : 바이트 수 반환
SELECT LENGTH('안유진')
FROM DUAL;

SELECT LENGTHB('안유진')
FROM DUAL;

SELECT LENGTH('LOSA')
FROM DUAL;

SELECT LENGTHB('LOSA')
FROM DUAL;

-- 6. EMPLOYEES 테이블에서 이름 중 ‘e’자의 위치를 출력하라.
-- INSTR(문자열, '찾고자하는문자', 시작위치, 몇번째인지지정(생략하면 첫번째)) 
SELECT FIRST_NAME, INSTR(FIRST_NAME, 'e', 1) FROM EMPLOYEES;

SELECT FIRST_NAME, INSTR(FIRST_NAME, 'l', 1, 2) FROM EMPLOYEES;

-- 7. EMPLOYEES 테이블에서 부서번호가 80인 사람의 급여를 30으로 나눈 나머지를 구하여 출력하라.
SELECT FIRST_NAME, SALARYMOD(SALARY, 30)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80; 

-- 8. EMPLOYEES 테이블에서 현재까지 근무일 수가 몇주 몇일 인가를 출력하여라.
-- 단 근무 일수가 많은 사람 순으로 출력하여라.
SELECT FIRST_NAME 이름, HIRE_DATE 입사일, 
    TRUNC((SYSDATE-HIRE_DATE)/7) || '주 ' || 
    TRUNC(MOD((SYSDATE-HIRE_DATE), 7)) || '일'  AS "근무주,일"
FROM EMPLOYEES
ORDER BY HIRE_DATE DESC;

SELECT FIRST_NAME, HIRE_DATE,
    TRUNC(SYSDATE - HIRE_DATE) AS "근무 일수",
    TRUNC((SYSDATE - HIRE_DATE) / 7) AS "근무 주차"
    FROM EMPLOYEES
ORDER BY "근무 일수" DESC;

SELECT FIRST_NAME 이름, HIRE_DATE 입사일, 
    FLOOR(TO_DATE(20220831, 'YYYYMMDD') - TO_DATE(HIRE_DATE)) TOTAL,
    FLOOR(FLOOR(TO_DATE(20220831, 'YYYYMMDD') - TO_DATE(HIRE_DATE)) / 7) WEEKS,
    MOD(FLOOR(TO_DATE(20220831, 'YYYYMMDD') - TO_DATE(HIRE_DATE)), 7) DAYS
FROM EMPLOYEES
ORDER BY HIRE_DATE; 

-- 9. EMPLOYEES 테이블에서 부서 50에서 급여 앞에 $를 삽입하고 3자리마다 ,를 출력하라
-- 0 : 숫자 한자리를 의미, 빈 자리를 0으로 채움
-- 9 : 숫자 한자리를 의미, 빈 자리를 채우지 않음
SELECT FIRST_NAME, SALARY, TO_CHAR(SALARY, '$999,999,999')
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50; 
 
-- 10. EMPLOYEES 테이블에서 부서별로 인원수, 평균 급여, 최저급여, 최고 급여, 급여의 합을 구하여 출력
SELECT DEPARTMENT_ID, COUNT(*), ROUND(AVG(SALARY), 1), MIN(SALARY), MAX(SALARY), SUM(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;

-- 11. EMPLOYEES 테이블에서 30번 부서 중 이름과 담당 업무를 연결하여 출력
SELECT FIRST_NAME || ' ' || JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 30;

-- 12. EMPLOYEES 테이블에서 업무별 급여의 평균이 10000 이상인 업무에 대해서 업무명, 평균 급여, 급여의 합을 구하여 출력
SELECT JOB_ID, AVG(SALARY), SUM(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID
    HAVING AVG(SALARY) >= 10000;
    
-- 13. EMPLOYEES 테이블에서 부서 인원이 4명보다 많은 부서의 부서번호, 인원수, 급여의 합을 구하여 출력
SELECT DEPARTMENT_ID, COUNT(*), SUM(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
    HAVING COUNT(*) > 4
ORDER BY DEPARTMENT_ID;

                