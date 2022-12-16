-- ����) ��� �������� Į���� ��Ī�� �ٿ��� ����Ͻÿ�.

-- LEVEL1
-- Q1. ������� ����̸�, �μ���ȣ�� ��ȸ�Ͻÿ�.
SELECT
    ename ����̸�, deptno �μ���ȣ
FROM
    emp
;

-- Q2. ������� �μ���ȣ�� ��ȸ�ϴµ�, �ߺ��Ǵ� �μ��� �ѹ��� ��µǰ� �Ͻÿ�.
SELECT
    DISTINCT deptno �μ���ȣ
FROM
    emp
;

-- Q3. ������� ����̸�, ������ ��ȸ�Ͻÿ�. ������ �޿� * 12�� ����Ͻÿ�.
SELECT
    ename ����̸�, (sal * 12) ����
FROM
    emp
;

-- Q4. ������� ����̸�, ����, �� �Ѽ��Ծ�((sal * 12) + comm)�� ��ȸ�Ͻÿ�.
SELECT
    ename ����̸�, job ����, NVL((sal * 12) + comm, (sal * 12)) AS "�� �Ѽ��Ծ�"
FROM
    emp
;

-- Q5. ������� ����̸�, ����, �޿��� ��ȸ�ϴµ�, �޿��� ���� �޿��� 15% �λ�� �޿��� ��ȸ�Ͻÿ�.
SELECT
    ename ����̸�, job ����, (sal * 1.15) �޿�
FROM
    emp
;

-- Q6. ������� ����̸�, �Ի���, ������ ��ȸ�ϴµ�, ����̸��� �տ� 'Mr.' �� �ٿ��� ��ȸ�Ͻÿ�.
SELECT
    'Mr.' || ename ����̸�, hiredate �Ի���, job ����
FROM
    emp
;

-- Q7. ������� ���̺��� ��� ������ ��ȸ�Ͻÿ�.
SELECT
    empno �����ȣ, ename ����̸�, job ����, mgr ����ȣ, hiredate �Ի���, sal �޿�, comm Ŀ�̼�, deptno �μ���ȣ
FROM
    emp
;

-- Q8. ������� ����̸�, ����, �Ի���, Ŀ�̼��� ��ȸ�Ͻÿ�.
-- ��, Ŀ�̼��� ���� Ŀ�̼ǿ� 200�� ���� ����� ��ȸ�ϰ�, Ŀ�̼��� ���� ����� 100���� ��ȸ�ǰ� �Ͻÿ�.
SELECT
    ename ����̸�, job ����, hiredate �Ի���, NVL(comm + 200, 100) Ŀ�̼�
FROM
    emp
;

--------------------------------------------------------------------------------------
-- LEVEL2
-- Q1. ������� �μ���ȣ�� 10���� ������� ����̸�, ����, �Ի���, �μ���ȣ�� ��ȸ�Ͻÿ�.
SELECT
    ename ����̸�, job ����, hiredate �Ի���, deptno �μ���ȣ
FROM
    emp
WHERE
    deptno = 10
;

-- Q2. ������ 'SALESMAN'�� ������� ����̸�, ����, �޿��� ��ȸ�Ͻÿ�.
SELECT
    ename ����̸�, job ����, sal �޿�
FROM
    emp
WHERE
    job = 'SALESMAN'
;

-- Q3. �޿��� 1000���� ���� ������� ����̸�, ����, �޿�, �μ���ȣ�� ��ȸ�Ͻÿ�.
SELECT
    ename ����̸�, job ����, sal �޿�, deptno �μ���ȣ
FROM
    emp
WHERE
    sal < 1000
;

-- Q4. ����� �̸��� 'M' ���� ���ڷ� �����ϴ� ������� ����̸�, ����, �޿��� ��ȸ�Ͻÿ�.
SELECT
    ename ����̸�, job ����, sal �޿�
FROM
    emp
WHERE
    ename <= 'M'
;

-- Q5. �Ի����� 1981�� 9�� 8���� ����� ����̸�, ����, �Ի����� ��ȸ�Ͻÿ�.
/*
    ��¥�����͸� ������ �����ؼ� ���ڿ��� ��ȯ�ϴ� ���
    
    TO_CHAR(������, 'YYYY/MM/DD HH24:MI:SS') ==> �ʱ��� ��ȯ
    TO_CHAR(������, 'YYYY/MM/DD') ==> �ϱ����� ��ȯ
    TO_CHAR(������, 'MM') ==> ���� ��ȯ
*/

-- �߰�����(Q16). ������� ����̸�, �Ի����� ��ȸ�ϴµ�, �Ի��� ��������� "2022�� 12�� 15��"�� �������� ��ȸ�ϼ���.
SELECT
    ename ����̸�, TO_CHAR(hiredate, 'YYYY') || '�� ' || TO_CHAR(hiredate, 'MM') || '�� ' || TO_CHAR(hiredate, 'DD') || '��' �Ի���
FROM
    emp
;

SELECT
    ename ����̸�, job ����, hiredate �Ի���
FROM
    emp
WHERE
    hiredate = '1981/09/08'
;

-- Q6. ����� �̸��� 'M' ���� ���ڷ� �����ϴ� ��� �� �޿��� 1000 �̻��� ������� ����̸�, ����, �޿��� ��ȸ�Ͻÿ�.
SELECT
    ename ����̸�, job ����, sal �޿�
FROM
    emp
WHERE
    ename >= 'M'
    AND sal >= 1000
;

-- Q7. ������ 'MANAGER'�� �޿��� 1000���� ũ�� �μ���ȣ�� 10���� �μ��� �ٹ��ϴ� ������� ����̸�, ����, �޿�(+, �μ���ȣ)�� ��ȸ�Ͻÿ�.
SELECT
    ename ����̸�, job ����, sal �޿�, deptno �μ���ȣ
FROM
    emp
WHERE
    job = 'MANAGER'
    AND sal > 1000
    AND deptno = 10
;

-- Q8. ������ 'MANAGER'�� ������� ������ ��� ����� ����̸�, ����, �Ի����� ��ȸ�Ͻÿ�. (�� ���� �̻� ������� �ذ��Ͻÿ�.)
-- (1)
SELECT
    ename ����̸�, job ����, hiredate �Ի���
FROM
    emp
WHERE
    NOT job = 'MANAGER'
;
-- (2)
SELECT
    ename ����̸�, job ����, hiredate �Ի���
FROM
    emp
WHERE
    job <> 'MANAGER'
;
-- (3)
SELECT
    ename ����̸�, job ����, hiredate �Ի���
FROM
    emp
WHERE
    job != 'MANAGER'
;
-- (3)
SELECT
    ename ����̸�, job ����, hiredate �Ի���
FROM
    emp
WHERE
    job ^= 'MANAGER'
;
-- Q9. �̸��� 'C' ���� ���ڷ� �����ϰ� 'M' ���� ���ڷ� �����ϴ� ������� ����̸�, ����, �޿��� ��ȸ�Ͻÿ�. (BETWEEN ������ �̿�)
SELECT
    ename ����̸�, job ����, sal �޿�
FROM
    emp
WHERE
    ename BETWEEN 'D' AND 'L'
;

-- Q10. �޿��� 800�̰ų� 950�� ������� ����̸�, ����, �޿��� ��ȸ�Ͻÿ�. (IN ������ �̿�)
SELECT
    ename ����̸�, job ����, sal �޿�
FROM
    emp
WHERE
    sal IN(800, 950)
;

-- Q11. ����� �̸��� 'S'�� �����ϰ� ���ڼ��� 5������ ������� ����̸�, ������ ��ȸ�Ͻÿ�.
SELECT
    ename ����̸�, job ����
FROM
    emp
WHERE
    ename >= 'S'
    AND lENGTH(ename) = 5
--    AND ename LIKE '_____'
;

-- Q12. �Ի����� 3���� ������� ����̸�, ����, �Ի����� ��ȸ�Ͻÿ�.
SELECT
    ename ����̸�, job ����, hiredate �Ի���
FROM
    emp
WHERE
    hiredate LIKE '_____/03'
;

-- Q13. ����� �̸��� 4�����̰ų� 5������ ������� �̸�, ������ ��ȸ�Ͻÿ�.
SELECT
    ename ����̸�, job ����
FROM
    emp
WHERE
    LENGTH(ename) = 4
    OR LENGTH(ename) = 5
--    ename LIKE '____'
--   OR ename LIKE '_____'
;

-- Q14. �Ի�⵵�� 81�⵵�ų� 82�⵵�� ������� ����̸�, �Ի���, �޿��� ��ȸ�Ͻÿ�.
-- ��, �޿��� ����޿����� 10% �λ�� �޿��� ��ȸ�Ͻÿ�.
SELECT
    ename ����̸�, hiredate �Ի���, (sal * 1.1) �λ�޿�
FROM
    emp
WHERE
    hiredate LIKE '81/_____'
    OR hiredate LIKE '82/_____'
;

-- Q15. ����� �̸��� 'S'�� ������ ������� ����̸�, �޿�, Ŀ�̼��� ��ȸ�Ͻÿ�.
-- ��, Ŀ�̼��� ���� Ŀ�̼ǿ� 100�� ���ؼ� ��ȸ�ϰ�, Ŀ�̼��� ���� ����� 100�� �־ ��ȸ�Ͻÿ�.
SELECT
    ename ����̸�, sal �޿�, NVL(comm + 100, 100) Ŀ�̼�
FROM
    emp
WHERE
    ename LIKE '%S'
;

-----------------------------------------------------------------------------------------------------
-- LEVEL3(?)
-- Q1. ������� ����̸�, ����, �Ի���, �޿��� ��ȸ�Ͻÿ�.
-- ��, �޿��� ���� �޴� ����� ���� ��µǰ� �Ͻÿ�.
SELECT
    ename ����̸�, job ����, hiredate �Ի���, sal �޿�
FROM
    emp
ORDER BY
    sal DESC
;

-- Q2. ������� ����̸�, ����, �Ի���, �μ���ȣ�� ��ȸ�Ͻÿ�.
-- ��, �μ���ȣ ������� ��µǰ� �ϰ�, (�μ���ȣ��) ������ �Ի��� ������� ��µǰ� �Ͻÿ�.
SELECT
    ename ����̸�, job ����, hiredate �Ի���, deptno �μ���ȣ
FROM
    emp
ORDER BY
    deptno ASC, hiredate ASC
;
-- Q3. �Ի���� 5���� ������� ����̸�, ����, �Ի����� ��ȸ�Ͻÿ�.
-- ��, �Ի����� ���� ����� ���� ��µǰ� �Ͻÿ�.
SELECT
    ename ����̸�, job ����, hiredate �Ի���
FROM
    emp
WHERE
    TO_CHAR(hiredate, 'MM') = '05'
ORDER BY
    hiredate ASC
;
-- Q4. �̸��� ������ ���ڰ� S�� ����� ����̸�, ����, �Ի����� ��ȸ�Ͻÿ�.
-- ��, ���� ������� ��µǰ� �ϰ�, ���� �����̸� �Ի��� ������� ��µǰ� �Ͻÿ�.
SELECT
    ename ����̸�, job ����, hiredate �Ի���
FROM   
    emp
WHERE
    ename LIKE '%S'
ORDER BY
    job ASC, hiredate ASC
;
-- Q5. Ŀ�̼��� 27% �λ��ؼ� ����̸�, ��Ŀ�̼�, �λ�Ŀ�̼��� ��ȸ�Ͻÿ�.
-- ��, Ŀ�̼��� ���� ����� 100�� �����Ͽ� �� Ŀ�̼ǿ� 27%�� �λ��ϵ��� �Ͻÿ�. 
-- Ŀ�̼��� ���� �޴� ������� ����ϰ�, Ŀ�̼��� ������ �̸������� �����Ͻÿ�.
SELECT
    ename ����̸�, comm ��Ŀ�̼�, NVL(comm * 1.27, 100 * 1.27) �λ�Ŀ�̼�
FROM
    emp
ORDER BY
    NVL(comm * 1.27, 100 * 1.27) DESC, ename ASC
;