create table emp as select * from scott.emp;
    create table dept as select * from scott.dept;
update student SET birthday=to_date('1999-12-12 6:6:6','YYYY-MM-DD HH24:MT:SS') where id=4;

select e.* from (select emp.*,rownum rn  from emp order by sal asc) e where e.rn between 5 and 10;

create view emp_1 as select ename,empno,job from emp;
--��table ��ͼview ����index �洢����procedure ����function ������trigger
--��ͼ view  ���ϵͳ�İ�ȫ�ԣ��򻯲�ѯ���
--view ֻ�нṹ��û�����ݣ����ݻ����ڻ����д洢
select * from emp_1;


create table account(userId number,money number(10,2));
create table orders(userId number,money number(10,2),create_time timestamp);

select * from orders;
insert into account values(1,1000);


create or replace procedure proc_addorder(
   userid in number,
   money in number,
   result out varchar2 
)as
  begin
   insert into orders values(1,200,sysdate);
   update account set money =money-200 where userid=1;
   end proc_addorder;
   
  DECLARE
  USERID NUMBER;
  MONEY NUMBER;
  RESULT VARCHAR2(200);
BEGIN
  USERID := NULL;
  MONEY := NULL;

  PROC_ADDORDER(
    USERID => USERID,
    MONEY => MONEY,
    RESULT => RESULT
  );
  /* Legacy output: 
DBMS_OUTPUT.PUT_LINE('RESULT = ' || RESULT);
*/ 
  :RESULT := RESULT;
--rollback; 
END;  

create table account_bak as select * from account where 1=0;

--��account_bak �������һ��ʱ���ֶ�
alter table account_bak add operate_time timestamp;

select * from account_bak;
--���������������޸�account���������ǣ����޸�֮ǰ�����ݱ��ݵ�account_bak
CREATE OR REPLACE TRIGGER TRG_ACCOUNT 
BEFORE UPDATE OF MONEY ON ACCOUNT 
BEGIN
  insert into account_bak select userid,money,sysdate from account;
END;
update account set money=money+100;
select * from account;






