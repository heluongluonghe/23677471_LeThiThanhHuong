﻿USE QLST17
SET DATEFORMAT DMY
CREATE TABLE NhomSanPham( MANHOM INT NOT NULL PRIMARY KEY,
	TenNhom NVARCHAR(15));
INSERT INTO NhomSanPham(MANHOM, TenNhom) VALUES
(1, 'RAU'),
(2, 'CU'),
(3, 'HOA'),
(4, 'QUA'),
(5, 'THIT'),
(6, 'CA');
CREATE TABLE NhaCungCap (MaNCC INT NOT NULL PRIMARY KEY,
	TenNcc NVARCHAR(40) NOT NULL,
	Diachi NVARCHAR(60),
	Phone NVARCHAR(24),
	SoFax NVARCHAR(24),
	DCMail NVARCHAR(50));
INSERT INTO NhaCungCap (MaNCC, TenNcc, Diachi, Phone, SoFax, DCMail) VALUES
(1, 'AC-FARM', 'LONG AN', '0933684518', '65748', 'ACFARM@GMAIL.COM'),
(2, 'ACT-FARM', 'LONG AN', '0642388322', '62268', 'ACTFARM@GMAIL.COM'),
(3, 'AT-FARM', 'DONG THAP', '0291882128', '65733', 'ATFARM@GMAIL.COM');
INSERT INTO NhaCungCap (MaNCC, TenNcc, Diachi, Phone, SoFax, DCMail) VALUES
(4, 'MO-FARM', 'USA', '0933664518', '65741', 'MOFARM@GMAIL.COM'),
(5, 'MOT-FARM', 'USA', '0233664518', '65740', 'MOTFARM@GMAIL.COM');
CREATE TABLE SanPham (MaSp INT NOT NULL PRIMARY KEY,
	TenSp NVARCHAR(40) NOT NULL,
	MaNCC INT,
	MoTa NVARCHAR(50),
	MaNhom INT,
	Donvitinh NVARCHAR(20),
	GiaGoc MONEY CHECK (GiaGoc > 0),
	SLTON INT CHECK (SLTON > 0),
	CONSTRAINT FK_SanPham_Nhom FOREIGN KEY (MaNhom) REFERENCES NhomSanPham(MANHOM),
    CONSTRAINT FK_SanPham_NCC FOREIGN KEY (MaNCC) REFERENCES NhaCungCap(MaNCC));
INSERT INTO SanPham (MaSp, TenSp, MaNCC, MoTa, MaNhom, Donvitinh, GiaGoc, SLTON) VALUES
(1, 'XA LACH ROMAIN', 1, NULL, 1, 'KG', 20000, 50),
(2, 'RAU MUI', 1, NULL, 1, 'KG', 30000, 50),
(3, 'CU KHOAI TAY', 1, NULL, 2, 'KG', 40000, 20),
(4, 'HOA HONG', 3, NULL, 3, 'BO', 100000, 50),
(5, 'THIT HEO', 2, NULL, 5, 'KG', 7000, 100);
INSERT INTO SanPham (MaSp, TenSp, MaNCC, MoTa, MaNhom, Donvitinh, GiaGoc, SLTON) VALUES
(6, 'CA TAM', 1, NULL, 6, 'HOP', 200000, 50),
(7, 'CA CHE BIEN', 1, NULL, 6, 'HOP', 250000, 50);
INSERT INTO SanPham (MaSp, TenSp, MaNCC, MoTa, MaNhom, Donvitinh, GiaGoc, SLTON) VALUES
(8, 'CU MI', 1, NULL, 2, 'CU', 200000, 9),
(9, 'CA MU', 1, NULL, 6, 'CON', 300000, 3);
INSERT INTO SanPham (MaSp, TenSp, MaNCC, MoTa, MaNhom, Donvitinh, GiaGoc, SLTON) VALUES
(10, 'CU KHOAI LANG', 4, NULL, 2, 'CU', 200000, 9),
(11, 'CA MU TRAN CHAU', 4, NULL, 6, 'CON', 300000, 3);
CREATE TABLE HoaDon (MaHD INT NOT NULL,
	NgayLapHD DATETIME, 
	NgayGiao DATETIME,
	Noichuyen NVARCHAR(60) NOT NULL,
	MaKh NCHAR(5));
INSERT INTO HoaDon (MaHD, NgayLapHD, NgayGiao, Noichuyen, MaKh, MaNV, LoaiHD) VALUES
(1, '1996-11-29', '1996-12-1', 'LONG AN', 'Kh001', 'NV001', 'X'),
(2, '1996-11-30', '1996-12-2', 'LONG AN', 'Kh002', 'NV002', 'X'),
(3, '1997-1-11', '1997-1-20', 'LONG AN', 'Kh002', 'NV003', 'X'),
(4, '1997-2-11', '1997-2-20', 'DONG THAP', 'Kh001', 'NV004', 'X');
INSERT INTO HoaDon (MaHD, NgayLapHD, NgayGiao, Noichuyen, MaKh, MaNV, LoaiHD) VALUES
(5, '1997-07-29', '1997-08-01', 'LONG AN', 'Kh001', 'NV001', 'X'),
(6, '1997-07-30', '1997-08-05', 'LONG AN', 'Kh005', 'NV004', 'X');
CREATE TABLE CT_HoaDon (MaHD INT NOT NULL,
	MaSp INT NOT NULL,
	Soluong INT CHECK (Soluong > 0),
	Dongia MONEY,
	ChietKhau MONEY CHECK (ChietKhau >= 0));
INSERT INTO CT_HoaDon(MaHD, MaSp, Soluong, Dongia, ChietKhau) VALUES
(1, 3, '10',35000, 0),
(2, 2, '10',45000, 0),
(3, 5, '20',70000, 0),
(4, 4, '5',110000, 10000);
INSERT INTO CT_HoaDon(MaHD, MaSp, Soluong, Dongia, ChietKhau) VALUES
(5, 10, '6',300000, 0),
(6, 11, '3',400000, 0);
CREATE TABLE KhachHang (MaKh NCHAR(5) NOT NULL,
	TenKh NVARCHAR(40) NOT NULL,
	LoaiKh NVARCHAR(3) CHECK (LoaiKh IN ('VIP','TV','VL')),
	DiaChi NVARCHAR(60),
	Phone NVARCHAR(24),
	SoFax NVARCHAR(24),
	DCMail NVARCHAR(50),
	DiemTL INT CHECK (DiemTL >= 0));
	--- b) THÊM KHÓA CHÍNH CHO 3 TABLE
ALTER TABLE KhachHang ADD CONSTRAINT PK_KhachHang PRIMARY KEY (MaKh);
ALTER TABLE HoaDon ADD CONSTRAINT Pk_HoaDon PRIMARY KEY (MaHD);
ALTER TABLE CT_HoaDon ADD CONSTRAINT Pk_CTHoaDon PRIMARY KEY (MaHD, MaSp);
--- C) THÊM KHÓA NGOẠI CHO 3 TABLE
ALTER TABLE HoaDon ADD CONSTRAINT FK_HoaDON_KhachHang FOREIGN KEY (MaKh) REFERENCES KhachHang(MaKh);
ALTER TABLE CT_HoaDon ADD CONSTRAINT FK_CT_HoaDon_HoaDon FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD);
ALTER TABLE CT_HoaDon ADD CONSTRAINT FK_CT_HoaDon_SanPham FOREIGN KEY (MaSp) REFERENCES SanPham(MaSp);
--- d) Alter Table … khai báo các ràng buộc miền giá trị (Check Constraint) và ràng buộc giá trị mặc định:
ALTER TABLE HoaDon  ADD CONSTRAINT DF_NgayLapHD DEFAULT GETDATE() FOR NgayLapHD;
--- e) LoaiHD vào bảng HOADON, có kiểu dữ liệu char(1), Chỉ nhập N(Nhập), X(Xuất), C(Chuyển từ cửa hàng này sang cửa hàng khác), T (Trả), giá trị mặc định là ‘N’.
ALTER TABLE HoaDon ADD LoaiHD CHAR(1) NOT NULL DEFAULT 'N';
ALTER TABLE HoaDon ADD CONSTRAINT CK_LoaiHD CHECK (LoaiHD IN ('N', 'X', 'C', 'T'));
---f) ràng buộc cho bảng HoaDon với yêu cầu NgayGiao>=NgayLapHD
ALTER TABLE HoaDon ADD CONSTRAINT CK_NgayGiao CHECK (NgayGiao >= NgayLapHD);
CREATE TABLE [dbo].[Nhanvien](
 [MaNV] [nchar](5) PRIMARY KEY,
 [TenNV] [nvarchar](40) NOT NULL,
 [DiaChi] [nvarchar](60) NULL,
 [Dienthoai] [nvarchar](24) NULL )
GO
ALTER TABLE HoaDon ADD MaNV NCHAR(5);
ALTER TABLE HoaDon ADD CONSTRAINT FK_HoaDon_Nhanvien FOREIGN KEY (MaNV) REFERENCES Nhanvien(MaNV);
INSERT INTO KhachHang(MaKh, TenKh, LoaiKh, DiaChi, Phone, SoFax, DCMail, DiemTL)
VALUES ('Kh001', 'LE THI THANH HUONG', 'VIP', 'Q12-TP.HCM', '0965147417', '181020', 'shaythuong@gmail.com', 10);
INSERT INTO KhachHang(MaKh, TenKh, LoaiKh, DiaChi, Phone, SoFax, DCMail, DiemTL)
VALUES ('Kh002', 'PHAN THANH NGHIEP', 'TV', 'Q12-TP.HCM', '0965082640', '203050', 'thnghiepp@gmail.com', 50);
INSERT INTO KhachHang(MaKh, TenKh, LoaiKh, DiaChi, Phone, SoFax, DCMail, DiemTL) VALUES
('Kh003', 'KAGEYAMA', 'VIP', 'LONDON', '0983136121', '09876', 'KAGE@GMAIL.COM', 100),
('Kh004', 'KAGETO', 'VIP', 'LONDON', '0982323213', '09875', 'KAGET@GMAIL.COM', 90),
('Kh005', 'HINATA', 'TV', 'LONDON', '0935454651', '09874', 'HINA@GMAIL.COM', 10),
('Kh006', 'HINO', 'VL', 'LONDON', '0954545453', '09873', 'HINO@GMAIL.COM', 0);
INSERT INTO Nhanvien (MaNV, TenNV, DiaChi, Dienthoai)
VALUES ('NV001', 'NGUYEN VAN A', 'PHU NHUAN', '0987265146');
INSERT INTO Nhanvien (MaNV, TenNV, DiaChi, Dienthoai)
VALUES ('NV010', 'NGUYEN HOA B', 'PHU NHUAN', '0901120456');
INSERT INTO Nhanvien (MaNV, TenNV, DiaChi, Dienthoai)
VALUES ('NV015', 'NGUYEN XUAN C', 'PHU NHUAN', '0902530811');
INSERT INTO Nhanvien (MaNV, TenNV, DiaChi, Dienthoai) Values
('NV002', 'NGUYEN KIM CHI', 'PHU NHUAN', '0139284439'),
('NV003', 'NGUYEN KIM THAO', 'PHU NHUAN', '0823893821'),
('NV004', 'NGUYEN KIM HOA', 'PHU NHUAN', '0783494839');
CREATE TABLE TESTTHU (MaTEST INT PRIMARY KEY,
	TENTEST NVARCHAR(60),
	HEEHEH NVARCHAR(60),
	CUOICUNG NVARCHAR(60));
ALTER TABLE TESTTHU ADD TESTTT INT;
Select * from KhachHang


---TUAN 9:
/** CAU 6, 7, 8 (CACH 1) **/
USE TEST_T9;
CREATE TABLE SanPham (MaSp INT NOT NULL PRIMARY KEY,
	TenSp NVARCHAR(40) NOT NULL,
	MaNCC INT,
	MoTa NVARCHAR(50),
	MaNhom INT,
	Donvitinh NVARCHAR(20),
	GiaGoc MONEY CHECK (GiaGoc > 0),
	SLTON INT CHECK (SLTON > 0));
INSERT INTO SanPham (MaSp, TenSp, MaNCC, MoTa, MaNhom, Donvitinh, GiaGoc, SLTON)
SELECT MaSp, TenSp, MaNCC, MoTa, MaNhom, Donvitinh, GiaGoc, SLTON
FROM QLST17.dbo.SanPham
WHERE MaNCC IN (1, 2, 3);
SELECT * FROM SanPham
CREATE TABLE NhaCungCap (MaNCC INT NOT NULL PRIMARY KEY,
	TenNcc NVARCHAR(40) NOT NULL,
	Diachi NVARCHAR(60),
	Phone NVARCHAR(24),
	SoFax NVARCHAR(24),
	DCMail NVARCHAR(50));
INSERT INTO NhaCungCap(MaNCC, TenNcc, Diachi, Phone, DCMail)
SELECT MaNCC, TenNcc, Diachi, Phone, DCMail
FROM QLST17.dbo.NhaCungCap
INSERT INTO NhaCungCap(MaNCC, TenNcc, Diachi, Phone, DCMail)
SELECT MaNCC, TenNcc, Diachi, Phone, DCMail
FROM Northwind.dbo.NhaCungCap
CREATE TABLE [dbo].[Nhanvien](
 [MaNV] [nchar](5) PRIMARY KEY,
 [TenNV] [nvarchar](40) NOT NULL,
 [DiaChi] [nvarchar](60) NULL,
 [Dienthoai] [nvarchar](24) NULL );
 INSERT INTO Nhanvien (MaNV, TenNV, DiaChi, Dienthoai)
 SELECT * FROM QLST17.dbo.Nhanvien
 CREATE TABLE CT_HoaDon (MaHD INT NOT NULL,
	MaSp INT NOT NULL,
	Soluong INT CHECK (Soluong > 0),
	Dongia MONEY,
	ChietKhau MONEY CHECK (ChietKhau >= 0));
/** BAI TAP 1: INSERT - CACH 2: **/
﻿USE C2_T9;
CREATE TABLE NhomSanPham( MANHOM INT NOT NULL PRIMARY KEY,
	TenNhom NVARCHAR(15));
CREATE TABLE NhaCungCap (MaNCC INT NOT NULL PRIMARY KEY,
	TenNcc NVARCHAR(40) NOT NULL,
	Diachi NVARCHAR(60),
	Phone NVARCHAR(24),
	SoFax NVARCHAR(24),
	DCMail NVARCHAR(50));
CREATE TABLE SanPham (MaSp INT NOT NULL PRIMARY KEY,
	TenSp NVARCHAR(40) NOT NULL,
	MaNCC INT,
	MoTa NVARCHAR(50),
	MaNhom INT,
	Donvitinh NVARCHAR(20),
	GiaGoc MONEY CHECK (GiaGoc > 0),
	SLTON INT CHECK (SLTON > 0),
	CONSTRAINT FK_SanPham_Nhom FOREIGN KEY (MaNhom) REFERENCES NhomSanPham(MANHOM),
    CONSTRAINT FK_SanPham_NCC FOREIGN KEY (MaNCC) REFERENCES NhaCungCap(MaNCC));
CREATE TABLE HoaDon (MaHD INT NOT NULL,
	NgayLapHD DATETIME, 
	NgayGiao DATETIME,
	Noichuyen NVARCHAR(60) NOT NULL,
	MaKh NCHAR(5));
CREATE TABLE CT_HoaDon (MaHD INT NOT NULL,
	MaSp INT NOT NULL,
	Soluong INT CHECK (Soluong > 0),
	Dongia MONEY,
	ChietKhau MONEY CHECK (ChietKhau >= 0));
CREATE TABLE KhachHang (MaKh NCHAR(5) NOT NULL,
	TenKh NVARCHAR(40) NOT NULL,
	LoaiKh NVARCHAR(3) CHECK (LoaiKh IN ('VIP','TV','VL')),
	DiaChi NVARCHAR(60),
	Phone NVARCHAR(24),
	SoFax NVARCHAR(24),
	DCMail NVARCHAR(50),
	DiemTL INT CHECK (DiemTL >= 0));
ALTER TABLE KhachHang ADD CONSTRAINT PK_KhachHang PRIMARY KEY (MaKh);
ALTER TABLE HoaDon ADD CONSTRAINT Pk_HoaDon PRIMARY KEY (MaHD);
ALTER TABLE CT_HoaDon ADD CONSTRAINT Pk_CTHoaDon PRIMARY KEY (MaHD, MaSp);
--- C) THÊM KHÓA NGOẠI CHO 3 TABLE
ALTER TABLE HoaDon ADD CONSTRAINT FK_HoaDON_KhachHang FOREIGN KEY (MaKh) REFERENCES KhachHang(MaKh);
ALTER TABLE CT_HoaDon ADD CONSTRAINT FK_CT_HoaDon_HoaDon FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD);
ALTER TABLE CT_HoaDon ADD CONSTRAINT FK_CT_HoaDon_SanPham FOREIGN KEY (MaSp) REFERENCES SanPham(MaSp);
--- d) Alter Table … khai báo các ràng buộc miền giá trị (Check Constraint) và ràng buộc giá trị mặc định:
ALTER TABLE HoaDon  ADD CONSTRAINT DF_NgayLapHD DEFAULT GETDATE() FOR NgayLapHD;
--- e) LoaiHD vào bảng HOADON, có kiểu dữ liệu char(1), Chỉ nhập N(Nhập), X(Xuất), C(Chuyển từ cửa hàng này sang cửa hàng khác), T (Trả), giá trị mặc định là ‘N’.
ALTER TABLE HoaDon ADD LoaiHD CHAR(1) NOT NULL DEFAULT 'N';
ALTER TABLE HoaDon ADD CONSTRAINT CK_LoaiHD CHECK (LoaiHD IN ('N', 'X', 'C', 'T'));
---f) ràng buộc cho bảng HoaDon với yêu cầu NgayGiao>=NgayLapHD
ALTER TABLE HoaDon ADD CONSTRAINT CK_NgayGiao CHECK (NgayGiao >= NgayLapHD);
CREATE TABLE [dbo].[Nhanvien](
 [MaNV] [nchar](5) PRIMARY KEY,
 [TenNV] [nvarchar](40) NOT NULL,
 [DiaChi] [nvarchar](60) NULL,
 [Dienthoai] [nvarchar](24) NULL )
GO
ALTER TABLE HoaDon ADD MaNV NCHAR(5);
ALTER TABLE HoaDon ADD CONSTRAINT FK_HoaDon_Nhanvien FOREIGN KEY (MaNV) REFERENCES Nhanvien(MaNV);
/** BT TUAN 9: **/
INSERT INTO KhachHang (MaKh, TenKh, LoaiKh, DiaChi, Phone, SoFax, DCMail, DiemTL)
SELECT CustomerID, CompanyName,'TV',Address, Phone, Fax, NULL, 0
FROM Northwind.dbo.Customers;

INSERT INTO SanPham (MaSp, TenSp, MaNCC, MoTa, MaNhom, Donvitinh, GiaGoc, SLTON)
SELECT ProductID, ProductName, SupplierID, QuantityPerUnit, CategoryID,'Hộp', UnitPrice, UnitsInStock
FROM Northwind.dbo.Products
WHERE SupplierID BETWEEN 4 AND 29;

INSERT INTO HoaDon (MaHD, NgayLapHD, NgayGiao, Noichuyen, MaKh)
SELECT OrderID, OrderDate, RequiredDate, ShipAddress, CustomerID
FROM Northwind.dbo.Orders
WHERE OrderID BETWEEN 10248 AND 10350;

INSERT INTO HoaDon (MaHD, NgayLapHD, NgayGiao, Noichuyen, MaKh)
SELECT OrderID, OrderDate, RequiredDate, ShipAddress, CustomerID
FROM Northwind.dbo.Orders
WHERE OrderID BETWEEN 10351 AND 10446;

INSERT INTO CT_HoaDon (MaHD, MaSp, Soluong, Dongia, ChietKhau)
SELECT OrderID, ProductID, Quantity, UnitPrice, Discount
FROM Northwind.dbo.[Order Details]
WHERE OrderID BETWEEN 10248 AND 10270;


/** CAU 2: Khi bảng CT_HoaDon vẫn còn dữ liệu liên kết đến SanPham thông qua khóa ngoại MaSp,
 thì bạn không thể xóa SanPham được do vi phạm ràng buộc toàn vẹn.**/
/** CAU 3: Bạn phải xóa bảng con trước, hoặc tắt tạm thời ràng buộc khóa ngoại**/
/** BAI TAP 2: UPDATE: **/
/** CAU 1: Cập nhật đơn giá bán 100000 cho mã sản phẩm có tên bắt đầu bằng chữ T **/
UPDATE SanPham SET GiaGoc = 100000 WHERE TenSp LIKE 'T%';
SELECT MaSp, TenSp, GiaGoc FROM SanPham
WHERE TenSp LIKE 'T%';
/** CAU 2: Cập nhật số lượng tồn = 50% số lượng tồn hiện có cho những sản phẩm có đơn
vị tính có chữ box **/
UPDATE SanPham SET SLTON = SLTON / 2 WHERE Donvitinh LIKE '%HOP%';
SELECT MaSp, TenSp, Donvitinh, SLTON FROM SanPham
WHERE Donvitinh LIKE '%HOP%';
/** CAU 3: Cập nhật mã nhà cung cấp là 1 trong bảng NHACUNGCAP thành 100? **/
UPDATE NhaCungCap SET MaNCC = 100 WHERE MaNCC = 1;
/** CAU NAY LOI VI KHOA NGOAI**/
/** CAU 4: Tăng điểm tích lũy lên 100 cho những KH mua hàng trong tháng 7/1997 **/
UPDATE KhachHang SET DiemTL = DiemTL + 100
WHERE MaKh IN (SELECT DISTINCT MaKh
    FROM HoaDon
    WHERE MONTH(NgayLapHD) = 7 AND YEAR(NgayLapHD) = 1997);
SELECT KH.MaKh, TenKh, DiemTL FROM KhachHang KH
JOIN HoaDon HD ON KH.MaKh = HD.MaKh
WHERE MONTH(HD.NgayLapHD) = 7 AND YEAR(HD.NgayLapHD) = 1997;
/** CAU 5: Giảm 10% đơn giá bán cho những sản phẩm có SLTON < 10 **/
UPDATE SanPham SET GiaGoc = GiaGoc * 0.9 WHERE SLTON < 10;
SELECT MaSp, TenSp, SLTON, GiaGoc FROM SanPham
WHERE SLTON < 10;
/** CAU 6: Cập nhật giá bán trong CT_HoaDon bằng giá mua từ SanPham cho SP có MaNCC = 4 hoặc 7 **/
UPDATE CT_HoaDon SET Dongia = SP.GiaGoc
FROM CT_HoaDon CT
JOIN SanPham SP ON CT.MaSp = SP.MaSp
WHERE SP.MaNCC IN (4, 7);
SELECT CT.MaHD, CT.MaSp, CT.Dongia, SP.GiaGoc, SP.MaNCC
FROM CT_HoaDon CT
JOIN SanPham SP ON CT.MaSp = SP.MaSp
WHERE SP.MaNCC IN (4, 7);
/** BAI TAP 3: DELETE: **/
/** CAU 1:  Xóa các hóa đơn được lập trong tháng 7 năm 1996. Bạn có thực hiện được không? Vì sao? **/
/** Không thể xóa trực tiếp nếu như hóa đơn đó đã có dữ liệu liên quan trong bảng CT_HoaDon (bảng con) do ràng buộc khóa ngoại.
Phải xóa chi tiết hóa đơn trước rồi mới xóa hóa đơn. **/
DELETE FROM CT_HoaDon
WHERE MaHD IN (SELECT MaHD FROM HoaDon
    WHERE MONTH(NgayLapHD) = 7 AND YEAR(NgayLapHD) = 1996);
DELETE FROM HoaDon
WHERE MONTH(NgayLapHD) = 7 AND YEAR(NgayLapHD) = 1996;

/** CAU 2:  Xóa các hóa đơn của các khách hàng có loại là 'VL' mua hàng trong năm 1996 **/
DELETE FROM CT_HoaDon
WHERE MaHD IN (SELECT MaHD FROM HoaDon HD
    JOIN KhachHang KH ON HD.MaKh = KH.MaKh
    WHERE KH.LoaiKh = 'VL' AND YEAR(NgayLapHD) = 1996);
DELETE FROM HoaDon
WHERE MaHD IN (SELECT MaHD FROM HoaDon HD
    JOIN KhachHang KH ON HD.MaKh = KH.MaKh
    WHERE KH.LoaiKh = 'VL' AND YEAR(NgayLapHD) = 1996);
 /** CAU 3:   Xóa các sản phẩm chưa bán được trong năm 1996 **/
 DELETE FROM SanPham
WHERE MaSp NOT IN (SELECT DISTINCT MaSp FROM HoaDon HD
    JOIN CT_HoaDon CT ON HD.MaHD = CT.MaHD
    WHERE YEAR(NgayLapHD) = 1996);

 /** CAU 4: Xóa các khách hàng vãng lai (Loại là 'VL') cùng với hóa đơn và chi tiết hóa đơn của họ **/
 DELETE FROM CT_HoaDon
WHERE MaHD IN (SELECT MaHD FROM HoaDon HD
    JOIN KhachHang KH ON HD.MaKh = KH.MaKh
    WHERE KH.LoaiKh = 'VL');
DELETE FROM HoaDon
WHERE MaKh IN (SELECT MaKh FROM KhachHang
    WHERE LoaiKh = 'VL');
DELETE FROM KhachHang WHERE LoaiKh = 'VL';

  /** CAU 5:   Tạo bảng HoaDon797 chứa các hóa đơn được lập trong tháng 7 năm 1997, sau đó xóa bằng TRUNCATE **/
SELECT * INTO HoaDon797
FROM HoaDon
WHERE MONTH(NgayLapHD) = 7 AND YEAR(NgayLapHD) = 1997;
/** XOA **/
TRUNCATE TABLE HoaDon797;

