USE 课程设计
go

IF EXISTS(Select 1 From Sysobjects Where Name='普通员工信息')
DROP table 普通员工信息
create table 普通员工信息
(
	员工编号 nchar(3),
	姓名 nchar(10),
	上级员工编号 nchar(3),
	所在部门编号 nchar(3),
	账号 nchar(20),
	密码 nchar(20),
	PRIMARY KEY (员工编号)
)
go

IF EXISTS(Select 1 From Sysobjects Where Name='部门负责人信息')
DROP table 部门负责人信息
create table 部门负责人信息
(
	负责人编号 nchar(3),
	姓名 nchar(10),
	分管部门 nchar(3),
	账号 nchar(20),
	密码 nchar(20),
	PRIMARY KEY (负责人编号)
)
go

IF EXISTS(Select 1 From Sysobjects Where Name='请假信息')
DROP table 请假信息
create table 请假信息
(
	员工编号 nchar(3),
	请假日期 date,
	请假类型编号 int Check (请假类型编号 in (1,2,3,4)),
	请假开始时间 date,
	请假结束时间 date,
	请假累计天数 int,
	请假原因描述 Text,
	确认标志 bit,
	确认人 nchar(10)
)
go


INSERT INTO 普通员工信息
values 
(001,'李静  ',101,201,'user1','123'),
(002,'张明  ',101,201,'user2','123'),
(003,'方文  ',102,202,'user3','123'),
(004,'宋同济',102,202,'user4','123'),
(005,'丁婉  ',102,202,'user5','123'),
(006,'宋高邈',103,203,'user6','123'),
(007,'杜春  ',104,204,'user7','123'),
(008,'吴景天',104,204,'user8','123'),
(009,'杨阳州',105,205,'user9','123')

INSERT INTO 部门负责人信息
values
(101,'刘宇  ',201,'admin1','123'),
(102,'李敏  ',202,'admin2','123'),
(103,'张雯  ',203,'admin3','123'),
(104,'龚宇达',204,'admin4','123'),
(105,'于光  ',205,'admin5','123')

INSERT INTO 请假信息
values
('002','2020-11-28',1,'2020-11-29','2020-11-30',1,'123',0,NULL)
GO

exec sp_configure 'show advanced options',1
reconfigure
go
EXEC sp_configure 'xp_cmdshell',1
reconfigure
go

CREATE TRIGGER 请假申请约束
ON 请假信息
Instead OF INSERT
AS
BEGIN
DECLARE @BEGIN_TIME DATE, @END_TIME DATE, @BEGIN_IN DATE, @END_IN DATE, @ERROR BIT, @TMP CHAR(10)

SET @BEGIN_IN = (SELECT 请假开始时间 FROM inserted)
SET @END_IN = (SELECT 请假结束时间 FROM inserted)
SET @ERROR = 0

DECLARE CHECK_DATE CURSOR FOR
SELECT 请假信息.请假开始时间, 请假信息.请假结束时间
FROM 请假信息,inserted
WHERE 请假信息.员工编号 = inserted.员工编号

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
	INSERT INTO 请假信息 SELECT * FROM inserted
END

