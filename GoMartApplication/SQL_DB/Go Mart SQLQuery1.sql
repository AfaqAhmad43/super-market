create database GoMartDB


create table tblAdmin
(
AdminID nvarchar(50) primary key,
[Password] nvarchar(50),
FullName nvarchar(50)
)

select * from tblAdmin

select top 1 AdminID,Password,FullName from tblAdmin where AdminID=@AdminID and Password=@Password

create table tblSeller
(
SellerID int identity(1,1) primary key,
SellerName nvarchar(50) Unique,
SellerAge int,
SellerPhone nvarchar(10),
SellerPass nvarchar(50)
)

select * from tblSeller

select top 1 SellerName,SellerPass from tblSeller where SellerName=@SellerName and SellerPass=@SellerPass


create table tblCategory
(
CatID int identity(1,1) primary key not null,
CategoryName nvarchar(50),
CategoryDesc nvarchar(50)
)
select * from tblCategory

insert into tblCategory (CategoryName,CategoryDesc) values(@CategoryName,@CategoryDesc)

create procedure spCatInsert
(
@CategoryName nvarchar(50),
@CategoryDesc nvarchar(50)
)
as
begin
insert into tblCategory (CategoryName,CategoryDesc) values(@CategoryName,@CategoryDesc)
end
------
select  CatID as CategoryID,CategoryName,CategoryDesc as CategoryDescription from tblCategory

------

create procedure spCatUpdate
(
@CatID int,
@CategoryName nvarchar(50),
@CategoryDesc nvarchar(50)
)
as
begin
update tblCategory set CategoryName=@CategoryName,CategoryDesc=@CategoryDesc where CatID=@CatID
end
-----


create procedure spCatDelete
(
@CatID int 
)
as
begin
Delete from tblCategory where CatID=@CatID
end

----
select * from tblSeller


create procedure spSellerInsert
(
@SellerName nvarchar(50),
@SellerAge int, 
@SellerPhone nvarchar(50),
@SellerPass nvarchar(50)
)
as
begin
insert into tblSeller(SellerName,SellerAge,SellerPhone,SellerPass) values(@SellerName,@SellerAge,@SellerPhone,@SellerPass)
end
go
-------------
create procedure spSellerUpadte
(
@SellerID int,
@SellerName nvarchar(50),
@SellerAge int, 
@SellerPhone nvarchar(50),
@SellerPass nvarchar(50)
)
as
begin
update tblSeller set SellerName=@SellerName,SellerAge=@SellerAge,SellerPhone=@SellerPhone,SellerPass=@SellerPass where SellerID=@SellerID
end
go

----
create procedure spSellerDelete
(
@SellerID int 
)
as
begin
Delete from tblSeller where SellerID=@SellerID
end

go



select * from tblAdmin
select AdminID from tblAdmin where AdminID='Coder'


create procedure spAddAdmin
(
@AdminID nvarchar(50),
@Password nvarchar(50),
@FullName nvarchar(50)
)
as
begin
Insert into tblAdmin(AdminID,[Password],FullName) values(@AdminID,@Password,@FullName)
end
go

----
create procedure spUpdateAdmin
(
@AdminID nvarchar(50),
@Password nvarchar(50),
@FullName nvarchar(50)
)
as
begin
update tblAdmin set [Password]=@Password,FullName=@FullName where AdminID=@AdminID
end
go

select * from tblAdmin
---
create procedure spDeleteAdmin
(
@AdminID nvarchar(50)
)
as
begin
delete tblAdmin where AdminID=@AdminID
end
go

--
create table tblProduct
(
ProdID int identity(1,1) primary key not null,
ProdName nvarchar(50),
ProdCatID int,
ProdPrice decimal(10,2),
ProdQty int,
)

create procedure spGetCategory
as
begin
set nocount on;
select CatID,CategoryName from tblCategory order by CategoryName asc
end
go

--
select * from tblProduct

create procedure spCheckDuplicateProduct
(
@ProdName nvarchar(50),
@ProdCatID int
)
as
begin
set nocount on;
select ProdName from tblProduct where ProdName=@ProdName and ProdCatID=@ProdCatID
end
go
----
create procedure spInsertProduct
(
@ProdName nvarchar(50),
@ProdCatID int,
@ProdPrice decimal(10,2),
@ProdQty int
)
as
begin
 
Insert into tblProduct(ProdName,ProdCatID,ProdPrice,ProdQty) values(@ProdName,@ProdCatID,@ProdPrice,@ProdQty)
end
go

----


select * from tblCategory


select * from tblProduct

create procedure spGetAllProductList
as  
begin
set nocount on;
select t1.ProdID,t1.ProdName,t2.CategoryName,t1.ProdCatID as CategoryID,t1.ProdPrice,t1.ProdQty from tblProduct as t1
inner join tblCategory as t2 on t1.ProdCatID=t2.CatID
order by t1.ProdName,t2.CategoryName asc
end
go

---

create procedure spUpdateProduct
(
@ProdID int,
@ProdName nvarchar(50),
@ProdCatID int,
@ProdPrice decimal(10,2),
@ProdQty int
)
as
begin
 
update tblProduct set ProdName=@ProdName,ProdCatID=@ProdCatID,ProdPrice=@ProdPrice,ProdQty=@ProdQty where ProdID=@ProdID
end
go

---
create procedure spDeleteProduct
(
@ProdID Int
)
as
begin
 
delete from tblProduct where ProdID=@ProdID
end
go

select * from tblProduct
--
create procedure spGetAllProductList_SearchByCat
(
@ProdCatID int
)
as
begin
set nocount on;
select t1.ProdID,t1.ProdName,t2.CategoryName,t1.ProdCatID as CategoryID,t1.ProdPrice,t1.ProdQty from tblProduct as t1
inner join tblCategory as t2 on t1.ProdCatID=t2.CatID
where t1.ProdCatID=@ProdCatID
order by t1.ProdName,t2.CategoryName asc
end
go

----------------

create table tblBill
(
Bill_ID int primary key,
SellerID nvarchar(50),
SellDate nvarchar(50),
TotalAmt decimal(18,2)
)

create procedure spInsertBill
(
@Bill_ID int,
@SellerID nvarchar(50),
@SellDate nvarchar(50),
@TotalAmt decimal(18,2)
)
as
begin
insert into tblBill (Bill_ID,SellerID,SellDate,TotalAmt) values(@Bill_ID,@SellerID,@SellDate,@TotalAmt)
end
go
---

create procedure spGetBillList
as
begin
set nocount on;
select Bill_ID,SellerID,SellDate,TotalAmt from tblBill order by Bill_ID desc 
end
go




-- Get Connection string
-- Source - https://stackoverflow.com/a
-- Posted by Brijesh Kumar Tripathi
-- Retrieved 2025-12-09, License - CC BY-SA 4.0

select
    'data source=' + @@servername +
    ';initial catalog=' + db_name() +
    case type_desc
        when 'WINDOWS_LOGIN' 
            then ';trusted_connection=true'
        else
            ';user id=' + suser_name() + ';password=<<YourPassword>>'
    end
    as ConnectionString
from sys.server_principals
where name = suser_name()

-- changing the admin store procedure through adding checks
alter procedure spAddAdmin
    @AdminID nvarchar(50),
    @Password nvarchar(50),
    @FullName nvarchar(50)
as
begin


    -- Admin ID Validation
    if @AdminID is null
    begin
        raiserror('Admin ID cannot be empty', 16, 1);
        return;
    end

    if LEN(@AdminID) > 50
    begin
        raiserror('Admin ID cannot be more than 50 characters.', 16, 1);
        return;
    end

    if exists(select 1 from tblAdmin where AdminID=@AdminID)
    begin
        raiserror('AdminID aleady exists', 16, 1);
        return;
    end

    -- Password validation
    if @Password is null
    begin
        raiserror('Password cannot be empty.', 16, 1);
        return;
    end

    if LEN(@Password) > 50
    begin
        raiserror('Password cannot be more than 50 characters.', 16, 1);
        return;
    end

    -- FullName validation
    if @FullName is null
    begin
        raiserror('Full name cannot be empty.', 16, 1);
        return;
    end

    if LEN(@FullName) > 50
    begin
        raiserror('Full name cannot be more than 50 characters.', 16, 1);
        return;
    end

    begin transaction
    begin try
        insert into tblAdmin(AdminID, [Password], FullName)
        values(@AdminID, @Password, @FullName);

        commit transaction;
    end try
    begin catch
        rollback transaction;
    end catch
end
go

    -- Admin ID Validation
    if @AdminID is null
    begin
        raiserror('Admin ID cannot be empty', 16, 1);
        return;
    end

    if LEN(@AdminID) > 50
    begin
        raiserror('Admin ID cannot be more than 50 characters.', 16, 1);
        return;
    end

    -- Password validation
    if @Password is null
    begin
        raiserror('Password cannot be empty.', 16, 1);
        return;
    end

    if LEN(@Password) > 50
    begin
        raiserror('Password cannot be more than 50 characters.', 16, 1);
        return;
    end

    -- FullName validation
    if @FullName is null
    begin
        raiserror('Full name cannot be empty.', 16, 1);
        return;
    end

    if LEN(@FullName) > 50
    begin
        raiserror('Full name cannot be more than 50 characters.', 16, 1);
        return;
    end

    begin transaction
    begin try
        update tblAdmin
        set [Password] = @Password,
            FullName = @FullName
        where AdminID = @AdminID

        commit transaction;
    end try
    begin catch
        rollback transaction;
        throw
    end catch
end
go
--Check is for the Updating the Admin 
alter procedure spUpdateAdmin
(
@AdminID nvarchar(50),
@Password nvarchar(50),
@FullName nvarchar(50)
)
as
begin

    -- Admin ID Validation
    if @AdminID is null
    begin
        raiserror('Admin ID cannot be empty', 16, 1);
        return;
    end

    if LEN(@AdminID) > 50
    begin
        raiserror('Admin ID cannot be more than 50 characters.', 16, 1);
        return;
    end

    -- Password validation
    if @Password is null
    begin
        raiserror('Password cannot be empty.', 16, 1);
        return;
    end

    if LEN(@Password) > 50
    begin
        raiserror('Password cannot be more than 50 characters.', 16, 1);
        return;
    end

    -- FullName validation
    if @FullName is null
    begin
        raiserror('Full name cannot be empty.', 16, 1);
        return;
    end

    if LEN(@FullName) > 50
    begin
        raiserror('Full name cannot be more than 50 characters.', 16, 1);
        return;
    end

    begin transaction
    begin try
        update tblAdmin
        set [Password] = @Password,
            FullName = @FullName
        where AdminID = @AdminID

        commit transaction;
    end try
    begin catch
        rollback transaction;
        throw
    end catch
end
go

-- checks for deleting admin, updating spDeleteAdmin
alter procedure spDeleteAdmin
    @AdminID nvarchar(50)
as
begin
    
    begin transaction
    begin try

        if @AdminID is null
        begin
            raiserror('Admin ID cannot be empty.', 16, 1);
            rollback transaction;
            return;
        end

        if not exists(select 1 from tblAdmin where AdminID=@AdminID)
        begin
            raiserror('Admin ID does not exist', 16, 1);
            rollback transaction;
            return;
        end

        
   

        delete from tblAdmin where AdminID = @AdminID

        commit transaction
    end try
    begin catch
        rollback transaction

        throw
    end catch
end;
go

-- Seller table changes
alter table tblSeller 
alter column SellerName nvarchar(50) not null;

alter table tblSeller
alter column SellerAge int not null;

-- Age Check
alter table tblSeller
alter column SellerPhone nvarchar(10) not null;

alter table tblSeller
alter column SellerPass nvarchar(50) not null;

alter procedure spSellerInsert
@SellerName nvarchar(50),
@SellerAge int, 
@SellerPhone nvarchar(10),
@SellerPass nvarchar(50)
as begin 
-- Validation for the Seller Name Same 
 if @SellerName is null
    begin
        raiserror('Seller  Name  cannot be empty', 16, 1);
        return;
    end

    if LEN(@SellerName) > 50
    begin
        raiserror('SellerName cannot be more than 50 characters.', 16, 1);
        return;
    end

    if exists(select 1 from tblSeller where SellerName = @SellerName)
    begin
        raiserror('Seller name already exists.',16, 1);
        return;
    end

    --Validation for the Seller Age 
    if @SellerAge  is null
    begin
        raiserror('Seller  Age   cannot be empty', 16, 1);
        return;
    end
      
    if @SellerAge < 18 or @SellerAge > 100
    begin
        raiserror('Seller age must be between 18 and 100.', 16, 1);
        return
    end

    --Validation for the Seller Phone 
    if @SellerPhone  is null
    begin
        raiserror('Seller Phone Number is Must ', 16, 1);
        return;
    end

    if LEN(@SellerPhone)  >10
    begin
        raiserror('Seller  Phone Number Cannot be Greater then the 50 ', 16, 1);
        return;
    end

    if @SellerPhone like '%[^0-9]%'
    begin
        raiserror('Seller phone must be exactly 10 digits', 16, 1);
        return;
    end
    -- Validation for the Seller  Password

   if @SellerPass  is null
    begin
        raiserror('Seller Password  Cannot be Empty  ', 16, 1);
        return;
    end
       if LEN(@SellerPass)  >50
    begin
        raiserror('Seller  PassWord  Cannot be Greater then the 50 ', 16, 1);
        return;
    end

    begin transaction
    begin try
        insert into tblSeller(SellerName,SellerAge,SellerPhone,SellerPass) values(@SellerName,@SellerAge,@SellerPhone,@SellerPass)
        commit transaction
    end try
    begin catch
        rollback transaction
        throw
    end catch

end
go

-- Checks for the Updating Seller 
alter procedure spSellerUpadte
(
@SellerID int,
@SellerName nvarchar(50),
@SellerAge int, 
@SellerPhone nvarchar(10),
@SellerPass nvarchar(50)
)
as
begin
    
    if not exists(select 1 from tblSeller where SellerID = @SellerID)
    begin
        raiserror('Seller ID does not exist. Cannot update.', 16, 1);
        return;
    end

    -- Validation for the Seller Name Same 
 if @SellerName is null
    begin
        raiserror('Seller  Name  cannot be empty', 16, 1);
        return;
    end

    if LEN(@SellerName) > 50
    begin
        raiserror('SellerName cannot be more than 50 characters.', 16, 1);
        return;
    end

    if exists(select 1 from tblSeller where SellerName = @SellerName)
    begin
        raiserror('Seller name already exists.',16, 1);
        return;
    end

    --Validation for the Seller Age 
    if @SellerAge  is null
    begin
        raiserror('Seller  Age   cannot be empty', 16, 1);
        return;
    end
      
    if @SellerAge < 18 or @SellerAge > 100
    begin
        raiserror('Seller age must be between 18 and 100.', 16, 1);
        return
    end

    --Validation for the Seller Phone 
    if @SellerPhone  is null
    begin
        raiserror('Seller Phone Number is Must ', 16, 1);
        return;
    end

    if LEN(@SellerPhone)  >10
    begin
        raiserror('Seller  Phone Number Cannot be Greater then the 50 ', 16, 1);
        return;
    end

    if @SellerPhone like '%[^0-9]%'
    begin
        raiserror('Seller phone must be exactly 10 digits', 16, 1);
        return;
    end
    -- Validation for the Seller  Password

   if @SellerPass  is null
    begin
        raiserror('Seller Password  Cannot be Empty  ', 16, 1);
        return;
    end
       if LEN(@SellerPass)  >50
    begin
        raiserror('Seller  PassWord  Cannot be Greater then the 50 ', 16, 1);
        return;
    end

    -- Transaction Block for Atomicity
    begin transaction
    begin try
        update tblSeller set 
            SellerName=@SellerName,
            SellerAge=@SellerAge,
            SellerPhone=@SellerPhone,
            SellerPass=@SellerPass 
        where SellerID=@SellerID
        
        commit transaction;
    end try
    begin catch
        rollback transaction;
        throw
    end catch
end
go
-----------------------------
alter procedure spSellerDelete
(
@SellerID int 
)
as
begin
    
    -- Existence Check (Ensures Seller ID exists before attempting delete)
    if not exists(select 1 from tblSeller where SellerID = @SellerID)
    begin
        raiserror('Seller ID does not exist. Cannot be Deleted.', 16, 1);
        return;
    end

    -- Transaction Block for Atomicity
    begin transaction
    begin try
        
        -- The Core Deletion Command
        Delete from tblSeller where SellerID=@SellerID

        commit transaction;
    end try
    begin catch
        -- If any error occurs  rollback changes
        rollback transaction; 
        throw
    end catch
end
go


-- Changes to category table
alter table tblCategory
alter column CategoryName nvarchar(50) not null;

-- Made CategoryName unique through constraint
alter table tblCategory
add constraint uniqueCategoryName unique (CategoryName)

-- Checks added to category insert procedure
go
alter procedure spCatInsert (
@CategoryName nvarchar(50),
@CategoryDesc nvarchar(50)
)
as
begin
    
    if @CategoryName is null
    begin
        raiserror('CategoryName cannot be null', 16, 1);
        return;
    end

    if LEN(@CategoryName) > 50
    begin
        raiserror('CategoryName cannot exceed 50 characters', 16, 1);
        return;
    end


    if @CategoryDesc is null
    begin
        raiserror('Category decription cannot be null', 16, 1);
        return;
    end

    if LEN(@CategoryDesc) > 50
    begin
        raiserror('Category description cannot exceed 50 characters', 16, 1);
        return;
    end

    if exists(select 1 from tblCategory where CategoryName = @CategoryName)
    begin
        raiserror('Category Name already exists', 16, 1)
        return;
    end

    begin transaction
    begin try
        insert into tblCategory(CategoryName, CategoryDesc)
        values(@CategoryName, @CategoryDesc);
        commit transaction;
    end try

    begin catch
        rollback transaction;
        throw;
    end catch
end
go

-- Changes added to category update procedure

alter procedure spCatUpdate
    @CatID int,
    @CategoryName nvarchar(50),
    @CategoryDesc nvarchar(50)
as
begin
    
    if not exists(select 1 from tblCategory where CatID = @CatID)
    begin
        raiserror('Category ID does not exist', 16, 1);
        return;
    end

    if @CategoryName is null
    begin
        raiserror('Category name cannot be empty', 16, 1);
        return;
    end

    if LEN(@CategoryName) > 50
    begin
        raiserror('Category name cannot exceed 50 characters', 16, 1);
        return;
    end

    if @CategoryDesc is null
    begin
        raiserror('Category description cannot be empty', 16, 1);
        return;
    end

    if LEN(@CategoryDesc) > 50
    begin
        raiserror('Category description cannot exceed 50 characters', 16, 1);
        return;
    end

    begin transaction
    begin try
        update tblCategory
        set CategoryName = @CategoryName,
            CategoryDesc = @CategoryDesc
        where CatID = @CatID;

        commit transaction;
    end try

    begin catch
        rollback transaction;
        throw;
    end catch
end
go

-- changes to the category delete procedure
alter procedure spCatDelete
    @CatID int
as
begin
    if not exists(select 1 from tblCategory where CatID = @CatID)
    begin
        raiserror('Category ID does not exist.', 16, 1);
        return;
    end

    begin transaction
    begin try
        delete from tblCategory where CatID = @CatID;
        commit transaction;
    end try

    begin catch
        rollback transaction;
        throw;
    end catch;
end
go

-- added indexing on CategoryName
create index indexCategoryName on tblCategory(CategoryName);

-- Changes to product table

-- Made other properties not null to ensure proper functioning
alter table tblProduct
alter column ProdName nvarchar(50) not null;

ALTER TABLE tblProduct ALTER COLUMN ProdCatID int NOT NULL;
ALTER TABLE tblProduct ALTER COLUMN ProdPrice decimal(10,2) NOT NULL;
ALTER TABLE tblProduct ALTER COLUMN ProdQty int NOT NULL;

-- Altered prodCatID from category to be a foreign key
alter table tblProduct
add constraint FK_ProductCategory
foreign key (ProdCatID)
references tblCategory(CatID);

-- Added indexing on prodCatID for better searching
create index IndexProdCategory
on tblProduct(ProdCatID);


-- Added unique constraint on product name and foreign key
alter table tblProduct
add constraint UniqueProduct_Name_Category
unique (ProdName, ProdCatID);


-- Changed spInsertProduct with checks
alter procedure spInsertProduct 
(
    @ProdName nvarchar(50),
    @ProdCatID int,
    @ProdPrice decimal (10, 2),
    @ProdQty int
)
as
begin
    -- ProdName checks
    if @ProdName is null
    begin
        raiserror('Product name cannot be empty.', 16, 1);
        return;
    end

    -- Price check
    if @ProdPrice <= 0
    begin
        raiserror('Product price should be greater than zero.', 16, 1);
        return;
    end

    -- Quantity check
    if @ProdQty < 0
    begin
        raiserror('Product quantity cannot be negative', 16, 1);
        return;
    end

    -- Category existence checks
    if not exists (select 1 from tblCategory where CatID = @ProdCatID)
    begin
        raiserror('Selected category does not exist.', 16, 1);
        return;
    end

    -- Duplicate check
    if exists (select 1 from tblProduct where ProdName = @ProdName and ProdCatID = @ProdCatID)
    begin
        raiserror('Product already exists in this category', 16, 1);
        return;
    end

    begin transaction
    begin try
        insert into tblProduct
        (ProdName, ProdCatID, ProdPrice, ProdQty)
        values
        (@ProdName, @ProdCatID, @ProdPrice, @ProdQty);

        commit transaction;
    end try

    begin catch
        rollback transaction;
        throw;
    end catch
end
go

-- spUpdateProduct procedure with checks
alter procedure spUpdateProduct
(
    @ProdID int,
    @ProdName nvarchar(50),
    @ProdCatID int,
    @ProdPrice decimal(10,2),
    @ProdQty int
)
as 
begin
-- ProdName checks
    if @ProdName is null
    begin
        raiserror('Product name cannot be empty.', 16, 1);
        return;
    end

    -- Price check
    if @ProdPrice <= 0
    begin
        raiserror('Product price should be greater than zero.', 16, 1);
        return;
    end

    -- Quantity check
    if @ProdQty < 0
    begin
        raiserror('Product quantity cannot be negative', 16, 1);
        return;
    end

    -- Category existence checks
    if not exists (select 1 from tblCategory where CatID = @ProdCatID)
    begin
        raiserror('Selected category does not exist.', 16, 1);
        return;
    end

    -- Duplicate check
    if exists (select 1 from tblProduct where ProdName = @ProdName and ProdCatID = @ProdCatID and ProdID <> @ProdID)
    begin
        raiserror('Product already exists in this category', 16, 1);
        return;
    end

    begin transaction
    begin try
        update tblProduct 
        set ProdName = @ProdName,
            ProdCatID = @ProdCatID,
            ProdPrice = @ProdPrice,
            ProdQty = @ProdQty
        where ProdID = @ProdID;

        commit transaction;
    end try

    begin catch
        rollback transaction;
        throw;
    end catch
end
go

-- spDeleteProduct procedure changes
alter procedure spDeleteProduct
(
    @ProdID int
)
as
begin
    if not exists (select 1 from tblProduct where ProdID = @ProdID)
    begin
        raiserror('Product does not exist.', 16, 1);
        return;
    end

    begin transaction
    begin try
        delete from tblProduct where ProdID = @ProdID;
        commit transaction;
    end try

    begin catch
        rollback transaction;
        throw;
    end catch;
end
go

-- Bill table changes
alter table tblBill
drop column totalAmt

alter table tblBill
alter column SellerID int not null;

alter table tblBill
alter column SellDate datetime not null;

alter table tblBill 
add newBillID int identity(1,1);

alter table tblBill
drop constraint PK__tblBill__CF6E7D43CFBB0F34;

alter table tblBill
add constraint PK_tblBill primary key (newBillID)

alter table tblBill
drop column Bill_ID

exec sp_rename 'tblBill.NewBillID', 'Bill_ID', 'COLUMN';

alter table tblBill
add constraint FK_tblBill_Seller
foreign key (SellerID) references tblSeller(SellerID);

-- Creating bill details table
create table tblBillDetails
(
    BillDetailID int identity(1,1) primary key,
    Bill_ID int not null,
    ProdID int not null,
    Quantity int not null check (Quantity > 0),
    Price decimal(10, 2) not null check (Price >= 0),
    foreign key (Bill_ID) references tblBill(Bill_ID),
    foreign key (ProdID) references tblProduct(ProdID)
)

-- spInsertBill changes
alter procedure spInsertBill
(
    @SellerID int,
    @SellDate datetime,
    @Bill_ID int output
)
as
begin
    --Validate if seller actually exists
    if not exists(select 1 from tblSeller where SellerID = @SellerID)
    begin
        raiserror('Seller does not exist', 16, 1);
        return;
    end

    begin transaction
    begin try
        insert into tblBill(SellerID, SellDate)
        values (@SellerID, @SellDate)

        set @Bill_ID = SCOPE_IDENTITY();

        commit transaction;
    end try

    begin catch
        rollback transaction;
        throw;
    end catch
end
go

CREATE OR ALTER PROCEDURE spInsertBillDetails
(
    @Bill_ID int,
    @ProdID int,
    @Quantity int,
    @Price decimal(10,2)
)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM tblBill WHERE Bill_ID = @Bill_ID)
    BEGIN
        RAISERROR('Bill does not exist.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM tblProduct WHERE ProdID = @ProdID)
    BEGIN
        RAISERROR('Product does not exist.', 16, 1);
        RETURN;
    END

    IF @Quantity <= 0
    BEGIN
        RAISERROR('Quantity must be greater than 0.', 16, 1);
        RETURN;
    END

    IF @Price < 0
    BEGIN
        RAISERROR('Price cannot be negative.', 16, 1);
        RETURN;
    END

    BEGIN TRANSACTION
    BEGIN TRY
        INSERT INTO tblBillDetails (Bill_ID, ProdID, Quantity, Price)
        VALUES (@Bill_ID, @ProdID, @Quantity, @Price);
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        THROW
    END CATCH
END
GO


alter PROCEDURE spInsertBill
    @SellerID INT,
    @SellDate DATETIME,
    @Bill_ID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO tblBill (SellerID, SellDate)
    VALUES (@SellerID, @SellDate);

    -- Return the new Bill_ID
    SET @Bill_ID = SCOPE_IDENTITY();
END

alter PROCEDURE spInsertBillDetails
    @Bill_ID INT,
    @ProdID INT,
    @Quantity INT,
    @Price DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    -- Basic validation
    IF @Quantity <= 0
    BEGIN
        RAISERROR('Quantity must be greater than 0', 16, 1);
        RETURN;
    END

    IF @Price < 0
    BEGIN
        RAISERROR('Price must be non-negative', 16, 1);
        RETURN;
    END

    INSERT INTO tblBillDetails (Bill_ID, ProdID, Quantity, Price)
    VALUES (@Bill_ID, @ProdID, @Quantity, @Price);
END


-- Gemini try
alter procedure spInsertBill
(
    @SellerID int,
    @SellDate datetime
)
as
begin
    set nocount on;
    
    -- Seller Existence Check (Crucial for Foreign Key integrity)
    if not exists (select 1 from tblSeller where SellerID = @SellerID)
    begin
        raiserror('Invalid SellerID: Seller does not exist.', 16, 1);
        return -1; -- Use a return value to indicate failure
    end

    begin transaction
    begin try
        insert into tblBill (SellerID, SellDate) 
        values (@SellerID, @SellDate);
        
        -- Return the newly generated Bill_ID
        select SCOPE_IDENTITY() as NewBillID; 

        commit transaction;
    end try
    begin catch
        if @@TRANCOUNT > 0
            rollback transaction;
        -- Re-throw the error
        throw; 
    end catch
    
    return 0; -- Return 0 on success
end
go

create procedure spGetSellerID
(
    @SellerName nvarchar(50)
)
as
begin
    set nocount on;
    -- Returns the SellerID. If the name does not exist, it returns NULL or an empty result set.
    select SellerID from tblSeller where SellerName = @SellerName;
end
go

create procedure spInsertBillDetail
(
    @Bill_ID int,
    @ProdID int,
    @Quantity int,
    @Price decimal(10, 2)
)
as
begin
    set nocount on;
    
    -- Validation Checks (based on table constraints)
    if @Quantity <= 0
    begin
        raiserror('Quantity must be greater than zero.', 16, 1);
        return;
    end
    
    if @Price < 0
    begin
        raiserror('Price cannot be negative.', 16, 1);
        return;
    end
    
    -- Foreign Key Existence Checks
    if not exists (select 1 from tblBill where Bill_ID = @Bill_ID)
    begin
        raiserror('Bill ID does not exist.', 16, 1);
        return;
    end
    
    if not exists (select 1 from tblProduct where ProdID = @ProdID)
    begin
        raiserror('Product ID does not exist.', 16, 1);
        return;
    end
    
    begin transaction
    begin try
        insert into tblBillDetails (Bill_ID, ProdID, Quantity, Price)
        values (@Bill_ID, @ProdID, @Quantity, @Price);
        
        -- Optional: Add logic here to update the quantity (ProdQty) in tblProduct
        
        commit transaction;
    end try
    begin catch
        if @@TRANCOUNT > 0
            rollback transaction;
        throw;
    end catch
end
go


----trying

create or alter procedure spInsertBill
    @SellerID int,
    @SellDate datetime
as
begin
    set nocount on;

    -- validate seller
    if not exists (select 1 from tblSeller where SellerID = @SellerID)
    begin
        raiserror('Invalid Seller ID', 16, 1);
        return;
    end

    insert into tblBill (SellerID, SellDate)
    values (@SellerID, @SellDate);

    -- return generated Bill_ID
    select scope_identity() as Bill_ID;
end

create or alter procedure spAddBillItem
    @Bill_ID int,
    @ProdID int,
    @Quantity int,
    @Price decimal(10,2)
as
begin
    set nocount on;

    if not exists (select 1 from tblBill where Bill_ID = @Bill_ID)
    begin
        raiserror('Invalid Bill ID', 16, 1);
        return;
    end

    if not exists (select 1 from tblProduct where ProdID = @ProdID)
    begin
        raiserror('Invalid Product ID', 16, 1);
        return;
    end

    if @Quantity <= 0 or @Price < 0
    begin
        raiserror('Invalid quantity or price', 16, 1);
        return;
    end

    insert into tblBillDetails (Bill_ID, ProdID, Quantity, Price)
    values (@Bill_ID, @ProdID, @Quantity, @Price);
end

create or alter procedure spGetBillList
as
begin
    set nocount on;

    select
        b.Bill_ID,
        s.Username as Seller,
        b.SellDate,
        isnull(sum(d.Quantity * d.Price), 0) as TotalAmt
    from tblBill b
    join tblSeller s on s.SellerID = b.SellerID
    left join tblBillDetails d on d.Bill_ID = b.Bill_ID
    group by b.Bill_ID, s.Username, b.SellDate
    order by b.Bill_ID desc;
end
    
--- Customer table
create table tblCustomer
(
    CustomerID int identity(1,1) primary key,
    CustomerName nvarchar(50) not null,
    Phone nvarchar(15) not null,
    Email nvarchar(50) not null,
    Address nvarchar(100) not null,
    CreatedDate datetime default getdate()
);

-- Procedures


exec sp_rename 'tblCustomer.Phone', 'CustomerPhone', 'COLUMN'

exec sp_rename 'tblCustomer.Email', 'CustomerEmail', 'COLUMN'

exec sp_rename 'tblCustomer.Address', 'CustomerAddress', 'COLUMN'

CREATE PROCEDURE spCustomerInsert
    @CustomerName NVARCHAR(50),
    @CustomerPhone NVARCHAR(15),
    @CustomerEmail NVARCHAR(50),
    @CustomerAddress NVARCHAR(100)
AS
BEGIN
    -- Check if customer already exists
    IF EXISTS (SELECT 1 FROM tblCustomer WHERE CustomerName = @CustomerName)
    BEGIN
        PRINT 'Customer Name already exists';
        RETURN;
    END

    -- Insert customer
    INSERT INTO tblCustomer (CustomerName, CustomerPhone, CustomerEmail, CustomerAddress)
    VALUES (@CustomerName, @CustomerPhone, @CustomerEmail, @CustomerAddress)
END

alter PROCEDURE spCustomerUpdate
    @CustomerID INT,
    @CustomerName NVARCHAR(100),
    @CustomerPhone NVARCHAR(20),
    @CustomerEmail NVARCHAR(100),
    @CustomerAddress NVARCHAR(200)
AS
BEGIN

    BEGIN TRY
        -- Checks
        IF NOT EXISTS (SELECT 1 FROM tblCustomer WHERE CustomerID = @CustomerID)
            THROW 50003, 'Customer ID does not exist', 1;

        IF EXISTS (SELECT 1 FROM tblCustomer WHERE CustomerName = @CustomerName AND CustomerID <> @CustomerID)
            THROW 50004, 'Customer Name already exists for another record', 1;

        -- Update
        UPDATE tblCustomer
        SET CustomerName = @CustomerName,
            CustomerPhone = @CustomerPhone,
            CustomerEmail = @CustomerEmail,
            CustomerAddress = @CustomerAddress
        WHERE CustomerID = @CustomerID;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END

-- History tables

create table tblCustomerHistory
(
    HistoryID int identity(1,1) primary key,
    CustomerID int,
    CustomerName nvarchar(100),
    CustomerPhone nvarchar(20),
    CustomerEmail nvarchar(100),
    CustomerAddress nvarchar(200),

    ActionType nvarchar(10),
    ActionDate datetime default getdate()
)

-- Triggers
create trigger trg_Customer_Insert
on tblCustomer
after insert
as
begin
    insert into tblCustomerHistory
    (
        CustomerID,
        CustomerName,
        CustomerPhone,
        CustomerEmail,
        CustomerAddress,
        ActionType
    )
    select
        CustomerID,
        CustomerName,
        CustomerPhone,
        CustomerEmail,
        CustomerAddress,
        'INSERT'
    from inserted;
end;

create trigger trg_customer_update
on tblCustomer
after update
as
begin
    insert into tblCustomerHistory
    (
        CustomerID,
        CustomerName,
        CustomerPhone,
        CustomerEmail,
        CustomerAddress,
        ActionType,
        ActionDate
    )
    select
        CustomerID,
        CustomerName,
        CustomerPhone,
        CustomerEmail,
        CustomerAddress,
        'update',
        getdate()
    from inserted;
end;

create trigger trg_customer_delete
on tblCustomer
after delete
as
begin
    insert into tblCustomerHistory
    (
        CustomerID,
        CustomerName,
        CustomerPhone,
        CustomerEmail,
        CustomerAddress,
        ActionType,
        ActionDate
    )
    select
        CustomerID,
        CustomerName,
        CustomerPhone,
        CustomerEmail,
        CustomerAddress,
        'delete',
        getdate()
    from deleted;
end;

-- Seller history table
create table tblSellerHistory
(
    historyID int identity(1,1) primary key,
    sellerID int,
    sellerName varchar(100),
    sellerAge int,
    sellerPhone varchar(20),
    sellerPass varchar(50),
    actionType varchar(10),  
    actionDate datetime default getdate()
)

create trigger trg_seller_insert
on tblSeller
after insert
as
begin
    insert into tblSellerHistory (sellerID, sellerName, sellerAge, sellerPhone, sellerPass, actionType)
    select sellerID, sellerName, sellerAge, sellerPhone, sellerPass, 'INSERT'
    from inserted
end

create trigger trg_seller_update
on tblSeller
after update
as
begin
    insert into tblSellerHistory (sellerID, sellerName, sellerAge, sellerPhone, sellerPass, actionType)
    select sellerID, sellerName, sellerAge, sellerPhone, sellerPass, 'UPDATE'
    from inserted
end

create trigger trg_seller_delete
on tblSeller
after delete
as
begin
    insert into tblSellerHistory (sellerID, sellerName, sellerAge, sellerPhone, sellerPass, actionType)
    select sellerID, sellerName, sellerAge, sellerPhone, sellerPass, 'DELETE'
    from deleted
end

-- Customer history table
create table tblProductHistory
(
    historyID int identity(1,1) primary key,
    productID int,
    productName varchar(100),
    categoryID int,
    price decimal(18,2),
    quantity int,
    actionType varchar(10), 
    actionDate datetime default getdate(),
    performedBy varchar(50)
)

create trigger tr_product_insert
on tblProduct
after insert
as
begin
    insert into tblProductHistory(productID, productName, categoryID, price, quantity, actionType)
    select 
        i.prodID,
        i.prodName,
        i.prodCatID,
        i.prodPrice,
        i.prodQty,
        'Insert'
    from inserted i
end

create trigger tr_product_update
on tblProduct
after update
as
begin
    insert into tblProductHistory(productID, productName, categoryID, price, quantity, actionType)
    select 
        i.prodID,
        i.prodName,
        i.prodCatID,
        i.prodPrice,
        i.prodQty,
        'Update'
    from inserted i
end

create trigger tr_product_delete
on tblProduct
after delete
as
begin
    insert into tblProductHistory(productID, productName, categoryID, price, quantity, actionType)
    select 
        d.prodID,
        d.prodName,
        d.prodCatID,
        d.prodPrice,
        d.prodQty,
        'Delete'
    from deleted d
end

