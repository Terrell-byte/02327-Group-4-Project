DROP database if exists gruppe4;
CREATE DATABASE gruppe4;
USE gruppe4;

DROP TABLE IF EXISTS Phone;
DROP TABLE IF EXISTS Email;
DROP TABLE IF EXISTS Ref;
DROP TABLE IF EXISTS Footage;
DROP TABLE IF EXISTS Edition;
DROP TABLE IF EXISTS Item;
DROP TABLE IF EXISTS Topic;
DROP TABLE IF EXISTS Journalist;

CREATE TABLE Journalist (
    CPR char(10) primary key,
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
    primary key(JournalistCPR, PhoneNr),
    FOREIGN KEY (JournalistCPR) references Journalist(CPR) on delete cascade
);

CREATE TABLE Email (
    JournalistCPR char(10),
    EmailAddr varchar(40),
    FOREIGN KEY (JournalistCPR) references Journalist (CPR) on delete cascade,
    PRIMARY KEY (JournalistCPR, EmailAddr)
);

CREATE TABLE Topic (
   Title varchar(40) Primary key,
   Description varchar(255)
);

CREATE TABLE Ref (
    TopicTitle varchar(40),
    JournalistCPR CHAR(10),
    Roles varchar(20),
    FOREIGN KEY (JournalistCPR) references Journalist(CPR),
    foreign key (TopicTitle) references Topic(Title) on delete cascade,
    primary key(TopicTitle, JournalistCPR)
);

CREATE TABLE Footage (
    Title varchar(40),
    DateShot date,
    DurationLength int,
    ReporterCPR CHAR(10),
    primary key(Title, DateShot)
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
    FOREIGN KEY (Topictitle) references Topic(Title) on delete set null
);

INSERT Journalist VALUES
("2501991812", "Maria", "Larsen", "Helsingborgvej", "35", "Silkeborg", "8600", "DK"),
("1212681819", "Newt", "McCalister", "Vesterbrogade", "135", "København", "1620", "DK"),
("1806797928", "Pia", "Ludvigsen", "Helsingborgvej", "37", "Silkeborg", "8600", "DK"),
("1703079811", "Rekrut", "Internmand", "Skrotvej", "1", "Tårnby", "2770", "DK"),
("0102694201", "Skipper", "Bent", "Voldboligerne", "2", "København", "1426", "DK"),
("2603851515", "Don", "Domingo", "Jyllingevej", "35", "Vanløse", "2720", "DK"),
("1804008922", "Maj", "McCalister", "Vesterbrogade", "135", "København", "1620", "DK"),
("1010594511", "John", "Ludvigsen", "Helsingborgvej", "37", "Silkeborg", "8600", "DK"),
("1701944848", "Ilse", "Ludomand", "Spilvej", "6", "Tårnby", "2770", "DK"),
("0104206969", "Gamle", "Ole", "Tusindårsvej", "2", "København", "1426", "DK");

INSERT Phone VALUES
("2501991812", "12345678"),
("2501991812", "01234567"),
("1212681819", "88888888"),
("1212681819", "99999999"),
("1806797928", "11111111"),
("1703079811", "02345678"),
("0102694201", "98745612"),
("0102694201", "12233322"),
("2603851515", "42005200"),
("1804008922", "98765432"),
("1010594511", "78945612"),
("1701944848", "12233322"),
("0104206969", "69696969");

INSERT Email VALUES
("2501991812", "Maria1234@gmail.com"),
("2501991812", "MariaFreetime@gmail.com"),
("1212681819", "cashMeOuside@gmail.com"),
("1212681819", "howAbouDa@gmail.com"),
("1806797928", "powerPia@gmail.com"),
("1806797928", "tiredPia@gmail.com"),
("1703079811", "intern@gmail.com"),
("0102694201", "Haddock@gmail.com"),
("2603851515", "Søndag@gmail.com"),
("1804008922", "MonthMay@gmail.com"),
("1010594511", "tiredJohn@gmail.com"),
("1701944848", "leoVegas@gmail.com"),
("0104206969", "firstMan@gmail.com");

INSERT Topic VALUES
("War in Ukraine", "The war in Ukraine is still going strong, Putin is still refusing to negotiate about pulling out his troops"),
("The great bakeoff", "Yet again is the drama wilder than ever in the famous tent"),
("President election 2023", "The polling is suggesting that Camacho is in the lead, with 70% over John Cena"),
("The steoroid nightmare", "Tons of young people has begun using sterorids in their local gyms, and the staff are aiding them in SATS"),
("Paddle Cup Scandal", "In a local paddle cup, a male participant has destroyed his own bat and his opponents aswell, after not scoring a single point"),
("Incel rebellion", "A group of people, who claim to be incels have gathered around Area 51 to free socalled 'real life anime waifus'."),
("Are bananas going extinct?", "Bananas as we now today are clones of original inedible bananas, should the clones go extinct we won't have edible bananas."),
("The Lonely Island splitting up?", "The Lonely Island are not splitting up, they are taking a break."),
("DTU Comp. Sci Students on strike?", "After further research, it has been concluded that most of the Comp. sci. students are just to lazy to show up for lectures."),
("News outro", "News are done for today, come back tommorrow");

INSERT Ref VALUES
("War in Ukraine", "2501991812", "Leader"),
("War in Ukraine", "1703079811", "Intern"),
("The great bakeoff", "1806797928", "Leader"),
("President election 2023", "1806797928", "Leader"),
("President election 2023", "1703079811", "Intern"),
("The steoroid nightmare", "0102694201", "Leader"),
("The steoroid nightmare", "1703079811", "Intern"),
("Paddle Cup Scandal", "1212681819", "Leader"),
("Paddle Cup Scandal", "1703079811", "Intern"),
("Paddle Cup Scandal", "2501991812", "Advisor"),
("Incel rebellion", "2603851515", "Leader"),
("Incel rebellion", "1703079811", "Intern"),
("Are bananas going extinct?", "1804008922", "Leader"),
("The Lonely Island splitting up?", "1010594511", "Leader"),
("DTU Comp. Sci Students on strike?", "0104206969", "Leader"),
("DTU Comp. Sci Students on strike?", "1701944848", "Researcher"),
("News outro", "1701944848", "Leader");

INSERT Footage VALUES
("Bombings in Kiev", "2023-03-28", 126, "2501991812"),
("Chocolate mousse seperating", "2023-03-18", 69, "1806797928"),
("Man destroying paddlebats", "2023-03-22", 180, "1212681819"),
("DTU students waking up late", "2023-02-14", 45, "0104206969"),
("Banana", "2023-01-16", 5, "1804008922"),
("Needles laying around in SATS", "2022-09-29", 120, "0102694201"),
("President candidate Camacho speech", "2022-12-23", 30, "1806797928"),
("News outro scene", "2013-03-18", 4, "1701944848"),
("Andy Samberg screaming at journalist", "2023-03-30", 159, "1010594511"),
("Incels protesting outside Area 51", "2023-03-29", 169, "2603851515");

INSERT Edition VALUES
("2023-03-28 20:00:00", "2023-03-28 20:29:59", "2501991812"),
("2023-03-28 20:30:00", "2023-03-28 20:59:59", "0102694201"),
("2023-03-28 21:00:00", "2023-03-28 21:29:59", "1212681819"),
("2023-03-29 20:00:00", "2023-03-29 20:29:59", "0102694201"),
("2023-03-29 20:30:00", "2023-03-29 20:59:59", "1212681819"),
("2023-03-30 20:00:00", "2023-03-30 20:29:59", "0104206969"),
("2023-03-30 20:30:00", "2023-03-30 20:59:59", "2603851515"),
("2023-03-30 21:00:00", "2023-03-30 21:29:59", "1701944848"),
("2023-03-31 20:00:00", "2023-03-31 20:29:59", "0104206969"),
("2023-03-31 20:15:00", "2023-03-31 22:00:59", "1212681819");

INSERT Item VALUES
("2023-03-28 20:01:30", "This item is about the war in Ukraine", 15000, "War in Ukraine"),
("2023-03-28 20:31:30", "This item is about the great bakeoff", 60000, "The great bakeoff"),
("2023-03-28 20:46:00", "This item is about the President election 2023", 40000, "President election 2023"),
("2023-03-29 20:01:30", "This item is about the steroid nightmare", 17000, "The steoroid nightmare"),
("2023-03-29 20:31:30", "This item is about the Paddle Cup Scandal", 9000, "Paddle Cup Scandal"),
("2023-03-30 20:01:30", "This item is about the incel rebellion", 23000, "Incel rebellion"),
("2023-03-30 20:31:30", "This item is about banana", 50000, "Are bananas going extinct?"),
("2023-03-30 20:46:00", "This item is about The Lonely Island", 6000, "The Lonely Island splitting up?"),
("2023-03-31 20:01:30", "This item is about the DTU Comp. Sci. students", 35000, "DTU Comp. Sci Students on strike?"),
("2023-03-31 20:31:30", "This item is the news outro", 6969, "News outro");





