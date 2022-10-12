/* 문자 가공 함수 - 단일행 함수 */
SELECT ENAME, UPPER(ENAME)대문자, LOWER(ENAME)소문자, INITCAP(ENAME)첫자만대문자
FROM EMP;

SELECT *
    FROM EMP
WHERE UPPER(ENAME) = 'JAMES';

SELECT *
    FROM EMP
WHERE UPPER(ENAME) = UPPER('james');

SELECT *
    FROM EMP
WHERE UPPER(ENAME) LIKE UPPER('%JAM%');

/* 문자열 길이를 구하는 함수 */
SELECT ENAME, LENGTH(ENAME)이름의길이
FROM EMP;
-----------------------------------------
SELECT ENAME, LENGTH(ENAME)이름의길이
    FROM EMP
WHERE LENGTH(ENAME) >= 5;
-- LENGTH() : 문자열의 길이를 반환
-- LENGTHB() : 문자열의 바이트수를 반환
-- DUAL : SYS 계정에서 제공하는 테이블로 함수나 계산식을 테이블 참조 없이 실행해보기 위한 DUMMY테이블
SELECT LENGTH('안유진'), LENGTHB('안유진')
FROM DUAL;

SELECT 20*30 FROM DUAL;

/* MOD : 나머지를 구하는 함수 */
SELECT MOD(5,4) FROM DUAL;

/* ABS() : 절대값을 구하는 함수 */
SELECT -10, ABS(-10) FROM DUAL;

/* ROUND() : 반올림한 결과를 반환하는 함수 */
-- 반올림할 위치 지정 가능, 지정하지 않으면 소수점 첫째 자리에서 반올림, 음수 지정 가능(정수구간)
SELECT 12.3456, ROUND(12.6456), ROUND(12.3456, 2), ROUND(16.3456, -1), ROUND(62.3456, -2)
FROM DUAL;

/* TRUNC : 버림을 한 결과를 반환하는 함수 */
-- 버림할 자리수를 지정할 수 있음, 지정하지 않으면 소수점 첫째자리, 음수 지정 가능
SELECT 12.3456, TRUNC(12.6456), TRUNC(12.3456, 2), TRUNC(16.3456, -1), TRUNC(62.3456, -2)
FROM DUAL;

/* MOD(대상, 나눌 수) : 나누어서 나머지를 반환하는 함수 */
SELECT MOD(21, 5) FROM DUAL;

/* CEIL : 소수점 이하가 있으면 무조건 올림 */
SELECT CEIL(12.345) FROM DUAL;

/* FLOOR : 소수점 이하를 무조건 내림 */
SELECT FLOOR(12.945) FROM DUAL;

/* POWER(A, B) : A를 B만큼 제곱하는 함수 */
SELECT POWER(3, 4) FROM DUAL;
SELECT POWER(3, 3.1) FROM DUAL;

/* SUBSTR(문자열데이터, 시작위치) : 문자열을 시작위치부터(인덱스 아님) 끝까지 반환
-- SUBSTR(문자열데이터, 시작위치, 길이) : 문자열을 시작 위치부터 길이만큼 반환 */
SELECT JOB, SUBSTR(JOB, 1, 2), SUBSTR(JOB, 3, 2), SUBSTR(JOB, 5)
FROM EMP;
-------------------------------------------------------------------------------
-- 음수는 뒤에서부터 카운트함
SELECT JOB, 
    SUBSTR(JOB, -LENGTH(JOB)),
    SUBSTR(JOB, -LENGTH(JOB), 2),
    SUBSTR(JOB, -3)
FROM EMP;
-------------------------------------------------------------------------------
/* INSTR() : 문자열 데이터 안에 특정 문자나 문자열이 어디에 포함되어 있는지 위치 확인 */
-- INSTR(대상문자열, 찾으려는문자, 위치는 안주면 처음부터, 몇번째 나오는 문자인지)

SELECT INSTR('HELLO, ORACLE!!!', 'L') AS "INSTR기본",
    INSTR('HELLO, ORACLE!!!', 'L', 5) AS "INSTR위치지정",
    INSTR('HELLO, ORACLE!!!', 'L', 2,3) AS "INSTR위치지정"
FROM DUAL;  

-------------------------------------------------------------------------------
/* 특정 문자가 포함된 행 찾기 */
SELECT *
    FROM EMP
WHERE INSTR(ENAME, 'S') > 0;

SELECT *
    FROM EMP
WHERE ENAME LIKE '%S%';
-------------------------------------------------------------------------------
/* REPLACE() : 특정 문자열에 포함된 문자 또는 문자열을 다른 문자열로 대체, 대체할 문자를 지정하지 않으면 해당 문자열 삭제 */
-- REPLACE(문자열, 찾는문자열, [선택]대체할문자열)
SELECT '010-5006-4146' AS 변경이전문자열,
    REPLACE('010-5006-4146', '-', '*') AS 문자열변경,
    REPLACE('010-5006-4146', '-') AS 문자열삭제
FROM DUAL;
-------------------------------------------------------------------------------
/* LPAD, RPAD : 기준 공간 칸수를 지정하고 빈칸 만큼을 특정 문자로 채우는 함수 */
SELECT LPAD('ORACLE', 10, '+') FROM DUAL;
SELECT RPAD('ORACLE', 10, '+') FROM DUAL;
SELECT LPAD('ORACLE', 10) FROM DUAL; -- 3번째에 값을 지정하지 않으면 공백으로 채움
SELECT RPAD('ORACLE', 10) FROM DUAL;

SELECT
    RPAD('200222-', 14, '*') AS 주민등록번호,
    RPAD('010-5006-', 13, '*') AS 전화번호
FROM DUAL;
-------------------------------------------------------------------------------
/* 두 문자열을 합치는 CONCAT 함수 */
SELECT CONCAT(EMPNO, ENAME),
    CONCAT(EMPNO, CONCAT(' : ', ENAME))
    FROM EMP
WHERE ENAME = 'JAMES';
-------------------------------------------------------------------------------
/* TRIM / LTRIM / RTLIM : 문자열 내에서 특정 문자열을 지움 (앞/뒤) */
-- TRIM은 앞과 뒤 문자열만 지울 수 있으므로 중간 문자열 지울때는 REPLACE 쓰기
SELECT '[' || TRIM(' =ORACLE=') || ']' AS TRIM,
    '[' || LTRIM(' =ORACLE= ') || ']',
    '[' || LTRIM('<=ORACLE=>', '<=') || ']' AS LTRIM_2,
    '[' || RTRIM(' =ORACLE= ') || ']' AS RTRLM,
    '[' || RTRIM('<=ORACLE=>', '=>') || ']' AS LTRIM_2
FROM DUAL;
-------------------------------------------------------------------------------
/* 날짜 데이터를 다루는 함수 */
-- 날짜데이터 + 숫자 : 날짜에서 숫자만큼 경과된 날짜를 보여줌
-- 날짜데이터 - 숫자 : 날짜에서 숫자만큼 이전의 날짜를 보여줌
-- 날짜데이터 - 날짜데이터 : 두 날짜의 일수를 보여줌
-- 날짜데이터 + 날짜데이터 : 안됨

/* SYSDATE : 오라클이 설치된 운영체제의 현재 시간을 보여줌 */
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE AS 오늘,
    SYSDATE-1 AS 어제,
    SYSDATE+1 AS 내일
FROM DUAL;
-------------------------------------------------------------------------------
-- ADD_MONTHS(날짜데이터, 더할개월수)
SELECT SYSDATE,
    ADD_MONTHS(SYSDATE, 4)
FROM DUAL;
-------------------------------------------------------------------------------
SELECT EMPNO, ENAME, HIREDATE,
    ADD_MONTHS(HIREDATE, 120) AS 입사10주년
FROM EMP;
-------------------------------------------------------------------------------
/* MONTHS_BETWEEN(날짜데이터, 날짜데이터) : 두 날짜 간의 개월 수 차이를 구하는 함수 */
-- TRUNC와 조합해서 개월수를 얻어냄
SELECT EMPNO, ENAME, HIREDATE, SYSDATE,
    TRUNC(MONTHS_BETWEEN(HIREDATE, SYSDATE)) AS MONTH1,
    TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTH2,
    TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTH3
FROM EMP;
------------------------------------------------------------------------------
/* NEXT_DAY(날짜데이터, 요일문자) : 특정 날짜 기준으로 돌아오는 요일의 날짜를 출력하는 함수 */
/* LAST_DAY(날짜데이터) : 특정 날짜가 속한 달의 마지막 날짜를 출력해 주는 함수 */
SELECT SYSDATE,
    NEXT_DAY(SYSDATE, '금요일'),
    LAST_DAY(SYSDATE)
FROM DUAL;

SELECT SYSDATE,
    NEXT_DAY('1970/01/01', '금요일'),
    LAST_DAY('1970/01/01')
FROM DUAL;
------------------------------------------------------------------------------
/* 오라클에서 날짜 데이터를 사용할 때 기준 포맷 */
-- CC, SCC : 세기
-- YYYY, YEAR, YY, Y : 연도를 표시하는 포맷
-- Q : 분기
-- MONTH, MON, MM, RM : 
-- WW : 해당 연도의 몇째 주인지 확인
-- W : 해당월의 몇주인지 확인
-- HH12, HH24 : 시간제 표시
SELECT SYSDATE,
    TO_CHAR(SYSDATE, 'CC') AS FORMAT_CC,
    TO_CHAR(SYSDATE, 'YY') AS FORMAT_YY,
    TO_CHAR(SYSDATE, 'YYYY/MM/DD PM HH:MI:SS') AS "년/월/일 시:분:초",
    TO_CHAR(SYSDATE, 'Q') AS FORMAT_Q,
    TO_CHAR(SYSDATE, 'DD') AS FORMAT_DD,
    TO_CHAR(SYSDATE, 'DDD') AS FORMAT_DDD,
    TO_CHAR(SYSDATE, 'HH') AS FORMAT_HH,
    TO_CHAR(SYSDATE, 'HH12') AS FORMAT_HH12,
    TO_CHAR(SYSDATE, 'HH24') AS FORMAT_HH24,
    TO_CHAR(SYSDATE, 'WW') AS FORMAT_WW,
    TO_CHAR(SYSDATE, 'W') AS FORMAT_W
FROM DUAL;
------------------------------------------------------------------------------
SELECT EMPNO, ENAME, EMPNO + '500' -- '500'은 문자형인데 숫자 + 문자 => 숫자형으로 출력
    FROM EMP
WHERE ENAME = 'FORD';

/* SELECT EMPNO, ENAME, EMPNO + 'ABCD' -- 'ABCD'는 숫자로 바꿀 수 없는 타입이기 때문에 에러남
    FROM EMP
WHERE ENAME = 'FORD'; */
------------------------------------------------------------------------------
/* 수동 형변환 */
-- 날짜 또는 숫자를 문자로 변환하기 :  TO_CHAR 함수
-- TO_CHAR(날짜데이터, '출력되기를 원하는 문자 형태')
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD PM HH/MI/SS') AS 현재날짜와시간
FROM DUAL;

SELECT SYSDATE,
    TO_CHAR(SYSDATE, 'CC') AS 세기,
    TO_CHAR(SYSDATE, 'YY') AS "2자리 연도",
    TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') AS "년/월/일 시:분:초",
    TO_CHAR(SYSDATE, 'Q') AS 분기,
    TO_CHAR(SYSDATE, 'DD') AS 날짜,
    TO_CHAR(SYSDATE, 'DDD') AS 경과날짜,
    TO_CHAR(SYSDATE, 'PM HH') AS "오후 시간",
    TO_CHAR(SYSDATE, 'WW') AS "1년중 몇주차"
FROM DUAL;
------------------------------------------------------------------------------
/* 특정 언어에 맞춰서 날짜 출력하기 */
-- TO_CHAR(날짜 데이터, '출력포맷', 'NLS_DATE_LANGUAGE=KOREAN')
SELECT SYSDATE,
    TO_CHAR(SYSDATE, 'MM') AS MM,
    TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = KOREAN') AS MON_KR,
    TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = JAPANESE') AS MON_JP,
    TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH') AS MON_EN,
    TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = KOREAN') AS MON_KR,
    TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = JAPANESE') AS MON_JP,
    TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = ENGLISH') AS MON_EN
FROM DUAL;

/* 특정 언어에 맞춰서 요일 출력하기 */
SELECT SYSDATE,
    TO_CHAR(SYSDATE, 'MM') AS MM,
    TO_CHAR(SYSDATE, 'DD', 'NLS_DATE_LANGUAGE = KOREAN') AS MON_KR,
    TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = JAPANESE') AS MON_JP,
    TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = ENGLISH') AS MON_EN,
    TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = KOREAN') AS MON_KR,
    TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = JAPANESE') AS MON_JP,
    TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = ENGLISH') AS MON_EN
FROM DUAL;
    
-- 숫자 데이터 형식 출력
-- 9 : 숫자의 한자리를 의미 (빈자리는 채우지 않음)
-- 0 : 빈자리를 0으로 채움
-- $ : 달러 표시를 붙임
-- L : 지역 화폐 단위 기호를 붙여서 출력함(LOCAL)
-- . : 소수점을 표시
-- , : 천단위의 구분 기호를 표시

SELECT SAL,
    TO_CHAR(SAL, '$999,999') AS SAL_$,
    TO_CHAR(SAL, 'L999,999') AS SAL_L,
    TO_CHAR(SAL, '$999,999.00') AS SAL_1,
    TO_CHAR(SAL, '000,999,999.00') AS SAL_2,
    TO_CHAR(SAL, '000999999.99') AS SAL_3,
    TO_CHAR(SAL, '999,999,00') AS SAL_4
FROM EMP;

SELECT 
    TO_CHAR(SYSDATE, 'YY/MM/DD')
FROM DUAL;

------------------------------------------------------------------------------
SELECT TO_NUMBER('1300') - TO_NUMBER('1500')
FROM DUAL;

SELECT '1300' - '1500'
FROM DUAL;
------------------------------------------------------------------------------
/* TO_DATE('문자열', '문자열포맷') : 문자열을 명시된 날짜로 변환하는 함수 */
SELECT 
    TO_DATE('22/08/25', 'YY/MM/DD')
FROM DUAL;

SELECT 
    TO_DATE('2022-08-25', 'YY/MM/DD')
FROM DUAL;

SELECT 
    TO_DATE('20220825', 'YY/MM/DD')
FROM DUAL;
------------------------------------------------------------------------------
/* NULL 처리 함수 */
-- 특정열에서 행에 대한 데이터가 없는 경우 데이터의 값을 NULL이 됩니다. (값이 없음을 의미)
-- 오라클에서 테이블을 정의할 때 NULL값을 가지지 못하도록 지정할 수 있습니다. (NOT NULL)
-- 0값과는 다른 의미, 그래서 NULL은 연산을 할 수 없음
-- NVL(NULL 여부를 체크할 데이터, 해당 데이터가 NULL인 경우 대체할 값)
SELECT EMPNO, ENAME, SAL, COMM, SAL+COMM, 
    NVL(COMM, 0), 
    SAL+NVL(COMM, 0)
FROM EMP;
/* NVL2 (NULL 여부를 체크할 데이터, NULL이 아닌 경우, NULL인 경우) */
SELECT EMPNO, ENAME, SAL, COMM,
    NVL2(COMM, 'O', 'X'),
    NVL2(COMM, SAL*12+COMM,  SAL*12) AS 총연봉
FROM EMP;
------------------------------------------------------------------------------
/* NULLIF(A, B) : 두 값이 동일하면 NULL 반환하고 아니면 첫번째 값 반환 */
SELECT NULLIF(10, 10),
    NULLIF('A', 'B')
FROM DUAL;
------------------------------------------------------------------------------
/* DECODE : 주어진 데이터 값이 조건값과 일치하는 값을 출력하고 없으면 기본값 출력 */
-- DECODE(검사 대상이 될 열의 데이터, [조건1], [조건2], .............)
SELECT EMPNO, ENAME, JOB, SAL,
    DECODE(JOB,
        'MANAGER', SAL*1.1,
        'SALESMAN', SAL*1.05,
        'ANALYST', SAL,
        SAL*1.03) AS "급여 인상건"
FROM EMP;

-- CASE(검사 대상이 될 일의 데이터, WHEN 조건 THEN 실행될 문장..... ELSE)
SELECT EMPNO, ENAME, JOB, SAL,
    CASE JOB
        WHEN 'MANAGER' THEN SAL*1.1
        WHEN 'SALESMAN' THEN SAL*1.05
        WHEN 'ANALYST' THEN SAL
        ELSE SAL*1.03
    END AS "급여 인상건"
FROM EMP;

SELECT EMPNO, ENAME, COMM, 
    CASE
        WHEN COMM IS NULL THEN '해당사항 없음'
        WHEN COMM = 0 THEN '수당없음'
        WHEN COMM > 0 THEN '수당 : ' || COMM
    END AS "수당표시"
FROM EMP;
------------------------------------------------------------------------------
/* 실습 문제 */

-- 1번 문제
-- RPAD('문자열', 총길이, 오른쪽에채울문자) : 기준 공간 칸수를 지정하고 빈칸 만큼을 특정 문자로 채우는 함수
-- SUBSTR('문자열', 시작위치, 길이) : 문자열을 시작 위치부터 길이만큼 반환
SELECT EMPNO,
    RPAD(SUBSTR(EMPNO, 1, 2), 4, '*') AS MASKING_EMPNO,
    ENAME,
    RPAD(SUBSTR(ENAME, 1, 1), LENGTH(ENAME), '*') AS MASKING_ENAME
    FROM EMP
WHERE LENGTH(ENAME) = 5;


-- 2번 문제
SELECT EMPNO, ENAME, SAL,
     TRUNC(SAL / 21.5, 2) AS DAY_PAY, 
     ROUND(SAL / 21.5 / 8, 1) AS TIME_PAY
FROM EMP;


-- 3번 문제
-- 모든 행의 타입이 같아야 하므로 COMM의 결과값을 'N/A'와 같은 문자열로 변경함
SELECT EMPNO, ENAME, HIREDATE, 
    TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '월요일'), 'YYYY/MM/DD') AS R_JOB,
    NVL(TO_CHAR(COMM), 'N/A') AS COMM
FROM EMP;

-- 4번 문제
SELECT EMPNO, ENAME, MGR,
    CASE 
      WHEN MGR IS NULL THEN '0000'
      WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = '78' THEN '8888'
      WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = '77' THEN '7777'
      WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = '76' THEN '6666'
      ELSE TO_CHAR(MGR)
    END AS CHG_MGR
FROM EMP;


    
    
    
