
drop database if exists los_dulces;
create database los_dulces;
use los_dulces;

create table Manager(
	employeeID int,
    name varchar(40),
    position varchar(40) check (position in("General Manager","Rooms Manager", "HouseKeeping Manager", "Restaurant Manager", "Front Office Manager", "Valet Manager", "IT Manager", "Facilities Manager")),
    primary key(employeeID)
    
);
create table Department(
	deptID int primary key,
    name varchar(40) check(name in("Facility", "Office", "Housekeeping","Restaurant", "Security")),
    employeeID int,
    foreign key(employeeID) references Manager(employeeID)
		on delete cascade
        on update cascade
);

create table Hotel(
	hotelID int primary key,
    hotelName varchar(40),
    capacity int check(capacity <= 250),
    employeeID int,
    foreign key(employeeID) references Manager(employeeID)
		on delete cascade
        on update cascade
);

create table AffiliatedWith(
	employeeID int primary key,
    hotelName varchar(60),
    deptID int,
    foreign key(employeeID) references Hotel(employeeID)
		on delete cascade
        on update cascade,
    foreign key(deptID) references Department(deptID)
		on delete cascade
        on update cascade
    );
create table Room(
	roomID int primary key,
    roomType varchar(40),
    check(roomType in ("King", "Double Queen", "Double Queen Accessible")),
    check(roomId >= 1 and roomID <= 250)
);
create table Guest(
	guestID int primary key,
    name varchar(40),
    address varchar(100),
    phone varchar(16), 
    roomID int,
    foreign key(roomID) references Room(roomID)
		on delete cascade
        on update cascade
);

create table Staff(
	employeeID int primary key, 
    name varchar(40),
    position varchar(40),
    check(position in ("Front Desk Clerk", "Concierge", "Housekeeper", "Valet", "Chef", "Server", "Security Officer"))
);
create table Amenity(
	amenityID int primary key,
	amenityType varchar(30),
    amenityName varchar(40),
    check (amenityType in("Consumable", "Return")),
    check(amenityName in ("Pillow","Blanket", "Iron", "Robe", "Hair Dryer", "Toiletries"))
);
create table Delivers(
	employeeID int,
    guestID int, 
    amenityID int,
    deliveryDateTime datetime,
    quantity int check(quantity <= 5),
    primary key(employeeID, guestID),
    foreign key(employeeID) references Staff(employeeID)
		on delete cascade
        on update cascade,
    foreign key(guestID) references Guest(guestID)
		on delete cascade
        on update cascade,
    foreign key(amenityID) references Amenity(amenityID)
		on delete cascade
        on update cascade
);

create table Stay(
	stayID int,
    guestID int,
    roomID int,
    startDate date,
    endDate date,
    primary key(stayID, guestID),
    foreign key(guestID) references Guest(guestID)
		on delete cascade
        on update cascade,
    foreign key(roomID) references Room(roomID)
		on delete cascade
        on update cascade
);

create table Rental(
	guestID int, 
    itemName varchar(40),
    stayID int,
    eventDate date,
    employeeID int,
    primary key(guestID, itemName, stayID),
    foreign key(guestID) references Guest(guestID),
    foreign key(stayID) references Stay(stayID)
		on delete cascade
        on update cascade,
    foreign key(employeeID) references Staff(employeeID)
		on delete cascade
        on update cascade,
    check (itemName in ("Golf Clubs", "Tennis racket", "Bicycle", "Golf cart", "Games", "Movies"))
);

create table OnCall(
	employeeID int,
    startDate date, 
    endDate date,
    primary key(employeeID, startDate, endDate),
    foreign key(employeeID) references Staff(employeeID)
		on delete cascade
        on update cascade
);

create table Reservation(
	reserveID int,
    guestID int,
    employeeID int,
    startDateTime datetime,
    endDateTime datetime,
    primary key(reserveID),
    foreign key(guestID) references Guest(guestID)
		on delete cascade
        on update cascade
);