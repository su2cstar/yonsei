#1. 사원 테이블의 모든 레코드를 조회하시오.
SELECT * 
FROM EMP;

SELECT EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO 
FROM EMP;

#2. 사원명과 입사일을 조회하시오.
SELECT ENAME,HIREDATE
FROM EMP;

#3. 사원번호와 이름을 조회하시오. EMP 테이블 DEPTNO,ENAME 



#4. 사원테이블에 있는 직책의 목록을 조회하시오.
SELECT DISTINCT JOB
FROM EMP;
#DISTINCT는 검색 결과에서 중복된 레코드는 한 번만 보여주어야 할 때 사용한다.

#5. 총 사원수를 구하시오.
SELECT COUNT(EMPNO)
FROM EMP;
#COUNT는 그룹함수로 검색된 레코드의 수를 반환한다. COUNT(컬럼명)은 NULL이 아닌 레코드의 수를, COUNT(*)은 NULL을 포함한 레코드의 수를 반환한다.




#WHERE 조건
#6. 부서번호가 10인 사원을 조회하시오.
SELECT * 
FROM EMP
WHERE DEPTNO = 10;
#7. 월급여가 2500이상 되는 사원을 조회하시오. EMP 테이블 SAL



#WHERE 절이 추가되었다. 이제 WHERE 다음에 나오는 조건에 부합하는 레코드는 배제된다. 위 쿼리문은 WHERE 조건에 =,>,>=,<=,< 비교 연산자를 사용한 예이다.

#8. 이름이 'KING'인 사원을 조회하시오.
SELECT *
FROM EMP
WHERE ENAME = 'KING';
#쿼리문은 대소문자를 가리지 않는다. 하지만 컬럼에 들어가는 데이터는 당연히 대소문자를 가린다. KING라고 저장되어 있는데 king로는 검색되지 않는다.


#9. 사원들 중 이름이 S로 시작하는 사원의 사원번호와 이름을 조회하시오.
SELECT EMPNO,ENAME
FROM EMP
WHERE ENAME LIKE 'S%';

#10. 사원 이름에 T가 포함된 사원의 사원번호와 이름을 조회하시오. EMP테이블 EMPNO ENAME




#LIKE는 % 와 _문자와 함께 검색할 때 사용된다.

#11. 커미션이 300, 500, 1400 인 사원의 사번,이름,커미션을 조회하시오.
SELECT EMPNO,ENAME,COMM
FROM EMP
WHERE COMM = 300 OR COMM = 500 OR COMM = 1400;

SELECT EMPNO,ENAME,COMM
FROM EMP
WHERE COMM IN (300,500,1400);
#둘 다 같은 결과를 보여준다. 첫번째 쿼리문은 논리 연산자 OR를 사용했고 두번째는 IN을 사용했다.

#12. 월급여가 1200 에서 3500 사이의 사원의 사번,이름,월급여를 조회하시오.
SELECT EMPNO,ENAME,SAL
FROM EMP
WHERE SAL BETWEEN 1200 AND 3500;
#위 쿼리는 BETWEEN ~ AND ~ 사용법을 보여준다. SAL BETWEEN 1200 AND 3500은 수학적으로 1200 <= SAL <= 3500이다.

#13. 직급이 매니저이고 부서번호가 30번인 사원의 이름,사번,직급,부서번호를 조회하시오.
SELECT ENAME,EMPNO,JOB,DEPTNO
FROM EMP
WHERE DEPTNO = 30 AND JOB = 'MANAGER';

#14. 부서번호가 30인 아닌 사원의 사번,이름,부서번호를 조회하시오.
SELECT EMPNO,ENAME,DEPTNO
FROM EMP
WHERE NOT DEPTNO = 30;

#15. 커미션이 300, 500, 1400 이 모두 아닌 사원의 사번,이름,커미션을 조회하시오.
SELECT EMPNO,ENAME,COMM
FROM EMP
WHERE COMM NOT IN (300,500,1400);

#16. 이름에 S가 포함되지 않는 사원의 사번,이름을 조회하시오.
SELECT EMPNO,ENAME
FROM EMP
WHERE ENAME NOT LIKE '%S%';
#17. 급여가 1200보다 미만이거나 3700 초과하는 사원의 사번,이름,월급여를 조회하시오. EMP테이블 EMPNO,ENAME,SAL



#18. 직속상사가 NULL 인 사원의 이름과 직급을 조회하시오.
SELECT ENAME,JOB
FROM EMP
WHERE MGR IS NULL;
#컬럼이 NULL인지 판단하기 위해선, IS NULL, IS NOT NULL 문장을 사용한다.



#GROUP BY 구문
SELECT DEPTNO,AVG(SAL)
FROM EMP;
#부서별 평균 급여가 위 쿼리문의 의도다. 이때 그룹화의 기준이 되는 컬럼은 DEPTNO다. 그룹함수와 그룹화의 기준이 되는 컬럼이 함께 쓰일 때는 이 컬럼을 GROUP BY로 명시해 주어야 에러를 피할 수 있다.

#20. 부서별 평균월급여를 구하는 쿼리

SELECT DEPTNO,AVG(SAL)
FROM EMP
GROUP BY DEPTNO;

#21. 부서별 전체 사원수와 커미션을 받는 사원들의 수를 구하는 쿼리
SELECT DEPTNO,COUNT(*),COUNT(COMM)
FROM EMP
GROUP BY DEPTNO;

#22. 부서별 최대 급여와 최소 급여를 구하는 쿼리
SELECT DEPTNO,MAX(SAL),MIN(SAL)
FROM EMP
GROUP BY DEPTNO;
#HAVING은 GROUP BY 절에서 생성된 결과 값 중 원하는 조건에 부합하는 자료만 추출하기 위해 사용한다.

#22. 부서별로 급여 평균 (단, 부서별 급여 평균이 2000 이상만)
SELECT DEPTNO,AVG(SAL)
FROM EMP
WHERE AVG(SAL) >= 2000;
GROUP BY DEPTNO;
#GROUP BY 구문을 사용하면서 이 결과에 조건을 줄 때 WHERE 조건문을 사용할 수 없다. 따라서 위 쿼리는 에러를 발생한다. GROUP BY 구문을 사용하면서 조건을 주기 위해서는 대신 HAVING 구문을 사용한다. HAVING 구문에서는 그룹화의 기준이 되는 컬럼과 그룹함수만이 사용 할 수 있다는 점에 주의한다. 위 쿼리문에서 그룹화의 기준이 되는 컬럼이 DEPTNO이므로, DEPTNO는 HAVING 구문에 사용할 수 있다.

SELECT DEPTNO,AVG(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL) >= 2000;
#23. 월급여가 1000 이상인 사원만을 대상으로 부서별로 월급여 평균을 구하라. 단, 평균값이 2000 이상인 레코드만 구하라.
SELECT DEPTNO,AVG(SAL)
FROM EMP
WHERE SAL >= 1000
GROUP BY DEPTNO
HAVING AVG(SAL) >= 2000;
#WHERE 절은 테이블에서 데이터를 가져올 때 그 테이블에서 특정 조건에 부합하는 레코드만을 가져올 때 사용하고, HAVING 절은 GROUP BY 구문을 사용하여 구한 레코드 중에서 원하는 조건에 맞는 레코드만을 가져올 때 사용한다.

#ORDER BY 구문
#SELECT 문장을 사용하여 레코드를 검색할 때 임의의 컬럼을 기준으로 정렬을 해야 할 필요가 발생한다. 이런 경우 사용하는 구문이 ORDER BY 이다. 사용형식은 아래와 같다.
#ORDER BY 정렬의 기준이 되는 컬럼 ASC 또는 DESC;
#여기서 ASC는 오름차순을 의미한다. ASC는 생략할 수 있다. DESC는 내림차순을 의미한다.

#24. 급여가 높은 순으로 조회하되 급여가 같을 경우 이름의 철자가 빠른 사원순으로 사번,이름,월급여를 조회하시오.
SELECT EMPNO,ENAME,SAL
FROM EMP
ORDER BY SAL DESC,ENAME ASC;



#조인

#조인은 2개 이상의 테이블에서 데이터를 조회할 때 사용한다. 조인조건은 테이블 N개를 조인할 때 N-1 개의 조인 조건이 필요하다. 사용형식은 다음과 같다.
#SELECT 테이블1.컬럼,테이블2.컬럼,....FROM 테이블1,테이블2,...

#카테시안 곱
SELECT EMP.ENAME,DEPT.DNAME
FROM EMP,DEPT;
#조인의 조건이 없는 단순 조인이다. 앞으로 나오는 조인 예제는 이러한 단순 조인 결과를 머리속에 그리면서 실습해야 한다. 총 56개의 행은 EMP 테이블에 존재하는 14개의 레코드와 DEPT 테이블에 존재하는 4개의 레코드의 곱으로 생성된다. 조회 대상이 되는 각 테이블의 컬럼이 명백히 어느 테이블의 컬럼인지가 확실하다면 EMP.ENAME을 ENAME처럼 테이블명을 생략 할 수 있다.

#25. 사원명과 부서명을 조회하시오.
SELECT ENAME,DNAME
FROM EMP,DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;
#테이블에 별칭을 사용할 수 있다. 이로써 복잡한 조인문이 간단해 질 수 있다.

SELECT E.ENAME,D.DNAME
FROM EMP E,DEPT D
WHERE E.DEPTNO = D.DEPTNO;
#아래 쿼리를 사용할 수 있다.

SELECT E.ENAME, M.ENAME 
FROM EMP E INNER JOIN EMP M ON E.MGR = M.EMPNO;

#26. 이름,월급여,월급여등급을 조회하시오.
SELECT E.ENAME,E.SAL,S.GRADE
FROM EMP E,SALGRADE S
WHERE E.SAL >= S.LOSAL AND E.SAL <= S.HISAL;
#WHERE 조건에 조인조건을 = 이외의 비교 연산자를 사용한 조인문이다. 이 SQL문을 BETWEEN ~ AND 문으로 변경하면 아래와 같다.


SELECT E.ENAME,E.SAL,S.GRADE
FROM EMP E,SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

#27. 이름,부서명,월급여등급을 조회하시오.
SELECT E.ENAME,D.DNAME,S.GRADE
FROM EMP E,DEPT D,SALGRADE S
WHERE E.DEPTNO = D.DEPTNO
AND E.SAL BETWEEN S.LOSAL AND S.HISAL;

#28. 이름,직속상사이름을 조회하시오.
SELECT E.ENAME,M.ENAME
FROM EMP E,EMP M
WHERE E.MGR = M.EMPNO;
#위 결과에 회장(PRESIDENT)에 대한 레코드가 배제됐다. 회장은 직속상사가 없으므로 MGR 컬럼이 NULL이고 사원번호가 NULL인 사원은 없기 때문에 조인조건에 만족하지 않는다. 그럼에도 불구하고 결과에 회장 레코드를 보여야 한다면 아래처럼 질의해야 한다.

SELECT E.ENAME,M.ENAME
FROM EMP E LEFT JOIN EMP M ON E.MGR = M.EMPNO;
#위와 같은 조인을 외부OUTER조인이라 한다. A LEFT JOIN B는 조인 조건에 만족하지 못하더라도 왼쪽 테이블 A의 행을 나타내고 싶을 때 사용한다.

#29. 이름,부서명을 조회하시오.단, 사원테이블에 부서번호가 40에 속한 사원이 없지만 부서번호 40인 부서명도 출력되도록 하시오.
#E.ENAME,D.DNAME DEPT D EMP E




#30. 이름,부서번호,부서이름을 조회하시오.
SELECT ENAME,E.DEPTNO,DNAME
FROM EMP E,DEPT D
WHERE E.DEPTNO = D.DEPTNO;
SELECT ENAME,E.DEPTNO,DNAME
FROM EMP E INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO;

#31. 부서번호가 30번인 사원들의 이름, 직급, 부서번호, 부서위치를 조회하시오.
SELECT ENAME,JOB,E.DEPTNO,LOC
FROM EMP E,DEPT D
WHERE E.DEPTNO = D.DEPTNO AND D.DEPTNO = 30;
SELECT ENAME,JOB,E.DEPTNO,LOC
FROM EMP E INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE D.DEPTNO = 30;

#32. 커미션을 받는 사원의 이름, 커미션, 부서이름,부서위치를 조회하시오.
SELECT ENAME,COMM,DNAME,LOC
FROM EMP,DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO 
AND EMP.COMM IS NOT NULL AND EMP.COMM <> 0;

SELECT ENAME,COMM,DNAME,LOC
FROM EMP,DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO 
AND EMP.COMM IS NOT NULL AND EMP.COMM != 0;

SELECT ENAME,COMM,DNAME,LOC
FROM EMP,DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO 
AND EMP.COMM IS NOT NULL AND EMP.COMM NOT IN(0);

SELECT ENAME,COMM,DNAME,LOC
FROM EMP INNER JOIN DEPT ON EMP.DEPTNO = DEPT.DEPTNO
WHERE EMP.COMM IS NOT NULL AND EMP.COMM <> 0;

#33. DALLAS에서 근무하는 사원의 이름,직급,부서번호,부서명을 조회하시오. E.ENAME,E.JOB,D.DEPTNO,D.DNAME // EMP E,DEPT D









#34.이름에 A 가 들어가는 사원의 이름,부서명을 조회하시오.
SELECT E.ENAME,D.DNAME
FROM EMP E,DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.ENAME LIKE '%A%';

SELECT E.ENAME,D.DNAME
FROM EMP E INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE E.ENAME LIKE '%A%';

#35. 이름, 직급, 월급여, 월급여등급을 조회하시오.
SELECT E.ENAME,E.JOB,E.SAL,S.GRADE
FROM EMP E,SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

#36. ALLEN과 같은 부서에 근무하는 사원의 이름, 부서번호를 조회하시오.
SELECT C.ENAME,C.DEPTNO
FROM EMP E,EMP C
WHERE E.EMPNO <> C.EMPNO
AND E.DEPTNO = C.DEPTNO
AND E.ENAME = 'ALLEN'
ORDER BY C.ENAME;

SELECT C.ENAME,C.DEPTNO
FROM EMP E INNER JOIN EMP C ON E.DEPTNO = C.DEPTNO 
WHERE E.EMPNO <> C.EMPNO
AND E.ENAME = 'ALLEN'
ORDER BY C.ENAME;

#서브쿼리
#서브 쿼리는 SELECT 문 안에서 ()로 둘러싸인 SELECT 문을 말하며 쿼리문의 결과를 메인 쿼리로 전달하기 위해 사용된다.

#37. 사원명 'JONES'가 속한 부서명을 조회하시오.
SELECT DNAME 
FROM DEPT
WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME = 'JONES');
#부서번호를 알아내기 위한 쿼리가 서브 쿼리로 사용되고, 이 서브쿼리는 단 하나의 결과값을 얻기 때문에 단일 행 서브 쿼리라 한다.

#38. 10번 부서에서 근무하는 사원의 이름과 10번 부서의 부서명을 조회하시오.






#39. 평균 월급여보다 더 많은 월급여를 받은 사원의 사원번호,이름,월급여 조회하시오.







#40. 부서번호가 10인 사원중에서 최대급여를 받는 사원과 동일한 급여를 받는 사원의 사원번호, 이름을 조회하시오.



