/*
    SQL(Structured Query Language) : 구조화된 쿼리 언어 라는 의미. 데이터베이스에 질의명령을 작성할 때 사용하는 언어.
    구조화가 되어 있으므로 새롭게 프로그래밍할 수 없다. 형식이 다 정해져 있으므로 정해진 형식에 맞추어 작성하면 된다.
    
    DDL(Data Definition Language) : 데이터 정의 언어. 데이터베이스에 개체를 직접 만들고 수정하는 명령. 그래서 바로 트랜잭션 처리가 된다.
    ==> 명령 : CREATE, ALTER, DROP, TRUNCATE,..
 
    DML(Data Manipuration Language) : 데이터 조작 언어. 
    ==> CRUD - 데이터를 조작하는 방법

        C.R.U.D      명령
        CREATE    : INSERT 
        READ      : SELECT
        UPDATE    : UPDATE
        DELETE    : DELETE
        
    ==> DBMS에게 할당받은 메모리(세션, session)에서만 작업이 이루어진다.
        따라서 데이터베이스에 적용시키려면 트랜잭션 처리 명령으로 적용시켜야 한다.(=commit 해야 한다.)
    
    DCL(Data Control Language) : 데이터 제어 언어. 
    ==> TCL(Transaction Control Language) : 트랜잭션 제어 언어. ==> commit, rollback, savepoint,..
        권한 관련 명령 : GRANT(권한 부여), REBOKE(권한 회수),.. 
 
 ------------------------------------------------------------------------------------------------------------------------------------
 
    현재 계정(user)이 가지고 있는 테이블의 간략한 정보를 조회하는 방법
        : DESCRIBE 테이블이름;
          DESC 테이블이름; (describe의 약자)
          
    현재 계정(user)이 소유한 모든 테이블의 간략한 정보를 조회하는 방법
        : SELECT * FROM tab;
    
        참고) tab 테이블 : 해당 계정이 소유한 테이블들의 간략한 정보를 기억하는 테이블
    
    참고) sqlplus 명령은 세션이 종료되면 초기화된다.

--------------------------------------------------------------------------------------------------------------------------------------

    중복된 조회 데이터를 한번만 조회되게 하는 명령 : DISTINCT
    
        참고) DISTINCT 명령을 입력한 상황에서 여러 개의 컬럼을 나열해서 조회하는 경우는
              여러 개의 컬럼의 데이터가 모두 동일한 행만 한번만 조회하게 된다.    
    
*/

-- 사원들의 부서번호 조회하기
SELECT
    deptno
FROM
    emp
;

-- 사원들의 부서번호 조회하기. 단, 중복된 부서는 한번만 조회되게 하기.
SELECT
    DISTINCT deptno
FROM
    emp
;

-- 사원들의 사원이름, 부서번호 조회하기.
SELECT
    DISTINCT ename, deptno -- 한 행이 데이터 한 개. ename과 deptno 합쳐서 데이터 한 개. 이름은 중복이 없으므로 부서번호가 중복이 있어도 데이터는 모두 다른 것.
FROM
    emp
;
-- ==> 사원이름과 부서번호가 동일한 사원은 존재하지 않으므로, 모든 사원의 정보를 조회하게 된다.

/*
    데이터 조회 질의명령
        형식1) SELECT
                   [DISTINCT] 컬럼이름1, 컬럼이름2,..
               FROM
                   테이블이름
               ;
        
        형식2) SELECT (=SELECT절)
                   [DISTINCT] 컬럼이름1, 컬럼이름2,..
               FROM (=FROM절)
                   테이블이름
               WHERE (=WHERE 조건절)
                   조건식  ==> 한 행씩 검토해서 조건식이 참이면 결과집합에 포함시키고 거짓이면 제외한다.
               ;
*/

-- 부서번호가 10번인 사원들의 사원번호, 사원이름, 직급, 부서번호 조회하기.
SELECT
    empno "사원번호", ename 사원이름, job AS "직 급", deptno 부서번호
FROM
    emp
WHERE
    deptno = 10 -- '=' : 동등비교 연산자 (여기서는 대입연산자가 아님. 대입연산자로서도 물론 쓰임)
;

/*
    조회결과에 연산식을 포함해서 조회할 수 있다.
    
    산술연산자
        +
        -
        *
        /
*/

-- 간단한 계산결과(10 / 3)를 조회해보자.
SELECT
    10 / 3
FROM
    emp
;
-- emp 테이블에 데이터가 14개 존재하므로 계산 결과도 14개의 3.333... 으로 출력됨.
-- 이런 경우를 위해서 오라클에서는, 물리적으로 만들어져 있지는 않지만, 한 개의 행과 한 개의 컬럼으로 구성된 가상의 테이블을 제공한다.
-- 이 테이블의 이름은 DUAL이며, 이런 가상의 테이블을 가리켜 '의사테이블'이라고 부른다.
SELECT
    10 / 3
FROM
    dual
;

-- 질의명령 안에 연산식을 포함할 수 있다.
-- 10번 부서 사원들의 사원이름, 부서번호, 원급여, (10%)인상급여 조회하기.
SELECT
    ename 사원이름, deptno 부서번호, sal 원급여, (sal * 1.1) 인상급여
FROM
    emp
WHERE
    deptno = 10
;

-- Q1. 사원들 중 급여가 1500 이상인 사원들의 사원이름, 직급, 급여를 조회하시오.
SELECT
    ename "사원 이름", job 직급, sal 급여
FROM
    emp
WHERE
    sal >= 1500
;

/*
    not 연산자 : 부정 연산자. 결과를 부정한다.
*/

SELECT
    ename "사원 이름", job 직급, sal 급여
FROM
    emp
WHERE
    not sal < 1500
;

/*
    참고(중요!!)
        NULL 데이터 : 필드에는 데이터가 보관되어야 하는데, 아직 데이터가 만들어지지 않은 경우도 생길 수 있다.
                        이처럼 컬럼에 데이터가 없는 상태를 NULL 데이터라고 한다.
    
        NULL 데이터는 모든 연산에서 제외된다.
        따라서 NULL 데이터의 비교가 필요한 경우는, IS NULL / IS NOT NULL 이라는 연산자로 비교해야 한다.
        
    참고(중요!!)
        NULL 데이터 대체 함수
        ==> NULL 데이터는 모든 연산에서 제외되므로, 연산이 필요한 경우에는 특정 데이터로 교체해서 연산작업이 되어야 한다.
            이때 사용하는 함수 : NVL(컬럼이름, 대체값) / NVL2(컬럼이름, 연산식, 대체값)
    
    참고) NULL 일 때 대체값 데이터와 본래 데이터의 타입은 같아야 한다.
*/

-- 사원들 중 커미션이 없는 사원들의 사원이름, 직급, 급여, 커미션 조회하기.
SELECT
    ename, job, sal, comm
FROM
    emp
WHERE
    comm IS NULL
;  


-- 사원들의 사원이름, 급여, 지급커미션을 조회하는데, 커미션을 100 인상해서 조회하기.
-- 단, 커미션이 없는 사원은 50을 지급하기.

SELECT
    ename 사원이름, sal 급여, NVL(comm, -50) + 100 지급커미션 
FROM
    emp
;

SELECT
    ename 사원이름, sal 급여, NVL(comm + 100, 50) 지급커미션 
FROM
    emp
;

SELECT
    ename 사원이름, sal 급여, NVL2(comm, comm + 100, 50) 지급커미션 
FROM
    emp
;

-- comm은 NUMBER 타입이고, '커미션 없음'은 CHAR 타입이다.
-- TO_CHAR 은 날짜나 숫자 데이터를 문자로 변환시키는 함수다.
SELECT
    ename, NVL(TO_CHAR(comm), '커미션 없음') 커미션
FROM
    emp
;

/*
    WHERE 조건절에 조건을 여러 개 나열할 수 있다.
    이때, 각 조건을 연산하는 논리 연산자는 다음과 같다.
        AND : 모든 조건이 참이다.
        OR : 여러 개 중 하나만 참이다.
*/

-- 부서번호가 30번이고 직급이 'MANAGER'인 사원들의 사원번호, 사원이름, 직급, 급여, 부서번호 조회하기.
SELECT
    empno, ename, job, sal, deptno
FROM
    emp
WHERE
    deptno = 30
    AND job = 'MANAGER'
;

-- 연산자, 테이블이름, 필드이름, 명령 등은 대소문자를 구분하지 않지만,
-- 데이터는 대소문자를 필히 구분한다!!

-- Q. smith 사원의 사원이름, 직급, 부서번호를 조회하시오.
SELECT
    ename, job, deptno
FROM
    emp
WHERE
    ename = 'SMITH'
;

-- Q. 부서번호가 20번이고 급여가 1500 이상인 사원들의 사원이름, 직급, 부서번호, 급여를 조회하시오.
SELECT
    ename, job, deptno, sal
FROM
    emp
WHERE
    deptno = 20
    AND NOT sal < 1500
;

SELECT
    MOD(10, 3) 나머지 -- MOD : 나머지 구하는 함수
FROM
    dual
;

/*
    오라클에서도 문자열을 결합해서 조회할 수 있다.
    이때는 두 개의 컬럼을 결합할 수도 있고, 하나의 컬럼과 하나의 문자열을 결합할 수도 있으며, 두 개의 문자열을 결합할 수도 있다.
    
    연산자 : 데이터 || 데이터 
*/

SELECT
    3.14 || 100
FROM
    dual
;


-- 사원들의 사원번호, 사원이름, 직급 조회하기.
-- 단, 사원번호는 번호 뒤에 '번'을 붙이고, 사원이름은 이름 뒤에 '사원'을 붙이기.

SELECT
    empno || ' 번' "사원번호", ename || ' 사원' "사원이름", job "직급" 
FROM
    emp
;

-- 사원들의 '사원번호 - 사원이름 : 직급'을 이 형식에 맞춰서 조회하기.
-- 작은 따옴표가 한 쌍이므로 세 개의 컬럼이 결합하여 하나의 컬럼을 만들어야 함.
SELECT
    empno || ' - ' || ename || ' : ' || job 사원정보
FROM
    emp
;

/*
    참고) 오라클은 데이터의 형태를 매우 중요시한다.
          원칙적으로 문자는 문자끼리, 숫자는 숫자끼리 비교할 수 있다.
          단, 예외가 한 가지 존재하는데, 날짜는 문자와 비교가 가능하다.
*/

-- 1981년 10월 이후 (10월 포함) 에 입사한 사원들의 사원이름, 직급, 입사일 조회하기.
SELECT
    ename 사원이름, job 직급, hiredate 입사일
FROM
    emp
WHERE
    hiredate > '1981/09/30'
;

/*
    참고) 오라클은 문자데이터도 크기비교가 가능하다.
          이때는 ASCII 코드값을 이용해서 비교한다.
          즉, 'A'는 'B'보다 작다.
*/

-- 사원의 이름이 'H' 이후의 문자 (H 포함) 로 시작하는 사원들의 사원이름, 사원직급, 입사일 조회하기.
SELECT
    ename, job, hiredate
FROM
    emp
WHERE
    ename > 'Gzzzzzzzzzzzz' -- ename >= 'H'
;

/*
    참고) 오라클은 문자와 문자열을 구분하지 않는다. 모두 하나의 형태로 관리한다.
          이때 문자데이터의 표현은 작은따옴표('')를 사용해서 표현한다.
          
    참고) 오라클은 모든 명령이 대소문자를 구분하지 않는다. 하지만 데이터만큼은 반드시 대소문자를 구분해야 한다.
*/

-- Q. 직급이 'CLERK'인 사원들의 사원이름, 직급, 월 급여를 조회하시오.
--    단, 월 급여는 급여 + 커미션으로 하고 커미션이 없는 사람은 0으로 계산하시오.
SELECT
    ename, job, sal, comm, sal + NVL(comm, 0) -- NVL(sal + comm, sal)
FROM
    emp
WHERE
    job = 'CLERK'
;
-- SALESMAN 으로 다시 해봤음.
SELECT
    ename, job, sal, comm, sal + NVL(comm, 0)
FROM
    emp
WHERE
    job = 'SALESMAN'
;

-- Q. 사원들 중 급여가 1000 ~ 3000 사이인 사원들의 사원이름, 직급, 급여를 조회하시오.
SELECT
    ename, job, sal
FROM
    emp
WHERE
    sal >= 1000
    AND sal <= 3000
-- sal BETWEEN 1000 AND 3000 (BETWEEN 연산자 : 범위 비교 연산자 - 주의! 작은 값이 먼저 와야 한다.)
;
-- Q. 부서번호가 10번이거나 20번인 사원들의 사원이름, 직급, 부서번호를 조회하시오.
SELECT
    ename, job, deptno
FROM
    emp
WHERE
    deptno = 10
    OR deptno = 20
-- deptno IN (10, 20) (IN 연산자 : 다중값 비교연산자. 동등비교연산을 한다. 나열한 데이터는 OR의 기능으로 조회된다.)
;

/*
    조건 비교 연산자
    1 - BETWEEN A AND B : 데이터가 A와 B 사이에 있는지 확인하는 조건 연산자.
    2 - IN : 데이터가 주어진 여러 개의 데이터 중 하나라도 만족하는지 알아보는 조건 연산자.
            형식) 컬럼(데이터) IN(데이터1, 데이터2, 데이터3,..)
    3 - LIKE : 문자열 비교 연산자. 문자열의 일부분을 형식을 지정해서 맞는지 검사하는 조건 연산자.]
            형식) 필드이름(데이터) LIKE '와일드카드 포함 문자열'
            의미) 필드의 데이터가 지정한 문자열과 동일한 형식인지 비교한다.
            
            참고) 와일드카드 사용방법
                형식)) _ : 언더바 1개당 한글자만 올 수 있다. (_ 1개 : 한글자를 의미한다)
                       % : 글자수에 관계없이 모든 문자열을 포함하는 형식문자.
                       
                EX) 
                    'M%' : M으로 시작하는 모든 문자열
                    '%M%' : M이 포함된 모든 문자열
                    '_M%' : 두번째 문자가 M인 모든 문자열
                    
                    '____/01/__' : 1월
                    '____' : 문자 네 개로 구성된 문자열
*/

-- 사원의 이름이 5글자인 사원들의 사원이름, 직급 조회.
SELECT
    ename, job
FROM
    emp
WHERE
    ename LIKE '_____'
;

-- 1월에 입사한 사원들의 사원이름, 입사일 조회.
SELECT
    ename, hiredate
FROM
    emp
WHERE
    hiredate LIKE '__/01/__'
;

-- 날짜가 오늘 날짜와 같은 날에 입사한 사원의 사원이름, 입사일 조회.

SELECT
    ename, hiredate
FROM
    emp
WHERE
    hiredate LIKE '___12/15'
;

-- 2월 20일에 입사한 사람으로 다시.
SELECT
    ename, hiredate
FROM
    emp
WHERE
    hiredate LIKE '___02/20'
;
-- 참고) 질의명령이 실행되는 순간의 날짜 데이터를 알려주는 명령: sysdate
SELECT SYSDATE FROM DUAL;


-----------------------------------------------------------------------------------------------------------
-- 수업내용

/*
    NULL 데이터는 모든 연산에서 제외된다. 따라서 조건식에서도 사용할 수 없다.
    IS NULL / IS NOT NULL 로 비교해야 한다.
*/

-- 사장님의 이름 조회
SELECT
    ename 사장님이름
FROM
    emp
WHERE
    mgr IS NULL -- 상사번호가 없는 사람 (job = 'PRESIDENT' 로도 가능)
;

/*
    데이터 조회 질의명령 형식
        형식 3)
            SELECT
                컬럼이름, 컬럼이름,..
            FROM
                테이블이름
            WHERE
                조건식
            ORDER BY   
                컬럼이름 ASC OR DESC, 컬럼이름 ASC OR DESC,..
            ;
 
    ORDER BY : 데이터 정렬
               WHERE절까지 읽어서 실행한 후 데이터 결과집합 생성.
               이후에 ORDER BY가 실행되어야 함.
               그래서 가장 마지막에 위치해야 함.
    ASC : 오름차순 정렬 (생략 가능)
    DESC : 내림차순 정렬

    조건절이 추가되는 경우는 조건절을 먼저 기술하고 정렬절을 나중에 기술한다.
    (이유 : 걸러진 결과를 정렬에 사용하기 때문)
    조건절은 많이 걸러내는 조건, ~ , 적게 걸러내는 조건 순으로 입력하면 전체적 작업 시간이 단축된다.

    참고) 
*/

-- 사원들의 사원이름, 입사일, 급여를 조회하는데, 급여가 같으면 입사일이 빠른 사원부터 조회.
SELECT
    ename 사원이름, hiredate 입사일, sal 급여
FROM
    emp
ORDER BY
    sal DESC, hiredate
;

-- Q. 사원의 이름이 5글자인 사원들의 사원이름, 직급을 조회하시오.
-- 단, 이름 순서대로 정렬해서 조회하시오.
SELECT 
    ename 사원이름, job 직급
FROM
    emp
WHERE
    LENGTH(ename) = 5
--    ename LIKE '_____' -- 길이 도출하는 함수로 표현 : LENGTH(ename) = 5
ORDER BY
    ename ASC
;

---------------------------------------------------------------------------------------------------------
/*
    (하나의 컬럼에는 하나의 데이터 타입만 들어간다)
    집합연산자 : 두 개 이상의 조회 질의 결과를 이용해서 그 결과의 결합을 얻어내는 방법
        형식) 
            SELECT ~ FROM ~ ~ ~ ;
            집합연산자
            SELECT ~ FROM ~ ~ ~ ;
            
        종류) 
            UNION       : 합집합
            
            UNION ALL   : 합집합. 중복데이터를 한번 더 출력한다.
            
            INTERSECT   : 교집합. 중복데이터만 출력한다.
            
            MINUS       : 차집합. 
        
        참고)
            공통적인 특징
                1. 두 질의명령에서 나온 결과는 같은 필드의 갯수를 가져야 한다.
                2. 두 질의명령에서 나온 결과 필드의 타입과 순서가 같아야 한다. 이때 크기는 상관없다.
*/
 
 --부서번호와 상사번호를 하나의 컬럼으로 표현해보자.
 SELECT
    job 직급, mgr 상사번호 -- job 과 ename, mgr 과 deptno는 타입이 동일하다. 타입의 순서도 동일하다. 갯수도 동일하다.
 FROM
    emp
 UNION ALL
 SELECT
    ename, deptno
 FROM
    emp
 ;
 
 SELECT
    job 직급, mgr 상사번호
 FROM
    emp
 MINUS -- 위쪽 SELECT 절의 데이터만 나온다. 교집합이 없어서.
 SELECT
    ename, deptno
 FROM
    emp
 ORDER BY
     직급 -- 집합 연산 때문에 필드명이 별칭으로 고정되어버리므로 별칭으로 적어야 하는 상황이다. 일반 질의명령은 상관X.
 ;
 
 -- 같은 SELECT 절을 UNION 집합연산 하면 DISTINCT 썼을 때와 같은 질의결과가 나온다.
 SELECT
    deptno
 FROM
    emp
 UNION
 SELECT
    deptno
 FROM
    emp
 ;
 
 -- 이름이 5글자 이상 6글자 이하인 사원들의 사원이름, 직급을 조회.
 SELECT
    ename 사원이름, job 직급
 FROM
    emp
 WHERE
    LENGTH(ename) BETWEEN 5 AND 6
 ;
 
 -- 입사년도가 85년~87년 사이인 사원들의 사원이름, 직급, 입사일 조회하시오. (BETWEEN 사용)
 SELECT
    ename 사원이름, job 직급, TO_CHAR(hiredate, 'YYYY') 입사년도
 FROM
    emp
 WHERE
    TO_CHAR(hiredate, 'YYYY') BETWEEN '1985' and '1987'
 ;
 
 