create database CARVAN
go
use CARVAN
go

----------

create table UserAccount (
	UserId int primary key identity,
	FullName varchar(256),
	UserName varchar(256),
	Password varchar(256),
	Address text,
	Email varchar(100),
	PhoneNumber varchar(50),	
	Birthday Date not null,
	CreatedDate DateTime,
	UpdatedDate DateTime,
	Status int 
)
go

insert into UserAccount values('Administrator','admin','MTIzNDU2','Bach Khoa Aptech','c1808j1@gmail.com','1234567890',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,1)
go
/*
password: 123456
*/

create proc Insert_UserAccount
	@FullName varchar(256),
	@UserName varchar(256),
	@Password varchar(256),
	@Address text,
	@Email varchar(100),
	@PhoneNumber varchar(50),
	@Birthday Date
	as
	begin
	insert into UserAccount values(@FullName,@UserName,@Password,@Address,@Email,@PhoneNumber,@Birthday,CURRENT_TIMESTAMP,NULl,0)
	end
go

create proc Update_UserAccount
	@UserId int,
	@FullName varchar(256),
	@UserName varchar(256),
	@Password varchar(256),
	@Address text,
	@Email varchar(100),
	@PhoneNumber varchar(50),
	@Birthday Date
	as
	begin
	update UserAccount set FullName = @FullName, UserName = @UserName, Password = @Password,Email = @Email, Address = @Address,PhoneNumber = @PhoneNumber,Birthday = @Birthday,UpdatedDate = CURRENT_TIMESTAMP where UserId = @UserId
	end
go

----------

create table Brands(
BrandId int primary key identity,
BrandName varchar(256),
Image text,
CreatedDate DateTime,
UpdatedDate DateTime
)
go


create proc Insert_Brand
	@BrandName varchar(256),
	@image text 
	as
	begin
	insert into Brands values(@BrandName,@image,CURRENT_TIMESTAMP,NULL)
	end
go

create proc Update_Brand
@BrandId int,
@BrandName varchar(256),
@image text
as 
begin 
update Brands set BrandName=@BrandName, image = @image, UpdatedDate = CURRENT_TIMESTAMP where BrandId= @BrandId
end 
go 
----------

create table ModelCars(
ModelCarId int primary key identity,
ModelCarName varchar(256),
BrandId int references Brands(BrandId),
CreatedDate DateTime,
UpdatedDate DateTime
)
go

create proc Insert_ModeCar
@ModelCarName varchar(256),
@BrandId int
as
begin
	insert into ModelCars values(@ModelCarName,@BrandId,CURRENT_TIMESTAMP,NULL)
end
go

----------

create table Cars(
CarId int primary key identity,
ModelNumberCar varchar(100),
CarName varchar(256),
PriceInput float,
PriceOutput float,
SeatQuantity int,
Color varchar(50),
Gearbox varchar(256),
Engine varchar(256),
FuelConsumption float,
KilometerGone float,
Status int,
Checking int,
CreatedDate DateTime,
UpdatedDate DateTime,
Sold int
)
go


create proc Insert_Car
	@ModelNumberCar varchar(100),
	@Id int,
	@CarName varchar(256),
	@PriceInput float,
	@PriceOutput float,
	@SeatQuantity int,
	@Color varchar(50),
	@Gearbox varchar(256),
	@Engine varchar(256),
	@FuelConsumption float,
	@KilometerGone float,	
	@Status int,
	@Checking int
as
begin
	insert into Cars values(@ModelNumberCar, @Id, @CarName, @PriceInput, @PriceOutput, @SeatQuantity, @Color, @Gearbox, @Engine, @FuelConsumption, @KilometerGone, @Status, @Checking, CURRENT_TIMESTAMP, NULL,0)
end
go

create proc Update_Car_Sold
	@ModelNumberCar varchar(100),
	@Sold int,
	@Checking int
as
begin
	update Cars set Sold = @Sold, Checking = @Checking where ModelNumberCar = @ModelNumberCar
end
go

create table Images(
ImageId int primary key identity,
CarId int references Cars(CarId),
Name varchar(MAX),
Status int
)
go