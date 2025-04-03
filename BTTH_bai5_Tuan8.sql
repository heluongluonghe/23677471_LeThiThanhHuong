---- BÀI TẬP 5:
--- Câu 1:
SELECT 
    CAST(CustomerID AS NVARCHAR) AS CodeID, 
    CompanyName AS Name, 
    Address, 
    NULL AS Phone
FROM Customers
UNION ALL
SELECT 
    CAST(EmployeeID AS NVARCHAR) AS CodeID, 
    LastName + ' ' + FirstName AS Name, 
    NULL AS Address, 
    NULL AS Phone
FROM Employees;
--- Câu 2:
SELECT 
    Customers.CustomerID,
    Customers.CompanyName,
    Customers.Address,
    SUM(OrderDetails.Quantity * OrderDetails.UnitPrice) AS Total
INTO HDKH_71997
FROM Orders
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Orders.OrderDate BETWEEN '1997-07-01' AND '1997-07-31'
GROUP BY Customers.CustomerID, Customers.CompanyName, Customers.Address;
--- Câu 3:
SELECT 
    Employees.EmployeeID,
    Employees.LastName + ' ' + Employees.FirstName AS Name,
    Employees.City AS Address,
    SUM(OrderDetails.Quantity * OrderDetails.UnitPrice) AS Total
INTO LuongNV
FROM Orders
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE Orders.OrderDate BETWEEN '1996-12-01' AND '1996-12-31'
GROUP BY Employees.EmployeeID, Employees.LastName, Employees.FirstName, Employees.City;
--- Câu 5:
CREATE TABLE HoaDonBanHang
(
    orderid INT NOT NULL,
    orderdate DATE NOT NULL,
    empid INT NOT NULL,
    custid VARCHAR(5) NOT NULL,
    qty INT NOT NULL,
    CONSTRAINT PK_Orders PRIMARY KEY(orderid)
);

INSERT INTO HoaDonBanHang (orderid, orderdate, empid, custid, qty) 
VALUES
(30001, '20070802', 3, 'A', 10),
(10001, '20071224', 2, 'A', 12),
(10005, '20071224', 1, 'B', 20),
(40001, '20080109', 2, 'A', 40),
(10006, '20080118', 1, 'C', 14),
(20001, '20080212', 2, 'B', 12),
(40005, '20090212', 3, 'A', 10),
(20002, '20090216', 1, 'C', 20),
(30003, '20090418', 2, 'B', 15),
(30004, '20070418', 3, 'C', 22),
(30007, '20090907', 3, 'D', 30);

--- a) Tính tổng Qty cho mỗi nhân viên. Thông tin gồm empid, custid
SELECT empid, custid, SUM(qty) AS TotalQty
FROM dbo.HoaDonBanHang
GROUP BY empid, custid;
--- b) Tạo bảng Pivot
SELECT empid, A, B, C, D
FROM
(
    SELECT empid, custid, SUM(qty) AS qty
    FROM HoaDonBanHang
    GROUP BY empid, custid
) AS D
PIVOT
(
    SUM(qty)
    FOR custid IN (A, B, C, D)
) AS P