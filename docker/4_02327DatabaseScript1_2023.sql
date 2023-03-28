DROP database if exists gruppe4;
CREATE DATABASE gruppe4;
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
    JournalistCPR char(10),
    PhoneNr char(8),
    FOREIGN KEY (JournalistCPR) references Journalist(CPR),
    CONSTRAINT PhoneID primary key(JournalistCPR, PhoneNr)
);

CREATE TABLE Email (
    JournalistCPR char(10),
    EmailAddr varchar(40),
    FOREIGN KEY (JournalistCPR) references Journalist(CPR),
    constraint EmailID PRIMARY KEY (JournalistCPR, EmailAddr)
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
    ReporterCPR CHAR(10),
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

INSERT Journalist VALUES("2501991812", "Maria", "Larsen", "Helsingborgvej", "35", "Silkeborg", "8600", "DK");
INSERT Journalist VALUES("1212681819", "Newt", "McCalister", "Vesterbrogade", "135", "København", "1620", "DK");
INSERT Journalist VALUES("1806797928", "Pia", "Ludvigsen", "Helsingborgvej", "37", "Silkeborg", "8600", "DK");
INSERT Journalist VALUES("1703079811", "Rekrut", "Internmand", "Skrotvej", "1", "Tårnby", "2770", "DK");
INSERT Journalist VALUES("0102694201", "Skipper", "Bent", "Voldboligerne", "2", "København", "1426", "DK");

INSERT Phone VALUES("2501991812", "12345678");
INSERT Phone VALUES("2501991812", "01234567");
INSERT Phone VALUES("1212681819", "88888888");
INSERT Phone VALUES("1212681819", "99999999");
INSERT Phone VALUES("1806797928", "11111111");
INSERT Phone VALUES("1703079811", "02345678");
INSERT Phone VALUES("0102694201", "98745612");
INSERT Phone VALUES("0102694201", "12233322");

INSERT Email VALUES("2501991812", "Maria1234@gmail.com");
INSERT Email VALUES("2501991812", "MariaFreetime@gmail.com");
INSERT Email VALUES("1212681819", "cashMeOuside@gmail.com");
INSERT Email VALUES("1212681819", "howAbouDa@gmail.com");
INSERT Email VALUES("1806797928", "powerPia@gmail.com");
INSERT Email VALUES("1806797928", "tiredPia@gmail.com");
INSERT Email VALUES("1703079811", "intern@gmail.com");
INSERT Email VALUES("0102694201", "Haddock@gmail.com");

INSERT Topic VALUES("War in Ukraine", "The war in Ukraine is still going strong, Putin is still refusing to negotiate about pulling out his troops");
INSERT Topic VALUES("The great bakeoff", "Yet again is the drama wilder than ever in the famous tent");
INSERT Topic VALUES("President election 2023", "The polling is suggesting that Camacho is in the lead, with 70% over John Cena");
INSERT Topic VALUES("The steoroid nightmare", "Tons of young people has begun using sterorids in their local gyms, and the staff are aiding them in SATS");
INSERT Topic VALUES("Paddle Cup Scandal", "In a local paddle cup, a man participant has destroyed his own bat and his opponents aswell, after not scoring a single point");

INSERT Reference VALUES("War in Ukraine", "2501991812", "Leader");
INSERT Reference VALUES("War in Ukraine", "1703079811", "Intern");
INSERT Reference VALUES("The great bakeoff", "1806797928", "Leader");
INSERT Reference VALUES("President election 2023", "1806797928", "Leader");
INSERT Reference VALUES("President election 2023", "1703079811", "Intern");
INSERT Reference VALUES("The steoroid nightmare", "0102694201", "Leader");
INSERT Reference VALUES("The steoroid nightmare", "1703079811", "Intern");
INSERT Reference VALUES("Paddle Cup Scandal", "1212681819", "Leader");
INSERT Reference VALUES("Paddle Cup Scandal", "1703079811", "Intern");
INSERT Reference VALUES("Paddle Cup Scandal", "2501991812", "Advisor");

INSERT Footage VALUES("Bombings in Kiev", "2023-03-28", 126, "2501991812");
INSERT Footage VALUES("Chocolate mousse seperating", "2023-03-18", 69, "1806797928");
INSERT Footage VALUES("Man destroying paddlebats", "2023-03-22", 180, "1212681819");

INSERT Edition VALUES("2023-03-28 20:00:00", "2023-03-28 20:27:00", "2501991812");
INSERT Edition VALUES("2023-03-28 20:30:00", "2023-03-28 20:59:59", "0102694201");
INSERT Edition VALUES("2023-03-28 21:00:00", "2023-03-28 21:29:59", "1212681819");
INSERT Edition VALUES("2023-03-29 20:00:00", "2023-03-29 20:29:59", "0102694201");
INSERT Edition VALUES("2023-03-29 20:30:00", "2023-03-29 20:59:59", "1212681819");

INSERT Item VALUES("2023-03-28 20:01:30", "This item is about the war in Ukraine", 15000, "War in Ukraine");
INSERT Item VALUES("2023-03-28 20:31:30", "This item is about the grat bakeoff", 15000, "The great bakeoff");
INSERT Item VALUES("2023-03-28 20:46:00", "This item is about the President election 2023", 15000, "President election 2023");
INSERT Item VALUES("2023-03-29 20:01:30", "This item is about the steroid nightmare", 15000, "The steoroid nightmare");
INSERT Item VALUES("2023-03-29 20:31:30", "This item is about the Paddle Cup Scandal", 15000, "Paddle Cup Scandal");


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

DELIMITER //
CREATE FUNCTION TimeoverlapWithTable
	(vStartTime DATETIME, vEndTime DATETIME)
	RETURNS BOOLEAN
BEGIN
	DECLARE vCounter INT;
    SELECT (SELECT * FROM Edition
    WHERE Timeoverlap(vStartTime, vEndTime,
    StartTime, EndTime)) INTO vCounter FROM EDITION;
RETURN vCounter > 0;
END //
DELIMITER ;

CREATE FUNCTION IsEditionInvalid
(vStartDate dateTime, vEndDate dateTime)
RETURNS BOOLEAN
RETURN vEndDate <= vStartDate;

CREATE FUNCTION StartEndDiff
(vStartDate dateTime, vEndDate dateTime)
RETURNS INT
RETURN TIMESTAMPDIFF(SECOND, vStartDate, vEndDate);


DELIMITER //
CREATE TRIGGER Edition_BEFORE_INSERT
BEFORE INSERT ON Edition FOR EACH ROW
	BEGIN
    DECLARE Duration int;
	IF IsEditionInvalid(NEW.StartDate, NEW.EndDate)
		THEN SIGNAL SQLSTATE 'HY000'
		SET MYSQL_ERRNO = 1525,
		MESSAGE_TEXT = 'EndDate is equal to or before StartDate';
		END IF;
    IF StartEndDiff(NEW.Startdate, NEW.EndDate) > 1800
		THEN SIGNAL SQLSTATE 'HY000'
		SET MYSQL_ERRNO = 1525,
		MESSAGE_TEXT = 'Edition is too long, exceeds 30 minutes';
    END IF;
    IF TimeoverlapWithTable(NEW.StartDate, NEW.EndDate)
		THEN SIGNAL SQLSTATE 'HY000'
		SET MYSQL_ERRNO = 1525,
		MESSAGE_TEXT = 'Edition is overlapping with another edition';
    END IF;
END//
DELIMITER ;



    
	


