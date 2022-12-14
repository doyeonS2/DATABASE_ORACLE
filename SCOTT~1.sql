-- 1번 문제 --

SELECT EMPNO,
    RPAD(SUBSTR(EMPNO,1,2), 4, '*'),
    ENAME,
    RPAD(SUBSTR(ENAME,1,1),LENGTH(ENAME),'*')
FROM EMP;

-- 2번 문제 --

SELECT EMPNO, ENAME, SAL,
    TRUNC(SAL / 21.5, 2) AS DAY_PAY,
    ROUND((SAL / 21.5) / 8, 1) AS TIME_PAY
FROM EMP;

-- 3번 문제 --

SELECT EMPNO, ENAME, HIREDATE,
    TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS R_JOB,
    NVL(TO_CHAR(COMM), 'N/A') AS COMM
FROM EMP;
    
-- 4번 문제 --

SELECT EMPNO, ENAME, MGR,
    CASE 
        WHEN MGR IS NULL THEN '0000'
        WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = '75' THEN '5555'
        WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = '76' THEN '6666'
        WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = '77' THEN '7777'
        WHEN SUBSTR(TO_CHAR(MGR), 1, 2) = '78' THEN '8888'
        ELSE TO_CHAR(MGR)
    END AS CHG_MGR
FROM EMP;
        




   


