USE gruppe4;

DROP FUNCTION IF exists IsFootageTooLong;
CREATE FUNCTION IsFootageTooLong
(vTitle VARCHAR(40), vDateShot date, vDurationLength INT)
RETURNS BOOLEAN
RETURN vDurationLength > 180;

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
IF IsFootageTooLong(NEW.Title, NEW.DateShot, NEW.DurationLength)
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

SELECT * FROM Journalist;
SELECT * FROM Phone;
Select * FROM Email;
SELECT * FROM Topic;
SELECT * FROM Reference;
SELECT * FROM Footage;
SELECT * FROM Edition;
SELECT * FROM Item;
