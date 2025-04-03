Use QLSACH
-- baitaptuan4
-- câu 1
select distinct Products.ProductID, ProductName, OrderDetails.UnitPrice
from Products
join OrderDetails on Products.ProductID = OrderDetails.ProductID
where OrderDetails.UnitPrice > (select AVG(UnitPrice) from OrderDetails)

-- câu 2
INSERT INTO Products (ProductID, ProductName, UnitPrice, UnitInStock) VALUES
    (101, 'Nước ép cam', 30, 50),
    (102, 'Nước khoáng', 25, 100),
    (103, 'Nho khô', 35, 30)
INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate) VALUES
    (5001, 1, 2, '1998-01-15'),
    (5002, 2, 3, '1998-02-10'),
    (5003, 3, 1, '1998-03-05')
INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity) VALUES
    (5001, 101, 30, 10), 
    (5002, 102, 25, 15),  
    (5003, 103, 35, 20)
select * from Orders
select AVG(UnitPrice) from OrderDetails

INSERT INTO Products (ProductID, ProductName, UnitPrice, UnitInStock) VALUES
    (104, 'Nước trái cây', 80, 100),
    (105, 'Nước ép dứa', 100, 200),
    (106, 'Nước ép cam', 140, 150)
INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate) VALUES
    (5004, 4, 2, '1998-04-12'),
    (5005, 5, 3, '1998-05-15'),
    (5006, 6, 1, '1998-06-20');

INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity) VALUES
    (5004, 104, 60, 10),
    (5005, 105, 50, 15),
    (5006, 106, 40, 20)

select distinct Products.ProductID, ProductName, OrderDetails.UnitPrice
from Products
join OrderDetails on Products.ProductID = OrderDetails.ProductID
where OrderDetails.UnitPrice > (select AVG(UnitPrice) from OrderDetails)
and Products.ProductName like 'N%' 

-- câu 3
select distinct Products.ProductID, ProductName, OrderDetails.UnitPrice
from Products
join OrderDetails on Products.ProductID = OrderDetails.ProductID
where Products.ProductName like 'N%' 
and OrderDetails.UnitPrice > (
	select max(UnitPrice) from OrderDetails
	where ProductID != Products.ProductID)

-- câu 4
select distinct Products.ProductID, ProductName, OrderDetails.UnitPrice
from Products
join OrderDetails on Products.ProductID = OrderDetails.ProductID

-- câu 5
ALTER TABLE Products ADD PurchasePrice DECIMAL(10,2)

UPDATE Products
SET PurchasePrice = UnitPrice * 0.8

select distinct Products.ProductID, PurchasePrice, OrderDetails.UnitPrice
from Products
join OrderDetails on Products.ProductID = OrderDetails.ProductID
where Products.PurchasePrice> (select Min(UnitPrice) from OrderDetails)

-- câu 6
SELECT Orders.OrderID, Orders.CustomerID, Customers.CompanyName, Orders.OrderDate
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Customers.City IN ('London', 'Madrid')

select * from customers

-- câu 7
SELECT ProductID, ProductName, UnitPrice, PurchasePrice 
FROM Products
WHERE UnitPrice LIKE '%Box%' 
AND PurchasePrice < (SELECT AVG(UnitPrice) FROM Products)

-- câu 8
SELECT Products.ProductID, ProductName, SUM(OrderDetails.Quantity) AS TotalSold
FROM Products
JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY Products.ProductID, ProductName
HAVING SUM(OrderDetails.Quantity) = (
    SELECT MAX(TotalQuantity) 
    FROM (
        SELECT SUM(Quantity) AS TotalQuantity 
        FROM OrderDetails 
        GROUP BY ProductID
    ) AS SubQuery
);
-- câu 9
SELECT * FROM Customers 
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.CustomerID IS NULL

-- câu 10
ALTER TABLE Products ADD Package VARCHAR(50)

UPDATE Products SET Package = '12-Box' WHERE ProductID = 1;
UPDATE Products SET Package = '24-Box' WHERE ProductID = 2;

INSERT INTO Products (ProductID, ProductName, UnitPrice, UnitInStock, Package) VALUES
    (201, 'Trà xanh hộp', 50, 100, '12-Box'),
    (202, 'Cà phê sữa hộp', 60, 150, '24-Box'),
    (203, 'Bánh quy hộp', 45, 200, '6-Box'),
    (204, 'Nước ép trái cây', 70, 80, 'Bottle'),
    (205, 'Kẹo hộp', 65, 120, '12-Box');

SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice = (SELECT MAX(UnitPrice) FROM Products)
AND Package LIKE '%Box%';

-- câu 11
SELECT ProductID, ProductName, UnitPrice 
FROM Products
WHERE UnitPrice > (
    SELECT AVG(UnitPrice) FROM Products WHERE ProductID <= 5
);

-- câu 12
SELECT P.ProductID, P.ProductName, SUM(O.Quantity) AS TotalSold
FROM Products P
JOIN OrderDetails O ON P.ProductID = O.ProductID
GROUP BY P.ProductID, P.ProductName
HAVING SUM(O.Quantity) > (SELECT AVG(TotalQuantity) FROM (
    SELECT SUM(Quantity) AS TotalQuantity FROM OrderDetails GROUP BY ProductID
) AS SubQuery);

-- câu 13
SELECT DISTINCT C.CustomerID, C.CompanyName 
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
WHERE NOT EXISTS (
    SELECT 1 FROM OrderDetails 
    WHERE OrderDetails.OrderID = O.OrderID AND ProductID < 3
);

-- câu 14
SELECT P.ProductID, P.ProductName, COUNT(O.OrderID) AS OrderCount
FROM Products P
JOIN OrderDetails OD ON P.ProductID = OD.ProductID
JOIN Orders O ON OD.OrderID = O.OrderID
WHERE YEAR(O.OrderDate) = 1998 AND MONTH(O.OrderDate) BETWEEN 7 AND 9
GROUP BY P.ProductID, P.ProductName
HAVING COUNT(O.OrderID) > 20;

-- câu 15
SELECT * FROM Products
WHERE ProductID NOT IN (
    SELECT DISTINCT ProductID FROM OrderDetails
    JOIN Orders ON OrderDetails.OrderID = Orders.OrderID
    WHERE YEAR(OrderDate) = 1996 AND MONTH(OrderDate) = 6
);

-- câu 16
SELECT * FROM Employees
WHERE EmployeeID NOT IN (
    SELECT DISTINCT EmployeeID FROM Orders
    WHERE OrderDate = CAST(GETDATE() AS DATE)
);

-- câu 17
SELECT * FROM Customers
WHERE CustomerID NOT IN (
    SELECT DISTINCT CustomerID FROM Orders
    WHERE YEAR(OrderDate) = 1997
);

-- câu 18
INSERT INTO Products (ProductID, ProductName, UnitPrice, UnitInStock, Package) 
VALUES (210, 'Trà xanh', 50, 100, 'Box'), 
       (211, 'Táo đỏ', 30, 200, 'Box'); 
INSERT INTO Customers (CustomerID, CompanyName, City) 
VALUES (301, 'Công ty A', 'Hà Nội'),
       (302, 'Công ty B', 'TP.HCM');
INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate) 
VALUES (7101, 301, 1, '1998-07-10'),
       (7102, 302, 2, '1998-07-15');
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) 
VALUES (7001, 201, 10, 50), 
       (7002, 202, 15, 30);
SELECT DISTINCT C.CustomerID, C.CompanyName
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
WHERE P.ProductName LIKE 'T%' 
AND MONTH(O.OrderDate) = 7;

-- câu 19
INSERT INTO Customers (CustomerID, CompanyName, City) 
VALUES (303, 'Công ty C', 'Hà Nội'),
       (304, 'Công ty D', 'Hà Nội'),
       (305, 'Công ty E', 'Hà Nội') 

SELECT City, COUNT(CustomerID) AS TotalCustomers
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) > 3;

-- câu 20
-- Truy vấn 1: Câu hỏi: Liệt kê tất cả các sản phẩm có đơn giá lớn hơn tất cả các sản phẩm có tên bắt đầu bằng chữ 'B'.
-- Truy vấn 2: Câu hỏi: Liệt kê tất cả các sản phẩm có đơn giá lớn hơn ít nhất một sản phẩm có tên bắt đầu bằng chữ 'B'.
-- Truy vấn 3: Câu hỏi: Liệt kê tất cả các sản phẩm có đơn giá bằng với ít nhất một sản phẩm có tên bắt đầu bằng chữ 'B'.
-- Sự khác nhau giữa 3 câu truy vấn:
-- Câu truy vấn 1 (ALL): So sánh đơn giá của sản phẩm với tất cả các đơn giá của các sản phẩm có tên bắt đầu bằng 'B'. Chỉ những sản phẩm có giá lớn hơn tất cả các sản phẩm bắt đầu bằng 'B' mới được liệt kê.
-- Câu truy vấn 2 (ANY): So sánh đơn giá của sản phẩm với ít nhất một trong số các đơn giá của các sản phẩm có tên bắt đầu bằng 'B'. Chỉ cần có một sản phẩm có đơn giá nhỏ hơn đơn giá của sản phẩm cần tìm thì sản phẩm đó sẽ được liệt kê.
-- Câu truy vấn 3 (ANY): Tương tự như câu 2, nhưng thay vì kiểm tra "lớn hơn", câu truy vấn này kiểm tra xem đơn giá của sản phẩm có bằng với đơn giá của ít nhất một sản phẩm bắt đầu bằng 'B'.
