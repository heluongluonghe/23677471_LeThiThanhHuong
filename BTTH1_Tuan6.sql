CREATE DATABASE QLSACH
go
USE QLSACH

CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL)

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    SupplierID INT,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    UnitInStock INT NOT NULL,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID))


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CompanyName VARCHAR(100) NOT NULL,
    Address VARCHAR(200),
    City VARCHAR(50),
    Region VARCHAR(50),
    Country VARCHAR(50))

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    LastName VARCHAR(50) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    BirthDate DATE,
    City VARCHAR(50))


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    EmployeeID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID))

CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    Discount DECIMAL(5, 2),
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID))

INSERT INTO Suppliers (SupplierID, SupplierName) values
    (1, 'Công ty TNHH Thanh Hương'),
    (2, 'Công ty CP Huyền Nga'),
    (3, 'Công ty tư nhân Ánh Dương'),
	(4, 'Công ty gia đình Ba Chị Em'),
	(5, 'Công ty Hai Đứa Mình'),
	(6, 'Công ty DHTMDT19C')


INSERT INTO Products (ProductID, ProductName, SupplierID, UnitPrice, UnitInStock) values
    (1, 'Bánh quy', 1, 15.00, 60),
    (2, 'Sữa tươi', 2, 20.00, 40),
    (3, 'Trà xanh', 3, 25.00, 86),
    (4, 'Cà phê', 4, 30.00, 90),
    (5, 'Matcha Latte', 5, 12.00, 20),
	(6, 'Bánh bao đường', 6, 6.00, 35)


INSERT INTO Customers (CustomerID, CompanyName, Address, City, Region, Country) values 
    (1, 'Cửa hàng bách hóa An Hoa', '123 Đường Lê Lợi', 'TPHCM', 'Miền Nam', 'Việt Nam'),
    (2, 'Tiệm bánh kem Su Su', '456 Đường Nguyễn Huệ', 'Hội An', 'Miền Trung', 'Việt Nam'),
    (3, 'Quán trà sữa Hoàng Gia', '789 Đường Trần Phú', 'Vũng Tàu', 'Miền Nam', 'Việt Nam'),
    (4, 'Salt Cafe Small Alley', '101 Collins Street', 'Melbourne', 'Victoria', 'Australia'),
    (5, 'Nana Restaurant', '2/87 Baker Street', 'Manchester', 'North West', 'UK'),
	(6, 'Cơm chiên Gà Ác Xanh', 'Số 2 Đường Láng', 'Hà Nội', 'Miền Bắc', 'Việt Nam')

INSERT INTO Employees (EmployeeID, LastName, FirstName, BirthDate, City) values
    (1, 'Lê', 'Thái An', '1958-04-12', 'Hà Nội'),
    (2, 'Trần', 'Hưng Thịnh', '1965-09-25', 'TP HCM'),
    (3, 'Hứa', 'Quang Hán', '1980-11-03', 'Đà Nẵng'),
    (4, 'Chương', 'Hồng Ngọc', '1995-07-15', 'Quy Nhơn'),
    (5, 'Trịnh', 'Trần Phương Tuấn', '1997-04-11', 'Bến Tre'),
    (6, 'Cao', 'Thái Lai', '2005-03-29', 'Biên Hòa')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate) VALUES
    (1001,1, 1, '1997-5-9'),
    (1002,2, 2, '1997-7-11'),
    (1003,3, 3, '1997-7-14'),
    (1004,4, 4, '1997-4-15'),
    (1005,5, 5, '1997-6-17'),
    (1006,6, 6, '1997-7-19')

INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount) VALUES
    (1001, 1, 15.00, 10, 0.05),
    (1002, 2, 20.00, 8, 0.01),
    (1003, 3, 25.00, 7, 0.01),
    (1004, 4, 30.00, 12, 0.02),
    (1005, 5, 12.00, 5, 0),
    (1006, 6, 16.00, 4, 0)
-- câu 1
Select Customers.CustomerID ,CompanyName, Address, OrderID, OrderDate
from Customers, Orders
where Customers.CustomerID = orders.CustomerID
and year (OrderDate) = 1997 and MONTH (orderdate) = 7
order by CustomerID , orderDate desc

-- câu 2 (xíu thêm dữ liệu)
use QLSACH
INSERT INTO Orders(OrderID, CustomerID, EmployeeID, OrderDate) VALUES
    (1007,1, 1, '1997-7-1'),
    (1008,2, 2, '1997-7-2'),
    (1009,3, 3, '1997-7-15')
INSERT INTO Orders(OrderID, CustomerID, EmployeeID, OrderDate) VALUES
    (1010,4, 1, '1997-01-6'),
    (1011,6, 5, '1997-01-21'),
    (1012,5, 4, '1997-01-13')

Select Customers.CustomerID ,CompanyName, Address, OrderID, OrderDate
from Customers, Orders
where Customers.CustomerID = Orders.CustomerID
and OrderDate between '1997-01-01' and '1997-01-15'
order by CustomerID, OrderDate desc

-- câu 3

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate) VALUES
    (1013,4, 4, '1996-07-16'),
    (1014,5, 5, '1996-07-16'),
    (1015,6, 6, '1996-07-16')
INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount) VALUES
    (1013, 1, 15.00, 10, 0.05),
    (1014, 2, 20.00, 8, 0.01),
    (1015, 3, 25.00, 7, 0.01)

select Products.ProductID, ProductName
from Products, OrderDetails, Orders
where Products.ProductID = OrderDetails.ProductID
And OrderDetails.OrderID = Orders.OrderID
And OrderDate = '1996-07-16'

-- câu 4

SELECT Orders.OrderID, CompanyName, OrderDate
FROM Customers, Orders
WHERE Customers.CustomerID = Orders.CustomerID
AND YEAR(OrderDate) = 1997
AND MONTH(OrderDate) IN (4, 9)
ORDER BY CompanyName, OrderDate DESC

-- câu 5
INSERT INTO Employees (EmployeeID, LastName, FirstName, BirthDate, City) values
    (7, 'Fuller', 'Thanh Xuân', '1958-04-12', 'Trà Vinh'),
    (8, 'Fuller', 'Thái Thịnh', '1965-09-25', 'Quảng Ngãi'),
    (9, 'Fuller', 'Quang Huy', '1980-11-03', 'Thái Nguyên')
INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate) VALUES
    (1016, 1, 7, '1997-07-16'),
    (1017, 2, 8, '1997-07-17'),
    (1018, 3, 9, '1997-07-18')
SELECT Orders.OrderID, Employees.LastName, Employees.FirstName, OrderDate
FROM Employees, Orders
WHERE Employees.EmployeeID = Orders.EmployeeID
AND LastName = 'Fuller'

-- câu 6 
SELECT Products.ProductID, ProductName, SupplierID
FROM Products, OrderDetails, Orders
WHERE Products.ProductID = OrderDetails.ProductID
AND OrderDetails.OrderID = Orders.OrderID
AND SupplierID IN (1, 3, 6)
AND YEAR(OrderDate) = 1997
AND MONTH(OrderDate) BETWEEN 4 AND 6
ORDER BY SupplierID, ProductID

-- câu 7
SELECT ProductID, ProductName
FROM Products
WHERE UnitPrice in (SELECT UnitPrice FROM OrderDetails WHERE Products.ProductID = OrderDetails.ProductID)

-- câu 8
INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate)
VALUES (10248, 1, 1, '1997-07-16')
INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES
    (10248, 1, 15.00, 10, 0.05),
    (10248, 2, 20.00, 5, 0.02)

SELECT Products.ProductID, ProductName
FROM Products, OrderDetails
WHERE Products.ProductID = OrderDetails.ProductID
AND OrderDetails.OrderID = 10248

-- câu 9
SELECT DISTINCT Employees.EmployeeID, LastName, FirstName
FROM Employees, Orders
WHERE Employees.EmployeeID = Orders.EmployeeID
AND YEAR(OrderDate) = 1996 AND MONTH(OrderDate) = 7

-- câu 10
INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate)
VALUES
    (10249, 1, 1, '1996-12-07'),
    (10250, 2, 2, '1996-12-01')
INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES
    (10249, 1, 15.00, 10, 0.05),
    (10250, 2, 20.00, 5, 0.02)

SELECT Products.ProductID, ProductName, Orders.OrderID, OrderDate, Customers.CustomerID, 
       OrderDetails.UnitPrice, Quantity, Quantity * OrderDetails.UnitPrice AS Total
FROM Products, OrderDetails, Orders, Customers
WHERE Products.ProductID = OrderDetails.ProductID
AND OrderDetails.OrderID = Orders.OrderID
AND Orders.CustomerID = Customers.CustomerID
AND YEAR(OrderDate) = 1996 AND MONTH(OrderDate) = 12
AND DATEPART(WEEKDAY, OrderDate) IN (7, 1)
ORDER BY ProductID, Quantity DESC
 
-- câu 11
SELECT Employees.EmployeeID, LastName + ' ' + FirstName AS EmployeeName, 
       Orders.OrderID, OrderDate, Products.ProductID, Quantity, OrderDetails.UnitPrice, 
       Quantity * OrderDetails.UnitPrice AS Total
FROM Employees, Orders, OrderDetails, Products
WHERE Employees.EmployeeID = Orders.EmployeeID
AND Orders.OrderID = OrderDetails.OrderID
AND OrderDetails.ProductID = Products.ProductID
AND YEAR(OrderDate) = 1996

-- câu 12
SELECT OrderID, OrderDate
FROM Orders
WHERE YEAR(OrderDate) = 1996 AND MONTH(OrderDate) = 12
AND DATEPART(WEEKDAY, OrderDate) = 7

-- câu 13
INSERT INTO Employees (EmployeeID, LastName, FirstName, BirthDate, City) 
VALUES (10, 'Nguyễn', 'Ngân Thanh', '1990-05-10', 'Kiên Giang')
SELECT Employees.EmployeeID, LastName, FirstName
FROM Employees
WHERE EmployeeID NOT IN (SELECT EmployeeID FROM Orders)

-- dùng left join
SELECT Employees.EmployeeID, Employees.LastName, Employees.FirstName
FROM Employees
LEFT JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
WHERE Orders.EmployeeID IS NULL

-- câu 14
INSERT INTO Products (ProductID, ProductName, SupplierID, UnitPrice, UnitInStock)
VALUES (7, 'Bánh tráng nướng', 2, 18.00, 50)
SELECT ProductID, ProductName
FROM Products
WHERE ProductID NOT IN (SELECT ProductID FROM OrderDetails)

SELECT Products.ProductID, Products.ProductName
FROM Products
LEFT JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
WHERE OrderDetails.ProductID IS NULL

-- câu 15
INSERT INTO Customers (CustomerID, CompanyName, Address, City, Region, Country)
VALUES (7, 'Tiệm Tạp Hóa Thanh Bình', '12 Nguyễn Văn Cừ', 'Đà Nẵng', 'Miền Trung', 'Việt Nam')
SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders)

SELECT Customers.CustomerID, Customers.CompanyName
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.CustomerID IS NULL
