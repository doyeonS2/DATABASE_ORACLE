/* 시험 대비 연습 */

/* 1번 문제*/

-- 부서별 평균 월급이 2800을 초과하는 부서를 조회한 후 오름차순 정렬
-- GROUP BY로 묶은 그룹에 대해서 조건을 추가하기 위해서는 HAVING 절을 사용해야 합니다. 
SELECT DEPTNO, SUM(SAL)합계, FLOOR(AVG(SAL))평균, COUNT(*)인원수
    FROM EMP
    GROUP BY DEPTNO
    HAVING FLOOR(AVG(SAL)) > 1000
ORDER BY DEPTNO ASC;
-- 집계 함수가 들어갔을 때 WHERE 절을 쓰면 안된다!!! HAVING 절이 들어가야 된다!!!!!!!!!!

------------------------------------------------------------------------------
/* 2번 문제 */

-- ROWNUM를 이용해서 월급이 가장 높은 3명을 출력하고자 함. 잘못된 부분을 수정하시오.
-- FROM 절의 서브쿼리 이용(인라인뷰)해서 해당 테이블을 정렬한 결과를 받음
SELECT ROWNUM, ENAME, SAL
    FROM EMP
WHERE ROWNUM <= 3
ORDER BY SAL DESC; 
-- 정렬이 안되어있음..

-- 정렬된 상태로 바꾸기
SELECT ROWNUM, ENAME, SAL
    FROM (SELECT * 
            FROM EMP 
            ORDER BY SAL DESC)
WHERE ROWNUM <= 3
ORDER BY SAL DESC;
------------------------------------------------------------------------------
/* 서술형 문제 

1. 데이터 베이스의 특징
- 실시간 접근성 : 다수의 사용자의 요구에 실시간 처리 및 응답해야 한다.
- 지속적인 변화 : 저장된 데이터가 항상 최신 상태를 유지해야 한다.
- 동시 공유 : 동일한 데이터를 다양한 목적으로 동시에 사용할 수 있어야 한다.
- 내용에 의한 참조 : 데이터는 주소나 위치에 대해 참조되는 것이 아니라 값에 따라 참조되어야 한다.

2. DDL : CREATE (테이블 생성), DROP (테이블 삭제) , ALTER (테이블 변경)

3. 자료형 관련 : 
  - NUMBER : 숫자형에 대한 처리, NUMBER(3, 2) : 총 길이가 3이고 이 중 소수점 이하 표시가 2자리 
  - CHAR : 
  - VARCHAR2 :
  
4. 문자열 데이터 타입 : CHAR(100) -> 고정 문자열 자료형이며 크기가 100바이트를 할당

5. 데이터를 조회하는 SELECT 구문 중 INNER JOIN에 대해 서술 
  - 조인이 되는 키값 기준으로 교집합 결과셋을 출력하는 조인 방법으로 각 테이블의 NULL 값을 포함하지 않는다.
  - 동등 조인도 해당함

6. OUTER JOIN에 대해서 서술
  - 누락되는 데이터가 없도록 가져오는 방식
  - 조인하는 테이블에서 한쪽에는 데이터가 있고, 한쪽에서는 데이터가 없는 경우, 데이터가 있는 쪽 기준으로 테이블의 모든 내용을 출력

7. SUBSTR 함수 : 조회한 문자열의 일부를 추출하는 함수

8. DBMS에서 사용하는 용어 중, 데이터를 일종의 표 형태로 표현하는 것을 무엇이라고 하나? 
  - 답 : 테이블

9. DBMS에서 사용하는 용어 중, SELECT 명령어로 조회한 결과를 표 형태로 나타내는 것?
  - 답 : 결과셋
  
10. 문자열 데이터 '22/08/29'를 '2022-08-29'로 표현될 수 있도록 SELECT 구문 작성
-- TO_CHAR : 날짜 및 숫자 데이터를 문자 데이터로 변환, TO_CHAR(날짜데이터, '출력포맷');
-- TO_DATE : 문자열로 명시된 날짜로 변환하는 함수
SELECT TO_CHAR(TO_DATE('22/08/29', 'YY/MM/DD'), 'YYYY-MM-DD')
    FROM DUAL;
    
11. UPPER 함수에 대해서..
  - 답 : 괄호 안 문자 데이터를 모두 대문자로 변환하여 반환 (다 대문자로 바꿔주는 함수)
  
12. SET OPERATOR : UNION(합집합, 중복제거), UNION ALL(합집합, 중복제거 안함), INTERSECT(교집합), MINUS(차집합, 앞에서 뒤를 뺌)

13. 문자열 데이터 '190505' -> '2019년5월5일'로 출력
SELECT TO_CHAR(TO_DATE('190505','YYMMDD'), 'YYYY"년"MM"월"DD"일"')
    FROM DUAL;

14. INITCAP 함수 : 괄호 안 문자 데이터 중 첫 글자는 대문자로, 나머지 문자를 소문자로 변환 후 반환 (첫자를 대문자로 변경하는 함수)

15. TRIM 함수 : 문자열 데이터 내에서 특정 문자를 지우기 위해 사용(조회한 컬럼의 좌우의 띄어쓰기, 빈칸 등의 공백을 제거함)

16. SET OPERATOR : INTERSET(교집합) : SELECT 문의 수행 결과에서 둘다 포함되어 있는 부분만 추출해서 출력

17. UNION과 UNION ALL 차이 : 중복 포함 여부에 따라 구분 
  - UNION : 여러 개의 SQL문의 결과에 대한 합집합을 반환, 중복행을 하나의 행으로 보여줌
  - UNION ALL : 여러 개의 SQL 문의 결과에 대한 합집합을 반환, UNION 연산자와 다르게 중복행도 모두 출력

18. DECODE 문에 대해서 : 주어진 데이터 값이 조건값과 일치하면 값을 출력하고 일치하는 값이 없으면 기본값 출력
SELECT EMPNO, ENAME, JOB, SAL,
    DECODE(JOB, 
        'MANAGER', SAL*200,
        'SALESMAN', SAL*100,
        SAL) AS "성과급"
FROM EMP; 
-- 문제랑 똑같이 안알려줌,,, 변별력,,,

19. 문자열을 이어붙이는 방법
SELECT CONCAT(EMPNO, ENAME)
    FROM EMP
    WHERE ENAME = 'JAMES';
    
SELECT CONCAT(EMPNO, ENAME), CONCAT(EMPNO, CONCAT(' : ', ENAME))
    FROM EMP
    WHERE ENAME = 'JAMES';

20. || -> CONCAT
SELECT CONCAT(EMPNO, CONCAT(', ' , CONCAT(ENAME, (CONCAT(', ', DEPTNO)))))
    FROM EMP
    WHERE ENAME = 'JAMES';
    
21. RANK() OVER 함수? -> 순위 부여 시 중복값이 발생하면 중복 값의 갯수만큼 건너뛰고 다음 순위 부여

22. 직원 급여 인상하기 문제 
SELECT EMPNO, ENAME, JOB, SAL,
    DECODE(JOB,
        'MANAGER', SAL*1.08,
        'SALESMAN', SAL*1.07,
        'ANALYST', SAL*1.05,
        SAL*1.03) AS "급여인상"
    FROM EMP;
-- 문제 똑같이 안나옴
    
23. 22번을 CASE 문으로 옮기기
SELECT EMPNO, ENAME, JOB, SAL,
    CASE JOB
        WHEN 'MANAGER' THEN SAL*1.08
        WHEN 'SALESMAN' THEN SAL*1.07
        WHEN 'ANALYST' THEN SAL*1.05
        ELSE SAL*1.03
    END AS "급여인상"
    FROM EMP;
-- 문제 똑같이 안나옴

24. ROLLUP() : 그룹별로 중간 집계를 처리하는 함수
    CUBE() : 그룹별 산출 결과를 집계하는 함수
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB);

SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB);

25. RANK() OVER 함수? -> 순위 부여 시 중복값이 발생하면 중복값의 개수만큼 건너뛰고 다음 순위 부여 (1, 2, 2 ,2 ,5)
DENSE_RANK() OVER -> 순위 부여 시 중복값이 발생하면 다음 순위를 연속해서 부여(90, 80, 80, 80, 70 -> 1, 2, 2, 2, 3)

        