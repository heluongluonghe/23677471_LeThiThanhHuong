USE QLSACH
-- câu 1
SELECT Orders.OrderID, OrderDate, 
       SUM(OrderDetails.Quantity * OrderDetails.UnitPrice) AS TotalAccount
FROM Orders
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY Orders.OrderID, Orders.OrderDate


-- câu 2 
SELECT Orders.OrderID, OrderDate, 
       SUM(OrderDetails.Quantity * OrderDetails.UnitPrice) AS TotalAccount
FROM Orders
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Customers.City = 'Madrid'
GROUP BY Orders.OrderID, Orders.OrderDate

INSERT INTO Customers (CustomerID, CompanyName, Address, City, Region, Country) 
VALUES (10, 'Cửa hàng Madrid', '123 Đường Madrid', 'Madrid', 'Tây Ban Nha', 'Spain')

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate) 
VALUES (2001, 10, 1, '2024-03-30')

INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount) 
VALUES (2001, 1, 15.00, 5, 0.1)

-- câu 3
WITH ProductTotals AS (
	select Products.ProductID, ProductName, SUM (OrderDetails.Quantity) AS COUNTOFORDERS
	from Products
	JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
	GROUP BY Products.ProductID, ProductName)

SELECT * FROM ProductTotals
WHERE CountOfOrders = (SELECT MAX(CountOfOrders) FROM ProductTotals)
-- câu 4
SELECT Customers.CustomerID, CompanyName, count (orders.OrderID) as COUNTOFORDERS
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerID, CompanyName

-- câu 5

select Employees.EmployeeID, LastName + ' ' + FirstName as EmployeeName,
Count (Orders.OrderID) as COUNTOFORDERS,
SUM(OrderDetails.Quantity * OrderDetails.UnitPrice) as TotalRevenue
from Employees
join Orders on Employees.EmployeeID = Orders.EmployeeID
join OrderDetails on Orders.OrderID = OrderDetails.OrderID
group by Employees.EmployeeID, Employees.LastName, Employees.FirstName

-- câu 6
SELECT Employees.EmployeeID, 
       Employees.LastName + ' ' + Employees.FirstName AS EmployeeName,
       MONTH(Orders.OrderDate) AS Month_Salary,
       SUM(OrderDetails.Quantity * OrderDetails.UnitPrice) * 0.1 AS Salary
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
WHERE YEAR(Orders.OrderDate) = 1996
GROUP BY Employees.EmployeeID, Employees.LastName, Employees.FirstName, MONTH(Orders.OrderDate)
ORDER BY Month_Salary, Salary DESC

-- câu 7
select Customers.CustomerID, CompanyName,
sum (OrderDetails.Quantity * OrderDetails.UnitPrice) as TotalAmount
from Customers
join orders on Customers.CustomerID = Orders.CustomerID
join OrderDetails on Orders.OrderID = OrderDetails.OrderID
where orders.OrderDate between '1996-12-31' AND '1998-01-01'
group by Customers.CustomerID, CompanyName
having sum (OrderDetails.Quantity * OrderDetails.UnitPrice)> 20000

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate)
VALUES 
    (3001, 1, 1, '1996-12-31'),
    (3002, 2, 2, '1997-01-05'),
    (3003, 3, 3, '1997-06-10'),
    (3004, 4, 4, '1997-12-30'),
    (3005, 5, 5, '1998-01-01')
INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES
    (3001, 1, 150.00, 100, 0.05), 
    (3001, 2, 200.00, 100, 0.02),  
    (3002, 3, 50.00, 300, 0.01),  
    (3002, 4, 250.00, 50, 0.00),   
    (3003, 5, 100.00, 150, 0.00),  
    (3003, 6, 80.00, 200, 0.05),   
    (3004, 1, 120.00, 180, 0.03),  
    (3005, 3, 90.00, 250, 0.01)

-- câu 8
SELECT Customers.CustomerID, Customers.CompanyName, 
       COUNT(Orders.OrderID) AS TotalOrders, 
       SUM(OrderDetails.Quantity * OrderDetails.UnitPrice) AS TotalAmount
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
WHERE Orders.OrderDate BETWEEN '1996-12-31' AND '1998-01-01'
GROUP BY Customers.CustomerID, Customers.CompanyName
HAVING SUM(OrderDetails.Quantity * OrderDetails.UnitPrice) > 20000
ORDER BY Customers.CustomerID ASC, TotalAmount DESC

-- câu 9
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL)
ALTER TABLE Products ADD CategoryID INT
ALTER TABLE Products ADD CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
INSERT INTO Products (ProductID, ProductName, UnitPrice, UnitInStock, CategoryID) VALUES
    (667,'Bánh quy', 15, 500, 1),
    (668, 'Sữa tươi', 20, 100, 4),
    (669, 'Trà xanh', 10, 200, 2),
    (670, 'Cà phê', 30, 150, 2),
    (671, 'Matcha Latte', 22, 120, 2),
    (672, 'Bánh bao đường', 18, 400, 1)

SELECT Categories.CategoryID, Categories.CategoryName, 
       SUM(Products.UnitInStock) AS Total_UnitsInStock, 
       AVG(Products.UnitPrice) AS Average_UnitPrice
FROM Categories
JOIN Products ON Categories.CategoryID = Products.CategoryID
GROUP BY Categories.CategoryID, Categories.CategoryName
HAVING SUM(Products.UnitInStock) > 300 
   AND AVG(Products.UnitPrice) < 25

-- câu 10
SELECT Categories.CategoryID, Categories.CategoryName, 
       COUNT(Products.ProductID) AS TotalOfProducts
FROM Categories
LEFT JOIN Products ON Categories.CategoryID = Products.CategoryID
GROUP BY Categories.CategoryID, Categories.CategoryName
HAVING COUNT(Products.ProductID) < 10
ORDER BY Categories.CategoryName ASC, TotalOfProducts DESC

-- câu 11
SELECT Products.ProductID, Products.ProductName, 
       SUM(OrderDetails.Quantity) AS SumOfQuantity
FROM OrderDetails
JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
WHERE YEAR(Orders.OrderDate) = 1998 
      AND MONTH(Orders.OrderDate) BETWEEN 1 AND 3
GROUP BY Products.ProductID, Products.ProductName
HAVING SUM(OrderDetails.Quantity) > 200

INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate)
VALUES (7001, 1, 2, '1998-01-15'), (7002, 2, 3, '1998-02-20')


INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES 
    (7001, 1, 150, 20.00), 
    (7001, 2, 100, 25.00), 
    (7002, 3, 120, 30.00)

-- câu 12
select Customers.CustomerID, CompanyName,
format (orders.OrderDate, 'MM-yyyy') as Month_Year,
sum (OrderDetails.Quantity * OrderDetails.UnitPrice) as Total
from Customers
join Orders on Customers.CustomerID = Orders. CustomerID
join OrderDetails on Orders.OrderID = OrderDetails.OrderID
GROUP BY Customers.CustomerID, CompanyName, FORMAT(Orders.OrderDate, 'MM-yyyy')

-- câu 13
INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate)
VALUES (1111, 1, 1, '1997-07-05'),
       (1112, 2, 2, '1997-07-15'),
       (1113, 3, 3, '1997-07-20'),
       (1114, 1, 1, '1997-07-25')
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES (1111, 1, 10, 50), 
       (1112, 2, 20, 40),
       (1113, 3, 15, 60),
       (1114, 1, 25, 30)

SELECT TOP 1 Employees.EmployeeID, Employees.LastName, Employees.FirstName, 
       SUM(OrderDetails.Quantity * OrderDetails.UnitPrice) AS TotalSales
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
WHERE YEAR(Orders.OrderDate) = 1997 AND MONTH(Orders.OrderDate) = 7
GROUP BY Employees.EmployeeID, Employees.LastName, Employees.FirstName

-- câu 14
INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate)
VALUES (3001, 1, 2, '1996-03-10'),
       (3002, 2, 3, '1996-06-15'),
       (3003, 3, 4, '1996-09-20'),
       (3004, 1, 2, '1996-11-05'),
       (3005, 2, 3, '1996-12-12'),
       (3006, 3, 4, '1996-12-25'),
       (3007, 1, 2, '1996-04-08'),
       (3008, 1, 2, '1996-07-14'),
       (3009, 2, 3, '1996-10-30')
SELECT TOP 3 Customers.CustomerID, Customers.CompanyName, 
       COUNT(Orders.OrderID) AS NumberOfOrders
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE YEAR(Orders.OrderDate) = 1996
GROUP BY Customers.CustomerID, Customers.CompanyName

-- câu 15
INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate)
VALUES (4001, 1, 2, '1997-03-05'),
       (4002, 2, 3, '1997-03-10'),
       (4003, 3, 4, '1997-03-15'),
       (4004, 4, 2, '1997-03-20'),
       (4005, 5, 3, '1997-03-25')
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES (4001, 1, 50, 100), 
       (4002, 2, 30, 120), 
       (4003, 3, 60, 80),   
       (4004, 4, 40, 110),  
       (4005, 5, 20, 200) 
SELECT Employees.EmployeeID, Employees.LastName, Employees.FirstName, 
       COUNT(Orders.OrderID) AS CountOfOrderID, 
       SUM(OrderDetails.Quantity * OrderDetails.UnitPrice) AS SumOfTotal
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
WHERE YEAR(Orders.OrderDate) = 1997 AND MONTH(Orders.OrderDate) = 3
GROUP BY Employees.EmployeeID, Employees.LastName, Employees.FirstName
HAVING SUM(OrderDetails.Quantity * OrderDetails.UnitPrice) > 4000