USE �γ����
go

IF EXISTS(Select 1 From Sysobjects Where Name='��ͨԱ����Ϣ')
DROP table ��ͨԱ����Ϣ
create table ��ͨԱ����Ϣ
(
	Ա����� nchar(3),
	���� nchar(10),
	�ϼ�Ա����� nchar(3),
	���ڲ��ű�� nchar(3),
	�˺� nchar(20),
	���� nchar(20),
	PRIMARY KEY (Ա�����)
)
go

IF EXISTS(Select 1 From Sysobjects Where Name='���Ÿ�������Ϣ')
DROP table ���Ÿ�������Ϣ
create table ���Ÿ�������Ϣ
(
	�����˱�� nchar(3),
	���� nchar(10),
	�ֹܲ��� nchar(3),
	�˺� nchar(20),
	���� nchar(20),
	PRIMARY KEY (�����˱��)
)
go

IF EXISTS(Select 1 From Sysobjects Where Name='�����Ϣ')
DROP table �����Ϣ
create table �����Ϣ
(
	Ա����� nchar(3),
	������� date,
	������ͱ�� int Check (������ͱ�� in (1,2,3,4)),
	��ٿ�ʼʱ�� date,
	��ٽ���ʱ�� date,
	����ۼ����� int,
	���ԭ������ Text,
	ȷ�ϱ�־ bit,
	ȷ���� nchar(10)
)
go


INSERT INTO ��ͨԱ����Ϣ
values 
(001,'�  ',101,201,'user1','123'),
(002,'����  ',101,201,'user2','123'),
(003,'����  ',102,202,'user3','123'),
(004,'��ͬ��',102,202,'user4','123'),
(005,'����  ',102,202,'user5','123'),
(006,'�θ���',103,203,'user6','123'),
(007,'�Ŵ�  ',104,204,'user7','123'),
(008,'�⾰��',104,204,'user8','123'),
(009,'������',105,205,'user9','123')

INSERT INTO ���Ÿ�������Ϣ
values
(101,'����  ',201,'admin1','123'),
(102,'����  ',202,'admin2','123'),
(103,'����  ',203,'admin3','123'),
(104,'�����',204,'admin4','123'),
(105,'�ڹ�  ',205,'admin5','123')

INSERT INTO �����Ϣ
values
('002','2020-11-28',1,'2020-11-29','2020-11-30',1,'123',0,NULL)
GO

exec sp_configure 'show advanced options',1
reconfigure
go
EXEC sp_configure 'xp_cmdshell',1
reconfigure
go

CREATE TRIGGER �������Լ��
ON �����Ϣ
Instead OF INSERT
AS
BEGIN
DECLARE @BEGIN_TIME DATE, @END_TIME DATE, @BEGIN_IN DATE, @END_IN DATE, @ERROR BIT, @TMP CHAR(10)

SET @BEGIN_IN = (SELECT ��ٿ�ʼʱ�� FROM inserted)
SET @END_IN = (SELECT ��ٽ���ʱ�� FROM inserted)
SET @ERROR = 0

DECLARE CHECK_DATE CURSOR FOR
SELECT �����Ϣ.��ٿ�ʼʱ��, �����Ϣ.��ٽ���ʱ��
FROM �����Ϣ,inserted
WHERE �����Ϣ.Ա����� = inserted.Ա�����

OPEN CHECK_DATE
FETCH NEXT FROM CHECK_DATE INTO @BEGIN_TIME, @END_TIME
WHILE (@@FETCH_STATUS=0 AND @ERROR = 0)
BEGIN

IF (NOT (@BEGIN_IN >= @END_TIME OR @END_IN <= @BEGIN_TIME))
	SET @ERROR = 1

FETCH NEXT FROM CHECK_DATE INTO @BEGIN_TIME, @END_TIME
END
CLOSE  CHECK_DATE
deallocate CHECK_DATE

IF @ERROR = 0
	INSERT INTO �����Ϣ SELECT * FROM inserted
END

