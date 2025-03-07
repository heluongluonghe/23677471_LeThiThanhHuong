USE QLBH
DELETE FROM NhomSanPham
DELETE FROM SanPham
DELETE FROM NhaCungCap
DELETE FROM HoaDon
DELETE FROM CT_HoaDon
DELETE FROM KhachHang


INSERT INTO NhomSanPham (MaNhom, TenNhom) VALUES (1, 'Đồ điện tử')
INSERT INTO NhomSanPham (MaNhom, TenNhom) VALUES (2, 'Đồ gia dụng')

INSERT INTO NhaCungCap (MaNCC, TenNcc, Diachi, Phone, SoFax, DCMail) VALUES (1, 'Công ty A', 'Hà Nội', '0123456789', '0241234567', 'contact@congtya.com')
INSERT INTO NhaCungCap (MaNCC, TenNcc, Diachi, Phone, SoFax, DCMail) VALUES (2, 'Công ty B', 'TP.HCM', '0987654321', '0289876543', 'info@congtyb.com')

INSERT INTO SanPham (MaSp, TenSp, MaNCC, MoTa, MaNhom, Đonvitinh, GiaGoc, SLTON) VALUES (1, 'Tủ lạnh', 1, 'Tủ lạnh 2 cánh', 1, 'Chiếc', 10000000, 5)
INSERT INTO SanPham (MaSp, TenSp, MaNCC, MoTa, MaNhom, Đonvitinh, GiaGoc, SLTON) VALUES (2, 'Nồi cơm điện', 2, 'Nồi cơm điện cao tần', 2, 'Chiếc', 1500000, 10)

INSERT INTO HoaDon (MaHD, NgayLapHD, NgayGiao, Noichuyen, MaKh) VALUES (1, GETDATE(), '2025-03-10', 'Hà Nội', 'KH001')
INSERT INTO HoaDon (MaHD, NgayLapHD, NgayGiao, Noichuyen, MaKh) VALUES (2, GETDATE(), '2025-03-15', 'TP.HCM', 'KH002')

INSERT INTO CT_HoaDon (MaHD, MaSp, Soluong, Dongia, ChietKhau) VALUES (1, 1, 2, 9500000, 500000);
INSERT INTO CT_HoaDon (MaHD, MaSp, Soluong, Dongia, ChietKhau) VALUES (2, 2, 1, 1400000, 100000);


INSERT INTO KhachHang (MaKh, LoaiKh, DiemTL) VALUES ('KH001', 'VIP', 200)
INSERT INTO KhachHang (MaKh, LoaiKh,DiemTL) VALUES ('KH002', 'Thường', 50)


UPDATE SanPham
SET GiaGoc = GiaGoc * 1.05
WHERE MaSp = 2

UPDATE SanPham
SET SLTON = SLTON + 100
WHERE MaNhom = 3 AND MaNCC = 2

UPDATE KhachHang
SET DiemTL= DiemTL + 50
WHERE LoaiKh <> 'Vãng lai'

UPDATE SanPham
SET MoTa = 'Sản phẩm tiện lợi cho gia đình, giúp nấu ăn nhanh chóng'
WHERE TenSp = 'Lò vi sóng';

-- e) Tăng đơn giá gốc lên 2% cho những sản phẩm mà tên chứa chữ 'u'
UPDATE SanPham
SET GiaGoc = GiaGoc * 1.02
WHERE TenSp LIKE '%u%'


DELETE FROM SanPham
WHERE SLTON < 2

DELETE FROM HoaDon
WHERE MaKh IN (SELECT MaKh FROM KhachHang WHERE LoaiKh = 'Vãng lai')

-- c) Xóa khách hàng thuộc loại VIP có điểm tích lũy bằng 0
DELETE FROM KhachHang
WHERE LoaiKh= 'VIP' AND DiemTL = 0
