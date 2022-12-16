/*
    날짜 함수
        참고) sysdate : 오라클의 예약어로, 현재 시스템의 날짜와 시간을 출력한다.
    
        날짜 연번)
            1970년 1월 1일 0시 0분 0초를 기준으로, 지정한 날짜까지의 날짜 연번을 이용해서 날짜데이터를 기억한다.
            아래와 같은 형식(숫자 타입)으로 기억한다.
            형식) 날수.시간 (ex, 3.14 ==> 3일, 0.14는 1일보다 적으므로 0.14일의 시간임)
        
        참고) 날짜데이터끼리의 연산은 - 는 가능하지만, +, *, / 는 불가능하다.
              예외적으로 날짜 + 숫자 는 가능하다.
              날짜 연번은 숫자이므로, 결국 날짜에서 원하는 숫자만큼 이동된 날짜를 표시하게 된다.
        
        1) ADD_MONTHS() : 현재 날짜에 지정한 달수를 더하거나 뺀 날짜를 알려주는 함수
            형식) ADD_MONTHS(sysdate, 더할 개월수)
        
        2) MONTHS_BETWEEN() : 두 날짜 사이의 개월수를 알려주는 함수
            형식) MONTHS_BETWEEN(미래날짜, 과거날짜)
                  ABS(MONTHS_BETWEEN(과거날짜, 미래날짜)) 도 가능!
                  
        3) LAST_DAY() : 지정한 날짜가 포함된 월의 마지막 날짜를 알려주는 함수
            형식) LAST_DAY(날짜)
            
        4) NEXT_DAY() : 지정한 날짜 이후 가장 처음 만나는 지정한 요일이 며칠인지 알려주는 함수
            형식) NEXT_DAY(날짜, 원하는 요일 형식)
            참고) 요일 형식 : 
                1> 한국 - 월 화 수 목 금 토 일
                2> 영어권 - MON THE WED THU FRI SAT SUN (환경설정에서 나라가 KOREA로 되어있어서 영문 출력은 현재 불가능)
    
        5) ROUND() : 날짜를 지정한 부분에서 반올림하는 함수
                     지정한 부분이란   년, 월, 일, 시간, 요일   등이 있다.
                     지정한 부분은 영어로 표기해야 한다. (year, month, day, hour,..)
                     연도의 경우, 1~6월이면 올해 출력, 7~12월이면 내년 출력.
                     월의 경우, 1~15일이면 이번달 출력, 16일 이후면 다음달 출력. (일수 계산해서 하지 않음. 기준값은 15일로 고정.)
            형식) ROUND(날짜, '반올림 기준')
           
*/
-- 날짜 함수 ex)
SELECT sysdate FROM dual;  -- 년월일까지 출력
SELECT TO_CHAR(sysdate, 'YYYY-MM-DD HH24:MI:SS') FROM dual; -- 년월일에 시간,분,초까지 출력 (문자형태)
SELECT (sysdate + sysdate) FROM dual; -- 'not allowed'
SELECT (sysdate + 100) 백일후 FROM dual; -- 날짜만 더하기 가능

-- 사원들의 근무일수 조회하기
SELECT
    ename 사원이름, hiredate 입사일, sysdate 오늘날짜, FLOOR(sysdate - hiredate) 근무일수
FROM
    emp
;

-- 3-1 : 지금부터 두 달 후의 날짜 조회
SELECT
    sysdate 오늘, ADD_MONTHS(sysdate, 2) 두달후
FROM
    dual
;

-- 3-2 : 사원들의 근무개월수 조회
SELECT
    ename 사원이름, TRUNC(MONTHS_BETWEEN(sysdate, hiredate)) 근무개월수
FROM
    emp
;

-- 3-3 : 이번 달 마지막 날짜 조회
SELECT
    LAST_DAY(sysdate) "당월 말일"
FROM
    dual
;  

-- Q. 사원들의 첫 급여일을 조회하시오. (급여일은 매월 1일)
SELECT
    ename 사원이름, hiredate 입사일, LAST_DAY(hiredate) + 1 급여일
FROM
    emp
;

-- 3-4 : 이번 주 일요일이 며칠인지 조회
SELECT
    sysdate 오늘, NEXT_DAY(sysdate, '일요일') "이번주 일요일"
FROM
    dual
;

-- 3-5
SELECT
    ROUND(sysdate, 'year') 
FROM
    dual
;

SELECT
    ROUND(TO_DATE('2022/06/28'), 'year')
FROM
    dual
;

SELECT
    ROUND(sysdate, 'month')
FROM
    dual
;

SELECT
    ROUND(TO_DATE('2022/2/15'), 'month')
FROM
    dual
;
----------------------------------------------------------------------------------------------------
/*
    형변환함수 : 데이터의 형태를 바꿔서 특정 함수에 사용 가능하도록 만들어주는 함수
        (DB의 함수는 모두 매개변수가 필요하다.)
        함수는 데이터 형태에 따라서 사용하는 함수가 달라진다.
        그런데 만약 사용하려는 함수가 필요한 데이터가 아닌 경우에는 필요한 데이터로 변환해주는 함수가 필요하다.
        그래서 만들어진 함수가 변환함수다.
    
        1) TO_CHAR() : 날짜 또는 숫자 데이터를 문자 데이터로 변환하는 함수
            형식1) TO_CHAR(날짜 또는 숫자) - 기본형으로 변환 (날짜는 년월일만)
            형식2) TO_CHAR(날짜 또는 숫자, '변환형식')
                변환형식)
                    날짜 - YYYY : 4자리 연도
                           YY : 2자리 연도
                           MM : 월
                           DD : 일
                           DAY : 요일
                           HH : 12시간단위 시간
                           HH24 : 24시간단위 시간
                           MI : 분
                           SS : 초
                           
                    숫자 - 0 : 무효숫자도 표현O
                           9 : 무효숫자는 표현X
                           $ : 통화기호
                           - : 음수부호
                           , : 세 자리 자릿수 기호
                           . : 소수점
    
        2) TO_DATE() : 날짜 형태의 문자열을 날짜 데이터로 변환하는 함수
            형식1) TO_DATE(날짜문자열)
                참고) 날짜문자열의 구분자가 /, -, ., _ 인 경우는 이 함수로 처리 가능하다.
            형식2) TO_DATE(날짜문자열, '형식')
        
        3) TO_NUMBER() : 숫자 형태의 문자열을 숫자로 변환하는 함수
            형식1) T0_NUMBER(숫자문자열)
            형식2) TO_NUMBER(숫자문자열, 형식)
        
        
    
*/

-- 4-1
SELECT 
    TO_CHAR(sysdate)
FROM
    dual
;

-- 4-1 형식1 ex) 급여가 세 자리수인 사원들의 사원이름, 급여 조회
SELECT
    ename 사원이름, sal 급여
FROM
    emp
WHERE
    LENGTH(TO_CHAR(sal)) = 3
-- sal BETWEEN 100 AND 999
;

-- 4-1 형식2 ex) 사원들의 사원이름, 급여를 조회하는데 급여를 7자리에 맞춰서 표현하고 세자리마다 , 로 구분하여 조회
SELECT
    ename 사원이름, TO_CHAR(sal, '0,000,000') 급여
FROM
    emp
;

-- Q. 사원들의 입사요일을 조회하시오.
SELECT
    ename 사원이름, hiredate 입사일, TO_CHAR(hiredate, 'DAY') 입사요일
FROM
    emp
;

-- 4-3
-- '1,234' + '5,678' 의 계산결과 조회
SELECT
    TO_NUMBER('1,234', '99,999,999') + TO_NUMBER('5,678', '99,999,999') 계산결과
FROM
    dual
;

-- Q. 사원들의 사원이름, 직급, 상사번호, 부서번호를 조회하는데, 상사번호가 없으면 '상사없음'으로 출력하시오.
SELECT
    ename 사원이름, job 직급, NVL(TO_CHAR(mgr), '상사없음') 상사번호, deptno 부서번호
FROM
    emp
;