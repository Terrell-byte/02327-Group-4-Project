USE gruppe4;


DROP TABLE IF EXISTS Phone;
DROP TABLE IF EXISTS Email;
DROP TABLE IF EXISTS Journalist;
DROP TABLE IF EXISTS Reference;
DROP TABLE IF EXISTS Footage;
DROP TABLE IF EXISTS Edition;
DROP TABLE IF EXISTS Topic;
DROP TABLE IF EXISTS Item;


CREATE TABLE Phone (
    JournalistCPR int,
    Phone varchar(255)
);

CREATE TABLE Email (
    JournalistCPR int,
    Email varchar(255)
);

CREATE TABLE Journalist (
    CPR int,
    FirstName varchar(255),
    LastName varchar(255),
    Address varchar(255),
    Civic varchar(255),
    City varchar(255),
    ZIP varchar(255),
    Country varchar(255)
);

CREATE TABLE Reference (
    TopicTitle varchar(255),
    JournalistCPR int,
    Role varchar(255)
);

CREATE TABLE Footage (
    Title varchar(255),
    DateShot date,
    DurationLength int,
    ReportCPR int
);

CREATE TABLE Edition (
    StartDate dateTime,
    EndDate dateTime,
    HostCPR int
);

CREATE TABLE Topic (
   Title varchar(255),
   Description varchar(255)
);

CREATE TABLE Item (
    DateTimeSlot dateTime,
    Description varchar(255),
    Views int,
    TopicTitle varchar(255)
);


