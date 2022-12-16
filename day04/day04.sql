/*
    함수 : 데이터를 가공하기 위해 오라클에서 제공하는 명령의 일종
    
    참고)
        DBMS는 데이터베이스 벤더(회사)마다 다르다. 특히 함수는 벤더가 직접 제작하기 때문에 각각이 매우 다르다.
        따라서 다른 데이터베이스를 사용하면 함수들이 달라질 것이므로, 함수들부터 파악해놓는 것이 좋다.
     
    종류)
        1. 단일행 함수 : 한 행마다 매번 명령이 실행되는 함수 ==> 데이터 하나로 처리되는 함수
            ==> 따라서 단일행 함수의 결과는 출력되는 데이터의 갯수와 동일하다.
        2. 그룹 함수 : 여러 행을 모아서 한번만 실행되는 함수
            ==> 따라서 그룹 함수는 출력되는 데이터의 갯수가 단 한 개다.
        
        ***
        주의)
            단일행 함수와 그룹 함수는 절대로 같이 호출할 수 없다.
*/

-- 계층형 질의명령  ex) 댓글게시판에서 유용
SELECT
    empno, ename, job, mgr, level-1 step
FROM
    emp
START WITH
    mgr IS NULL
CONNECT BY
    PRIOR EMPNO = mgr
;

/*
    단일행 함수
        1. 숫자 함수 : 데이터가 숫자인 경우에만 사용할 수 있는 함수
            1) ABS() : 절댓값 구해주는 함수(Absolute). 음수도 양수로 표현한다.
                형식)
                    ABS(숫자데이터 또는 컬럼이름 또는 숫자연산식)                   
            
            2) FLOOR() : 소수점 이하를 버리는 함수. (정수를 만들어주는 함수) (자릿수를 정할 수 없고 무조건 다 버린다.)
                형식)
                    FLOOR(숫자데이터 또는 컬럼이름 또는 숫자연산식)
                    
            3) ROUND() : 지정한 자릿수에서 반올림하는 함수.
                        (자릿수를 지정하지 않으면 0으로 간주되어 소수 첫째자리에서 반올림한다.)
                        (-1 : 일의자리에서 반올림, -2 : 십의자리에서 반올림, 1 : 소수점 둘째자리에서 반올림, 2 : 소수점 셋째자리에서 반올림)
                형식)
                    ROUND(숫자데이터 또는 컬럼이름 또는 숫자연산식[, 자릿수])
                참고)
                    자릿수는 양수를 쓰면 반올림해서 보여줄 소수점 자릿수가 되고, 음수를 쓰면 소수점 이상 반올림할 자릿수가 된다.
            
            4) TRUNC() : FLOOR() 함수와 마찬가지로 소수점 이하를 버리는 함수. 단, 자릿수를 지정할 수 있다.
                형식)
                    TRUNC(숫자데이터 또는 컬럼이름 또는 숫자연산식[, 자릿수])
                참고)
                    자릿수는 ROUND()와 동일하게 처리된다.
            
            5) MOD() : 나머지를 구하는 함수
                형식)
                    MOD(숫자데이터1, 숫자데이터2)
                    ==> 숫자데이터1을 숫자데이터2로 나눈 나머지 를 반환한다.
            
            참고)
                모든 함수는 SELECT절에서도 사용할 수 있고, WHERE 조건절에서도 사용할 수 있다.  
*/

-- 1-1
SELECT ABS(-100) FROM dual;
SELECT ABS(-200) FROM dual;
SELECT ABS(-3.14) FROM dual;

-- 1-2 : 사원들의 급여를 15% 인상한 금액을 조회하기. 단, 소수 이하는 버림한다.
SELECT
    empno 사원번호, ename 사원이름, sal 원급여, (sal * 1.15) AS "버림 전 인상급여", FLOOR(sal * 1.15) AS "버림 후 인상급여"
FROM
    emp
;

-- 1-3 : 사원들의 급여를 15% 인상해서 조회하기. 단, 십의자리에서 반올림한다.
SELECT
    empno 사원번호, ename 사원이름, sal 원급여, (sal * 1.15) AS "반올림 전 인상급여", ROUND(sal * 1.15, -2) AS "반올림 후 인상급여"
FROM
    emp
;

SELECT ROUND(3.141592, 2) 숫자 FROM dual;

-- 1-4 : 사원들의 급여를 15% 인상한 금액 조회하기. 단, 백단위 미만은 버린다.
SELECT
    empno 사원번호, ename 사원이름, sal 원급여, (sal * 1.15) "버림 전 인상급여", TRUNC(sal * 1.15, -2) "버림 후 인상급여"
FROM
    emp
;

SELECT TRUNC(3.141592, 3) no FROM dual;

-- 1-5 : 사원들 중 급여가 짝수인 사원만 조회하기. 
SELECT
    ename 사원급여, job 직급, sal 급여, MOD(sal, 2) 나머지
FROM
    emp
WHERE
    MOD(sal, 2) = 0
;

--------------------------------------------------------------------------------------------
/*
    형변환)
         TO_CHAR()       TO_CHAR()
    숫자 --------> 문자 <-------- 날짜
         <--------       -------->
        TO_NUMBER()      TO_DATE()

    단일행 함수
        2. 문자 함수 : 문자 데이터를 가공하는 함수
            1) LOWER() : 알파벳을 소문자로 변환하여 반환하는 함수
            
            2) UPPER() : 알파벳을 대문자로 변환하여 반환하는 함수
            
            3) INITCAP() : 단어의 첫 문자는 대문자로, 그 다음부터의 문자는 소문자로 변환하여 반환하는 함수
            
            4) LENGTH() / LENGTHB() : 문자열의 길이를 숫자/바이트로 반환하는 함수
            
            5) CONCAT() : 두 개의 문자열을 하나로 결합해주는 함수
                형식)
                    CONCAT(데이터1, 데이터2)
            
            6) SUBSTR() / SUBSTRB() : 문자열 중에서 특정 위치의 문자열만 추출하는 함수
                형식)
                    SUBSTR(문자열, 시작위치, 꺼낼 문자 갯수)
                참고)
                    위치값은 1부터 시작한다.
                    꺼낼 문자 갯수는 생략 가능하며, 생략하면 문자열의 맨 뒤까지 꺼낸다.
            
            7) INSTR() / INSTRB() : 문자열 중에서 특정 문자열이 시작되는 위치값(또는 바이트)을 알려주는 함수
                형식)
                    INSTR(문자열, 찾을 문자열, 시작위치, 건너뛸 횟수)
                참고)
                    시작위치는 음수로 사용할 수 있다. 음수로 쓰는 경우, 뒤에서부터 위치값을 계산한다.
                    주의사항! 검색 방향도 뒤에서부터 앞으로 진행해서 찾게 된다.
                    
                    찾을 문자가 없는 경우는 0을 반환한다.
            
            8) LPAD() / RPAD() : 문자열의 길이를 지정한 후 남는 공간은 지정한 문자로 채워서 문자열을 길이 수로 완성하는 함수 (LEFT PADDING, RIGHT PADDING)
                차이점) 남는 부분이 생겼을 때, LPAD는 왼쪽 or RPAD는 오른쪽에 특정 문자를 채운다.
                형식) LPAD(문자열, 길이, 채울 문자), RPAD(문자열, 길이, 채울 문자)
                참고) 채울 문자를 넣었을 때 만들어지는 문자열의  길이가 지정한 데이터 길이보다 작으면 지정한 데이터 길이만큼만 문자열을 만든다.
            
            9) REPLACE() : 문자열의 특정 부분을 다른 문자열로 교체하는 함수
                형식) REPLACE(문자열, 찾을 문자열, 교체 문자열)
                (문자열 안에 있는 모든 '찾을 문자열'을 '교체 문자열'로 바꾼다. 문자 갯수가 달라도 제약없이 적용된다.)
            
            10) TRIM() : 문자열 중에서 앞 또는 뒤에 있는 지정한 문자 한 글자를 삭제하는 함수
                형식) TRIM(삭제할 문자 FROM 문자열)
                참고) 중간에 있는 문자는 삭제하지 못한다.
                      같은 문자가 앞뒤에 있으면 모두 삭제한다.
                      간혹 데이터 앞뒤에 공백문자가 들어간 경우가 있는데, 이럴 때 앞뒤 공백문자를 제거하는 데 유용하다.

                10-1) LTRIM : 앞(왼쪽)에 있는 문자만 삭제한다.
                    ex) SELECT LTRIM('ooooooracleooooooooo', 'o') FROM dual; ==> racleooooooooo
                10-2) RTRIM : 뒤(오른쪽)에 있는 문자만 삭제한다.
                    ex) SELECT RTRIM('ooooooracleooooooooo', 'o') FROM dual; ==> ooooooracle
            
            11) ASCII() : 문자에 해당하는 아스키 코드값을 알려주는 함수
                형식) ASCII(문자열)
                참고) 데이터가 두 글자 이상이면 첫 번째 문자의 아스키코드값만 알려준다.
                ex) SELECT ASCII('dooly') FROM dual; ==> 100 ('d'의 아스키코드값)
                
            12) CHR() : 아스키코드값에 해당하는 문자를 알려주는 함수
            
            13) TRANSLATE() : REPLACE와 마찬가지로, 문자열 중 지정한 부분을 다른 문자로 교체하는 함수
                형식) TRANSLATE(문자열, 교체대상 원본문자SET, 교체하는 매핑문자SET)
                REPLACE 와의 차이점)
                    REPLACE - 바꿀 문자를 문자열 전체에서 전부 바꾼다.
                    TRNASLATE - 바꿀 문자를 문자 단위로 매핑해서 바꾼다. (예제 참고)
            
*/ 

-- 2-1 ~ 2-3 : 사원들의 이름 조회.
SELECT
    LOWER(ename) "소문자 이름", UPPER(LOWER(ename)) "대문자 이름", INITCAP(LOWER(ename)) "첫 글자만 대문자 이름"
FROM
    emp
;

-- 2-4 (영어는 1글자 = 1BYTE, 한글은 '홍' -> ㅎ = 1BYTE, ㅗ = 1BYTE, ㅇ = 1BYTE)
SELECT
    LENGTH(ename) "이름 글자 수", LENGTHB(ename) "이름 바이트 수"
FROM
    emp
;

SELECT
    LENGTH(name) "이름 글자 수", LENGTHB(name) "이름 바이트 수", LENGTHB(SUBSTR(name, 1, 1)) 홍, LENGTHB(SUBSTR(name, 2, 1)) 길, LENGTHB(SUBSTR(name, 3, 1)) 동
FROM
    (
        SELECT '홍길동' name FROM dual -- 인라인뷰
    )
;

-- 사원들의 이름의 글자수가 4글자 또는 5글자인 사원들의 사원이름, 직급 조회하기.
-- 이름 글자수가 적은 사람이 먼저 출력되게 하고, 같으면 이름순으로 출력하기.
SELECT
    ename 사원이름, LENGTH(ename) 이름글자수, job 직급
FROM
    emp
WHERE
    LENGTH(ename) IN(4, 5)
ORDER BY
    LENGTH(ename) ASC, ename
;

-- 2-5 : 사원들의 이름을 조회하는데, 이름 앞에 'Mr.'를 붙여서 조회하기.
SELECT
    'Mr.' || ename 사원이름, CONCAT('Mr.', ename) 사원이름2
FROM
    emp
;

SELECT
    CONCAT(sal, ename) 급여이름
FROM
    emp
;

SELECT
    CONCAT(sal, deptno) 급여부서번호
FROM
    emp
;

-- 2-6 : 사원들의 이름 중 세 번째 글자를 꺼내서 사원이름, 꺼낸문자 조회.
SELECT
    ename 사원이름, SUBSTR(ename, 3, 1) 꺼낸문자
FROM
    emp
;

-- 사원들의 이름에서 세 번째 문자가 'A'인 사원들의 사원이름, 직급 조회.
SELECT
    ename 사원이름, job 직급
FROM
    emp
WHERE
    SUBSTR(ename, 3, 1) = UPPER('a') -- ename LIKE '__A%'
;

SELECT 
    ename, SUBSTR(ename, -2)
FROM
    emp
;

-- '홍길동' 한글 문자열을 4byte 위치부터 맨뒤까지 자르기.
SELECT
    '홍길동' 이름, SUBSTRB('홍길동', 5) 자른이름
FROM
    dual
;

-- 2-7
SELECT
    INSTR('Hong Gil Dong', 'Gil') gil
FROM
    dual
;

SELECT
    INSTR('Hong Gil Dong', 'o', 1, 2) "두번째 o"
FROM
    dual
;

SELECT
    INSTR('Hong Gil Dong', 'on', -1, 2) "뒤에서부터 두번째 on" -- 시작위치 음수로 입력한 경우
FROM
    dual
;

SELECT
    INSTR('Hong Gil Dong', 'O') "대문자 O" -- 찾는 문자가 없는 경우
FROM
    dual
;

-- 사원의 이름에 'M'이 포함된 사원들의 사원이름, 직급, 입사일 조회.
SELECT
    ename 사원이름, job 직급, hiredate 입사일
FROM
    emp
WHERE
    INSTR(ename, 'M', 1) <> 0 -- 이름에 M이 포함된 사람의 갯수가 0이 아니면 출력한다.
-- ename LIKE '%M%'
;

/*
    비교연산자
        =       : 같다
        !=      : 다르다
        <>      : 다르다  
        ^=      : 다르다
        >       : 크다
        <       : 작다
        >=      : 크거나 같다
        <=      : 작거나 같다
        
    NOT : 부정연산자. 논리값을 반대로 만들어준다. T/F 의 데이터에서만 사용.
*/

-- 2-8
SELECT
    LPAD('Boa Hankok', 5, '$') 엘패드
FROM
    dual
;

SELECT
    LPAD('Boa Hankok', 11, '$') 엘패드
FROM
    dual
;

-- 사원들의 이름 첫 두글자를 보이게 하고 나머지 글자는 '#'으로 표현하기.
-- 사원이름, 변환이름, 직급, 입사일 조회.
SELECT
    ename 사원이름, RPAD(SUBSTR(ename, 1, 2), LENGTH(ename), '#') 변환이름, job 직급, hiredate 입사일
FROM
    emp
;

-- Q. 사원들의 이름을 끝 두글자만 표현하고 나머지 자리는 '*'로 표현하시오.
-- 사원이름, 직급 조회하시오.

SELECT
    ename 사원이름, LPAD(SUBSTR(ename, -2), LENGTH(ename), '*') 변환이름, job 직급
FROM
    emp
;

-- Q. 세번째 문자만 보이게 하시오.
SELECT
    ename 사원이름, CONCAT(LPAD(SUBSTR(ename, 3, 1), 1, ' '), RPAD(ename, -2, ' ')) 변환이름, job 직급
FROM
    emp
;


-- 2-9
SELECT
    REPLACE('Hong gil Dong', 'Hong', 'Gho')
FROM
    dual
;

SELECT
    REPLACE('Hong gil Dong', 'o', 'ho')
FROM
    dual
;

-- 2-10
SELECT
    TRIM('H' FROM 'Hong Gil Dong') H,
    TRIM(' ' FROM '     Hong Gil dong     ') 앞뒤공백
FROM
    dual
;

-- 2-11
SELECT
    ASCII('dooly') dooly, ASCII('d') d
FROM
    dual;

-- 2-12
SELECT
    CHR(100)
FROM
    dual
;

-- 2-13
SELECT
    TRANSLATE('abcdaadcb', 'abcd', '1234')
FROM
    dual
;

SELECT
    TRANSLATE('abcdaadcb', 'abc', '1234')
FROM
    dual
;