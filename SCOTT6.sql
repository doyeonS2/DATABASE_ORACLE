/* 9월 1일 목요일 수업 */

---------------------------------------------
/* DDL */
SELECT * FROM EMP;

/* CREATE 명령어 사용하여 직접 테이블 생성 */
CREATE TABLE EMP_DDL ( 
    EMPNO   NUMBER(4),
    ENAME   VARCHAR2(10),
    JOB     VARCHAR2(9),
    MGR     NUMBER(4),
    HIREDATE  DATE,
    SAL     NUMBER(7, 2),
    COMM    NUMBER(7, 2),
    DEPTNO  NUMBER(2)
);

DESC EMP_DDL; -- 세부정보 확인

/* 기존 테이블의 열과 데이터를 복사하여 새 테이블 구성 */
CREATE TABLE DEPT_DDL
    AS SELECT * FROM DEPT;
    
DESC DEPT_DDL;
SELECT * FROM DEPT_DDL;

/* 기존 테이블 열 구조와 일부 데이터만 복사하여 새 테이블 구성 */
CREATE TABLE EMP_DDL_30
    AS SELECT * FROM EMP
    WHERE DEPTNO = 30;

SELECT * FROM EMP_DDL_30;

/* 기존 테이블의 열 구조만 복사하여 새 테이블 구성 */
CREATE TABLE EMP_DEPT_DDL
    AS SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM,
        D.DEPTNO, D.DNAME, D.LOC
        FROM EMP E, DEPT D
        WHERE 1 != 1; -- 테이블 구조만 복사하고 데이터는 복사안함

DESC EMP_DEPT_DDL;

SELECT * FROM EMP_DEPT_DDL;

-------------------------------------------------------------------
/* 테이블 변경 : ALTER */
CREATE TABLE EMP_ALTER
    AS SELECT * FROM EMP;
    
SELECT * FROM EMP_ALTER;

-- 테이블에 열 추가 : ALTER에 ADD 사용
-- 기존 테이블의 컬럼(열)에 새로운 컬럼을 추가하는 명령어
-- 테이블의 맨 뒤에 추가되며 원하는 위치에 넣을 수 없음
-- 추가된 컬럼에는 값은 NILL값으로 입력됨
ALTER TABLE EMP_ALTER
    ADD HP VARCHAR2(20); -- 크기를 20으로 넣어줌
    
SELECT * FROM EMP_ALTER; 

-- 열이름 변경 : RENAME 
-- ALTER 명령어에 RENAME 키워드를 사용하면 테이블의 열 이름을 변경할 수 있음 
ALTER TABLE EMP_ALTER
    RENAME COLUMN HP TO TEL;
    
SELECT * FROM EMP_ALTER;

-- 열의 자료형을 변경 : MODIFY
-- 자료형 변경 시 이미 데이터가 존재하는 경우 크기를 크게 변경하는 것은 문제 없지만, 크기를 줄이는 건 경우에 따라 안될 수 있음
ALTER TABLE EMP_ALTER
    MODIFY EMPNO NUMBER(2); -- 변경 불가
    
ALTER TABLE EMP_ALTER
    MODIFY EMPNO NUMBER(5); -- 변경 가능

DESC EMP_ALTER;

/* 테이블 이름을 변경하는 RENAME */ -- ALTER 없이 단독으로 사용
RENAME EMP_ALTER TO EMP_RENAME;

SELECT * FROM EMP_RENAME;

/* 테이블의 데이터를 삭제하는 TRUNCATE */
-- 데이터가 저장되어 있던 공간을 지움, ROLLBACK이 안됨
TRUNCATE TABLE EMP_RENAME;

SELECT * FROM EMP_RENAME;

/* DELETE와 TRUNCATE 차이?
내부적인 동작의 차이 
DML은 롤백 가능 -> 저장공간은 살려놓고,,,,,,,,,,
DDL은 롤백 X -> 내용과 동시에 저장공간까지 날려버림,,,,,,, */

/* 테이블을 삭제하는 명령어 */ -- 현업에서는 쓰면 안돼안돼,,,ㅎ
DROP TABLE EMP_RENAME;

-----------------------------------------------------------------
/* 연습문제 */

-- 1. 다음 열의 구조를 가지는 EMP_HW 테이블을 만들어 보세요.

CREATE TABLE EMP_HW(
    EMPNO NUMBER(4),
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HTREDATE DATE,
    SAL NUMBER(7, 2),
    COMM NUMBER(7, 2),
    DEPTNO NUMBER(2)
);
    
DESC EMP_HW;

-- 2. EMP_HW 테이블에 BIGO 열을 추가해 보세요. BIGO 열의 자료형은 가변형 문자열이고, 길이는 20입니다.
ALTER TABLE EMP_HW
    ADD BIGO VARCHAR2(20);
    
SELECT * FROM EMP_HW;

-- 3. EMP_HW 테이블의 BIGO 열 크기를 30으로 변경해 보세요.
ALTER TABLE EMP_HW
    MODIFY BIGO VARCHAR2(30);

-- 4. EMP_HW 테이블의 BIGO 열 이름을 REMARK로 변경해 보세요.
ALTER TABLE EMP_HW
    RENAME COLUMN BIGO TO REMARK; 

-- 5. EMP_HW 테이블에 EMP 테이블의 데이터를 모두 저장해 보세요. 단 REMAKE 열은 NULL로 삽입합니다.
SELECT * FROM EMP;

INSERT INTO EMP_HW
    SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO, NULL FROM EMP;

-- 6. EMP_HW 테이블 삭제
DROP TABLE EMP_HW;

----------------------------------------------------------------
/* 제약 조건 */
-- 빈 값을 허용하지 않는 NOT NULL, 중복 여부와는 상관 없음, 반드시 열에 값이 존재해야 함을 의미
CREATE TABLE TABLE_NOT_NULL(
    LOGIN_ID    VARCHAR(20) NOT NULL, -- NULL 값 넣을 수 없음, 반드시 값을 입력해야함
    LOGIN_PWD   VARCHAR(20) NOT NULL,
    TEL         VARCHAR(20) 
);

DESC TABLE_NOT_NULL;

INSERT INTO TABLE_NOT_NULL(LOGIN_ID, LOGIN_PWD, TEL) 
    VALUES('곰돌이사육사', NULL, '010-5006-4146'); -- 안됨, NULL 값 넣을 수 없음
    
INSERT INTO TABLE_NOT_NULL(LOGIN_ID, TEL) 
    VALUES('곰돌이사육사', '010-5006-4146'); -- 안됨, NOT NULL이라 패스워드 꼭 넣어줘야함

INSERT INTO TABLE_NOT_NULL(LOGIN_ID, LOGIN_PWD) 
    VALUES('곰돌이사육사', '010-5006-4146'); -- 됨, TEL은 NOT NULL이 아니기 때문
    
INSERT INTO TABLE_NOT_NULL(LOGIN_ID, LOGIN_PWD, TEL) 
    VALUES('곰돌이사육사', 'JKS2024', '010-5006-4146'); -- 됨
    
SELECT * FROM TABLE_NOT_NULL;

-- 제약 조건을 확인하는 명령어
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS;

-- 제약 조건을 확인하는 명령어
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'TABLE_NOT_NULL';

-- 제약 조건 이름을 직접 지정하기
-- 테이블에서 TABLE_NOT_NULL 선택해서 제약조건 -> 테이블 편집에서 넣어도 됨!!!!^_^
CREATE TABLE TABLE_NOT_NULL2 (
    LOGIN_ID VARCHAR(20) CONSTRAINT TB_LOGIN_ID_NN NOT NULL,
    LOGIN_PWD VARCHAR(20) CONSTRAINT TB_LOGIN_PW_NN NOT NULL,
    TEL VARCHAR(20)
);

-- 이미 생성한 테이블에 제약 조건 지정하기
ALTER TABLE TABLE_NOT_NULL
    MODIFY TEL NOT NULL;
    
SELECT * FROM TABLE_NOT_NULL;

-- 이미 포함된 데이터에 NULL이 존재하기 때문에 먼저 해당 컬럼의 NULL을 제거
UPDATE TABLE_NOT_NULL
    SET TEL = '010-1234-5678'
    WHERE LOGIN_PWD = '010-5006-4146';
    
DESC TABLE_NOT_NULL;

--------------------------------------------------------
-- 중복되지 않는 값 : UNIQUE
-- 해당 열에 저장할 데이터의 중복을 허용하지 않고자 할 때 사용
-- NULL은 값이 존재하지 않음을 의미 하므로 중복 대상에서 제외됨
-- 테이블을 생성하면서 UNIQUE 제약 조건 지정
CREATE TABLE TABLE_UNIQUE (
    LOGIN_ID VARCHAR2(20) UNIQUE, -- LOGIN_ID에만 UNIQUE 제약 조건
    LOGIN_PWD VARCHAR2(20) NOT NULL,
    TEL VARCHAR2(20)
);

DESC TABLE_UNIQUE;

INSERT INTO TABLE_UNIQUE(LOGIN_ID, LOGIN_PWD, TEL)
    VALUES('곰돌이사육사', 'PW123456', '010-5006-4146');
    
SELECT * FROM TABLE_UNIQUE;

INSERT INTO TABLE_UNIQUE(LOGIN_ID, LOGIN_PWD, TEL)
    VALUES('달빛사냥꾼', 'PW123456', '010-5006-4146');
    
INSERT INTO TABLE_UNIQUE(LOGIN_PWD, TEL) 
    VALUES('PW123456', '010-5006-4146'); -- 됨, UNIQUE 이지만 NULL 체크는 안함 

---------------------------------------------------------------
-- 유일하게 하나만 있는 값 : PRIMARY KEY
-- UNIQUE와 NOT NULL 제약 조건이 결합된 형태
-- 즉, 중복을 허용하지 않고 NULL 값을 가질 수 없음
-- 유일한 값 : 사원 번호, 주민등록번호 등 유일한 값을 주로 지정해서 사용함
-- 테이블 당 한개만 지정 가능
-- 자동으로 인덱스가 만들어짐
CREATE TABLE TABLE_PK (
    LOGIN_ID    VARCHAR2(20) PRIMARY KEY,
    LOGIN_PWD   VARCHAR2(20) NOT NULL,
    TEL         VARCHAR2(20)
);

DESC TABLE_PK;

SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
    FROM USER_CONSTRAINTS
    WHERE TABLE_NAME = 'TABLE_PK'; -- 실행했을 때, NULL을 CHECK하는 거기 때문에 NULL이면 C로 뜸
    
CREATE TABLE TABLE_PK2 (
    LOGIN_ID    VARCHAR2(20) CONSTRAINT TB_LOGIN_ID_PK PRIMARY KEY,
    LOGIN_PWD   VARCHAR2(20) CONSTRAINT TB_LOGIN_ID_PWD NOT NULL,
    TEL VARCHAR(20)
);

SELECT * FROM TABLE_PK2;

INSERT INTO TABLE_PK2 VALUES('곰돌이사육사', 'JKS2024', '010-5006-4146');
INSERT INTO TABLE_PK2 VALUES('지구오락실', 'JKS2024', '010-5006-4146');
INSERT INTO TABLE_PK2 VALUES('빅마우스', 'JKS2024', '010-5006-4146');

-------------------------------------------------------------
/* FOREIGN KEY 지정하기 */
-- 서로 다른 테이블간에 관계를 정의하는데 사용하는 제약 조건
-- 참조하고 있는 기본키의 데이터 타입과 일치해야하고, 외래키에 참조되는 기본키는 삭제할 수 없음
CREATE TABLE DEPT_FK (
    DEPTNO  NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_FK PRIMARY KEY,
    DNAME   VARCHAR2(14),
    LOC     VARCHAR2(13)
);

DESC DEPT_FK;

-- EMP_FK : EMP_FK 테이블의 DEPTNO 열은 DEPT_FK 테이블의 DEPTNO 열을 참조하는 FOREIGN KEY 제약 조건 추가
CREATE TABLE EMP_FK (
    EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE,
    SAL NUMBER(7, 2),
    COMM NUMBER(7, 2),
    DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO)
);

-- EMP_FK 테이블에 데이터를 삽입(DEPTNO 데이터가 아직 없음, DEPT_FK 의 데이터가 아직 안만들어짐)
INSERT INTO EMP_FK
    VALUES(9998, '오락실', '가수', NULL, '2022/01/02', 3000, 300, 10); -- 부서가 없어서 사원등록을 못함
    
INSERT INTO EMP_FK
    VALUES(9999, '이종석', '연예인', NULL, '2022/01/02', 3000, 300, 20); 

INSERT INTO DEPT_FK
    VALUES(10, '개발팀', '서울'); -- 부서를 먼저 만들고 위의 사원등록을 다시 하면 됨
    
INSERT INTO DEPT_FK
    VALUES(20, '빅마우스', '서울');
    
SELECT * FROM EMP_FK;

DELETE FROM DEPT_FK WHERE DEPTNO = 10; -- 10번 부서에 사원정보가 있기 때문에 10번 부서를 지울 수 없음

DELETE FROM EMP_FK WHERE ENAME = '오락실'; -- 10번 부서에 있던 사원정보를 지웠기 때문에 이제 위의 10번 부서를 지울 수 있음

-------------------------------------------------------------------------
-- 데이터 형태와 범위를 정하는 CHECK
-- 열에 저장할 수 있는 값의 범위 또는 패턴을 정의할 때 사용
-- 테이블 생성 시 CHECK 제약 조건 설정하기
CREATE TABLE TABLE_CHECK (
    LOGIN_ID VARCHAR2(20) CONSTRAINT TBLCK_LOGIN_PK PRIMARY KEY,
    LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLCK_LOGINPW_CK CHECK (LENGTH(LOGIN_PWD) > 3),
    TEL VARCHAR2(20)
);

DESC TABLE_CHECK;

INSERT INTO TABLE_CHECK
    VALUES('곰돌이사육사', '1234', '010-5006-4146');
    
-------------------------------------------------------------------------
-- 기본값을 정하는 DEFAULT
CREATE TABLE TABLE_DEFAULT (
    LOGIN_ID VARCHAR2(20) PRIMARY KEY,
    LOGIN_PWD VARCHAR2(20) DEFAULT '1234',
    TEL VARCHAR2(20)
);

DESC TABLE_DEFAULT;

INSERT INTO TABLE_DEFAULT VALUES('곰돌이사육사', NULL, '010-5006-4146');

SELECT * FROM TABLE_DEFAULT;

INSERT INTO TABLE_DEFAULT (LOGIN_ID, TEL) VALUES('곰돌이헌터', '010-5006-4146');

----------------------------------------------------------------------
/* 연습 문제 (1) */

-- 1. product 테이블 생성
CREATE TABLE PRODUCT(
    PRODUCT_ID      NUMBER PRIMARY KEY,
    PRODUCT_NAME    VARCHAR2(20) NOT NULL,
    REG_DATE        DATE
);

DESC PRODUCT;

-- 2. product 테이블에 데이터 삽입
INSERT INTO PRODUCT
    VALUES(1, 'COMPUTER', '21/01/02');
INSERT INTO PRODUCT
    VALUES(2, 'SMARTPHONE', '22/02/03');
INSERT INTO PRODUCT
    VALUES(3, 'TELEVISION', '22/07/01');
    
SELECT * FROM PRODUCT;
    

-- 3. product 테이블에 열 추가 
ALTER TABLE PRODUCT
    ADD WEIGHT NUMBER CHECK(LENGTH(WEIGHT) >= 0);
ALTER TABLE PRODUCT
    ADD PRICE NUMBER CHECK(LENGTH(PRICE) >= 0);

DESC PRODUCT;

--------------------------------------------------------------

/* 연습 문제 (2) */

-- 고객테이블(Customer Table)
CREATE TABLE CUSTOM(
    CUSTOM_ID    NUMBER PRIMARY KEY,
    USER_NAME    VARCHAR2(12) NOT NULL,
    PHONE        VARCHAR2(20),
    EMAIL        VARCHAR2(20),
    REG_DATE     DATE DEFAULT '1900/01/01'
);

DESC CUSTOM;

-- 고객 테이블 추가
ALTER TABLE CUSTOM
    ADD AGE NUMBER CHECK(AGE BETWEEN 1 AND 199);
ALTER TABLE CUSTOM
    ADD SEX VARCHAR2(1) CHECK(SEX = 'M' OR SEX = 'F');
ALTER TABLE CUSTOM
    ADD BIRTH_DATE DATE;
    
DESC CUSTOM;

-- 제약 조건 추가 하기
ALTER TABLE CUSTOM
    MODIFY PHONE UNIQUE;
ALTER TABLE CUSTOM
    MODIFY EMAIL UNIQUE;
    
-- 변경하기
ALTER TABLE CUSTOM
    RENAME COLUMN SEX TO GENDER;
ALTER TABLE CUSTOM
    RENAME COLUMN PHONE TO MOBILE;
ALTER TABLE CUSTOM
    MODIFY USER_NAME VARCHAR2(20);
    
DESC CUSTOM;  

-- 데이터 추가하기
INSERT INTO CUSTOM
    VALUES('11', '윤지성', '010-1991-0308', 'YOONJ1@GMAIL.COM', '1991/03/08', 32, 'M', '1991/03/08');
INSERT INTO CUSTOM
    VALUES(123, '하성운', '010-1994-0322', 'SENG322@GMAIL.COM', '1994/03/22', 29, 'M', '1994/03/22');
INSERT INTO CUSTOM
    VALUES(109, '황민현', '010-1995-0809', 'HMH0809@GMAIL.COM', '1995/08/09', 28, 'M', '1995/08/09');
INSERT INTO CUSTOM
    VALUES(22, '장원영', '010-1234-5678', 'WY2@GMAIL.COM', '2002/05/05', 21, 'F', '2010/12/24');
INSERT INTO CUSTOM
    VALUES(32, '이영지', '010-2345-5678', 'YJ22@GMAIL.COM', '2003/08/05', 22, 'F', '2020/11/02');
INSERT INTO CUSTOM
    VALUES(124, '정경수', '010-3456-5678', 'JKS0224@GMAIL.COM', '1992/08/05', 31, 'M', '2010/12/24');
INSERT INTO CUSTOM
    VALUES(81, '정찬호', '010-7110-5678', 'JCH1@GMAIL.COM', '2002/12/31', 21, 'M', '2009/02/27');
INSERT INTO CUSTOM
    VALUES(93, '김도연', '010-2045-1005', 'DY123@GMAIL.COM', '2002/09/11', 11, 'F', '2022/01/02');
INSERT INTO CUSTOM
    VALUES(82, '정은종', '010-1111-5678', 'EJ22@GMAIL.COM', '2003/08/05', 22, 'F', '2021/11/12');
INSERT INTO CUSTOM
    VALUES(28, '이수빈', '010-2115-5008', 'SB22@GMAIL.COM', '2005/08/05', 24, 'F', '2020/12/02');
    
SELECT * FROM CUSTOM;
    

    
    
