USE gruppe4;

SELECT FirstName, LastName, TopicTitle, Roles 
FROM Ref natural join Journalist 
WHERE Ref.Roles = 'Leader' AND CPR = JournalistCPR Group by CPR;

SELECT CPR, FirstName, LastName, EmailAddr, PhoneNr 
FROM (Journalist natural join Email) Natural join Phone 
WHERE Email.JournalistCPR = Journalist.CPR AND Phone.JournalistCPR = Journalist.CPR order by LastName;

SELECT TopicTitle, Views, Description FROM Item WHERE Views = (SELECT MIN(Views) FROM Item);





SELECT FirstName, LastName FROM Journalist WHERE LastName = "McCalister";

DROP TRIGGER IF exists Footage_BEFORE_INSERT;
DELIMITER //
CREATE TRIGGER Footage_BEFORE_INSERT
BEFORE INSERT ON Footage FOR EACH ROW
BEGIN
IF NEW.DurationLength <= 0
THEN SIGNAL SQLSTATE 'HY000'
		SET MYSQL_ERRNO = 1525,
		MESSAGE_TEXT = 'Duration of footage is equal to/or under 0 seconds';
	END IF;
IF NEW.DurationLength > 180
THEN SIGNAL SQLSTATE 'HY000'
		SET MYSQL_ERRNO = 1525,
		MESSAGE_TEXT = 'Duration of footage is over 3 minutes';
	END IF;
END//
DELIMITER ;

DROP FUNCTION IF exists Timeoverlap;
CREATE FUNCTION Timeoverlap
(vStartDate1 dateTime, vEndDate1 dateTime,
vStartDate2 dateTime, vEndDate2 dateTime)
RETURNS BOOLEAN
RETURN ((vstartDate1 <= vStartDate2 AND
vStartDate2 <= vEndDate1) OR
(vstartDate2 <= vStartDate1 AND
vStartDate1 <= vEndDate2));

DROP FUNCTION IF exists TimeoverlapWithTable;
DELIMITER //
CREATE FUNCTION TimeoverlapWithTable
	(vStartDate DATETIME, vEndDate DATETIME)
	RETURNS BOOLEAN
BEGIN
	DECLARE vCounter INT;
	SELECT COUNT(distinct hostCPR)  INTO vCounter FROM Edition
    WHERE Timeoverlap(vStartDate, vEndDate, StartDate, EndDate);
    RETURN vCounter > 0;
END //
DELIMITER ;

DROP FUNCTION IF exists IsEditionInvalid;
CREATE FUNCTION IsEditionInvalid
(vStartDate dateTime, vEndDate dateTime)
RETURNS BOOLEAN
RETURN vEndDate <= vStartDate;

DROP FUNCTION IF exists StartEndDiff;
CREATE FUNCTION StartEndDiff
(vStartDate dateTime, vEndDate dateTime)
RETURNS INT
RETURN TIMESTAMPDIFF(SECOND, vStartDate, vEndDate);

DROP TRIGGER IF exists Edition_BEFORE_INSERT;
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

INSERT Edition values("2023-03-31 20:15:00", "2023-03-31 22:00:59", "1212681819");
INSERT Footage VALUES("too long footage part 2", "2023-02-20", 181, "2603851515"); 
INSERT Footage VALUES("too long footage part 3", "2023-02-20", 0, "2603851515");
INSERT Footage VALUES("Appropriate footage length", "2023-02-20", 159, "2603851515");