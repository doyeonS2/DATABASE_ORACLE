SET SERVEROUTPUT ON; -- 실행 결과를 화면에 출력

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO, PL/SQL!!!!!');
END;

/* 변수 선언 */
DECLARE
    V_EMPNO NUMBER(4) := 8000; -- 변수 이름 데이터형(크기) := (선언된 변수에 값을 대입)
    V_ENAME VARCHAR2(10); -- 선언 이후에 값을 대입하지 않음
BEGIN 
    V_ENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_EMPNO);
    DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' || V_ENAME);
END;

/* 상수 정의 및 사용하기 */
DECLARE
    V_TAX CONSTANT NUMBER(1) := 5;
BEGIN
    -- NUMBER := 6; 
    DBMS_OUTPUT.PUT_LINE('V_TAX : ' || V_TAX);
END;

DECLARE
    V_TAX NUMBER(1) := 5;
BEGIN
    V_TAX := 6;
    DBMS_OUTPUT.PUT_LINE('V_TAX : ' || V_TAX);
END;

/* 변수에 디폴트 값 대입하기 */
DECLARE
    V_DEPTNO NUMBER(2) DEFAULT 10;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
END;

/* 변수에 NULL 값 저장 막기 */
DECLARE
    V_DEPTNO NUMBER(2) NOT NULL := 10;
BEGIN
    V_DEPTNO := 20;
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
END;

/* 참조형 사용하기 */
-- 참조형은 오라클 데이터베이스에 존재하는 특정 테이블 열의 자료형이나 하나의 행 구조를 참조하는 자료형을 의미
-- 열을 참조할 때는 %TYPE, 행을 참조할 때는 %ROWTYPE을 사용합니다.
DECLARE 
    V_DEPTNO DEPT.DEPTNO%TYPE := 50;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
END;

-- V_DEPT_ROW : 데이터를 저장할 변수 이름(참조형 타입이 됨) - 하나의 행 구조를 참조하는 자료형
-- DEPT : 특정 테이블을 지정
-- %ROWTYPE : 값을 대입 받을 수 없음
DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;
BEGIN
    SELECT DEPTNO, DNAME, LOC INTO V_DEPT_ROW
        FROM DEPT
    WHERE DEPTNO = 40;
    DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_ROW.DNAME);
    DBMS_OUTPUT.PUT_LINE('LOC : ' || V_DEPT_ROW.LOC);
END;

/* 조건 제어문 */
-- IF-THEN : 특정 조건을 만족하는 경우 작업 수행
-- IF-THEN-ELSE : 특정 조건을 만족하는 경우와 만족하지 않는 경우 수행
-- IF-THEN-ELSIF : 여러 조건 처리
DECLARE
    V_NUMBER NUMBER := 14;
BEGIN 
    IF MOD(V_NUMBER, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('V_NUMBER는 홀수 입니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('V_NUMBER는 짝수 입니다.');
    END IF;
END;

DECLARE
    IF V_SCORE >= 90 THEN
        DBSE_OUTPUT.PUT_LINE('B학점');
    ELSIF V_SCORE >= 80 THEN
        DBSE_OUTPUT.PUT_LINE('C학점');
    ELSIF V_SCORE >= 70 THEN
        DBSE_OUTPUT.PUT_LINE('D학점');
    ELSIF V_SCORE >= 60 THEN
        DBSE_OUTPUT.PUT_LINE('F학점');
    END IF;
END;

/* CASE 조건문 */
DECLARE
    V_SCORE NUMBER := 78;
BEGIN
    CASE TRUNC(V_SCORE / 10)
        WHEN 10 THEN DBMS_OUTPUT.PUT_LINE('A학점');
        WHEN 9 THEN DBMS_OUTPUT.PUT_LINE('A학점');
        WHEN 8 THEN DBMS_OUTPUT.PUT_LINE('B학점');
        WHEN 7 THEN DBMS_OUTPUT.PUT_LINE('C학점');
        WHEN 6 THEN DBMS_OUTPUT.PUT_LINE('D학점');
        ELSE DBMS_OUTPUT.PUT_LINE('F학점');
    END CASE;
END;

DECLARE
    V_SCORE NUMBER := 78;
BEGIN
    CASE
        WHEN V_SCORE >= 90 THEN DBMS_OUTPUT.PUT_LINE('A학점');
        WHEN V_SCORE >= 80 THEN DBMS_OUTPUT.PUT_LINE('B학점');
        WHEN V_SCORE >= 70 THEN DBMS_OUTPUT.PUT_LINE('C학점');
        WHEN V_SCORE >= 60 THEN DBMS_OUTPUT.PUT_LINE('D학점');
        ELSE DBMS_OUTPUT.PUT_LINE('F학점');
    END CASE;
END;
    
/* 반복문 */
-- LOOP : 기본 반복문
-- WHILE LOOP : 특정 조건식의 결과를 통해 반복 수행
-- FOR LOOP : 반복 횟수를 정하여 반복
-- EXIT : 수행중인 반복을 종료
-- EXIT-WHEN : 반복 종료를 위한 조건식을 지정하고 만족하면 반복 종료
-- CONTINUE : 수행 중인 반복의 현재 주기를 건너뜀
-- CONTINUE-WHEN : 특정 조건을 지정하고 조건식을 만족하면 현재 반복 주기를 건너뜀
DECLARE
    V_NUM NUMBER := 0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('현재 V_NUM : ' || V_NUM);
        V_NUM := V_NUM + 1;
        EXIT WHEN V_NUM > 5;
    END LOOP;
END;

DECLARE
    V_NUM NUMBER := 0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('현재 V_NUM : ' || V_NUM);
        V_NUM := V_NUM + 1;
        IF V_NUM > 5 THEN EXIT;
        END IF;
    END LOOP;
END;

DECLARE
    V_NUM NUMBER := 0;
BEGIN
    WHITE V_NUM < 5 LOOP
        DBMS_OUTPUT.PUT_LINE('현재 V_NUM : ' || V_NUM);
        V_NUM := V_NUM + 1;
    END LOOP;
END;

/* FOR LOOP */
-- FOR LOOP : 반복의 횟수를 지정할 수 있는 반복문
-- REVERSE : 반대로 순회함
BEGIN
    FOR I IN 0..5 LOOP
        DBMS_OUTPUT.PUT_LINE('현재 I의 값 : ' || I);
    END LOOP;
END;

/* CONTINUE */
-- 오라클 11G 에서 신규로 추가됨
BEGIN
    FOR I IN 0..5 LOOP
        CONTINUE WHEN MOD(I, 2) = 1;
        DBMS_OUTPUT.PUT_LINE('현재 I의 값 : ' || I);
    END LOOP;
END;
    
    
    
    
    
    
    
    
    
    
    













