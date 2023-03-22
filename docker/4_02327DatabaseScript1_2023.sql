DROP TABLE IF EXISTS PreReq;
DROP TABLE IF EXISTS TimeSlot;
DROP TABLE IF EXISTS Advisor;
DROP TABLE IF EXISTS Takes;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Teaches;
DROP TABLE IF EXISTS Section;
DROP TABLE IF EXISTS Instructor;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Classroom;


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
    City varchar(255)
    ZIP varchar(255),
    Country varchar(255),
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
    ReportCPR int,
);

CREATE TABLE Edition (
    StartDate dateTime,
    EndDate dateTime,
    HostCPR int,
);

CREATE TABLE Topic (
   Title varchar(255),
   Description varchar(255),
);

CREATE TABLE Item (
    DateTimeSlot dateTime,
    Description varchar(255),
    Views int,
    TopicTitle varchar(255),
);
