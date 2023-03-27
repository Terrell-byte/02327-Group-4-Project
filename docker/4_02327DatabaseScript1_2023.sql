USE gruppe4;

DROP TABLE IF EXISTS Phone;
DROP TABLE IF EXISTS Email;
DROP TABLE IF EXISTS Reference;
DROP TABLE IF EXISTS Footage;
DROP TABLE IF EXISTS Edition;
DROP TABLE IF EXISTS Item;
DROP TABLE IF EXISTS Topic;
DROP TABLE IF EXISTS Journalist;


CREATE TABLE Journalist (
    CPR CHAR(10) primary key,
    FirstName varchar(20),
    LastName varchar(20),
    Address varchar(30),
    Civic varchar(5),
    City varchar(20),
    ZIP char(4),
    Country char(2)
);

CREATE TABLE Phone (
    JournalistCPR char(10) primary key,
    Phone char(8),
    FOREIGN KEY (JournalistCPR) references Journalist(CPR)
);

CREATE TABLE Email (
    JournalistCPR char(10) primary key,
    Email varchar(40),
    FOREIGN KEY (JournalistCPR) references Journalist(CPR)
);

CREATE TABLE Topic (
   Title varchar(40) Primary key,
   Description varchar(255)
);

CREATE TABLE Reference (
    TopicTitle varchar(40),
    JournalistCPR CHAR(10),
    Role varchar(20),
    FOREIGN KEY (JournalistCPR) references Journalist(CPR),
    foreign key (TopicTitle) references Topic(Title),
    constraint referenceID primary key(TopicTitle, JournalistCPR)
);

CREATE TABLE Footage (
    Title varchar(40),
    DateShot date,
    DurationLength int,
    ReportCPR CHAR(10),
    constraint FootageID primary key(Title, DateShot)
);

CREATE TABLE Edition (
    StartDate dateTime Primary key,
    EndDate dateTime,
    HostCPR CHAR(10),
    Foreign key (HostCPR) references Journalist(CPR)
);


CREATE TABLE Item (
    DateTimeSlot dateTime primary key,
    Description varchar(255),
    Views int,
    TopicTitle varchar(40),
    FOREIGN KEY (Topictitle) references Topic(Title)
);

CREATE FUNCTION IsFootageTooLong
(vTitle VARCHAR(40), vDateShot date, vDurationLength INT)
RETURNS BOOLEAN
RETURN vDurationLength > 180;

DELIMITER //
CREATE TRIGGER Footage_BEFORE_INSERT
BEFORE INSERT ON Footage FOR EACH ROW
BEGIN
IF NEW.DurationLength <= 0
THEN SIGNAL SQLSTATE 'HY000'
		SET MYSQL_ERRNO = 1525,
		MESSAGE_TEXT = 'Duration of footage is equal to/or under 0 seconds';
	END IF;
IF IsFootageTooLong(NEW.Title, NEW.DateShot, NEW.DurationLength)
THEN SIGNAL SQLSTATE 'HY000'
		SET MYSQL_ERRNO = 1525,
		MESSAGE_TEXT = 'Duration of footage is over 3 minutes';
	END IF;
END//
DELIMITER ;

CREATE FUNCTION Timeoverlap
(vStartDate1 dateTime, vEndDate1 dateTime,
vStartDate2 dateTime, vEndDate2 dateTime)
RETURNS BOOLEAN
RETURN ((vstartDate1 <= vStartDate2 AND
vStartDate2 <= vEndDate1) OR
(vstartDate2 <= vStartDate1 AND
vStartDate1 <= vEndDate2));

CREATE FUNCTION IsEditionInvalid
(vStartDate dateTime, vEndDate dateTime)
RETURNS BOOLEAN
RETURN vEndDate <= vStartDate;

DELIMITER //
CREATE TRIGGER Edition_BEFORE_INSERT
BEFORE INSERT ON Edition FOR EACH ROW
	BEGIN
	SELECT TIMESTAMPDIFF(SECOND, NEW.StartDate, NEW.EndDate) AS Duration;
	IF IsEditionValid
		THEN SIGNAL SQLSTATE 'HY000'
		SET MYSQL_ERRNO = 1525,
		MESSAGE_TEXT = 'EndDate is equal to or before StartDate';
		END IF;
    IF Duration > 1800
		THEN SIGNAL SQLSTATE 'HY000'
		SET MYSQL_ERRNO = 1525,
		MESSAGE_TEXT = 'Edition is too long, exceeds 30 minutes';
    END IF;
    IF Timeoverlap
		THEN SIGNAL SQLSTATE 'HY000'
		SET MYSQL_ERRNO = 1525,
		MESSAGE_TEXT = 'Edition is overlapping with another edition';
    END IF;
END//
DELIMITER ;



    
	


