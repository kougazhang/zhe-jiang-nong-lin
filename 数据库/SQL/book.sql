-- 3.3.1 模式的定义与删除 -------------------------------------------------------------

--  例3.1 为用户 WANG 创建一个学生-课程模式 S-T
--  Mysql 不可执行
CREATE SCHEMA "S-T" AUTHORIZATION WANG;

-- 例3.2 如果该语句没有指定模式名，则模式名隐含为用户名 WANG；
--  Mysql 不可执行
CREATE SCHEMA AUTHORIZATION WANG;

-- 例3.3 为用户 ZHANG 创建一个模式 TEST，并且在其中定义一个表 TAB1.
--  Mysql 不可执行
CREATE SCHEMA TEST AUTHORIZATION ZHANG

    CREATE TABLE TAB1
    (
        COL1 SMALLINT,
        COL2 INT,
        COL3 CHAR(20),
    );

-- 例3.4 删除模式 ZHANG, 同时，该模式中已定义的表 TAB1 也删除。
DROP SCHEMA ZHANG CASCADE;

-- 3.3.2 基本表的定义、删除与修改 ---------------------------------------------------------

-- 例3.5 建立一个学生表 Student
CREATE TABLE Student
(
    Sno   CHAR(9) PRIMARY KEY,
    Sname CHAR(20) UNIQUE,
    Ssex  CHAR(2),
    Sage  SMALLINT,
    Sdept CHAR(20)
);

-- 例3.6 建立一个课程表 Course
-- 本例说明参照表和被参照表可以是同一个表
CREATE TABLE Course
(
    Cno    CHAR(4) PRIMARY KEY,
    Cname  CHAR(40) NOT NULL,
    Cpno   CHAR(4), -- Cpno 是先修课
    Credit SMALLINT,
    FOREIGN KEY (Cpno) REFERENCES Course (Cno)
);

-- 参照表和被参照表可以是同一个表的使用场景是？
INSERT INTO Course
    (Cno, Cname, Cpno, Credit)
VALUES ('1', '数学上册', null, 20);

INSERT INTO Course
    (Cno, Cname, Cpno, Credit)
VALUES ('2', '数学下册', '1', 20);

DELETE
FROM Course
WHERE Cno = '1';

-- 例3.7 建立学生选课表 SC
-- 注意：主码由两个属性构成，必须作为表级完整性进行定义
CREATE TABLE SC
(
    Sno   CHAR(9),
    Cno   CHAR(4),
    Grade SMALLINT,
    PRIMARY KEY (Sno, Cno),                     -- 主码由两个属性构成，必须作为表级完整性进行定义
    FOREIGN KEY (Sno) REFERENCES Student (Sno), -- 表级完整性约束，被参照表是 Student
    FOREIGN KEY (Cno) REFERENCES Course (Cno)  -- 表级完整性约束，被参照表是 Course
);

-- 例3.8 向