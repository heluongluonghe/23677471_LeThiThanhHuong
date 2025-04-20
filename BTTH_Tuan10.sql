/** Tạo bảng BT Tuần 10 **/﻿

USE TUAN10_VIEW_INDEX;
CREATE TABLE Categories(CategoryID INT PRIMARY KEY,
    CategoryName NVARCHAR(100),
    Description NVARCHAR(255));
CREATE TABLE Suppliers( SupplierID INT PRIMARY KEY,
    SupplierName NVARCHAR(100),
    Address NVARCHAR(50),
    Phone NVARCHAR(50));
CREATE TABLE Products (ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    SupplierID INT FOREIGN KEY REFERENCES Suppliers(SupplierID),
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID),
    QuantityPerUnit NVARCHAR(50),
    UnitPrice MONEY,
    UnitsInStock INT);
CREATE TABLE Customers (CustomerID NVARCHAR(10) PRIMARY KEY,
    CompanyName NVARCHAR(100),
    ContactName NVARCHAR(100),
    City NVARCHAR(50));
CREATE TABLE Employees (EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50));
CREATE TABLE Orders (OrderID INT PRIMARY KEY,
    CustomerID NVARCHAR(10) FOREIGN KEY REFERENCES Customers(CustomerID),
    EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID),
    OrderDate DATE);
CREATE TABLE OrderDetails (OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    UnitPrice MONEY,
    Quantity INT,
    Discount FLOAT,
    PRIMARY KEY (OrderID, ProductID));

UPDATE Orders  SET DiemTL = 10 WHERE OrderID = 1
UPDATE Orders  SET DiemTL = 20 WHERE OrderID = 2
UPDATE Orders  SET DiemTL = 30 WHERE OrderID = 3
UPDATE Orders  SET DiemTL = 40 WHERE OrderID = 4
UPDATE Orders  SET DiemTL = 50 WHERE OrderID = 5
UPDATE Orders  SET DiemTL = 60 WHERE OrderID = 6
UPDATE Orders  SET DiemTL = 70 WHERE OrderID = 7

/** BÀI TẬP TUẦN 10: VIEW INDEX **/
/** 1) VIEW **/
/** CÂU 1: Tạo view vw_Products_Info hiển thị danh sách các sản phẩm từ bảng Products và bảng Categories. Thông tin bao gồm CategoryName, Description, ProductName, QuantityPerUnit, UnitPrice, UnitsInStock.**/
CREATE VIEW vw_Products_Info AS
SELECT Categories.CategoryName, Categories.Description, Products.ProductName, Products.QuantityPerUnit, Products.UnitPrice, Products.UnitsInStock
FROM Products
JOIN Categories ON Products.CategoryID = Categories.CategoryID;
/** CÂU 2: Tạo view List_Product_view chứa danh sách các sản phẩm dạng hộp (box) có đơn giá > 16, thông tin gồm ProductID, ProductName, UnitPrice, QuantityPerUnit, COUNT of OrderID**/
CREATE VIEW List_Product_view AS
SELECT Products.ProductID, Products.ProductName, Products.UnitPrice, Products.QuantityPerUnit, COUNT(OrderDetails.OrderID) AS OrderCount
FROM Products
JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
WHERE Products.QuantityPerUnit LIKE '%HOP%' AND Products.UnitPrice > 16
GROUP BY Products.ProductID, Products.ProductName, Products.UnitPrice, Products.QuantityPerUnit;
/** CÂU 3: Tạo view vw_CustomerTotals hiển thị tổng tiền bán được từ mỗi khách hàng theo tháng và theo năm. Thông tin gồm CustomerID, YEAR(OrderDate) AS OrderYear, MONTH(OrderDate) AS OrderMonth, SUM(UnitPrice*Quantity).
Xem lại cú pháp lệnh tạo view này.**/
CREATE VIEW vw_CustomerTotal AS
SELECT Orders.CustomerID, YEAR(Orders.OrderDate) AS OrderYear, MONTH(Orders.OrderDate) AS OrderMonth, SUM(OrderDetails.UnitPrice * OrderDetails.Quantity) AS TotalAmount
FROM Orders
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY Orders.CustomerID, YEAR(Orders.OrderDate), MONTH(Orders.OrderDate);
EXEC sp_helptext 'vw_CustomerTotal'
/** CÂU 4: Tạo view trả về tổng số lượng sản phẩm bán được của mỗi nhân viên (Employee) theo từng năm. Thông tin gồm EmployeeID, OrderYear, sumOfOrderQuantity. Yêu cầu sau khi tạo view, người dùng không xem được cú pháp lệnh đã tạo view này.**/
CREATE VIEW vw_EmployeeSales WITH ENCRYPTION AS
SELECT Orders.EmployeeID, YEAR(Orders.OrderDate) AS OrderYear, SUM(OrderDetails.Quantity) AS sumOfOrderQuantity
FROM Orders
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY Orders.EmployeeID, YEAR(Orders.OrderDate);
/** CÂU 5: Tạo view ListCustomer_view chứa danh sách các khách hàng có trên 5 hóa đơn đặt hàng từ năm 1997 đến 1998, thông tin gồm mã khách (CustomerID) , họ tên (CompanyName), Số hóa đơn (CountOfOrders).**/
CREATE VIEW ListCustomer_view AS
SELECT Customers.CustomerID, Customers.CompanyName, COUNT(Orders.OrderID) AS CountOfOrders
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE YEAR(Orders.OrderDate) BETWEEN 1997 AND 1998
GROUP BY Customers.CustomerID, Customers.CompanyName
HAVING COUNT(Orders.OrderID) > 5;
/** CÂU 6: Tạo view ListProduct_view chứa danh sách những sản phẩm nhóm Beverages và Seafood có tổng số lượng bán trong mỗi năm trên 30 sản phẩm, thông tin gồm CategoryName, ProductName, Year, SumOfOrderQuantity**/
CREATE VIEW ListProduct_view AS
SELECT Categories.CategoryName, Products.ProductName, YEAR(Orders.OrderDate) AS [Year], SUM(OrderDetails.Quantity) AS SumOfOrderQuantity
FROM Products
JOIN Categories ON Products.CategoryID = Categories.CategoryID
JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
JOIN Orders ON Orders.OrderID = OrderDetails.OrderID
WHERE Categories.CategoryName IN ('CAPHE', 'HAISAN')
GROUP BY Categories.CategoryName, Products.ProductName, YEAR(Orders.OrderDate)
HAVING SUM(OrderDetails.Quantity) > 30;
/** CÂU 7: Tạo view vw_OrderSummary với từ khóa WITH ENCRYPTION gồm OrderYear (năm của ngày lập hóa đơn), OrderMonth (tháng của ngày lập hóa đơn), OrderTotal (tổng tiền, =UnitPrice*Quantity). 
Sau đó xem thông tin và trợ giúp về mã lệnh của view này**/
CREATE VIEW vw_OrderSummary WITH ENCRYPTION AS
SELECT YEAR(Orders.OrderDate) AS OrderYear, MONTH(Orders.OrderDate) AS OrderMonth, SUM(OrderDetails.UnitPrice * OrderDetails.Quantity) AS OrderTotal
FROM Orders
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY YEAR(Orders.OrderDate), MONTH(Orders.OrderDate);
EXEC sp_help 'vw_OrderSummary';
SELECT * FROM vw_OrderSummary;
/** CÂU 8: Tạo view vwProducts với từ khóa WITH SCHEMABINDING gồm ProductID, ProductName, Discount. Xem thông tin của View. Xóa cột Discount. Có xóa được không? Vì sao?**/
CREATE VIEW dbo.vwProducts WITH SCHEMABINDING AS
SELECT Products.ProductID, Products.ProductName, OrderDetails.Discount
FROM dbo.Products
JOIN dbo.OrderDetails ON OrderDetails.ProductID = Products.ProductID
EXEC sp_help 'dbo.vwProducts';
/** View vwProducts đang sử dụng cột Discount, và do có từ khóa WITH SCHEMABINDING, SQL Server không cho phép thay đổi cấu trúc bảng mà ảnh hưởng đến view đó.**/
/** CÂU 9: Tạo view vw_Customer với với từ khóa WITH CHECK OPTION chỉ chứa các khách hàng ở thành phố London và Madrid, thông tin gồm: CustomerID, CompanyName, City.
a. Chèn thêm một khách hàng mới không ở thành phố London và Madrid thông qua view vừa tạo. Có chèn được không? Giải thích.**/
CREATE VIEW vw_Customer AS
SELECT CustomerID, CompanyName, City FROM Customers
WHERE City IN ('London', 'Madrid')
WITH CHECK OPTION;
/** WITH CHECK OPTION là gì? Nó đảm bảo rằng mọi thao tác INSERT hoặc UPDATE qua view phải thỏa điều kiện trong mệnh đề WHERE của view.Nếu City không phải London hoặc Madrid, thì SQL Server sẽ từ chối thao tác chèn hoặc cập nhật.**/
/** b. Chèn thêm một khách hàng mới ở thành phố London và một khách hàng mới ở thành phố Madrid. Dùng câu lệnh select trên bảng Customers để xem kết quả .**/
INSERT INTO vw_Customer (CustomerID, CompanyName, City) VALUES ('005', 'Cong ty ABC', 'Paris');
/** CÂU 10: Tạo 3 bảng lần lượt có tên là KhangHang_Bac, KhachHang_Trung, KhachHang_Nam, dùng để lưu danh sách các khách hàng ở ba miền, có cấu trúc như sau: MaKh, TenKH, DiaChi, KhuVuc. Trong đó, 
KhachHang_Bac có một Check Constraint là Khuvuc là ‘Bac Bo’ 
KhachHang_Nam có một Check Constraint là Khuvuc là ‘Nam Bo’
KhachHang_Trung có một Check Constraint là Khuvuc là ‘Trung Bo’
Khoá chính là MaKH và KhuVuc . Tạo một partition view từ ba bảng trên, sau đó chèn mẫu tin tuỳ ý thông qua view. Kiểm tra xem mẫu tin được lưu vào bảng nào khi thêm/sửa/xóa dữ liệu vào view?**/
CREATE TABLE KhachHang_Bac (MaKH NVARCHAR(10), TenKH NVARCHAR(100), DiaChi NVARCHAR(100),
    KhuVuc NVARCHAR(20) CHECK (KhuVuc = 'Bac Bo'),
    PRIMARY KEY (MaKH, KhuVuc));
CREATE TABLE KhachHang_Trung (MaKH NVARCHAR(10),
    TenKH NVARCHAR(100),
    DiaChi NVARCHAR(100),
    KhuVuc NVARCHAR(20) CHECK (KhuVuc = 'Trung Bo'),
    PRIMARY KEY (MaKH, KhuVuc));
CREATE TABLE KhachHang_Nam (MaKH NVARCHAR(10),
    TenKH NVARCHAR(100),
    DiaChi NVARCHAR(100),
    KhuVuc NVARCHAR(20) CHECK (KhuVuc = 'Nam Bo'),
    PRIMARY KEY (MaKH, KhuVuc));
CREATE VIEW vw_KhachHang_Mien AS
SELECT * FROM KhachHang_Bac
UNION ALL
SELECT * FROM KhachHang_Trung
UNION ALL
SELECT * FROM KhachHang_Nam;
/** CHEN TUY Y**/
INSERT INTO vw_KhachHang_Mien(MaKH, TenKH, DiaChi, KhuVuc) VALUES ('001', 'NGUYEN CONG HOAN', 'Ha Noi', 'Bac Bo');
INSERT INTO vw_KhachHang_Mien (MaKH, TenKH, DiaChi, KhuVuc) VALUES ('002', 'TRAN CONG SON', 'Da Nang', 'Trung Bo');
INSERT INTO vw_KhachHang_Mien (MaKH, TenKH, DiaChi, KhuVuc) VALUES ('003', 'LE HUY', 'Can Tho', 'Nam Bo');
/** KIEM TRA**/
SELECT * FROM KhachHang_Bac;
SELECT * FROM KhachHang_Trung;
SELECT * FROM KhachHang_Nam;
/** CÂU 11: .Lần lược tạo các view sau, đặt tên tùy ý, sau khi tạo kiểm tra sự tồn tại và kết quả truy vấn từ view. 
▪ Danh sách các sản phẩm có chữ ‘Boxes’ trong DonViTinh. 
▪ Danh sách các sản phẩm có đơn giá <10.
▪ Các sản phẩm có đơn giá gốc lớn hơn hay bằng đơn giá gốc trung bình.
▪ Danh sách các khách hàng ứng với các hóa đơn được lập. Thông tin gồm MaKH, TenKH, và tất cả các cột trong bảng HoaDon và CT_HoaDon. 
Trong các view ở câu trên view nào có thể INSERT, UPDATE, DELETE dữ liệu thông qua view được? Hãy Insert/Update/Delete thử dữ liệu tùy ý. **/
/** ▪ Danh sách các sản phẩm có chữ ‘Boxes’ trong DonViTinh.**/
CREATE VIEW vw_LoaiSanPham AS
SELECT * FROM Products
WHERE Products.QuantityPerUnit LIKE '%HOP%';
/** ▪ Danh sách các sản phẩm có đơn giá <10.**/
CREATE VIEW vw_GiaSanPham AS
SELECT * FROM Products
WHERE Products.UnitPrice < 10;
/** ▪ Các sản phẩm có đơn giá gốc lớn hơn hay bằng đơn giá gốc trung bình.**/
CREATE VIEW vw_GiaGocSanPham AS
SELECT * FROM Products
WHERE Products.UnitPrice >= (SELECT AVG(Products.UnitPrice) FROM Products);
/** ▪ Danh sách các khách hàng ứng với các hóa đơn được lập. Thông tin gồm MaKH, TenKH, và tất cả các cột trong bảng HoaDon và CT_HoaDon. **/
CREATE VIEW vw_ListCustomers AS
SELECT Customers.CustomerID AS MaKH, Customers.CompanyName AS TenKH, Orders.EmployeeID, Orders.OrderID, Orders.OrderDate, OrderDetails.Discount AS GiamGiaBan, OrderDetails.UnitPrice AS GiaBan, OrderDetails.Quantity, OrderDetails.ProductID
FROM Customers
JOIN Orders ON Orders.CustomerID = Customers.CustomerID
JOIN OrderDetails ON OrderDetails.OrderID = Orders.OrderID;
/** Trong các view ở câu trên view nào có thể INSERT, UPDATE, DELETE dữ liệu thông qua view được? Hãy Insert/Update/Delete thử dữ liệu tùy ý. **/
/** View KHÔNG thể cập nhật khi: Có JOIN, GROUP BY, HAVING, hoặc tính toán, Truy vấn phức tạp hoặc không ánh xạ rõ ràng tới một bảng gốc duy nhất
-> VIEW 1 VA 2 DUOC CAP NHAT CON 2 VIEW SAU KHONG CAP NHAT DUOC VI COS LIEN QUAN DEN TINH TOAN VA JOIN VOI BANG KHAC**/

/** 2) INDEX **/
/** CÂU 1: Tạo chỉ mục dạng CLUSTERED cho bảng Orders với cột làm chỉ mục là Customerid. Xem trợ giúp về chỉ mục vừa tạo. Dùng lệnh select xem thông tin bảng orders. **/
CREATE CLUSTERED INDEX IX_Orders_CustomerID
ON Orders(CustomerID);
--- KHONG TAO DUOC VI BANG Orders DA CO KHOA CHINH (PK - CLUSTERED INDEX ) NEN KHI CHEN NAY DU LIEU SE KHONG NHAN MA NEN CHUYEN SANG NONCLUSTERED ---
/** Xem trợ giúp về chỉ mục vừa tạo. **/
sp_helpindex Orders;
/** select XEM THONG TIN**/
SELECT * FROM Orders

/** CÂU 2: Tạo chỉ mục dạng NONCLUSTERED cho bảng Orders với cột làm chỉ mục là Employeeid. Xem trợ giúp về chỉ mục vừa tạo. Dùng lệnh select xem thông tin bảng orders. 
Nhận xét sự khác nhau giữa hai loại chỉ mục vừa tạo.**/
CREATE NONCLUSTERED INDEX IX_Orders_EmloyeeID
ON Orders(EmployeeID);
--- NONCLUSTERD INDEX -> CHI VI TRI CUA DU LIEU THOI CHU KHONG SAP XEP THEO DU LIEU NHU CLUSTERED INDEX---
sp_helpindex Orders
SELECT * FROM Orders
--- KET QUA SE KHONG THAY DOI MA CHI TANG TOC DO DUYET ---

/** CÂU 3: Thêm vào bảng Orders cột DiemTL. Tạo chỉ mục dạng unique cho cột DiemTL. Sau khi tạo chỉ mục này, nếu nhập dữ liệu cho 2 hóa đơn có cùng điểm tích lũy có được không? Giải thích**/
ALTER TABLE Orders ADD DiemTL INT; 
CREATE UNIQUE INDEX IX_Orders_DiemTL
ON Orders(DiemTL);
--- NEU TAO DU LIEU CUNG DIEM TICH LUY SE KHONG DUOC VI VI PHAM RANG BUOC DUY NHAT---

/** CÂU 4: Giả sử bạn có nhu cầu truy vấn thường xuyên câu lệnh sau:
SELECT * FROM Orders
WHERE orderdate= getdate();
Bạn hãy thực hiện việc tạo chỉ mục thích hợp để việc truy vấn câu trên thực hiện nhanh hơn? **/
CREATE NONCLUSTERED INDEX IX_Orders_OrderDate
ON Orders(OrderDate);
SELECT * FROM Orders WHERE OrderDate = GETDATE()

/** CÂU 5: Giả sử bạn có nhu cầu truy vấn thường xuyên câu lệnh sau:
SELECT *
FROM Products
WHERE ProductID = 57
Bạn hãy thực hiện việc tạo chỉ mục thích hợp để việc truy vấn câu trên thực hiện nhanh hơn?. **/
CREATE NONCLUSTERED INDEX IX_Products_ProductID
ON Products(ProductID)
SELECT * FROM Products WHERE ProductID = 57