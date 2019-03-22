
# coding: utf-8

# In[ ]:


get_ipython().system('pip install pymysql')


# In[2]:


import pymysql.cursors
import pandas as pd


# In[3]:


HOST = '35.200.30.86' #본인 GCP의 외부 IP 주소 ex) 192.0.0.1
USER = 'root' #본인이 생성한 mysql 계정
PASSWORD = 'mysql' #비밀번호


# In[4]:


try:
    conn = pymysql.connect(host=HOST,
        user=USER,
        password=PASSWORD,
        charset='utf8mb4')
    
    with conn.cursor() as cursor:
        sql = 'SHOW DATABASES'
        cursor.execute(sql)
        result = cursor.fetchall()
        print(result)
finally:
    conn.close()


# In[5]:


try:
    conn = pymysql.connect(host=HOST,
        user=USER,
        password=PASSWORD,
        db='DSLAB',
        charset='utf8mb4')
    
    with conn.cursor() as cursor:
        sql = 'Select * from EMP'
        cursor.execute(sql)
        result = cursor.fetchall()
        print(result)
finally:
    conn.close()


# In[12]:


try:
    conn = pymysql.connect(host=HOST,
        user=USER,
        password=PASSWORD,
        db='DSLAB',
        charset='utf8mb4')
    sql_for_df = '''SELECT E.ENAME,D.DNAME 
    FROM EMP E,DEPT D WHERE E.DEPTNO = D.DEPTNO
    AND D.DEPTNO = 10;'''
    df_from_database = pd.read_sql(sql_for_df , conn)
finally:
    conn.close()
df_from_database


# In[13]:


try:
    conn = pymysql.connect(host=HOST,
        user=USER,
        password=PASSWORD,
        db='DSLAB',
        charset='utf8mb4')
    sql_for_df = '''SELECT EMPNO,ENAME,SAL
FROM EMP
WHERE SAL > (SELECT AVG(SAL)
          FROM EMP)
ORDER BY SAL DESC;'''
    df_from_database = pd.read_sql(sql_for_df , conn)
finally:
    conn.close()
df_from_database


# In[14]:


try:
    conn = pymysql.connect(host=HOST,
        user=USER,
        password=PASSWORD,
        db='DSLAB',
        charset='utf8mb4')
    sql_for_df = '''SELECT EMPNO,ENAME
        FROM EMP
        WHERE SAL = (SELECT MAX(SAL) 
         FROM EMP 
         WHERE DEPTNO = 10);'''
    df_from_database = pd.read_sql(sql_for_df , conn)
finally:
    conn.close()
df_from_database

