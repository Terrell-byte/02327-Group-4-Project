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
    JournalistCPR char(10) primary key,
    Phone char(8),
    FOREIGN KEY (JournalistCPR) references Journalist(CPR)
);

CREATE TABLE Email (
    JournalistCPR char(10) primary key,
    Email varchar(40),
    FOREIGN KEY (JournalistCPR) references Journalist(CPR)
);

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

CREATE TABLE Reference (
    TopicTitle varchar(40),
    JournalistCPR CHAR(10),
    Role varchar(20),
    constraint referenceID primary key(TopicTitle, JournalistCPR),
    FOREIGN KEY (JournalistCPR) references Journalist(CPR),
    foreign key (TopicTitle) references Topic(Title)
);

CREATE TABLE Footage (
    Title varchar(40) Primary key,
    DateShot date primary key,
    DurationLength int,
    ReportCPR CHAR(10),
    constraint FootageID primary key(Title, DateShot)
);

CREATE TABLE Edition (
    StartDate dateTime Primary key,
    EndDate dateTime,
    HostCPR CHAR(10)
);

CREATE TABLE Topic (
   Title varchar(40) Primary key,
   Description varchar(255)
);

CREATE TABLE Item (
    DateTimeSlot dateTime primary key,
    Description varchar(255),
    Views int,
    TopicTitle varchar(40),
    FOREIGN KEY (Topictitle) references Topic(Title)
);


