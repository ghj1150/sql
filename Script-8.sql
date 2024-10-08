-- 사번, 이름, 부서번호, 부서이름 조회
SELECT * FROM TAB;

SELECT *
FROM EMPLOYEES e ;

SELECT *
FROM DEPARTMENTS d ;

SELECT DEPARTMENT_ID, FIRST_NAME || ' ' || LAST_NAME NAME, DEPARTMENT_ID, DEPARTMENT_NAME 
FROM EMPLOYEES e
JOIN DEPARTMENTS d USING(DEPARTMENT_ID);

-- 사번, 성, 상사의 사번, 상사의 성
SELECT E.EMPLOYEE_ID, E.LAST_NAME, E.MANAGER_ID, E2.LAST_NAME 
FROM EMPLOYEES e 
LEFT JOIN EMPLOYEES e2 ON E.MANAGER_ID = E2.EMPLOYEE_ID 
ORDER BY 1;