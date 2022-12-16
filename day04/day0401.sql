/*
    ��¥ �Լ�
        ����) sysdate : ����Ŭ�� ������, ���� �ý����� ��¥�� �ð��� ����Ѵ�.
    
        ��¥ ����)
            1970�� 1�� 1�� 0�� 0�� 0�ʸ� ��������, ������ ��¥������ ��¥ ������ �̿��ؼ� ��¥�����͸� ����Ѵ�.
            �Ʒ��� ���� ����(���� Ÿ��)���� ����Ѵ�.
            ����) ����.�ð� (ex, 3.14 ==> 3��, 0.14�� 1�Ϻ��� �����Ƿ� 0.14���� �ð���)
        
        ����) ��¥�����ͳ����� ������ - �� ����������, +, *, / �� �Ұ����ϴ�.
              ���������� ��¥ + ���� �� �����ϴ�.
              ��¥ ������ �����̹Ƿ�, �ᱹ ��¥���� ���ϴ� ���ڸ�ŭ �̵��� ��¥�� ǥ���ϰ� �ȴ�.
        
        1) ADD_MONTHS() : ���� ��¥�� ������ �޼��� ���ϰų� �� ��¥�� �˷��ִ� �Լ�
            ����) ADD_MONTHS(sysdate, ���� ������)
        
        2) MONTHS_BETWEEN() : �� ��¥ ������ �������� �˷��ִ� �Լ�
            ����) MONTHS_BETWEEN(�̷���¥, ���ų�¥)
                  ABS(MONTHS_BETWEEN(���ų�¥, �̷���¥)) �� ����!
                  
        3) LAST_DAY() : ������ ��¥�� ���Ե� ���� ������ ��¥�� �˷��ִ� �Լ�
            ����) LAST_DAY(��¥)
            
        4) NEXT_DAY() : ������ ��¥ ���� ���� ó�� ������ ������ ������ ��ĥ���� �˷��ִ� �Լ�
            ����) NEXT_DAY(��¥, ���ϴ� ���� ����)
            ����) ���� ���� : 
                1> �ѱ� - �� ȭ �� �� �� �� ��
                2> ����� - MON THE WED THU FRI SAT SUN (ȯ�漳������ ���� KOREA�� �Ǿ��־ ���� ����� ���� �Ұ���)
    
        5) ROUND() : ��¥�� ������ �κп��� �ݿø��ϴ� �Լ�
                     ������ �κ��̶�   ��, ��, ��, �ð�, ����   ���� �ִ�.
                     ������ �κ��� ����� ǥ���ؾ� �Ѵ�. (year, month, day, hour,..)
                     ������ ���, 1~6���̸� ���� ���, 7~12���̸� ���� ���.
                     ���� ���, 1~15���̸� �̹��� ���, 16�� ���ĸ� ������ ���. (�ϼ� ����ؼ� ���� ����. ���ذ��� 15�Ϸ� ����.)
            ����) ROUND(��¥, '�ݿø� ����')
           
*/
-- ��¥ �Լ� ex)
SELECT sysdate FROM dual;  -- ����ϱ��� ���
SELECT TO_CHAR(sysdate, 'YYYY-MM-DD HH24:MI:SS') FROM dual; -- ����Ͽ� �ð�,��,�ʱ��� ��� (��������)
SELECT (sysdate + sysdate) FROM dual; -- 'not allowed'
SELECT (sysdate + 100) ������ FROM dual; -- ��¥�� ���ϱ� ����

-- ������� �ٹ��ϼ� ��ȸ�ϱ�
SELECT
    ename ����̸�, hiredate �Ի���, sysdate ���ó�¥, FLOOR(sysdate - hiredate) �ٹ��ϼ�
FROM
    emp
;

-- 3-1 : ���ݺ��� �� �� ���� ��¥ ��ȸ
SELECT
    sysdate ����, ADD_MONTHS(sysdate, 2) �δ���
FROM
    dual
;

-- 3-2 : ������� �ٹ������� ��ȸ
SELECT
    ename ����̸�, TRUNC(MONTHS_BETWEEN(sysdate, hiredate)) �ٹ�������
FROM
    emp
;

-- 3-3 : �̹� �� ������ ��¥ ��ȸ
SELECT
    LAST_DAY(sysdate) "��� ����"
FROM
    dual
;  

-- Q. ������� ù �޿����� ��ȸ�Ͻÿ�. (�޿����� �ſ� 1��)
SELECT
    ename ����̸�, hiredate �Ի���, LAST_DAY(hiredate) + 1 �޿���
FROM
    emp
;

-- 3-4 : �̹� �� �Ͽ����� ��ĥ���� ��ȸ
SELECT
    sysdate ����, NEXT_DAY(sysdate, '�Ͽ���') "�̹��� �Ͽ���"
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
    ����ȯ�Լ� : �������� ���¸� �ٲ㼭 Ư�� �Լ��� ��� �����ϵ��� ������ִ� �Լ�
        (DB�� �Լ��� ��� �Ű������� �ʿ��ϴ�.)
        �Լ��� ������ ���¿� ���� ����ϴ� �Լ��� �޶�����.
        �׷��� ���� ����Ϸ��� �Լ��� �ʿ��� �����Ͱ� �ƴ� ��쿡�� �ʿ��� �����ͷ� ��ȯ���ִ� �Լ��� �ʿ��ϴ�.
        �׷��� ������� �Լ��� ��ȯ�Լ���.
    
        1) TO_CHAR() : ��¥ �Ǵ� ���� �����͸� ���� �����ͷ� ��ȯ�ϴ� �Լ�
            ����1) TO_CHAR(��¥ �Ǵ� ����) - �⺻������ ��ȯ (��¥�� ����ϸ�)
            ����2) TO_CHAR(��¥ �Ǵ� ����, '��ȯ����')
                ��ȯ����)
                    ��¥ - YYYY : 4�ڸ� ����
                           YY : 2�ڸ� ����
                           MM : ��
                           DD : ��
                           DAY : ����
                           HH : 12�ð����� �ð�
                           HH24 : 24�ð����� �ð�
                           MI : ��
                           SS : ��
                           
                    ���� - 0 : ��ȿ���ڵ� ǥ��O
                           9 : ��ȿ���ڴ� ǥ��X
                           $ : ��ȭ��ȣ
                           - : ������ȣ
                           , : �� �ڸ� �ڸ��� ��ȣ
                           . : �Ҽ���
    
        2) TO_DATE() : ��¥ ������ ���ڿ��� ��¥ �����ͷ� ��ȯ�ϴ� �Լ�
            ����1) TO_DATE(��¥���ڿ�)
                ����) ��¥���ڿ��� �����ڰ� /, -, ., _ �� ���� �� �Լ��� ó�� �����ϴ�.
            ����2) TO_DATE(��¥���ڿ�, '����')
        
        3) TO_NUMBER() : ���� ������ ���ڿ��� ���ڷ� ��ȯ�ϴ� �Լ�
            ����1) T0_NUMBER(���ڹ��ڿ�)
            ����2) TO_NUMBER(���ڹ��ڿ�, ����)
        
        
    
*/

-- 4-1
SELECT 
    TO_CHAR(sysdate)
FROM
    dual
;

-- 4-1 ����1 ex) �޿��� �� �ڸ����� ������� ����̸�, �޿� ��ȸ
SELECT
    ename ����̸�, sal �޿�
FROM
    emp
WHERE
    LENGTH(TO_CHAR(sal)) = 3
-- sal BETWEEN 100 AND 999
;

-- 4-1 ����2 ex) ������� ����̸�, �޿��� ��ȸ�ϴµ� �޿��� 7�ڸ��� ���缭 ǥ���ϰ� ���ڸ����� , �� �����Ͽ� ��ȸ
SELECT
    ename ����̸�, TO_CHAR(sal, '0,000,000') �޿�
FROM
    emp
;

-- Q. ������� �Ի������ ��ȸ�Ͻÿ�.
SELECT
    ename ����̸�, hiredate �Ի���, TO_CHAR(hiredate, 'DAY') �Ի����
FROM
    emp
;

-- 4-3
-- '1,234' + '5,678' �� ����� ��ȸ
SELECT
    TO_NUMBER('1,234', '99,999,999') + TO_NUMBER('5,678', '99,999,999') �����
FROM
    dual
;

-- Q. ������� ����̸�, ����, ����ȣ, �μ���ȣ�� ��ȸ�ϴµ�, ����ȣ�� ������ '������'���� ����Ͻÿ�.
SELECT
    ename ����̸�, job ����, NVL(TO_CHAR(mgr), '������') ����ȣ, deptno �μ���ȣ
FROM
    emp
;