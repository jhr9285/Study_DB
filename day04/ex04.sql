-- ex04
-- 단일행 함수 - 숫자 함수
/*
    Q1. 커미션을 27% 인상해서 사원이름, 현커미션, 인상커미션을 조회하시오.
        단, 커미션이 없는 사원은 100 을 지급하는 것으로 하고 여기서 27%를 인상하는 것으로 합니다.
        소수점 이상 둘째 자리에서 반올림해서 조회하시오.
*/
SELECT
    ename 사원이름, comm 현커미션, NVL(ROUND(comm * 1.27, -2), ROUND(100 * 1.27, -2)) 인상커미션
FROM
    emp
;
/*
    Q2. 사원들의 급여를 15% 인상한 금액과 커미션을 합쳐서 사원이름, 급여, 커미션, 지급액을 조회하시오.
        단, 소수점 이상 첫째 자리에서 버림해서 조회하시오.
        커미션이 없는 사람은 0으로 대체해서 계산하도록 합니다.
*/
SELECT
    ename 사원이름, sal 급여, comm 커미션, TRUNC(((sal * 1.15) + NVL(comm, 0)), -1) 지급액
FROM
    emp
;

--  Q3. 사원들의 급여가 100으로 나누어 떨어지는 사원들만 사원이름, 직급, 급여를 조회하시오.
SELECT
    ename 사원이름, job 직급, sal 급여
FROM
    emp
WHERE
    MOD(sal, 100) = 0
;


------------------------------------------------------------------------------------------------------------
-- 단일행 함수 - 문자 함수

--  Q1. 사원들 중 이름이 4글자 이하인 사원들의 사원이름, 직급, 입사일을 조회하시오. 
SELECT
    ename 사원이름, job 직급, hiredate 입사일
FROM
    emp
WHERE
    LENGTH(ename) <= 4
;
/*
    Q2. 사원들의 사원이름, 상사번호, 부서번호를 조회하시오.
        사원이름은 SMITH 사원 의 형식으로, 뒤에 '사원'이 붙도록 조회하시오.
*/
SELECT
    CONCAT(ename, ' 사원') 사원이름, mgr 상사번호, deptno 부서번호
FROM
    emp
;

--  Q3. 이름의 마지막 문자가 'N'인 사원의 사원이름, 직급, 부서번호를 조회하시오.
SELECT
    ename 사원이름, job 직급, deptno 부서번호
FROM
    emp
WHERE
    SUBSTR(ename, -1, 1) = 'N'
;
--  Q4. 이름에 'A'가 포함되지 않은 사원들의 사원이름, 직급, 입사일을 조회하시오.
SELECT
    ename 사원이름, job 직급, hiredate 입사일
FROM
    emp
WHERE
    INSTR(ename, 'A') = 0
;
--  BONUS)
--      사원이름에 '@githrd.com'을 붙여서 메일주소를 조회하는데,
--      메일주소는 아이디를 세번째 문자만 보여주고 나머지는 '*'로 출력하고,
--      도메인의 경우 '@'는 출력하고, 첫문자와 '.com'은 보여주고 나머지는 '*'로 출력하시오.
SELECT
    CONCAT(CONCAT('**', RPAD(SUBSTR(ename, 3, 1), LENGTH(ename) - 2, '*')),
    CONCAT(SUBSTR('@githrd.com', 1, 2), LPAD(SUBSTR('@githrd.com', -4), LENGTH('@githrd.com') - 2, '*'))) 메일주소
FROM
    emp
;


--  BONUS)
--      사원이름에 '@githrd.com'을 붙여서 메일주소를 조회하는데,
--      메일주소는 아이디를 세번째 문자만 보여주고 나머지는 '*'로 출력하고,
--      도메인의 경우 '@'는 출력하고, 첫번째~세번째 문자와 '.com'은 보여주고 나머지는 '*'로 출력하시오.

SELECT
    CONCAT(
        RPAD(
            LPAD(
                SUBSTR(ename, 3, 1), 3, '*'), LENGTH(ename), '*'),
        CONCAT(
            SUBSTR('@githrd.com', 1, 4),
            LPAD(
                SUBSTR('@githrd.com', -4), LENGTH('@githrd.com') - 4, '*'))) 메일주소
FROM
    emp
;

-- 번외

SELECT
    RPAD('chopa', 100, 'chopa')
FROM
    dual
;


------------------------------------------------------------------------------------------------------------
-- 단일행 함수 - 날짜 함수, 형변환 함수

--  Q1. 1년은 365일이라고 하고, 사원들의 근무일수를 년으로만 표시하고, 소수 이하는 버리시오. 
SELECT
    ename 사원이름, hiredate 입사일, FLOOR((sysdate - hiredate) / 365) "근무일수(년)"
FROM
    emp
;

--  Q2. 사원들의 근무년수를 년, 월 로 표시하시오. 단, 개월수로 처리하시오.
SELECT
    ename 사원이름, hiredate 입사일, FLOOR(MONTHS_BETWEEN(sysdate, hiredate) / 12) 근무년수, FLOOR(MOD(MONTHS_BETWEEN(sysdate, hiredate), 12)) 근무월수
FROM
    emp
;

--  Q3. 사원들이 첫 급여를 받을 때까지 근무한 일수를 조회하시오. 사원이름, 입사일, 근무일수를 함께 출력하시오. (급여일 익월 1일)
SELECT
    ename 사원이름, hiredate 입사일, (LAST_DAY(hiredate) + 1) - hiredate 근무일수
FROM
    emp
;

--  Q4. 사원들이 입사한 후 첫 번째 토요일의 날짜를 조회하시오. 사원이름, 입사일, 입사 후 첫 번째 토요일을 함께 출력하시오.
SELECT
    ename 사원이름, hiredate 입사일, NEXT_DAY(hiredate, '토요일') "첫 토요일"
FROM
    emp
;
--  Q5. 사원들의 근무년수 기준일을 조회하시오.
--      기준일은 입사한 달 1일이며, 15일 이전 입사자는 당월을 기준으로 하고, 15일 이후 입사자는 익월을 기준으로 합니다.
SELECT
    ename 사원이름, hiredate 입사일, ROUND(hiredate, 'month') "근무년수 기준일"
FROM
    emp
;
--  Q6. 사원들의 급여를 조회하는데, 모두 10자리로 표현하고, 급여 이외에 남는 자리에는 * 로 표현하시오.
SELECT
    ename 사원이름, REPLACE(TO_CHAR(sal, '9999999999'), ' ', '*') 급여
FROM
    emp
;
--  Q7. 사원 중 월요일에 입사한 사원의 사원번호, 사원이름, 직급, 입사일, 입사요일을 조회하시오.
SELECT
    empno 사원번호, job 직급, hiredate 입사일, TO_CHAR(hiredate, 'day') 입사요일
FROM
    emp
WHERE
    TO_CHAR(hiredate, 'day') = '월요일'
;
--  Q8. 사원 급여 중에서 백단위가 0인 사원의 사원이름, 직급, 급여를 조회하시오.
SELECT
    ename 사원이름, job 직급, sal 급여
FROM
    emp
WHERE
    SUBSTR(sal, -3, 1) = 0
;
--  Q9. 당신의 생년월일을 이용해서 지금까지 몇 년 몇개월 살고 있는지를 조회하시오.
SELECT
    FLOOR(MONTHS_BETWEEN(sysdate, '1993/10/02') / 12) 년수, FLOOR(MOD(MONTHS_BETWEEN(sysdate, '1993/10/02'), 12)) 개월수
FROM
    dual
;
--  Q10. 사원들의 사원이름, 직급, 급여, 커미션을 조회하는데, 커미션이 없는 사원의 커미션은 'NONE'으로 출력하시오.
SELECT
    ename 사원이름, job 직급, sal 급여, NVL(TO_CHAR(comm), 'NONE') 커미션
FROM
    emp
;

