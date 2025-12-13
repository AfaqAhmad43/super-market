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


-- Changes to category table
-- Checks for the Seller 
alter procedure spSellerInsert
@SellerName nvarchar(50),
@SellerAge int, 
@SellerPhone nvarchar(50),
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
    --Validation for the Seller Age 
    if @SellerAge  is null
    begin
        raiserror('Seller  Age   cannot be empty', 16, 1);
        return;
    end
      

    --Validation for the Seller Phone 
       if @SellerPhone  is null
    begin
        raiserror('Seller Phone Number is Must ', 16, 1);
        return;
    end
       if LEN(@SellerPhone)  >50
    begin
        raiserror('Seller  Phone Number Cannot be Greater then the 50 ', 16, 1);
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
-- Checks for the Updating Seller 
-- Checks for the Updating Seller 
-- Checks for the Updating Seller 
go

alter procedure spSellerUpadte
(
@SellerID int,
@SellerName nvarchar(50),
@SellerAge int, 
@SellerPhone nvarchar(50),
@SellerPass nvarchar(50)
)
as
begin
    
    if not exists(select 1 from tblSeller where SellerID = @SellerID)
    begin
        raiserror('Seller ID does not exist. Cannot update.', 16, 1);
        return;
    end

    -- Validation for Seller Name (ADDED)
    if @SellerName is null
    begin
        raiserror('Seller Name cannot be empty.', 16, 1);
        return;
    end

    if LEN(@SellerName) > 50
    begin
        raiserror('SellerName cannot be more than 50 characters.', 16, 1);
        return;
    end
    
    -- Validation for Seller Age (ADDED)
    if @SellerAge is null
    begin
        raiserror('Seller Age cannot be empty.', 16, 1);
        return;
    end
    
    -- Validation for Seller Phone (ADDED)
    if @SellerPhone is null
    begin
        raiserror('Seller Phone Number is Must.', 16, 1);
        return;
    end

    if LEN(@SellerPhone) > 50
    begin
        raiserror('Seller Phone Number Cannot be Greater than 50.', 16, 1);
        return;
    end

    -- Validation for Seller Password (ADDED)
    if @SellerPass is null
    begin
        raiserror('Seller Password Cannot be Empty.', 16, 1);
        return;
    end

    if LEN(@SellerPass) > 50
    begin
        raiserror('Seller Password Cannot be Greater than 50.', 16, 1);
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