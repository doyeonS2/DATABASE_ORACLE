/* 9월 2일 금요일 */

/* 인덱스 */
SELECT ROWID FROM EMP; -- 오브젝트 번호, 파일번호, 블럭번호, ROW번호
SELECT * FROM USER_INDEXES; -- SCOTT 계정이 가지고 있는 인덱스 정보
SELECT * 
    FROM USER_INDEXES
    WHERE TABLE_NAME = 'EMP';
-- 인덱스 키 등록
CREATE INDEX IDX_EMP_SAL ON EMP(SAL); -- 단일 인덱스 등록
-- 복합 인덱스 등록 (최대 32개까지 등록 가능)
CREATE INDEX IDX_EMP_TUPLE ON EMP(JOB, DEPTNO);
-- 유니크 인덱스 : 인덱스로 지정된 컬럼은 해당 테이블의 유일한 값(중복이 되면 안됨)
CREATE UNIQUE INDEX IDX_EMP_UK ON EMP(EMPNO, MGR);
-- 인덱스 삭제
DROP INDEX IDX_EMP_UK;
---------------------------------------------------------------
/* 테이블 뷰 */
-- 하나 이상의 테이블을 조회하는 SELECT문을 저장한 객체
-- 쿼리문을 단순화 할 수 있음
-- 보안성 목적으로 사용할 수 있음
CREATE VIEW VW_EMP20
    AS (SELECT EMPNO, ENAME, JOB, DEPTNO
        FROM EMP
        WHERE DEPTNO = 20);
        
SELECT * FROM EMP;
SELECT * FROM VW_EMP20;
SELECT * FROM USER_VIEWS;
---------------------------------------------------------------
/* 시퀀스 */
-- 오라클이 특정 규칙에 맞는 연속 숫자를 생성해주는 객체
CREATE SEQUENCE SEQ_EMPID
START WITH 300
INCREMENT BY 2 -- 2씩 증가
MAXVALUE 320 -- 320까지 증가
NOCYCLE
NOCACHE;

SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
---------------------------------------------------------------
/* 동의어 */
-- 영구적인 별칭을 부여하는 방법
CREATE SYNONYM E FOR EMP;
SELECT * FROM E;
SELECT * FROM EMP;
DROP SYNONYM E; -- 동의어 삭제
---------------------------------------------------------------
/* 연습 문제 */

-- 1. 다음의 SQL문을 작성 해보세요.
-- ① EMP 테이블과 같은 구조의 데이터를 저장하는 EMPIDX 테이블을 만들어 보세요.
CREATE TABLE EMPIDX
    AS SELECT * FROM EMP;
    
SELECT * FROM EMP;
SELECT * FROM EMPIDX; 

-- ② 생성한 EMPIDX 테이블의 EMPNO 열에 IDX_EMPIDX_EMPNO 인덱스를 만들어 보세요.
CREATE INDEX IDX_EMPIDX_EMPNO
    ON EMPIDX(EMPNO);


-- ③ 마지막으로 인덱스가 잘 생성되었는지 적절한 데이터 사전 뷰를 통해 확인해 보세요. 
SELECT * 
    FROM USER_INDEXES
    WHERE INDEX_NAME = 'IDX_EMPIDX_EMPNO';

/* 2. View 사용
문제 1번에서 생성한 EMPIDX 테이블의 데이터 중 급여(SAL)가 1500 초과인 사원들만 출력하
는 EMPIDX_OVER15K 뷰를 생성해 보세요. 이 이름을 가진 뷰가 이미 존재할 경우에 새로운 내
용으로 대체 가능해야 합니다. EMPIDX_OVER15K 뷰는 사원 번호, 사원 이름, 직책, 부서 번호,
급여, 추가 수당 열을 가지고 있습니다. 추가 수당 열의 경우에 추가 수당이 존재하면 O, 존재하지
않으면 X로 출력합니다. */
CREATE OR REPLACE VIEW EMPIDX_OVER15K
    AS (SELECT EMPNO, ENAME, JOB, DEPTNO, SAL, NVL2(COMM, 'O', 'X') AS COMM
        FROM EMPIDX
        WHERE SAL > 1500);

SELECT * FROM EMPIDX_OVER15K;

-- 3. 다음 3가지 SQL문을 작성
-- ① DEPT 테이블과 같은 열과 행 구성을 가지는 DEPTSEQ 테이블을 작성해 보세요.
CREATE TABLE DEPTSEQ
    AS SELECT * FROM DEPT;
    
SELECT * FROM DEPT;
SELECT * FROM DEPTSEQ; 

-- ② 생성한 DEPTSEQ 테이블의 DEPTNO 열에 사용할 시퀀스를 오른쪽 특성에 맞게 생성해 보세요.
CREATE SEQUENCE SEQ_DEPTSEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 99
MINVALUE 1
NOCYCLE
NOCACHE;

SELECT *
    FROM USER_SEQUENCES;

-- ③ 마지막으로 생성한 DEPTSEQ를 사용하여 오른쪽과 같이 세 개 부서를 차례대로 추가해 보세요. 


