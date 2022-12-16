-- 유의) 모든 문제에서 칼럼에 별칭을 붙여서 출력하시오.

-- LEVEL1
-- Q1. 사원들의 사원이름, 부서번호를 조회하시오.
SELECT
    ename 사원이름, deptno 부서번호
FROM
    emp
;

-- Q2. 사원들의 부서번호를 조회하는데, 중복되는 부서는 한번만 출력되게 하시오.
SELECT
    DISTINCT deptno 부서번호
FROM
    emp
;

-- Q3. 사원들의 사원이름, 연봉을 조회하시오. 연봉은 급여 * 12로 계산하시오.
SELECT
    ename 사원이름, (sal * 12) 연봉
FROM
    emp
;

-- Q4. 사원들의 사원이름, 직급, 연 총수입액((sal * 12) + comm)을 조회하시오.
SELECT
    ename 사원이름, job 직급, NVL((sal * 12) + comm, (sal * 12)) AS "연 총수입액"
FROM
    emp
;

-- Q5. 사원들의 사원이름, 직급, 급여를 조회하는데, 급여는 현재 급여의 15% 인상된 급여로 조회하시오.
SELECT
    ename 사원이름, job 직급, (sal * 1.15) 급여
FROM
    emp
;

-- Q6. 사원들의 사원이름, 입사일, 직급을 조회하는데, 사원이름은 앞에 'Mr.' 를 붙여서 조회하시오.
SELECT
    'Mr.' || ename 사원이름, hiredate 입사일, job 직급
FROM
    emp
;

-- Q7. 사원정보 테이블의 모든 정보를 조회하시오.
SELECT
    empno 사원번호, ename 사원이름, job 직급, mgr 상사번호, hiredate 입사일, sal 급여, comm 커미션, deptno 부서번호
FROM
    emp
;

-- Q8. 사원들의 사원이름, 직급, 입사일, 커미션을 조회하시오.
-- 단, 커미션은 현재 커미션에 200을 더한 결과로 조회하고, 커미션이 없는 사원은 100으로 조회되게 하시오.
SELECT
    ename 사원이름, job 직급, hiredate 입사일, NVL(comm + 200, 100) 커미션
FROM
    emp
;

--------------------------------------------------------------------------------------
-- LEVEL2
-- Q1. 사원들의 부서번호가 10번인 사원들의 사원이름, 직급, 입사일, 부서번호를 조회하시오.
SELECT
    ename 사원이름, job 직급, hiredate 입사일, deptno 부서번호
FROM
    emp
WHERE
    deptno = 10
;

-- Q2. 직급이 'SALESMAN'인 사원들의 사원이름, 직급, 급여를 조회하시오.
SELECT
    ename 사원이름, job 직급, sal 급여
FROM
    emp
WHERE
    job = 'SALESMAN'
;

-- Q3. 급여가 1000보다 적은 사원들의 사원이름, 직급, 급여, 부서번호를 조회하시오.
SELECT
    ename 사원이름, job 직급, sal 급여, deptno 부서번호
FROM
    emp
WHERE
    sal < 1000
;

-- Q4. 사원의 이름이 'M' 이전 문자로 시작하는 사원들의 사원이름, 직급, 급여를 조회하시오.
SELECT
    ename 사원이름, job 직급, sal 급여
FROM
    emp
WHERE
    ename <= 'M'
;

-- Q5. 입사일이 1981년 9월 8일인 사원의 사원이름, 직급, 입사일을 조회하시오.
/*
    날짜데이터를 형식을 지정해서 문자열로 변환하는 방법
    
    TO_CHAR(데이터, 'YYYY/MM/DD HH24:MI:SS') ==> 초까지 변환
    TO_CHAR(데이터, 'YYYY/MM/DD') ==> 일까지만 변환
    TO_CHAR(데이터, 'MM') ==> 월만 변환
*/

-- 추가문제(Q16). 사원들의 사원이름, 입사일을 조회하는데, 입사일 출력형식은 "2022년 12월 15일"의 형식으로 조회하세요.
SELECT
    ename 사원이름, TO_CHAR(hiredate, 'YYYY') || '년 ' || TO_CHAR(hiredate, 'MM') || '월 ' || TO_CHAR(hiredate, 'DD') || '일' 입사일
FROM
    emp
;

SELECT
    ename 사원이름, job 직급, hiredate 입사일
FROM
    emp
WHERE
    hiredate = '1981/09/08'
;

-- Q6. 사원의 이름이 'M' 이후 문자로 시작하는 사원 중 급여가 1000 이상인 사원들의 사원이름, 직급, 급여를 조회하시오.
SELECT
    ename 사원이름, job 직급, sal 급여
FROM
    emp
WHERE
    ename >= 'M'
    AND sal >= 1000
;

-- Q7. 직급이 'MANAGER'고 급여가 1000보다 크고 부서번호가 10번인 부서에 근무하는 사원들의 사원이름, 직급, 급여(+, 부서번호)를 조회하시오.
SELECT
    ename 사원이름, job 직급, sal 급여, deptno 부서번호
FROM
    emp
WHERE
    job = 'MANAGER'
    AND sal > 1000
    AND deptno = 10
;

-- Q8. 직급이 'MANAGER'인 사원들을 제외한 모든 사원의 사원이름, 직급, 입사일을 조회하시오. (두 가지 이상 방법으로 해결하시오.)
-- (1)
SELECT
    ename 사원이름, job 직급, hiredate 입사일
FROM
    emp
WHERE
    NOT job = 'MANAGER'
;
-- (2)
SELECT
    ename 사원이름, job 직급, hiredate 입사일
FROM
    emp
WHERE
    job <> 'MANAGER'
;
-- (3)
SELECT
    ename 사원이름, job 직급, hiredate 입사일
FROM
    emp
WHERE
    job != 'MANAGER'
;
-- (3)
SELECT
    ename 사원이름, job 직급, hiredate 입사일
FROM
    emp
WHERE
    job ^= 'MANAGER'
;
-- Q9. 이름이 'C' 다음 문자로 시작하고 'M' 이전 문자로 시작하는 사원들의 사원이름, 직급, 급여를 조회하시오. (BETWEEN 연산자 이용)
SELECT
    ename 사원이름, job 직급, sal 급여
FROM
    emp
WHERE
    ename BETWEEN 'D' AND 'L'
;

-- Q10. 급여가 800이거나 950인 사원들의 사원이름, 직급, 급여를 조회하시오. (IN 연산자 이용)
SELECT
    ename 사원이름, job 직급, sal 급여
FROM
    emp
WHERE
    sal IN(800, 950)
;

-- Q11. 사원의 이름이 'S'로 시작하고 글자수가 5글자인 사원들의 사원이름, 직급을 조회하시오.
SELECT
    ename 사원이름, job 직급
FROM
    emp
WHERE
    ename >= 'S'
    AND lENGTH(ename) = 5
--    AND ename LIKE '_____'
;

-- Q12. 입사일이 3일인 사원들의 사원이름, 직급, 입사일을 조회하시오.
SELECT
    ename 사원이름, job 직급, hiredate 입사일
FROM
    emp
WHERE
    hiredate LIKE '_____/03'
;

-- Q13. 사원의 이름이 4글자이거나 5글자인 사원들의 이름, 직급을 조회하시오.
SELECT
    ename 사원이름, job 직급
FROM
    emp
WHERE
    LENGTH(ename) = 4
    OR LENGTH(ename) = 5
--    ename LIKE '____'
--   OR ename LIKE '_____'
;

-- Q14. 입사년도가 81년도거나 82년도인 사원들의 사원이름, 입사일, 급여를 조회하시오.
-- 단, 급여는 현재급여에서 10% 인상된 급여로 조회하시오.
SELECT
    ename 사원이름, hiredate 입사일, (sal * 1.1) 인상급여
FROM
    emp
WHERE
    hiredate LIKE '81/_____'
    OR hiredate LIKE '82/_____'
;

-- Q15. 사원의 이름이 'S'로 끝나는 사원들의 사원이름, 급여, 커미션을 조회하시오.
-- 단, 커미션은 현재 커미션에 100을 더해서 조회하고, 커미션이 없는 사원도 100을 주어서 조회하시오.
SELECT
    ename 사원이름, sal 급여, NVL(comm + 100, 100) 커미션
FROM
    emp
WHERE
    ename LIKE '%S'
;

-----------------------------------------------------------------------------------------------------
-- LEVEL3(?)
-- Q1. 사원들의 사원이름, 직급, 입사일, 급여를 조회하시오.
-- 단, 급여를 많이 받는 사원이 먼저 출력되게 하시오.
SELECT
    ename 사원이름, job 직급, hiredate 입사일, sal 급여
FROM
    emp
ORDER BY
    sal DESC
;

-- Q2. 사원들의 사원이름, 직급, 입사일, 부서번호를 조회하시오.
-- 단, 부서번호 순서대로 출력되게 하고, (부서번호가) 같으면 입사일 순서대로 출력되게 하시오.
SELECT
    ename 사원이름, job 직급, hiredate 입사일, deptno 부서번호
FROM
    emp
ORDER BY
    deptno ASC, hiredate ASC
;
-- Q3. 입사월이 5월인 사원들의 사원이름, 직급, 입사일을 조회하시오.
-- 단, 입사일이 빠른 사원이 먼저 출력되게 하시오.
SELECT
    ename 사원이름, job 직급, hiredate 입사일
FROM
    emp
WHERE
    TO_CHAR(hiredate, 'MM') = '05'
ORDER BY
    hiredate ASC
;
-- Q4. 이름의 마지막 글자가 S인 사원의 사원이름, 직급, 입사일을 조회하시오.
-- 단, 직급 순서대로 출력되게 하고, 같은 직급이면 입사일 순서대로 출력되게 하시오.
SELECT
    ename 사원이름, job 직급, hiredate 입사일
FROM   
    emp
WHERE
    ename LIKE '%S'
ORDER BY
    job ASC, hiredate ASC
;
-- Q5. 커미션을 27% 인상해서 사원이름, 원커미션, 인상커미션을 조회하시오.
-- 단, 커미션이 없는 사원은 100을 지급하여 그 커미션에 27%를 인상하도록 하시오. 
-- 커미션을 많이 받는 사원부터 출력하고, 커미션이 같으면 이름순으로 정렬하시오.
SELECT
    ename 사원이름, comm 원커미션, NVL(comm * 1.27, 100 * 1.27) 인상커미션
FROM
    emp
ORDER BY
    NVL(comm * 1.27, 100 * 1.27) DESC, ename ASC
;