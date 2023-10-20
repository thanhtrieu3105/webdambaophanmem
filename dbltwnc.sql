


create database QLDienThoai
go

use QLDienThoai


-------------------TẠO BẢNG-----------------
--Admin
CREATE TABLE Admin
(
	TKAdmin char(11) primary key, 
	MKAdmin nvarchar(8) NOT NULL,
	ChucVu nvarchar(20) NOT NULL,
)
insert into Admin
values ('09876543222','123456',N'Nhân Viên')
GO
--ThuongHieu
CREATE TABLE ThuongHieu
(
	MaTH CHAR(2) PRIMARY KEY,
	TenTH nvarchar(50) NOT NULL,
)

--SanPham
CREATE TABLE SanPham
(
	MaSP char(4) primary key,
	TenSP nvarchar(50) NOT NULL,
	MaTH char(2) not null  foreign key (MaTH) references ThuongHieu(MaTH) ,
	MoTaSP  nvarchar (1000),

)

GO

--HinhSP
CREATE TABLE HinhSP
(
	MaHinh varchar(20) primary key,
	MaSP char(4) foreign key(MaSP) REFERENCES SanPham(MaSP),
	
)
GO
--Mau
CREATE TABLE Mau
(
	MaMau char(3) primary key,
	TenMau nvarchar(50) NOT NULL,
)
GO

--DungLuong
CREATE TABLE DungLuong
(
	MaDL char(4) primary key,
	KichThuocDL nvarchar(50) NOT NULL,
	
)
GO

--ChiTietSP
CREATE TABLE ChiTietSP
(
	MaCTSP char (7) primary key,
	MaSP char(4) foreign key(MaSP) REFERENCES SanPham(MaSP),
	MaDL char(4)foreign key(MaDL) REFERENCES DungLuong(MaDL),
	MaMau char(3)foreign key(MaMau) REFERENCES Mau(MaMau),
	Gia int CHECK ( Gia >= 0),
	SoLuongKho INT ,
)
GO
--LOAI KH---
CREATE TABLE LoaiKH
(
	MaLoaiKH CHAR(5) PRIMARY KEY,
	TenLoaiKH nvarchar(50),
	ChiecKhau decimal (3,2)
	
)
GO

--KHACHHNAG
CREATE TABLE KhachHang 
(
	MaKH char(4) primary key,
	TenKH nvarchar(50) NOT NULL,
	SDT varchar(10) ,
	DiaChi nvarchar(100),
	GioiTinh nvarchar(3) check (GioiTinh in('Nam',N'Nữ')) ,
	NgaySinh  SMALLDATETIME,
	MK varchar(8),
	Email varchar(50),
	MaLoaiKH char(5) foreign key (MaLoaiKH) REFERENCES LoaiKH(MaLoaiKH),
)

GO
CREATE TABLE DonHang
(
	MaDH CHAR(4) primary key,
	MaKH char(4) NULL foreign key (MaKH) REFERENCES KhachHang(MaKH),
	TenNguoiNhan nvarchar(50) NOT NULL,
	SDTnhan char(10)  NOT NULL,
	DiaChiNhan nvarchar(100)  NOT NULL,
	TriGia int check (TriGia > 0),
	TinhTrang nvarchar(25),
	NgayDH SMALLDATETIME,
	HTThanhToan nvarchar(50),
	HTGiaohang nvarchar(50),
	TongTien int ,
)

GO

--ChiTietDH
CREATE TABLE ChiTietDH
(
	MaCTDH char(7) PRIMARY KEY,
	SoLuong int check(Soluong>0),
	GiaMua int ,
	Thanhtien int ,
	MaCTSP char (7) foreign key (MaCTSP) references ChiTietSP(MaCTSP),
	MaDH CHAR(4) foreign key (MaDH) references DonHang(MaDH),
	
)

GO
GO
select * from KhachHang
--TSKTSP--
CREATE TABLE TSKTSP
(
	MaTS int PRIMARY KEY,
	MaSP char(4) foreign key(MaSP) REFERENCES SanPham(MaSP),
	CongNgheManHinh varchar(50),
	DoPhanGiai varchar(50),
	ManHinhrong varchar(50),
	MatKinhCamUng nvarchar(50),
	DoPhanGiaiCamS nvarchar(100),
	QuayPhim varchar(500),
	Flash nvarchar (50),
	TinhNangCamS nvarchar (500),
	DoPhanGiaiCamT nvarchar(100),
	TinhNangCamT nvarchar (500),
	HeDieuHanh varchar(25),
	CPU nvarchar(100),
	TocDoCPU nvarchar (100),
	GPU nvarchar(50),
	RAM varchar(6),
	DungLuong  varchar(6),
	DungLuongCon nvarchar (50),
	DanhBa nvarchar (20),
	Mang nvarchar (20),
	Sim Nvarchar (100),
	Wifi nvarchar (100),
	GPS nvarchar (100),
	Bluetooth varchar(50),
	Sac varchar(100),
	Jack varchar(100),
	KetNoiKhac nvarchar (50),
	DungLuongPin varchar(15),
	LoaiPin varchar(25),
	SacToiDa nvarchar (50),
	CongNghePin nvarchar (100),
	BaoMatNC nvarchar (100),
	TinhNangDB nvarchar (250),
	KhangNuocBui nvarchar (50),
	XemPhim varchar(100),
	NgheNhac nvarchar (100),
	ThietKe nvarchar (50),
	ChatLieu nvarchar(50),
	KichThuoc nvarchar (100),
	ThoiDiemRaMat date ,
)
GO


create table BinhLuan
(
	MaBL int identity(1,1) primary key,
	MaSP CHAR(4) NOT NULL foreign key(MaSP) REFERENCES SanPham(MaSP)  ,
	MaKH char(4)   foreign key(MaKH) REFERENCES KhachHang(MaKH),
	HoTen nvarchar (30) not null ,
	SDT varchar(11) not null,
	Chiase nvarchar(250) ,
	Anh varchar(50),
	TrangThai bit,
	ThoiGian datetime
)

create table PhieuGiamGia(
	MaGG int identity (1,1) primary key,
	TenGiamGia nvarchar (30) not null,
	chietkhau dec(4,3) 
)
create table GiamGiaSP
(
	MaGGSP int identity primary key,
	MaSP char(4) not null foreign key(MaSP) references SanPham(MaSP),
	MaGG int not null foreign key(MaGG) references PhieuGiamGia(MaGG),
)
  



----KyThuat--
--CREATE TABLE KyThuat
--(
--	MaKT int Identity(1,1),
--	MaLoaiKT int NOT NULL,
--	TenKyThuat NTEXT,
--	CONSTRAINT PK_KyThuat PRIMARY KEY (MaKT)
--)
--GO

----LoaiKT--
--CREATE TABLE LoaiKT
--(
--	MaLoaiKT int Identity(1,1),
--	TenLoaiKT NTEXT,
--	CONSTRAINT PK_LoaiKT PRIMARY KEY (MaLoaiKT)
--)
--GO

----FK KhachHnag
--ALTER TABLE KhachHang ADD CONSTRAINT FK_KhachHang_LoaiKH FOREIGN KEY (MaLoaiKH) REFERENCES LoaiKH(MaLoaiKH)
--GO

----FK SanPham
--ALTER TABLE SanPham ADD CONSTRAINT FK_SanPham_ThuongHieu FOREIGN KEY (MaTH) REFERENCES ThuongHieu(MaTH)
--GO

---- FK CHITIETSP
--ALTER TABLE ChiTietSP ADD CONSTRAINT FK_ChiTietSP_SanPham FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP)
--ALTER TABLE ChiTietSP ADD CONSTRAINT FK_ChiTietSP_Mau FOREIGN KEY (MaMau) REFERENCES Mau(MaMau)
--ALTER TABLE ChiTietSP ADD CONSTRAINT FK_ChiTietSP_DungLuong FOREIGN KEY (MaDL) REFERENCES DungLuong(MaDL)
--GO

----FK TSKTSP
--ALTER TABLE TSKTSP ADD CONSTRAINT FK_TSKTSP_SanPham FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP)
--ALTER TABLE TSKTSP ADD CONSTRAINT FK_TSKTSP_KyThuat FOREIGN KEY (MaKT) REFERENCES KyThuat(MaKT)

----FK KT
--ALTER TABLE KyThuat ADD CONSTRAINT FK_KyThuat_LoaiKT FOREIGN KEY (MaLoaiKT) REFERENCES LoaiKT(MaLoaiKT)
--GO


----HinhSP
--ALTER TABLE HinhSP ADD CONSTRAINT FK_HinhSP_SanPham FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP)
--GO 


----FK Ct DonHang
--ALTER TABLE ChiTietDH ADD CONSTRAINT FK_ChiTietDH_SanPham FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP)
--ALTER TABLE ChiTietDH ADD CONSTRAINT FK_ChiTietDH_DonHang FOREIGN KEY (MaDH) REFERENCES DonHang(MaDH)
--GO

----FK DONHANG
--ALTER TABLE DonHang ADD CONSTRAINT FK_DonHang_KhachHang FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH)
--GO

insert into ThuongHieu
values ('IP','IPHONE')
insert into ThuongHieu
values ('SS','SAMSUNG')
insert into ThuongHieu
values ('OP','OPPO')
insert into ThuongHieu
values ('HW','HUAWEI')
insert into ThuongHieu
values ('RM','REALME')
insert into ThuongHieu
values ('VV','VIVO')
insert into ThuongHieu
values ('XM','XIAO MI')

insert into DungLuong
values ('DL01','128GB')
insert into DungLuong
values ('DL02','256GB')
insert into DungLuong
values ('DL04','512GB')
insert into DungLuong
values ('DL05','1T')
insert into DungLuong
values ('DL06','64GB')

insert into Mau
values ('M01',N'Trắng')
insert into Mau
values ('M02',N'Đen')
insert into Mau
values ('M03',N'Xám')
insert into Mau
values ('M04',N'Bạc')
insert into Mau
values ('M05',N'Vàng')
insert into Mau
values ('M06',N'Đỏ')
insert into Mau
values ('M07',N'Tím')
insert into Mau
values ('M08',N'Xanh lá')
insert into Mau
values ('M09',N'Xanh dương')
insert into Mau
values ('M10',N'Hồng')
insert into Mau
values ('M11',N'Cam')


----SAN PHAM---------
-------------HUAWEI----------
insert into SanPham (MaSP,TenSP,MaTH,MoTaSP)
values ('HW01','Huawei hornor 20','HW',N'Kích thước của màn hình là 6.26 inch, tuy nhiên do tỉ lệ màn hình trên thân máy cao, cùng thiết kế bo cong ở mặt lưng, người dùng vẫn có thể dễ dàng cầm nắm và sử dụng.
Chiếc smartphone Honor này cho độ sáng màn hình khá cao, góc nhìn rộng giúp việc sử dụng dưới điều kiện ánh nắng ngoài trời không gặp phải bất cứ khó khăn gì.
Để việc mở khóa nhanh và chính xác, Honor 20 vẫn duy trì cảm biến vân tay điện dung ở một vị trí thuận lợi phía sau mặt lưng của máy.')

insert into SanPham (MaSP,TenSP,MaTH,MoTaSP)
values ('HW02','Huawei mate 30','HW',N'Huawei Mate 30 là một phiên bản thu gọn của chiếc Huawei Mate 30 Pro với giá phải chăng hơn bản Pro và đi kèm một số thay đổi trong thiết lập màn hình, camera.
Camera vẫn rất ấn tượng trong phân khúc
Camera luôn là một trong những đặc điểm nổi bật nhất của những chiếc smartphone tới từ Huawei với với chiếc Huawei Mate 30 thì một lần nữa người dùng lại được kiểm chứng điều này.')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('HW04','Huawei mate 50','HW',N'Điện thoại Huawei Mate 50 - Hiệu năng mạnh mẽ trong phân khúc cận cao cấp
Sau thành công vang dội từ Mate 40, thương hiệu điện tử xứ Hoa ngữ Huawei nay đã giới thiệu đến người dùng sản phẩm Huawei Mate 50 cùng với Mate 50 Pro. Với thiết kế đẹp mắt cùng hiệu năng ấn tượng, đây hứa hẹn sẽ là mẫu smartphone đáng chú ý trong phân khúc cận cao cấp.')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('HW05','Huawei mate x2','HW', N'Huawei Mate X2 chính là chiếc smartphone màn hình gập thế hệ tiếp theo của nhà Huawei với nhiều cải tiến vượt bậc. Smartphone sở hữu màn hình gập hiện đại, thiết kế sang trọng cuốn hút cùng hiệu năng mạnh mẽ từ chip SoC Kirin 9000 5G, sạc nhanh siêu tốc 55W,…hứa hẹn mở ra những trải nghiệm tuyệt hảo cho người dùng.
Huawei Mate X2 – Mặt kính cong 3D, thiết kế gập ngang chuyển đổi tablet và điện thoại
Huawei Mate X2 tiếp nối những thành công của người anh em tiền nhiệm là Mate X và có những cải tiến nâng cao chất lượng và trải nghiệm cho người dùng. Smartphone sở hữu công nghệ màn hình siêu tràn viền trong một thiết kế nổi bật, cấu hình vượt trội và cụm camera chuyên nghiệp.')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('HW06','Huawei nova 5T','HW',N'Huawei Nova 5T sử dụng màn hình IPS LCD 6.26 inch độ phân giải FHD thiết kế màn hình dạng nốt ruồi 
Với Nova 5T, Huawei trang bị cho flagship này công nghệ màn hình IPS, công nghệ màn hình này có khả năng cho chất lượng ảnh tươi, độ tái tạo màu sắc tuyệt vời. Khi áp dụng công nghệ này lên màn hình 6.26 inch cùng độ phân giải FHD hứa hẹn đây sẽ là một sản phẩm có màn hình đẹp nhất trên thị trường hiện nay với 16,7 triệu màu, độ bão hòa màu đạt 96%.')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('HW07','Huawei nova 9','HW',N'Đánh giá điện thoại Huawei Nova 9 – Thiết kế cao cấp trên một thiết bị tầm trung
Huawei Nova 9 là dòng sản phẩm tiếp nối sự thành công của phiên bản Nova 7 trước đó. Ở phiên bản lần này, Huawei mang đến cho người dùng thiết kế cao cấp hơn cùng kết nối 5G siêu tốc nhờ tích hợp vi xử lý Kirin 985 cao cấp của hãng.
Thiết kế đẳng cấp với chất liệu kính mới ở mặt lưng
Ở mỗi thế hệ điện thoại Huawei Nova đều mang đếng một thiết kế mới. Lần này, Huawei Nova 9 truyền cảm hứng đến người dùng với một thiêt kế màn hình cong tràn ấn tượng. Công nghệ phủ màu Xingsha Magic mang đến vẻ ngoài lộng lẫy hơn ở mặt lưng của máy.')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('HW08','Huawei P30 pro','HW',N'Điện thoại Huawei P30 Pro – Siêu phẩm Flagship tiếp theo của Huawei
Huawei P30 Pro, Huawei P30 và P30 Lite là 3 mẫu điện thoại mới nhất sẽ được Huawei ra mắt vào ngày 26/3 tại Paris, Pháp. Trong đó, P30 Pro là phiên bản cao cấp nhất với nhiều công nghệ đột phá đặt biệt là camera. Với dòng P của mình Huawei cho thấy khả năng dẫn đầu mảng cameraphone. Ngoài ra, bạn cũng có thể tham khảo thêm điện thoại Huawei 40 Pro với nhiều cải tiến đáng kể về camera.')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('HW09','Huawei P40','HW',N'Điện thoại Huawei P40 – Ba camera chụp ảnh đỉnh cao và hiệu năng mạnh mẽ
Huawei P40 và P40 Pro là một mẫu flagship mới của nhà Huawei và luôn bắt kịp với xu hướng hiện đại, P40 cũng được trang bị hệ thống 4 camera đỉnh cao, hiệu năng mạnh mẽ đáp ứng mọi nhu cầu sử dụng. Bên cạnh đó, máy còn sở hữu thiết kế cao cấp, quyến rũ với màn hình đục lỗ mới nhất cùng chất liệu kim loại và kính sang trọng, tạo nên một smartphone tuyệt đẹp. Ngoài ra, bạn cũng có thể tham khảo thêm điện thoại Huawei P40 Pro với cấu hình, camera chất lượng hơn.')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('HW10','Huawei P40 PRO','HW',N'Điện thoại Huawei P40 Pro - Smartphone cao cấp với camera siêu nét
Thời gian gần đây, gã khổng lồ nổi tiếng đến từ Trung Quốc Huawei luôn "khuấy đảo" thị trường smartphone với những thiết bị flagship cao cấp cùng cấu hình ấn tượng. Và một trong những chiếc flagship được hãng cho ra mắt trong năm 2020 đó là Huawei P40 Pro và Huawei P40. Trong đó, P40 Pro là smartphone sở hữu màn hình cong lớn, vi xử lý mạnh mẽ cùng camera có độ phân giải siêu nét. Ngoài ra, khách hàng có thể tham khảo điện thoại Huawei P50 Pro với nhiều nâng cấp về camera.')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('HW11','Huawei P50','HW',N'Điện thoại Huawei P50 – Chiếc flagship sở hữu chất liệu cao cấp, camera siêu ấn tượng
Huawei chưa bao giờ làm người dùng thất vọng với những chiếc điện thoại cao cấp của hãng. Tính cho đến thời điểm hiện tại, Huawei đã đánh cột mốc với 5 thế hệ flagship bằng chiếc Huawei P50 (ra mắt cùng Huawei P50 Pro). Thiết bị sở hữu con chip mới, viên pin lớn cùng hệ thống 5 camera sau.')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('HW12',' Huawei P50 Pro','HW',N'Điện thoại Huawei P50 Pro – Smartphone tiên phong trong nhiếp ảnh điện thoại
Khi nhắc đến những chiếc điện thoại có camera ấn tượng, dòng Huawei P luôn nằm trong danh sách đó. Huawei P50 Pro ra mắt nhằm khẳng định vị thế tiên phong trong nhiếp trên điện thoại cùng hàng loạt công nghệ đỉnh cao mang đến khả năng sáng tạo cũng như trải nghiệm sử dụng hoàn hảo đến người dùng.')

--------IPHONE
insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('IP01','iPhone X','IP',N'Thiết kế cao cấp tinh tế - 2 mặt kính, khung viền kim loại
Hình ảnh sắc nét, màu sắc chân thực với màn hình Retina, công nghệ True Tone
Chơi game thả ga với chip Apple A11, 3GB RAM
Chụp ảnh xóa phông chuyên nghiệp chỉ với 1 camera đơn 12MP')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('IP02','iPhone XS','IP',N'iPhone XS cũ 256GB cũ đẹp là máy đã qua sử dụng, ngoại hình tương tự như iPhone X cũ với hình thức không bị rơi móp tính năng sử dụng bình thường và có thể máy có trầy xước nhẹ nhưng không đáng kể. Đối với máy 99% khi nhập về chúng tôi sẽ mở máy để kiểm tra phần cứng bên trong.
Nếu máy cũ có bị chai pin thì chúng tôi sẽ thay pin Pisen vào, hoặc những phần linh kiện nhỏ nếu có trục trặc thì sẽ thay thế để máy dùng tốt hơn. Máy cũ có thể đã qua sửa chữa để đảm bảo hoạt động ổn định. Bảo hành 6 tháng. Đặc biệt, 30 ngày đầu 1 đổi 1 khi có lỗi từ phần cứng.
Nếu nhu cầu lưu trữ của bạn thấp thì iPhone XS 64GB cũ sẽ là lựa chọn phù hợp hơn.')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('IP03','iPhone 11 Pro','IP',N'iĐiện thoại iPhone 11 Pro 512GB cũ được CellphoneS thu mua từ khách hàng có nhu cầu bán lại, đổi trả hoặc tham gia các chương trình thu cũ đổi mới, lên đời sản phẩm. Trong đó có nhiều sản phẩm vừa kích hoạt bảo hành hãng, còn thời gian bảo hành chính hãng dài và hình thức như mới, vì vậy bạn có thể hoàn toàn an tâm. Nếu nhu cầu sử dụng của bạn không quá nhiều thì có thể tham khảo iPhone 11 Pro 256GB cũ.')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('IP04','iPhone 12 Mini','IP', N'Mạnh mẽ, siêu nhanh với chip A14, RAM 4GB, mạng 5G tốc độ cao
Rực rỡ, sắc nét, độ sáng cao - Màn hình OLED cao cấp, Super Retina XDR hỗ trợ HDR10, Dolby Vision
Chụp đêm ấn tượng - Night Mode cho 2 camera, thuật toán Deep Fusion, Smart HDR 3
Bền bỉ vượt trội - Kháng nước, kháng bụi IP68, mặt lưng Ceramic Shield')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('IP05','iPhone 12 Pro','IP',N'Mạnh mẽ, siêu nhanh với chip A14, RAM 6GB, mạng 5G tốc độ cao
Rực rỡ, sắc nét, độ sáng cao - Màn hình OLED cao cấp, Super Retina XDR hỗ trợ HDR10, Dolby Vision
Chụp ảnh siêu đỉnh - Night Mode , thuật toán Deep Fusion, Smart HDR 3, camera LiDar
Bền bỉ vượt trội - Kháng nước, kháng bụi IP68, mặt lưng Ceramic Shield')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('IP06','iPhone 12 Pro Max','IP', N'Mạnh mẽ, siêu nhanh với chip A14, RAM 6GB, mạng 5G tốc độ cao
Rực rỡ, sắc nét, độ sáng cao - Màn hình OLED cao cấp, Super Retina XDR hỗ trợ HDR10, Dolby Vision
Chụp ảnh siêu đỉnh - Night Mode , thuật toán Deep Fusion, Smart HDR 3, camera LiDar
Bền bỉ vượt trội - Kháng nước, kháng bụi IP68, mặt lưng Ceramic Shield')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('IP07','iPhone 13','IP', N'Hiệu năng vượt trội - Chip Apple A15 Bionic mạnh mẽ, hỗ trợ mạng 5G tốc độ cao
Không gian hiển thị sống động - Màn hình 6.1" Super Retina XDR độ sáng cao, sắc nét
Trải nghiệm điện ảnh đỉnh cao - Camera kép 12MP, hỗ trợ ổn định hình ảnh quang học
Tối ưu điện năng - Sạc nhanh 20 W, đầy 50% pin trong khoảng 30 phút')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('IP08','iPhone 13 Pro','IP',N'Hiệu năng vượt trội - Chip Apple A15 Bionic mạnh mẽ, hỗ trợ mạng 5G tốc độ cao
Không gian hiển thị sống động - Màn hình 6.1" Super Retina XDR độ sáng cao, sắc nét
Trải nghiệm điện ảnh đỉnh cao - Cụm 3 camera 12MP, hỗ trợ ổn định hình ảnh quang học
Tối ưu điện năng - Sạc nhanh 20 W, đầy 50% pin trong khoảng 30 phút')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('IP09','iPhone 13 Pro Max','IP',N'Hiệu năng vượt trội - Chip Apple A15 Bionic mạnh mẽ, hỗ trợ mạng 5G tốc độ cao
Không gian hiển thị sống động - Màn hình 6.7" Super Retina XDR độ sáng cao, sắc nét
Trải nghiệm điện ảnh đỉnh cao - Cụm 3 camera kép 12MP, hỗ trợ ổn định hình ảnh quang học
Tối ưu điện năng - Sạc nhanh 20 W, đầy 50% pin trong khoảng 30 phút')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('IP10','iPhone 14','IP',N'Tuyệt đỉnh thiết kế, tỉ mỉ từng đường nét - Nâng cấp toàn diện với kiểu dáng mới, nhiều lựa chọn màu sắc trẻ trung
Nâng tầm trải ngiệm giải trí đỉnh cao - Màn hình 6,1"" cùng tấm nền OLED có công nghệ Super Retina XDR cao cấp
Chụp ảnh chuyên nghiệp hơn - Cụm 2 camera 12 MP đi kèm nhiều chế độ và chức năng chụp hiện đại
Hiệu năng hàng đầu thế giới - Apple A15 Bionic 6 nhân xử lí nhanh, ổn định')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('IP11','iPhone 14 Pro','IP', N'Trải nghiệm thị giác ấn tượng - Màn hình Dynamic Island, sắc nét với công nghệ Super Retina XDR, mượt mà 120 Hz
Tuyệt đỉnh thiết kế, tỉ mỉ từng đường nét - Nâng cấp toàn diện với kiểu dáng mới, nhiều lựa chọn màu sắc trẻ trung
Hiệu năng hàng đầu thế giới - Apple A16 Bionic xử lí nhanh, ổn định mọi tác vụ
Camera chuẩn nhiếp ảnh chuyên nghiệp - Camera sau 48MP trang bị nhiều công nghệ chụp đa dạng')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('IP12','iPhone 14 Pro Max','IP',N'Màn hình Dynamic Island - Sự biến mất của màn hình tai thỏ thay thế bằng thiết kế viên thuốc, OLED 6,7 inch, hỗ trợ always-on display
Cấu hình iPhone 14 Pro Max mạnh mẽ, hiệu năng cực khủng từ chipset A16 Bionic
Làm chủ công nghệ nhiếp ảnh - Camera sau 48MP, cảm biến TOF sống động
Pin liền lithium-ion kết hợp cùng công nghệ sạc nhanh cải tiến')

-------------SAMSUNG--------
insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('SS01','SamSung Galaxy A53 5G','SS',N'Màu sắc rực rỡ, hiển thị chân thực - Màn hình 6.5 inches, Super AMOLED
Trọng lượng nhẹ, kháng bụi kháng nước tốt - Nhẹ chỉ 190g, kháng nước, bụi IP67
Ảnh chụp có chi tiết cao, nhiều tính năng mới mẻ - Cụm 4 camera 64MP, đa dạng chế độ chụp
Trải nghiệm mượt mà trên mọi tác vụ - Exynos 1280 8 nhân, RAM 8GB')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('SS02','SamSung Galaxy M53','SS',N'Bốn góc vẫn được bo viền để tạo cảm giác chắc tay khi cầm nắm nhưng do thân máy lớn, Samsung Galaxy M53 tạo cảm giác hơi khó cầm cho những ai sở hữu bàn tay nhỏ. Chiếc điện thoại này đặc biệt phù hợp với phái mạnh - những người sở hữu bàn tay lớn.
Mặt lưng vẫn được trang bị cụm Camera nằm ở góc trái phía trên được đóng trong khung hình chữ vuông quen thuộc cùng logo Samsung nổi bật tạo nên chất riêng hiện đại, mạnh mẽ mà không kém phần cá tính đặc trưng của dòng Samsung Galaxy M. Khung Bezel có tác dụng bảo vệ cấu trúc điện thoại đồng thời mang đến cảm giác cao cấp hơn cho thiết kế, giúp những chiếc Samsung Galaxy M53 mang màu sắc thời thượng và tinh mỹ hơn.')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('SS03','SamSung Galaxy Note 10','SS',N'Với hàng loạt những siêu phẩm từng tung ra thị trường, điện thoại Samsung lại một lần nữa làm cộng đồng người yêu công nghệ phải đứng ngồi không yên khi trình làng bộ đôi Samsung Galaxy Note 10 và Note 10 Plus mang đến những trải nghiệm tuyệt đỉnh như máy tính ngay từ chính chiếc smartphone của bạn, giúp bạn có thể làm mọi thứ chỉ bằng một chiếc điện thoại. Ngoài ra, bạn cũng có thể tham khảo phiên bản rút gọn với giá bán phải chăng hơn là Samsung Note 10 Plus.
Mặc dù Samsung Galaxy Note 20 sắp được ra mắt nhưng hiện tại Note 10 vẫn đang là sự lựa chọn hợp lý với giá tốt đi kèm nhiều tính năng cao cấp.')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('SS04','SamSung Galaxy Note 20','SS',N'Màn hình 6.7 inch mở ra góc nhìn lớn hơn, rộng hơn để bạn có thể tận hưởng mọi thước phim, “chiến” game, xử lý hình ảnh, video,… hoàn hảo. Samsung luôn sử dụng những công nghệ tiên tiến nhất cho các sản phẩm smartphone của mình khi trang bị cho Note 20 màn hình Dynamic AMOLED – màn hình tốt nhất của Samsung. Màn hình Dynamic AMOLED với khả năng tự động điều chỉnh màu sắc, 16 triệu màu và 100% dải màu giúp tái tạo màu sắc chân thực, chính xác, gần với thực tế để mang đến khung hình sống động, tuyệt vời.')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('SS05','SamSung Galaxy S21','SS',N'Thiết kế cao cấp - Vẻ đẹp tinh tế cùng nhiều màu sắc thời thượng
Trọn vẹn từng khung hình - Màn hình 6.4"", độ sáng cao cùng tần số quét 120Hz
Sắc nét từng khung hình - Bộ ba camera 12MP, hỗ trợ quay video 4K, chống rung điện từ EIS
Mượt mà mọi tác vụ - Chip Exynos 2100 tiến trình 5nm mạnh mẽ')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('SS06','SamSung Galaxy S21 Ultra','SS',N'Giải trí đỉnh cao - Màn hình AMOLED 6.8 inch, độ phân giải 2K, tần số quét cao 120Hz
Chụp ảnh, quay video siêu nét - 4 camera mạnh mẽ, quay phim 8K, quay phim siêu chống rung.
Tốc độ vượt trội, chơi game đỉnh cao - Exynos 2100 8 nhân 5nm, RAM 8GB, bộ nhớ tốc độ cao UFS 3.1
Trải nghiệm thả ga - Pin 5000mAh, hỗ trợ sạc nhanh lên đến 25W, công nghệ pin thông minh')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('SS07','SamSung Galaxy S21 FE','SS',N'Vi xử lý mạnh mẽ nhất Galaxy - Snapdragon 8 Gen 1 (4 nm)
Camera mắt thần bóng đêm Nightography - Chụp đêm cực đỉnh
S Pen đầu tiên trên Galaxy S - Độ trễ thấp, dễ thao tác
Dung lượng pin bất chấp ngày đêm - Viên pin 5000mAh, sạc nhanh 45W')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('SS08','SamSung Galaxy S22','SS',N'Camera mắt thần bóng đêm Nightography - Ghi lại khoảnh khắc đêm diệu kì
Mãn nhãn từng khoảnh khắc - Màn hình 6.1", Dynamic AMOLED 2X, 120Hz
Bứt phá hiệu năng - Snapdragon 8 Gen 1 (4 nm)
Thỏa sức trải nghiệm chỉ với một lần sạc - Viên pin 3700 mAh, sạc nhanh 25W, sạc không dây')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('SS09','SamSung Galaxy S22 Ultra','SS',N'Vi xử lý mạnh mẽ nhất Galaxy - Snapdragon 8 Gen 1 (4 nm)
Camera mắt thần bóng đêm Nightography - Chụp đêm cực đỉnh
S Pen đầu tiên trên Galaxy S - Độ trễ thấp, dễ thao tác
Dung lượng pin bất chấp ngày đêm - Viên pin 5000mAh, sạc nhanh 45W')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('SS10','SamSung Galaxy S23 8GB – 256GB','SS', N'ĐẶC ĐIỂM NỔI BẬT
Dẫn đầu công nghệ chụp đêm - Camera lên đến 50MP, zoom xa rõ nét, vi xử lí AI, công nghệ ảnh siêu chi tiết
Hiệu năng vượt trội - Snapdragon 8 Gen 2 8 nhân mạnh mẽ
Đa nhiệm mượt mà - RAM lớn 8G, dễ dàng chuyển đổi giữa các thiết bị
Thiết kế vì hành tinh - Màu sắc lấy cảm hứng từ thiên nhiên, chất liệu kính và lớp phim phủ PET tái chế')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('SS11','SamSung Galaxy Z Flip','SS',N'Samsung Galaxy Z Flip được trang bị 2 camera chính với cảm biến chính 12MP f/1.8 và camera góc siêu rộng 12MP f/2.2, phía trong có thêm camera selfie 10MP f/2.4 cho phép người dùng có thể lưu lại những khoảnh khắc tuyệt vời nhất với những bức ảnh chất lượng cao. Galaxy Z Flip hoàn toàn có thể cho bạn khả năng chụp ảnh chuyên nghiệp.
Tham khảo thêm điện thoại Samsung Z Flip 3 với thiết kế mới cùng nhiều nâng cấp về hệ thống camera, màn hình và hiệu năng.')

insert into SanPham(MaSP,TenSP,MaTH,MoTaSP)
values ('SS12','SamSung Galaxy Z Fold 3','SS',N'Thiết kế độc đáo tiện lợi, khẳng định đẳng cấp - Thiết kế gập mở, chất liệu cao cấp, bản lề chắc chắn
Màn hình kép ấn tượng - Màn hình chính 7.9" và màn hình phụ: 6.23", 120Hz chuyển động mượt mà
Hệ thống camera siêu ấn tượng - Bộ 3 ống kính camera 12MP, camera selfie ẩn dưới màn hình
Hiệu năng ấn tượng, làm chủ tốc độ - Snapdragon 888 kết hợp RAM 12GB, hỗ trợ 5G')



-------THONG SO KY THUAT
-------TSKT HUAWEI---------
insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('1','HW01','IPS LCD','Full HD+ (1080 x 2340 Pixels)','6.26"',N'Mặt kính cong 2.5D',N'Chính 48 MP & Phụ 16 MP, 2 MP, 2 MP','FullHD 1080p@60fpsFullHD 1080p@30fps4K 2160p@30fps',N'Có',N'Làm đẹp (Beautify) Tự động lấy nét (AF) Chạm lấy nét Nhận diện khuôn mặtHDR Toàn cảnh (Panorama) Siêu cận (Macro) Góc siêu rộng (Ultrawide)Góc rộng (Wide) Xóa phông','32 MP',N'Tự động lấy nét (AF) Nhận diện khuôn mặt Làm đẹp HDR Quay video Full HD Quay video HDFlash màn hình','Android 9 (Pie)',
N'Kirin 980 8 nhân',N'2 nhân 2.6 GHz, 2 nhân 1.92 GHz & 4 nhân 1.8 GHz','Mali-G76 MP10','6 GB','128 GB',N'Đang cập nhật',N'Không giới hạn',N'Hỗ trợ 4G','2 Nano SIM','Dual-band (2.4 GHz/5 GHz)Wi-Fi hotspotWi-Fi DirectWi-Fi 802.11 a/b/g/n/ac','GLONASSGPS','v4.2LEapt-Xv5.0','Type-C','','','3750 mAh','Li-Po','',N'Sạc pin nhanh Tiết kiệm pin',
N'Mở khoá khuôn mặt Mở khóa bằng vân tay',N'Chặn cuộc gọiChặn tin nhắn','','H.265 3GP MP4 H.263','FLAC AAC WAV',N'Nguyên khối',N'Khung kim loại & Mặt lưng kính cường lực',N'Nặng 174 g','')

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('2','HW02','OLED','Full HD+ (1080 x 2340 Pixels)','6.62"',N'Mặt kính cong 3D',N'Chính 40 MP & Phụ 16 MP, 8 MP','FullHD 1080p@60fps4K 2160p@30fps 4K 2160p@60fps FullHD 1080p@30fps FullHD 1080p@120fps',N'Đèn LED 2 tông màu',N'Chống rung điện tử kỹ thuật số (EIS) Lấy nét bằng laser Làm đẹp (Beautify) Chuyên nghiệp (Pro)Tự động lấy nét (AF) Chạm lấy nét Nhận diện khuôn mặtHDR Toàn cảnh (Panorama) Quay Siêu chậm (Super Slow Motion) Nhãn dán (AR Stickers)Vẽ ánh sáng (Light Painting) Ban đêm (Night Mode) Zoom quang học Điều chỉnh khẩu độAI Camera Lấy nét theo pha (PDAF) Google LensQuay chậm (Slow Motion) Xóa phông Trôi nhanh thời gian (Time Lapse) Góc siêu rộng (Ultrawide) Góc rộng (Wide)',N'Chính 24 MP & Phụ TOF 3D',N'Tự động lấy nét (AF) Nhận diện khuôn mặtLàm đẹp HDRQuay video Full HDQuay video HDChụp bằng cử chỉFlash màn hìnhNhãn dán (AR Stickers)','Android 10',
N'Kirin 990 8 nhân',N'2 nhân 2.86 GHz, 2 nhân 2.09 GHz & 4 nhân 1.86 GHz','Mali-G76 MP16','6 GB','128 GB',N'Khoảng 112 GB',N'Không giới hạn',N'Hỗ trợ 4G',N'2 Nano SIM (SIM 2 chung khe thẻ nhớ)','Wi-Fi 802.11 a/b/g/n/acWi-Fi DirectWi-Fi hotspotDual-band (2.4 GHz/5 GHz)DLNA','GPSGLONASS','A2DPapt-Xv5.1','Type-C','3.5 mm','OTGHồng ngoạiNFC','4200 mAh','Li-Po','',N'Sạc không dây Tiết kiệm pin Siêu tiết kiệm pin Sạc pin nhanh Sạc ngược không dây',
N'Mở khoá khuôn mặt Mở khóa bằng vân tay',N'Ứng dụng kép (Nhân bản ứng dụng),Thu nhỏ màn hình sử dụng một tay,Chặn cuộc gọi,Chặn tin nhắn','','3GP,MP4,H.264(MPEG4-AVC)','FLAC,AMR,MP3,Midi',N'Nguyên khối',N'Khung kim loại & Mặt lưng kính',N'Nặng 196 g','')

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('4','HW04','OLED','Đang cập nhật','6.73"',N'Mặt kính cong 3D',N'Đang cập nhật','FullHD 1080p@30fps 4K 2160p@30fps',N'Đèn LED 2 tông màu',N'AI Camera,Làm đẹp (Beautify),Chuyên nghiệp (Pro)',N'Camera góc siêu rộng: 13 MP, f/2.4, 18mm','4K@30/60fps, 1080p@30/60fps','EMUI 13',
N'Chipset Snapdragon 8+ 4G Thế hệ 1 (4 nm)',N'Loại CPU1x3,19 GHz Cortex-X2 & 3x2,75 GHz Cortex-A710 & 4x2,0 GHz Cortex-A510','Adreno 730','8 GB','256 GB',N'Đang cập nhật',N'Không giới hạn',N'Hỗ trợ 4G',N'Thẻ SIM2 SIM (Nano-SIM)',N'802.11 a / b / g / n / ac / 6, băng tần kép, Wi-Fi Direct, điểm phát sóng',N'Có, với A-GPS','v5.2, A2DP, LE',N'Sạc không dây nhanh 50W','3.5 mm',N'OTGHồng ngoạiNFC','4700  mAh','Li-Po',N'Sạc nhanh 66W ',N'Sạc không dây nhanh 50W',
N'Cảm biến vân tay Cảm biến vân tay trong màn hình',N'Chặn cuộc gọiChặn tin nhắn',N'Chỉ số kháng nước, bụi IP68','3GP WMV MP4','FLAC AMR AAC',N'Nguyên khối',N'Khung nhôm & Mặt lưng kính cường lực',N'Nặng 295 g','01/02/2021')

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('5','HW05','OLED','Full HD+ (1080 x 2340 Pixels)','8.0 "',N'tốc độ làm mới 90 Hz, 413 ppi',N'Chính  50MP, f/1.9, OIS & Phụ 16MP, f/2.2, 12MP, f/2.4','1080p@960fps',N'Có',N'Chân dung, Toàn cảnh, Chụp nụ cười, Phản chiếu trong gương, Điều khiển âm thanh, Hẹn giờ',N'Camera góc rộng: 16MP, f/2.2',N'Tự động lấy nét (AF) Nhận diện khuôn mặt','Android 10',
N'Chipset HUAWEI Kirin 9000',N'CPU1 x Cortex-A77@3,13 GHz + 3 x Cortex-A77@2,54 GHz + 4 x Cortex-A55@2,05 GHz','GPUMali-G78 24 nhân','8 GB','256 GB',N'',N'Không giới hạn',N'NFC CóHỗ trợ mạng5G',N'Thẻ SIM2 SIM (Nano-SIM)','802.11 a/b/g/n/ac/ax','GPS / AGPS / GLONASS/ BeiDou / GALILEO','v5.2','Type-C','','','4500 mAh','Li-Po','',N'',
N'Các loại cảm biến',N'Chặn cuộc gọiChặn tin nhắn','','3GP WMV MP4','FLAC AMR AAC',N'Nguyên khối',N'Khung nhôm & Mặt lưng kính cường lực',N'Nặng 295 g','02/02/2021')

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('6','HW06','IPS LCD','1080 x 2340 pixels (FullHD+)','6.26"',N'',N'Chính 48 MP & Phụ 16 MP, 2 MP, 2 MP',' 720p@30fps, 1080p@30fps, 720p@240fps,720p@960fps,1080p@60fps, 1080p@120fps, Quay phim 4K 2160p@30fps',N'Có',N' Góc siêu rộng (Ultrawide)Góc rộng (Wide) Xóa phông','32 MP',N'Tự động lấy nét (AF) Nhận diện khuôn mặt','Android  9.0',
N'ChipsetKirin 980 8 nhân',N'CPU2 nhân 2.6 GHz, 2 nhân 1.92 GHz & 4 nhân 1.8 GHz','Mali-G76 MP10','8 GB','128 GB',N'Đang cập nhật',N'Không giới hạn',N'Hỗ trợ 5G','2 Nano SIM',' hotspot','BDS, A-GPS, GLONASS','A2DP, LE, apt-X, v5.0','Type-C','Type-C','NFC,OTG','3750  mAh','Li-Po','',N'Sạc pin nhanh ',
N'Mở khoá khuôn mặt Mở khóa bằng vân tay',N'Chặn cuộc gọi Chặn tin nhắn Khoá ứng dụng','','Xvid WMV MP4','FLAC eAAC+ WAV',N'Nguyên khối',N'Khung kim loại & Mặt lưng kính cường lực',N'Nặng 174 g','01/02/2020')

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('7','HW07','OLED','Full HD+ (1080 x 2340 Pixels)','6.7"',N'Mặt kính cong 3D',N'68 MP, phụ 16 MP, 2 MP, 2 MP','4K, 1080p, 720p@960fps, gyro-EIS',N'Có',N'Quay video4K',N'16 MP, f/2.0,32 MP, f/2.4, 100˚',N'Quay video trước4K,Camera góc siêu rộng ','Android 10',
N'Chipset Kirin 985 5G',N'CPUOcta-coreGPUMali-G77 (8-core)',' LEGPSA-GPS','8 GB','256 GB',N'Đang cập nhật',N'Không giới hạn',N'Hỗ trợ 5G','2 Nano SIM','802.11 a/b/g/n/a/6, dual-band, Wi-Fi Direct, hotspot','GLONASS, BDS, GALILEO, QZSS, NavIC','5.2','Type-C','Type-C','NFC,OTG','4000  mAh','Li-Po',N'60% trong 15 phút, 100% trong 35 phút',N'Sạc nhanh 66W',
N'Mở khoá khuôn mặt Mở khóa bằng vân tay','','',N'có',N'Có',N'Nguyên khối',N'Đang cập nhật',N'Dài 160 mm - Ngang 73.7 mm - Dày 7.8 mm - Nặng 175 g','10/9/2021')

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('8','HW08','OLED','1080 x 2340 pixels (FullHD+)','6.4"',N'cảm ứng điện dung',N'40 MP, 20 MP và 8 MP ',N' 1080p@30fps, 960 fps 4K 2160p@30fps',N'Có',N'Quay video trước4K,Camera góc siêu rộng ',N'32 MP',N'Tự động lấy nét (AF) Làm đẹp','Android v9.0 (Pie)',
N'Chipset Hisilicon Kirin 980 ',N'8 nhân ','Mali-G76 MP10','8 GB','256 GB',N'Đang cập nhật',N'Không giới hạn',N'Hỗ trợ 4G','2 Nano SIM',' hotspot','GPSA-GPS, Glonass','LE, apt-X, A2DP, EDR, v4.2','Type-C','Type-C',N'NFC Hồng ngoại','4200  mAh','Li-Po','',N'Sạc nhanh',
N' Mở khóa bằng vân tay','','','WMV MP4 Xvid','WAV WMA',N'Nguyên khối',N'Khung kim loại & Mặt lưng kính cường lực',N'Nặng 192g','03/03/2019')

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('9','HW09','OLED','Full HD+ (1080 x 2340 Pixels)','6.1"',N'Mặt kính cong 2.5D',N'Chính 50 MP & Phụ 16 MP, 8 MP',N'FullHD 1080p@60fps4K 2160p@60fps',N'Đèn LED 2 tông màu',N'Chuyên nghiệp (Pro),Tự động lấy nét (AF),Chạm lấy nét',N'Chính 32 MP & Phụ IR TOF 3D',N'Tự động lấy nét (AF),Nhận diện khuôn mặt','EMUI 10',
N'Kirin 990 8 nhân',N'CPU2 nhân 2.86 GHz','Mali-G76 MP16','8 GB','128 GB',N'Đang cập nhật',N'Không giới hạn',N'Hỗ trợ 4G','2 Nano SIM','Wi-Fi Direct,dual-band, Wi-Fi Direct, hotspot','GPS,GLONASS','A2DP,LE,v5.1','Type-C 1.0','Type-C','OTG,Hồng ngoại,NFC','3800  mAh','Li-Po','',N'Sạc nhanh,Tiết kiệm pin',
N'Mở khoá vân tay dưới màn hìnhMở khoá khuôn mặt ',N'Chặn cuộc gọi,Chặn tin nhắn,Tối ưu game (Không gian trò chơi),Màn hình luôn hiển thị AOD','','WMV,MP4,Xvid','WAV,WMA,MP3,eAAC+,FLAC',N'Nguyên khối',N'Khung kim loại & Mặt lưng kính cường lực',N'Nặng 175 g','04/01/2020')

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('10','HW10','OLED','2K+ (1200 x 2640 Pixels)','6.58"',N'Mặt kính cong  3D',N'Chính 50 MP & Phụ 40 MP, 12 MP, TOF 3D',N'FullHD 1080p@60fps4K 2160p@60fps',N'Đèn LED 2 tông màu',N'Quay Siêu chậm (Super Slow Motion),AI Camera,ChạChuyên nghiệp (Pro)',N'Chính 32 MP & Phụ IR TOF 3D',N'Tự động lấy nét (AF),Nhãn dán (AR Stickers)','EMUI 10',
N'Kirin 990 8 nhân',N'2 nhân 2.86 GHz, 2 nhân 2.36 GHz & 4 nhân 1.95 GHz','Mali-G76 MP16','8 GB','256 GB',N'224 GB',N'Không giới hạn',N'Hỗ trợ 5G','2 Nano SIM','Wi-Fi Direct,dual-band, Wi-Fi Direct, hotspot','GPS,GLONASS','A2DP,LE,v5.1','Type-C 1.0','Type-C','OTG,Hồng ngoại,NFC','4200   mAh','Li-Po','',N'Sạc nhanh,Tiết kiệm pin',
N'Mở khoá vân tay dưới màn hìnhMở khoá khuôn mặt ',N'Chặn cuộc gọi,Chặn tin nhắn,Tối ưu game (Không gian trò chơi),Màn hình luôn hiển thị AOD','','WMV,MP4,Xvid','WAV,WMA,MP3,eAAC+,FLAC',N'Nguyên khối',N'Khung kim loại & Mặt lưng kính cường lực',N'Nặng 209 g','04/07/2020')

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('11','HW11','OLED','2K+ (1200 x 2640 Pixels)','6.6"',N'Đang cập nhật',N'Chính 50 MP & Phụ 64 MP, 40 MP, 13 MP',N'FullHD 1080p@60fps 4K 2160p@30fps ',N'Có',N'Toàn cảnh (Panorama),Lấy nét theo pha (PDAF),Zoom kỹ thuật số',N'13 MP',N'Quay video Full HD,HDR','HarmonyOS 2.0',
N'Kirin 9000 8 nhân',N'1 nhân 3.13 GHz, 3 nhân 2.54 GHz & 4 nhân 2.05 GHz','Mali-G78 MP24','12 GB','512 GB',N'Đang cập nhật',N'Không giới hạn',N'Hỗ trợ 4G','2 Nano SIM','Wi-Fi Direct,dual-band, Wi-Fi Direct, hotspot','GPS,GLONASS','A2DP,LE,v5.2','Type-C ','','NFC','4360 mAh','Li-Po','66 W',N'Sạc nhanh,Tiết kiệm pin',
N'Mở khoá vân tay dưới màn hìnhMở khoá khuôn mặt ',N'',N'Không có',N'Có',N'Có',N'Nguyên khối',N'Đang cập nhật',N'Nặng 195 g','07/1/2021')

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('36','HW12','OLED','2K+ (1200 x 2640 Pixels)','6.6"',N'Đang cập nhật',N'Chính 50 MP & Phụ 64 MP, 40 MP, 13 MP',N'FullHD 1080p@60fps 4K 2160p@30fps ',N'Có',N'Toàn cảnh (Panorama),Lấy nét theo pha (PDAF),Zoom kỹ thuật số',N'13 MP',N'Quay video Full HD,HDR','HarmonyOS 2.0',
N'Kirin 9000 8 nhân',N'1 nhân 3.13 GHz, 3 nhân 2.54 GHz & 4 nhân 2.05 GHz','Mali-G78 MP24','12 GB','512 GB',N'Đang cập nhật',N'Không giới hạn',N'Hỗ trợ 4G','2 Nano SIM','Wi-Fi Direct,dual-band, Wi-Fi Direct, hotspot','GPS,GLONASS','A2DP,LE,v5.2','Type-C ','','NFC','4360 mAh','Li-Po','66 W',N'Sạc nhanh,Tiết kiệm pin',
N'Mở khoá vân tay dưới màn hìnhMở khoá khuôn mặt ',N'',N'Không có',N'Có',N'Có',N'Nguyên khối',N'Đang cập nhật',N'Nặng 195 g','07/1/2021')

------IPHONE -----------

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('12','IP01','OLED','1125 x 2436 Pixels','5.8"',N'Kính cường lực Oleophobic (ion cường lực)',N'2 camera 12 MP',N'4K 2160p@60fps',N'4 đèn LED 2 tông màu',N'Lấy nét dự đoán,Nhận diện khuôn mặt,Chống rung quang học (OIS)',N'7 MP',N'Quay video Full HD,Nhận diện khuôn mặt','iOS 12',
N'Apple A11 Bionic 6 nhân',N'2.39 GHz','Apple GPU 3 nhân','3 GB','64 GB',N'Khoảng 55 GB',N'Không giới hạn',N'','1 Nano SIM','Wi-Fi 802.11 a/b/g/n/ac,Wi-Fi hotspot,Dual-band (2.4 GHz/5 GHz)','GPS,GLONASS','A2DP,LE,EDR,v5.0','Lightning','Lightning','OTG,NFC','2716 mAh','Li-Po','',N'Sạc không dây,Tiết kiệm pin,Sạc pin nhanh',
N'Mở khoá khuôn mặt Face ID ',N'3D Touch','','WMV,H.264(MPEG4-AVC)','WAV,WMA,MP3,eAAC+,AAC++',N'Nguyên khối',N'Khung kim loại & Mặt lưng kính cường lực',N'Nặng 174 g','09/01/2017')

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('13','IP02','OLED','1125 x 2436 Pixels','5.8"',N'Kính cường lực Oleophobic (ion cường lực)',N'2 camera 12 MP',N'4K 2160p@60fps,FullHD 1080p@240fps',N'4 đèn LED 2 tông màu',N'Điều chỉnh khẩu độ,Nhận diện khuôn mặt,Chống rung quang học (OIS)',N'7 MP',N'Góc rộng (Wide),Nhận diện khuôn mặt','iOS  14',
N'Apple A12  Bionic 6 nhân',N'2 nhân 2.5 GHz & 4 nhân 1.6 GHz','Apple GPU  4 nhân','4 GB','64 GB',N'Khoảng  57 GB',N'Không giới hạn',N'Hỗ trợ 4G','1 Nano SIM & 1 eSIM','Wi-Fi 802.11 a/b/g/n/ac,Wi-Fi hotspot,Dual-band (2.4 GHz/5 GHz)','GPS,GLONASS','LE,v5.0','Lightning','Lightning','OTG,NFC','2658 mAh','Li-Po','',N'Sạc không dây,Tiết kiệm pin,Sạc pin nhanh',
N'Mở khoá khuôn mặt Face ID ',N'3D Touch,Apple Pay','','WMV,H.264(MPEG4-AVC)','WAV,WMA,MP3,eAAC+,AAC++',N'Nguyên khối',N'Khung kim loại & Mặt lưng kính cường lực',N'Nặng 177 g','11/1/2017')

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('14','IP03','OLED','1125 x 2436 Pixels','5.8"',N'Kính cường lực Oleophobic (ion cường lực)',N'3 camera 12 MP',N'4K 2160p@60fps,FullHD 1080p@240fps',N'4 đèn LED 2 tông màu',N'Điều chỉnh khẩu độ,Nhận diện khuôn mặt,Chống rung quang học (OIS)',N'12 MP',N'Góc rộng (Wide),Nhận diện khuôn mặt','iOS  14',
N'Apple A13  Bionic 6 nhân',N'2 nhân 2.65 GHz & 4 nhân 1.8 GHz','Apple GPU 4 nhân','4 GB','64 GB',N'Khoảng  59 GB',N'Không giới hạn',N'Hỗ trợ 4G','1 Nano SIM & 1 eSIM','Wi-Fi 802.11 a/b/g/n/ac,Wi-Fi hotspot,Dual-band (2.4 GHz/5 GHz)','GPS,GLONASS','LE,v5.0','Lightning','Lightning','OTG,NFC','3046 mAh','Li-Po','',N'Sạc không dây,Tiết kiệm pin,Sạc pin nhanh',
N'Mở khoá khuôn mặt Face ID ',N'Âm thanh Dolby Audio,Apple Pay','','H.264(MPEG4-AVC)','WAV,AAC,Lossless,FLAC',N'Nguyên khối',N'Khung kim loại & Mặt lưng kính cường lực',N'Nặng 188  g','11/1/2019')

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('15','IP04','OLED','Full HD+ (1080 x 2340 Pixels)','5.8"',N'Kính cường lực  Ceramic Shield',N'2 camera 12 MP',N'4K 2160p@60fps,FullHD 1080p@240fps',N'Đèn LED kép',N'Điều chỉnh khẩu độ,Nhận diện khuôn mặt,Chống rung quang học (OIS)',N'12 MP',N'Retina Flash,Nhận diện khuôn mặt,Quay video Full HD','iOS  15',
N'Apple  A14 Bionic 6 nhân',N'2 nhân 3.1 GHz & 4 nhân 1.8 GHz','Apple GPU 4 nhân','4 GB','64 GB',N'Khoảng 49 GB',N'Không giới hạn',N'Hỗ trợ 5G','1 Nano SIM & 1 eSIM','Wi-Fi 802.11 a/b/g/n/ac,Wi-Fi hotspot,Dual-band (2.4 GHz/5 GHz)','GPS,GLONASS,iBeacon','A2DP,v5.0','Lightning','Lightning','NFC','2227  mAh','Li-Po','20 W',N'Sạc không dây,Tiết kiệm pin,Sạc pin nhanh',
N'Mở khoá khuôn mặt Face ID ',N'Âm thanh Dolby Audio','IP68','H.264(MPEG4-AVC)','AAC,MP3,Lossless,FLAC',N'Nguyên khối',N'Khung nhôm & Mặt lưng kính cường lực',N'Dài 131.5 mm - Ngang 64.2 mm - Dày 7.4 mm - Nặng 135 g','10/1/2020')

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('16','IP05','OLED','Super Retina XDR (1170 x 2532 Pixels)','6.1"',N'Kính cường lực Ceramic Shield',N'3 camera 12 MP',N'4K 2160p@60fps,FullHD 1080p@240fps',N'Đèn LED kép',N'Điều chỉnh khẩu độ,Nhận diện khuôn mặt,Chống rung quang học (OIS)',N'12 MP',N'Retina Flash,Nhận diện khuôn mặt,Quay video Full HD','iOS  15',
N'Apple  A14 Bionic 6 nhân',N'2 nhân 3.1 GHz & 4 nhân 1.8 GHz','Apple GPU 4 nhân','6 GB','128 GB',N'Khoảng 113 GB',N'Không giới hạn',N'Hỗ trợ 5G','1 Nano SIM & 1 eSIM','Wi-Fi 802.11 a/b/g/n/ac,Wi-Fi hotspot,Dual-band (2.4 GHz/5 GHz)','GPS,GLONASS,iBeacon','A2DP,v5.0','Lightning','Lightning','NFC','2815   mAh','Li-Po','20 W',N'Sạc không dây,Tiết kiệm pin,Sạc pin nhanh',
N'Mở khoá khuôn mặt Face ID ',N'Âm thanh Dolby Audio','IP68','H.264(MPEG4-AVC)','AAC,MP3,Lossless,FLAC',N'Nguyên khối',N'Khung thép không gỉ  & Mặt lưng kính cường lực',N'Dài 146.7 mm - Ngang 71.5 mm - Dày 7.4 mm - Nặng 189 g','10/01/2020')

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('17','IP06','OLED','Super Retina XDR (1284 x 2778 Pixels)','6.7"',N'Kính cường lực Ceramic Shield',N'3 camera 12 MP',N'4K 2160p@60fps,FullHD 1080p@240fps',N'Đèn LED kép',N'Điều chỉnh khẩu độ,Nhận diện khuôn mặt,Chống rung quang học (OIS)',N'12 MP',N'Retina Flash,Nhận diện khuôn mặt,Quay video Full HD','iOS  15',
N'Apple  A14 Bionic 6 nhân',N'2 nhân 3.1 GHz & 4 nhân 1.8 GHz','Apple GPU 4 nhân','6 GB','128 GB',N'Khoảng 113 GB',N'Không giới hạn',N'Hỗ trợ 5G','1 Nano SIM & 1 eSIM','Wi-Fi 802.11 a/b/g/n/ac,Wi-Fi hotspot,Dual-band (2.4 GHz/5 GHz)','GPS,GLONASS,iBeacon','A2DP,v5.0','Lightning','Lightning','NFC','3687 mAh','Li-Po','20 W',N'Sạc không dây,Tiết kiệm pin,Sạc pin nhanh',
N'Mở khoá khuôn mặt Face ID ',N'Âm thanh Dolby Audio','IP68','H.264(MPEG4-AVC)','AAC,MP3,Lossless,FLAC',N'Nguyên khối',N'Khung thép không gỉ  & Mặt lưng kính cường lực',N'Dài 160.8 mm - Ngang 78.1 mm - Dày 7.4 mm - Nặng 228 g','10/01/2020')


insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('18','IP07','OLED','Super Retina XDR (1170 x 2532 Pixels)','6.1"',N'Kính cường lực Ceramic Shield',N'2 camera 12 MP',N'4K 2160p@60fps,FullHD 1080p@240fps',N'Có',N'Smart HDR 4,Cinematic,Dolby Vision HDR',N'12 MP',N'Retina Flash,Smart HDR 4,Quay video Full HD','iOS  15',
N'Apple A15 Bionic 6 nhân',N'3.22 GHz','Apple GPU 4 nhân','4 GB','128 GB',N'Khoảng 113 GB',N'Không giới hạn',N'Hỗ trợ 5G','1 Nano SIM & 1 eSIM','Wi-Fi 802.11 a/b/g/n/ac,Wi-Fi hotspot,Dual-band (2.4 GHz/5 GHz)','GPS,GLONASS,iBeacon','A2DP,v5.0','Lightning','Lightning','NFC','3240 mAh','Li-Po','20 W',N'Sạc không dây,Tiết kiệm pin,Sạc pin nhanh',
N'Mở khoá khuôn mặt Face ID ',N'','IP68','H.264(MPEG4-AVC)','AAC,MP3,FLAC',N'Nguyên khối',N'Khung nhôm & Mặt lưng kính cường lực',N'Dài 146.7 mm - Ngang 71.5 mm - Dày 7.65 mm - Nặng 174 g','09/1/2021')



insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('19','IP08','OLED','Super Retina XDR (1170 x 2532 Pixels)','6.1"',N'Kính cường lực Ceramic Shield',N'3 camera 12 MP',N'4K 2160p@60fps,FullHD 1080p@240fps',N'Có',N'Smart HDR 4,Cinematic,Dolby Vision HDR',N'12 MP',N'Retina Flash,Smart HDR 4,Quay video Full HD','iOS  15',
N'Apple A15 Bionic 6 nhân',N'3.22 GHz','Apple GPU 5 nhân','6 GB','128 GB',N'Khoảng 113 GB',N'Không giới hạn',N'Hỗ trợ 5G','1 Nano SIM & 1 eSIM','Wi-Fi 802.11 a/b/g/n/ac,Wi-Fi hotspot,Dual-band (2.4 GHz/5 GHz)','GPS,GLONASS,iBeacon','A2DP,v5.0','Lightning','Lightning','NFC','3095 mAh','Li-Po','20 W',N'Sạc không dây,Tiết kiệm pin,Sạc pin nhanh',
N'Mở khoá khuôn mặt Face ID ',N'','IP68','H.264(MPEG4-AVC)','AAC,MP3,FLAC',N'Nguyên khối',N'Khung thép không gỉ & Mặt lưng kính cường lực',N'Dài 146.7 mm - Ngang 71.5 mm - Dày 7.65 mm - Nặng 204 g','09/1/2021')

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('20','IP09','OLED','Super Retina XDR (1284 x 2778 Pixels)','6.7"',N'Kính cường lực Ceramic Shield',N'3 camera 12 MP',N'4K 2160p@60fps,FullHD 1080p@240fps',N'Có',N'Smart HDR 4,Cinematic,Dolby Vision HDR',N'12 MP',N'Retina Flash,Smart HDR 4,Quay video Full HD','iOS  15',
N'Apple A15 Bionic 6 nhân',N'3.22 GHz','Apple GPU 5 nhân','6 GB','128 GB',N'Khoảng 113 GB',N'Không giới hạn',N'Hỗ trợ 5G','1 Nano SIM & 1 eSIM','Wi-Fi 802.11 a/b/g/n/ac,Wi-Fi hotspot,Dual-band (2.4 GHz/5 GHz)','GPS,GLONASS,iBeacon','A2DP,v5.0','Lightning','Lightning','NFC','4352 mAh','Li-Po','20 W',N'Sạc không dây,Tiết kiệm pin,Sạc pin nhanh',
N'Mở khoá khuôn mặt Face ID ',N'','IP68','H.264(MPEG4-AVC)','AAC,MP3,FLAC',N'Nguyên khối',N'Khung thép không gỉ & Mặt lưng kính cường lực',N'Dài 160.8 mm - Ngang 78.1 mm - Dày 7.65 mm - Nặng 240 g','09/1/2021')


insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('21','IP10','OLED','Super Retina XDR (1170 x 2532 Pixels)','6.1"',N'Kính cường lực Ceramic Shield',N'2 camera 12 MP',N'4K 2160p@60fps,FullHD 1080p@240fps',N'Có',N'Smart HDR 4,Live Photo,Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)',N'12 MP',N'Smart HDR 4,Live Photo,Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)','iOS 16',
N'Apple A15 Bionic 6 nhân',N'3.22 GHz','Apple GPU 5 nhân','6 GB','128 GB',N'Khoảng 113 GB',N'Không giới hạn',N'Hỗ trợ 5G','1 Nano SIM & 1 eSIM','Wi-Fi 802.11 a/b/g/n/ac,Wi-Fi hotspot,Dual-band (2.4 GHz/5 GHz)','GPS,GLONASS,iBeacon','v5.3','Lightning','Lightning','NFC','3279 mAh','Li-Po','20 W',N'Sạc không dây,Tiết kiệm pin,Sạc pin nhanh',
N'Mở khoá khuôn mặt Face ID ',N'Phát hiện va chạm (Crash Detection),Loa kép,Chạm 2 lần sáng màn hình','IP68','H.264(MPEG4-AVC)','AAC,MP3,FLAC',N'Nguyên khối',N'Khung thép không gỉ & Mặt lưng kính cường lực',N'Dài 146.7 mm - Ngang 71.5 mm - Dày 7.8 mm - Nặng 172 g','09/1/2022')

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('22','IP11','OLED','Super Retina XDR (2556 x 1179 Pixels)','6.1"',N'Kính cường lực Ceramic Shield',N'Chính 48 MP & Phụ 12 MP, 12 MP',N'4K 2160p@60fps,FullHD 1080p@240fps',N'Có',N'Smart HDR 4,Live Photo,Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)',N'12 MP',N'Smart HDR 4,Live Photo,Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)','iOS 16',
N'Apple A15 Bionic 6 nhân',N'3.22 GHz','Apple GPU 5 nhân','6 GB','128 GB',N'Khoảng 113 GB',N'Không giới hạn',N'Hỗ trợ 5G','1 Nano SIM & 1 eSIM','Wi-Fi 802.11 a/b/g/n/ac,Wi-Fi hotspot,Dual-band (2.4 GHz/5 GHz)','GPS,GLONASS,iBeacon','v5.3','Lightning','Lightning','NFC','3200 mAh','Li-Po','20 W',N'Sạc không dây,Tiết kiệm pin,Sạc pin nhanh',
N'Mở khoá khuôn mặt Face ID ',N'Phát hiện va chạm (Crash Detection),Loa kép,Chạm 2 lần sáng màn hình','IP68','H.264(MPEG4-AVC)','AAC,MP3,FLAC',N'Nguyên khối',N'Khung thép không gỉ & Mặt lưng kính cường lực',N'Dài 147.5 mm - Ngang 71.5 mm - Dày 7.85 mm - Nặng 206 g','09/1/2022')

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('23','IP12','OLED','2796 x 1290 Pixels','6.7"',N'Kính cường lực Ceramic Shield',N'Chính 48 MP & Phụ 12 MP, 12 MP',N'4K 2160p@60fps,FullHD 1080p@240fps',N'Có',N'Smart HDR 4,Live Photo,Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)',N'12 MP',N'Smart HDR 4,Live Photo,Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)','iOS 16',
N'Apple A16 Bionic 6 nhân',N'3.46 GHz','Apple GPU 5 nhân','6 GB','128 GB',N'Khoảng 113 GB',N'Không giới hạn',N'Hỗ trợ 5G','1 Nano SIM & 1 eSIM','Wi-Fi 802.11 a/b/g/n/ac,Wi-Fi hotspot,Dual-band (2.4 GHz/5 GHz)','GPS,GLONASS,iBeacon','v5.3','Lightning','Lightning','NFC','4323  mAh','Li-Po','20 W',N'Sạc không dây,Tiết kiệm pin,Sạc pin nhanh',
N'Mở khoá khuôn mặt Face ID ',N'Phát hiện va chạm (Crash Detection),Loa kép,Chạm 2 lần sáng màn hình','IP68','H.264(MPEG4-AVC)','AAC,MP3,ALAC',N'Nguyên khối',N'Khung thép không gỉ & Mặt lưng kính cường lực',N'Dài 160.7 mm - Ngang 77.6 mm - Dày 7.85 mm - Nặng 240 g','09/1/2022')
-----------SAM SUNG-----------------


insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('24','SS01','Super AMOLED','Full HD+ (1080 x 2400 Pixels)','6.5"',N'Kính cường lực Corning Gorilla Glass 5',N'Chính 64 MP & Phụ 12 MP, 5 MP, 5 MP',N'4K 2160p@60fps,FullHD 1080p@240fps',N'Có',N'Chuyên nghiệp (Pro),Siêu cận (Macro),Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)',N'32 MP',N'Quay video 4K,Flash màn hình,Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)','Android 12',
N'Exynos 1280 8 nhân',N'2 nhân 2.4 GHz & 6 nhân 2 GHz','Mali-G68','8 GB','128 GB',N'hỗ trợ tối đa 1 TB',N'Không giới hạn',N'Hỗ trợ 5G','2 Nano SIM','Wi-Fi 802.11 a/b/g/n/ac,Wi-Fi hotspot,Dual-band (2.4 GHz/5 GHz)','GLONASS,GALILEO,BEIDOU','v5.1','Type-C','Type-C','NFC','5000  mAh','Li-Po','25 W',N'Sạc pin nhanh',
N'Mở khoá khuôn mặt,Mở khoá vân tay dưới màn hình',N'Trợ lý ảo Samsung Bixby,Màn hình luôn hiển thị AOD','IP67','Có','Có',N'Nguyên khối',N'Khung & Mặt lưng nhựa',N'Dài 159.6 mm - Ngang 74.8 mm - Dày 8.1 mm - Nặng 189 g','03/1/2022')


insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('25','SS02','Super AMOLED Plus','Full HD+ (1080 x 2400 Pixels)','6.7"',N'Kính cường lực Corning Gorilla Glass 5',N'Chính 108 MP & Phụ 8 MP, 2 MP, 2 MP',N'4K 2160p@30fps',N'Có',N'Chuyên nghiệp (Pro),Siêu cận (Macro),Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)',N'32 MP',N'Quay video 4K,Flash màn hình,Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)','Android 12',
N'MediaTek Dimensity 900 5G',N'2 nhân 2.4 GHz & 6 nhân 2 GHz','Mali-G68','8 GB','256 GB',N'241 GB',N'Không giới hạn',N'Hỗ trợ 5G','2 Nano SIM','Wi-Fi 802.11 a/b/g/n/ac,Wi-Fi hotspot,Dual-band (2.4 GHz/5 GHz)','GLONASS,GALILEO,BEIDOU,QZSS','A2DP,v5.0','Type-C','Type-C','NFC','5000  mAh','Li-Po','25 W',N'Sạc pin nhanh',
N'Mở khoá khuôn mặt,Mở khoá vân tay dưới màn hình',N'Trợ lý ảo Samsung Bixby,Màn hình luôn hiển thị AOD',N'Không có','WMV,3GP','OGG,Midi',N'Nguyên khối',N'Khung kim loại & Mặt lưng nhựa',N'Dài 164.7 mm - Ngang 77 mm - Dày 7.4 mm - Nặng 176 g','04/1/2022')

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('26','SS03','Dynamic AMOLED','Full HD+ (1080 x 2280 Pixels)','6.3"',N'Kính cường lực Corning Gorilla Glass 5',N'Chính 12 MP & Phụ 12 MP, 16 MP',N'4K 2160p@30fps,FullHD 1080p@240fps',N'Có',N'Làm đẹp (Beautify),Lấy nét theo pha (PDAF),Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)',N'10 MP',N'Nhận diện khuôn mặt,Quay video Full HD','Android 9 (Pie)',
N'Exynos 9825 8 nhân',N'2 nhân 2.73 GHz, 2 nhân 2.4 GHz & 4 nhân 1.9 GHz','Mali-G76 MP12','8 GB','256 GB',N'223 GB',N'Không giới hạn',N'Hỗ trợ 5G','2 Nano SIM','Wi-Fi 802.11 a/b/g/n/ac,Wi-Fi hotspot,Dual-band (2.4 GHz/5 GHz)','GLONASS,GALILEO,BEIDOU,QZSS','A2DP,v5.0','2 Type-C','Type-C','OTG,NFC','3500  mAh','Li-Po','25 W',N'Siêu tiết kiệm pin,Sạc không dây',
N'Mở khoá khuôn mặt,Mở khoá vân tay dưới màn hình',N'Âm thanh Dolby Audio,Trợ lý ảo Samsung Bixby',N'Không có','WMV,3GP,MP4','OGG,Midi,eAAC+',N'Nguyên khối',N'Khung kim loại & Mặt lưng kính cường lực',N'Nặng 168 g','08/01/2019')

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('27','SS04','Super AMOLED Plus','Full HD+ (1080 x 2400 Pixels)','6.7"',N'Kính cường lực Corning Gorilla Glass 5',N'Chính 12 MP & Phụ 64 MP, 12 MP',N'8K 4320p@24fps',N'Có',N'Chuyên nghiệp (Pro),Siêu cận (Macro),Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)',N'10 MP',N'Quay video 4K,Flash màn hình,Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)','Android 10',
N'Exynos 990 8 nhân',N'2 nhân 2.73 GHz, 2 nhân 2.5 GHz & 4 nhân 2.0 Ghz','Mali-G77 MP11','8 GB','256 GB',N'223  GB',N'Không giới hạn',N'Hỗ trợ 5G','2 Nano SIM','Wi-Fi 802.11 a/b/g/n/ac,Wi-Fi hotspot,Dual-band (2.4 GHz/5 GHz)','GLONASS,GALILEO,BEIDOU,QZSS','A2DP,v5.0','Type-C','Type-C','NFC','4300 mAh','Li-Po','25 W',N'Sạc pin nhanh,Sạc ngược không dây',
N'Mở khoá khuôn mặt,Mở khoá vân tay dưới màn hình',N'Samsung Pay,Trợ lý ảo Samsung Bixby,Màn hình luôn hiển thị AOD',N'IP68','DivX,Xvid,3GP,MP4','OGG,WAV,eAAC+,Midi',N'Nguyên khối',N'Khung kim loại & Mặt lưng nhựa',N'Dài 161.6 mm - Ngang 72.5 mm - Dày 8.3 mm - Nặng 192 g','08/1/2022')

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('28','SS05','Super AMOLED 2X','Full HD+ (1080 x 2400 Pixels)','6.2"',N'Kính cường lực Corning Gorilla Glass Victus',N'
Chính 12 MP & Phụ 64 MP, 12 MP',N'4K 2160p@30fps',N'Có',N'Chuyên nghiệp (Pro),Siêu cận (Macro),Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)',N'32 MP',N'Quay video 4K,Flash màn hình,Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)','Android 12',
N'MediaTek Dimensity 900 5G',N'2 nhân 2.4 GHz & 6 nhân 2 GHz','Mali-G68','8 GB','256 GB',N'241 GB',N'Không giới hạn',N'Hỗ trợ 5G','2 Nano SIM','Wi-Fi 802.11 a/b/g/n/ac,Wi-Fi hotspot,Dual-band (2.4 GHz/5 GHz)','GLONASS,GALILEO,BEIDOU,QZSS','A2DP,v5.0','Type-C','Type-C','NFC','5000  mAh','Li-Po','25 W',N'Sạc pin nhanh',
N'Mở khoá khuôn mặt,Mở khoá vân tay dưới màn hình',N'Trợ lý ảo Samsung Bixby,Màn hình luôn hiển thị AOD',N'Không có','WMV,3GP','OGG,Midi',N'Nguyên khối',N'Khung kim loại & Mặt lưng nhựa',N'Dài 164.7 mm - Ngang 77 mm - Dày 7.4 mm - Nặng 176 g','04/1/2022')

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('29','SS06','Super AMOLED ','Full HD+ (1080 x 2300 Pixels)','6.7"',N'Kính cường lực Corning Gorilla ',N'Chính 108 MP & Phụ 12 MP, 10 MP, 10 MP',N'4K 2160p@30fps',N'Có',N'Chuyên nghiệp (Pro),Siêu cận (Macro),Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)',N'40 MP',N'Quay video 4K,Flash màn hình,Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)','Android 11',
N'Exynos 2100 8 nhân',N'1 nhân 2.9 GHz, 3 nhân 2.8 GHz & 4 nhân 2.2 GHz','Mali-G78 MP14','12 GB','128 GB',N'115 GB',N'Không giới hạn',N'Hỗ trợ 5G','2 Nano SIM','Wi-Fi 802.11 a/b/g/n/ac,Wi-Fi hotspot,Dual-band (2.4 GHz/5 GHz)','GLONASS,GALILEO,BEIDOU,QZSS','A2DP,v5.0','Type-C','Type-C','NFC','4000  mAh','Li-Po','25 W',N'Sạc pin nhanh',
N'Mở khoá khuôn mặt,Mở khoá vân tay dưới màn hình',N'Trợ lý ảo Samsung Bixby,Màn hình luôn hiển thị AOD',N'IP68','WMV,3GP,MP4','OGG,Midi',N'Nguyên khối',N'Khung  nhôm & Mặt lưng nhựa',N'Dài 151.7 mm - Ngang 71.2 mm- Dày 7.4 mm - Nặng 176 g','01/1/2021')

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('30','SS07','Super AMOLED 2X','Full HD+ (1080 x 2400 Pixels)','6.4"',N'Kính cường lực Corning Gorilla Glass 5',N'Chính 12 MP & Phụ 12 MP, 8 MP',N'4K 2160p@30fps,FullHD 1080p@60fps',N'Có',N'Chuyên nghiệp (Pro),Siêu cận (Macro),Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)',N'32 MP',N'Quay video 4K,Flash màn hình,Xóa phông,A.I Camera','Android 12',
N'Exynos 2100 8 nhân',N'1 nhân 2.9 GHz, 3 nhân 2.8 GHz & 4 nhân 2.2 GHz','Mali-G78 MP14','8 GB','128 GB',N'115 GB',N'Không giới hạn',N'Hỗ trợ 5G','2 Nano SIM','Wi-Fi 802.11 a/b/g/n/ac,Wi-Fi hotspot,Dual-band (2.4 GHz/5 GHz)','GLONASS,GALILEO,BEIDOU,QZSS','A2DP,v5.0','Type-C','Type-C','NFC','4000  mAh','Li-Po','25 W',N'Sạc pin nhanh',
N'Mở khoá khuôn mặt,Mở khoá vân tay dưới màn hình',N'Trợ lý ảo Samsung Bixby,Màn hình luôn hiển thị AOD',N'IP68','WMV,3GP','OGG,Midi',N'Nguyên khối',N'KKhung kim loại & Mặt lưng nhựa',N'Dài 155.7 mm - Ngang 74.5 mm - Dày 7.9 mm - Nặng 177 g','01/1/2021')


insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('31','SS08','Super AMOLED Plus','Full HD+ (1080 x 2400 Pixels)','6.1"',N'Kính cường lực Corning Gorilla Glass 5',N'Chính 50 MP & Phụ 12 MP, 10 MP',N'4K 2160p@30fps',N'Đèn LED kép',N'Chuyên nghiệp (Pro),Siêu cận (Macro),Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)',N'10 MP',N'Quay video 4K,Flash màn hình,Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)','Android 12',
N'Snapdragon 8 Gen 1 8 nhân',N'1 nhân 3 GHz, 3 nhân 2.5 GHz & 4 nhân 1.79 GHz','Adreno 730','8 GB','128 GB',N'100 GB',N'Không giới hạn',N'Hỗ trợ 5G','2 Nano SIM','Wi-Fi 802.11 a/b/g/n/ac,Wi-Fi hotspot,Dual-band (2.4 GHz/5 GHz)','GLONASS,GALILEO,BEIDOU,QZSS','A2DP,v5.2','Type-C','Type-C','NFC','4000  mAh','Li-Po','25 W',N'Sạc pin nhanh',
N'Mở khoá khuôn mặt,Mở khoá vân tay dưới màn hình',N'Trợ lý ảo Samsung Bixby,Màn hình luôn hiển thị AOD',N'Không có','WMV,3GP,MKV','OGG,M4A,Midi',N'Nguyên khối',N'Khung kim loại & Mặt lưng kính',N'Dài 146 mm - Ngang 70.6 mm - Dày 7.6 mm - Nặng 167 g','02/1/2021')

insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('32','SS09','Super AMOLED Plus','2K+ (1440 x 3088 Pixels)','6.8"',N'Kính cường lực Corning Gorilla Glass Victus+',N'Chính 108 MP & Phụ 12 MP, 10 MP, 10 MP',N'4K 2160p@30fps',N'Đèn LED kép',N'Chuyên nghiệp (Pro),Siêu cận (Macro),Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)',N'40 MP',N'Quay video 4K,Flash màn hình,Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)','Android 12',
N'Exynos 2100 8 nhân',N'1 nhân 2.9 GHz, 3 nhân 2.8 GHz & 4 nhân 2.2 GHz','Adreno 730','8 GB','128 GB',N'115 GB',N'Không giới hạn',N'Hỗ trợ 5G','2 Nano SIM','Wi-Fi 802.11 a/b/g/n/ac,Wi-Fi hotspot,Dual-band (2.4 GHz/5 GHz)','GLONASS,GALILEO,BEIDOU,QZSS','A2DP,v5.0','Type-C','Type-C','NFC','4000  mAh','Li-Po','25 W',N'Sạc pin nhanh',
N'Mở khoá khuôn mặt,Mở khoá vân tay dưới màn hình',N'Trợ lý ảo Samsung Bixby,Màn hình luôn hiển thị AOD',N'Không có','WMV,3GP','OGG,Midi',N'Nguyên khối',N'Khung hợp kim nhôm & Mặt lưng nhựa',N'Dài 163.3 mm - Ngang 77.9 mm - Dày 8.9 mm - Nặng 228 g','02/1/2021')


insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('33','SS10','Super AMOLED 2X','Full HD+ (1080 x 2340 Pixels)','6.7"',N'Kính cường lực Corning Gorilla Glass 5',N'Chính 50 MP & Phụ 12 MP, 10 MP',N'4K 2160p@30fps',N'Có',N'Chuyên nghiệp (Pro),Siêu cận (Macro),Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)',N'12 MP',N'Góc siêu rộng (Ultrawide),Trôi nhanh thời gian (Time Lapse)','Android 13',
N'Snapdragon 8 Gen 2 8 nhân',N'1 nhân 3.36 GHz, 4 nhân 2.8 GHz & 3 nhân 2 GHz','Adreno 740','8 GB','256 GB',N'216.7 GB',N'Không giới hạn',N'Hỗ trợ 5G','2 Nano SIM','Wi-Fi 802.11 a/b/g/n/ac,Wi-Fi hotspot,Dual-band (2.4 GHz/5 GHz)','GLONASS,GALILEO,BEIDOU,QZSS','A2DP,v5.0','Type-C','Type-C','NFC','3900   mAh','Li-Po','25 W',N'Sạc pin nhanh',
N'Mở khoá khuôn mặt,Mở khoá vân tay dưới màn hình',N'Trợ lý ảo Samsung Bixby,Màn hình luôn hiển thị AOD',N'Không có','WMV,3GP','OGG,Midi',N'Nguyên khối',N'Khung nhôm & Mặt lưng kính cường lực',N'Dài 146.3 mm - Ngang 70.9 mm - Dày 7.6 mm - Nặng 168 g','02/1/2023')


insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('34','SS11','Super AMOLED Plus','Full HD+ (1080 x 2400 Pixels)','6.7"',N'Kính cường lực Corning Gorilla Glass 5',N'2 camera 12 MP',N'4K 2160p@30fps',N'Có',N'Chuyên nghiệp (Pro),Siêu cận (Macro),Bộ lọc màu',N'10 MP',N'Quay video 4K,Flash màn hình,Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)','Android 11',
N'Snapdragon 888 8 nhân',N'1 nhân 2.84 GHz,, 3 nhân 2.8 GHz & 4 nhân 2.2 GHz','Adreno 660','8 GB','128 GB',N'100.5 GB',N'Không giới hạn',N'Hỗ trợ 5G','1 Nano SIM & 1 eSIM','Wi-Fi 802.11 a/b/g/n/ac,Wi-Fi hotspot,Dual-band (2.4 GHz/5 GHz)','GLONASS,GALILEO,BEIDOU,QZSS','A2DP,v5.0','Type-C','Type-C','NFC','3300   mAh','Li-Po','15 W',N'SSạc không dây',
N'Mở khoá khuôn mặt,Mở khoá vân tay cạnh viền',N'Samsung PayÂm thanh AKG',N'Không có','WMV,3GP','OGG,Midi',N'Nguyên khối',N'Khung nhôm & Mặt lưng kính cường lực',N'Dài 166 mm - Ngang 72.2 mm - Dày 6.9 mm - Nặng 183 g','09/1/2021')


insert into TSKTSP(MaTS,MaSP,CongNgheManHinh,DoPhanGiai,ManHinhrong,MatKinhCamUng,DoPhanGiaiCamS,QuayPhim,Flash,TinhNangCamS,DoPhanGiaiCamT,TinhNangCamT,HeDieuHanh,
CPU,TocDoCPU,GPU,RAM,DungLuong,DungLuongCon,DanhBa,Mang,Sim,Wifi,GPS,Bluetooth,Sac,Jack,KetNoiKhac,DungLuongPin,LoaiPin,SacToiDa,CongNghePin,
BaoMatNC,TinhNangDB,KhangNuocBui,XemPhim,NgheNhac,ThietKe,ChatLieu,KichThuoc,ThoiDiemRaMat)
values ('35','SS12','Super AMOLED Plus','Full HD+ (1080 x 2400 Pixels)','7.6"',N'Ultra Thin Glass',N'3 camera 12 MP',N'4K 2160p@30fps,4K 2160p@60fps',N'Có',N'Chuyên nghiệp (Pro),Siêu cận (Macro),Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)',N'10 MP & 4 MP',N'Quay video 4K,Flash màn hình,Bộ lọc màu,Trôi nhanh thời gian (Time Lapse)','Android 11',
N'Snapdragon 888 8 nhân',N'1 nhân 2.84 GHz, 3 nhân 2.4 GHz & 4 nhân 1.8 GHz','Adreno 660','12 GB','256 GB',N'215  GB',N'Không giới hạn',N'Hỗ trợ 5G','2 Nano SIM','Wi-Fi 802.11 a/b/g/n/ac,Wi-Fi hotspot,Dual-band (2.4 GHz/5 GHz)','GLONASS,GALILEO,BEIDOU,QZSS','A2DP,v5.0','Type-C','Type-C','NFC','4400  mAh','Li-Po','25 W',N'Sạc pin nhanh',
N'Mở khoá khuôn mặt,Mở khoá vân tay dưới màn hình',N'Trợ lý ảo Samsung Bixby,Màn hình luôn hiển thị AOD',N'Không có','WMV,3GP','OGG,Midi',N'Nguyên khối',N'Khung nhôm & Mặt lưng kính cường lực',N'Dài 158.2 mm - Ngang 128.1 mm - Dày 6.4 mm - Nặng 271 g','08/1/2021')

-----------HINH SAN PHAM--------------
------------------------------HUAWEI-----------------
insert into HinhSP
values ('huawei-honor20-1.jpg','HW01')
insert into HinhSP
values ('huawei-honor20-2.jpg','HW01')
insert into HinhSP
values ('huawei-honor20-3.jpg','HW01')
insert into HinhSP
values ('huawei-honor20-4.jpg','HW01')
insert into HinhSP
values ('huawei-honor20-5.jpg','HW01')
insert into HinhSP
values ('huawei-honor20-6.jpg','HW01')

insert into HinhSP
values ('huawei-mate30-1.jpg','HW02')
insert into HinhSP
values ('huawei-mate30-2.jpg','HW02')
insert into HinhSP
values ('huawei-mate30-3.jpg','HW02')
insert into HinhSP
values ('huawei-mate30-4.jpg','HW02')
insert into HinhSP
values ('huawei-mate30-5.png','HW02')
insert into HinhSP
values ('huawei-mate30-6.jpg','HW02')

insert into HinhSP
values ('huawei-mate50-1.jpg','HW04')
insert into HinhSP
values ('huawei-mate50-2.png','HW04')
insert into HinhSP
values ('huawei-mate50-3.png','HW04')
insert into HinhSP
values ('huawei-mate50-4.jpg','HW04')
insert into HinhSP
values ('huawei-mate50-5.png','HW04')
insert into HinhSP
values ('huawei-mate50-6.png','HW04')

insert into HinhSP
values ('huawei-mateX2-1.jpg','HW05')
insert into HinhSP
values ('huawei-mateX2-2.jpg','HW05')
insert into HinhSP
values ('huawei-mateX2-3.jpg','HW05')
insert into HinhSP
values ('huawei-mateX2-4.jpg','HW05')
insert into HinhSP
values ('huawei-mateX2-5.jpg','HW05')
insert into HinhSP
values ('huawei-mateX2-6.jpg','HW05')

insert into HinhSP
values ('huawei-nova-5T-1.jpg','HW06')
insert into HinhSP
values ('huawei-nova-5T-2.jpg','HW06')
insert into HinhSP
values ('huawei-nova-5T-3.jpg','HW06')
insert into HinhSP
values ('huawei-nova-5T-4.jpg','HW06')
insert into HinhSP
values ('huawei-nova-5T-5.jpg','HW06')
insert into HinhSP
values ('huawei-nova-5T-6.jpg','HW06')

insert into HinhSP
values ('huawei-nova9-1.jpg','HW07')
insert into HinhSP
values ('huawei-nova9-2.jpg','HW07')
insert into HinhSP
values ('huawei-nova9-3.jpg','HW07')
insert into HinhSP
values ('huawei-nova9-4.jpg','HW07')
insert into HinhSP
values ('huawei-nova9-5.jpg','HW07')
insert into HinhSP
values ('huawei-nova9-6.jpg','HW07')

insert into HinhSP
values ('huawei-P30-pro-1.jpg','HW08')
insert into HinhSP
values ('huawei-P30-pro-2.png','HW08')
insert into HinhSP
values ('huawei-P30-pro-3.jpg','HW08')
insert into HinhSP
values ('huawei-P30-pro-4.jpg','HW08')
insert into HinhSP
values ('huawei-P30-pro-5.png','HW08')
insert into HinhSP
values ('huawei-P30-pro-6.jpg','HW08')

insert into HinhSP
values ('huawei-P40-1.jpg','HW09')
insert into HinhSP
values ('huawei-P40-2.jpg','HW09')
insert into HinhSP
values ('huawei-P40-3.jpg','HW09')
insert into HinhSP
values ('huawei-P40-4.jpg','HW09')
insert into HinhSP
values ('huawei-P40-5.jpg','HW09')
insert into HinhSP
values ('huawei-P40-6.jpg','HW09')

insert into HinhSP
values ('huawei-P40-pro-1.jpg','HW10')
insert into HinhSP
values ('huawei-P40-pro-2.jpg','HW10')
insert into HinhSP
values ('huawei-P40-pro-3.jpg','HW10')
insert into HinhSP
values ('huawei-P40-pro-4.jpg','HW10')
insert into HinhSP
values ('huawei-P40-pro-5.jpg','HW10')
insert into HinhSP
values ('huawei-P40-pro-6.jpg','HW10')

insert into HinhSP
values ('huawei-P50-1.jpg','HW11')
insert into HinhSP
values ('huawei-P50-2.jpg','HW11')
insert into HinhSP
values ('huawei-P50-3.jpg','HW11')
insert into HinhSP
values ('huawei-P50-4.jpg','HW11')
insert into HinhSP
values ('huawei-P50-5.jpg','HW11')
insert into HinhSP
values ('huawei-P50-6.jpg','HW11')

insert into HinhSP
values ('huawei-P50-pro-1.png','HW12')
insert into HinhSP
values ('huawei-P50-pro-2.png','HW12')
insert into HinhSP
values ('huawei-P50-pro-3.png','HW12')
insert into HinhSP
values ('huawei-P50-pro-4.png','HW12')
insert into HinhSP
values ('huawei-P50-pro-5.jpg','HW12')
insert into HinhSP
values ('huawei-P50-pro-6.jpg','HW12')
------------IPHONE --------------------


insert into HinhSP
values ('ip-X-1.jpg','IP01')
insert into HinhSP
values ('ip-X-2.png','IP01')
insert into HinhSP
values ('ip-X-3.png','IP01')
insert into HinhSP
values ('ip-X-4.png','IP01')
insert into HinhSP
values ('ip-X-5.jpg','IP01')

insert into HinhSP
values ('ip-Xs-1.jpg','IP02')
insert into HinhSP
values ('ip-Xs-2.jpg','IP02')
insert into HinhSP
values ('ip-Xs-3.png','IP02')
insert into HinhSP
values ('ip-Xs-4.jpg','IP02')
insert into HinhSP
values ('ip-Xs-5.jpg','IP02')
insert into HinhSP
values ('ip-Xs-6.png','IP02')

insert into HinhSP
values ('ip-11p-1.jpg','IP03')
insert into HinhSP
values ('ip-11p-2.png','IP03')
insert into HinhSP
values ('ip-11p-3.jpg','IP03')
insert into HinhSP
values ('ip-11p-4.jpg','IP03')
insert into HinhSP
values ('ip-11p-5.jpg','IP03')
insert into HinhSP
values ('ip-11p-6.jpg','IP03')

insert into HinhSP
values ('ip-12m-1.png','IP04')
insert into HinhSP
values ('ip-12m-2.png','IP04')
insert into HinhSP
values ('ip-12m-3.png','IP04')
insert into HinhSP
values ('ip-12m-4.png','IP04')
insert into HinhSP
values ('ip-12m-5.png','IP04')
insert into HinhSP
values ('ip-12m-6.png','IP04')

insert into HinhSP
values ('ip-12p-1.png','IP05')
insert into HinhSP
values ('ip-12p-2.png','IP05')
insert into HinhSP
values ('ip-12p-3.png','IP05')
insert into HinhSP
values ('ip-12p-4.png','IP05')
insert into HinhSP
values ('ip-12p-5.png','IP05')
insert into HinhSP
values ('ip-12p-6.png','IP05')

insert into HinhSP
values ('ip-12pm-1.jpg','IP06')
insert into HinhSP
values ('ip-12pm-2.jpg','IP06')
insert into HinhSP
values ('ip-12pm-3.jpg','IP06')
insert into HinhSP
values ('ip-12pm-4.jpg','IP06')
insert into HinhSP
values ('ip-12pm-5.jpg','IP06')
insert into HinhSP
values ('ip-12pm-6.jpg','IP06')

insert into HinhSP
values ('ip-13-1.jpg','IP07')
insert into HinhSP
values ('ip-13-2.jpg','IP07')
insert into HinhSP
values ('ip-13-3.jpg','IP07')
insert into HinhSP
values ('ip-13-4.jpg','IP07')
insert into HinhSP
values ('ip-13-5.png','IP07')
insert into HinhSP
values ('ip-13-6.jpg','IP07')


insert into HinhSP
values ('ip-13p-1.jpg','IP08')
insert into HinhSP
values ('ip-13p-2.jpg','IP08')
insert into HinhSP
values ('ip-13p-3.jpg','IP08')
insert into HinhSP
values ('ip-13p-4.jpg','IP08')
insert into HinhSP
values ('ip-13p-5.jpg','IP08')
insert into HinhSP
values ('ip-13p-6.png','IP08')

insert into HinhSP
values ('ip-13pm-1.jpg','IP09')
insert into HinhSP
values ('ip-13pm-2.jpg','IP09')
insert into HinhSP
values ('ip-13pm-3.jpg','IP09')
insert into HinhSP
values ('ip-13pm-4.jpg','IP09')
insert into HinhSP
values ('ip-13pm-5.jpg','IP09')
insert into HinhSP
values ('ip-13pm-6.png','IP09')

insert into HinhSP
values ('ip-14-1.png','IP10')
insert into HinhSP
values ('ip-14-2.png','IP10')
insert into HinhSP
values ('ip-14-3.jpg','IP10')
insert into HinhSP
values ('ip-14-4.png','IP10')
insert into HinhSP
values ('ip-14-5.png','IP10')
insert into HinhSP
values ('ip-14-6.png','IP10')

insert into HinhSP
values ('ip-14p-1.jpg','IP11')
insert into HinhSP
values ('ip-14p-2.jpg','IP11')
insert into HinhSP
values ('ip-14p-3.jpg','IP11')
insert into HinhSP
values ('ip-14p-4.jpg','IP11')
insert into HinhSP
values ('ip-14p-5.jpg','IP11')
insert into HinhSP
values ('ip-14p-6.png','IP11')

insert into HinhSP
values ('ip-14pm-1.png','IP12')
insert into HinhSP
values ('ip-14pm-2.png','IP12')
insert into HinhSP
values ('ip-14pm-3.png','IP12')
insert into HinhSP
values ('ip-14pm-4.png','IP12')
insert into HinhSP
values ('ip-14pm-5.png','IP12')
insert into HinhSP
values ('ip-14pm-6.png','IP12')

insert into HinhSP
values ('ss-a53-1.png','SS01')
insert into HinhSP
values ('ss-a53-2.png','SS01')
insert into HinhSP
values ('ss-a53-3.png','SS01')
insert into HinhSP
values ('ss-a53-4.png','SS01')
insert into HinhSP
values ('ss-a53-5.png','SS01')
insert into HinhSP
values ('ss-a53-6.png','SS01')

insert into HinhSP
values ('ss-m53-1.png','SS02')
insert into HinhSP
values ('ss-m53-2.png','SS02')
insert into HinhSP
values ('ss-m53-3.png','SS02')
insert into HinhSP
values ('ss-m53-4.png','SS02')
insert into HinhSP
values ('ss-m53-5.png','SS02')
insert into HinhSP
values ('ss-m53-6.png','SS02')

insert into HinhSP
values ('ss-n10-1.jpg','SS03')
insert into HinhSP
values ('ss-n10-2.png','SS03')
insert into HinhSP
values ('ss-n10-3.jpg','SS03')
insert into HinhSP
values ('ss-n10-4.jpg','SS03')
insert into HinhSP
values ('ss-n10-5.jpg','SS03')
insert into HinhSP
values ('ss-n10-6.jpg','SS03')

insert into HinhSP
values ('ss-n20-1.png','SS04')
insert into HinhSP
values ('ss-n20-2.jpg','SS04')
insert into HinhSP
values ('ss-n20-3.jpg','SS04')
insert into HinhSP
values ('ss-n20-4.jpg','SS04')
insert into HinhSP
values ('ss-n20-5.jpg','SS04')
insert into HinhSP
values ('ss-n20-6.jpg','SS04')

insert into HinhSP
values ('ss-s21-1.jpg','SS05')
insert into HinhSP
values ('ss-s21-2.png','SS05')
insert into HinhSP
values ('ss-s21-3.jpg','SS05')
insert into HinhSP
values ('ss-s21-4.jpg','SS05')
insert into HinhSP
values ('ss-s21-5.jpg','SS05')
insert into HinhSP
values ('ss-s21-6.jpg','SS05')

insert into HinhSP
values ('ss-s21ul-1.jpg','SS06')
insert into HinhSP
values ('ss-s21ul-2.jpg','SS06')
insert into HinhSP
values ('ss-s21ul-3.jpg','SS06')
insert into HinhSP
values ('ss-s21ul-4.jpg','SS06')
insert into HinhSP
values ('ss-s21ul-5.png','SS06')
insert into HinhSP
values ('ss-s21ul-6.jpg','SS06')

insert into HinhSP
values ('ss-s21FE-1.jpg','SS07')
insert into HinhSP
values ('ss-s21FE-2.jpg','SS07')
insert into HinhSP
values ('ss-s21FE-3.jpg','SS07')
insert into HinhSP
values ('ss-s21FE-4.png','SS07')
insert into HinhSP
values ('ss-s21FE-5.png','SS07')
insert into HinhSP
values ('ss-s21FE-6.png','SS07')

insert into HinhSP
values ('ss-s22-1.jpg','SS08')
insert into HinhSP
values ('ss-s22-2.jpg','SS08')
insert into HinhSP
values ('ss-s22-3.png','SS08')
insert into HinhSP
values ('ss-s22-4.png','SS08')
insert into HinhSP
values ('ss-s22-5.png','SS08')
insert into HinhSP
values ('ss-s22-6.png','SS08')

insert into HinhSP
values ('ss-s22ul-1.jpg','SS09')
insert into HinhSP
values ('ss-s22ul-2.png','SS09')
insert into HinhSP
values ('ss-s22ul-3.jpg','SS09')
insert into HinhSP
values ('ss-s22ul-4.jpg','SS09')
insert into HinhSP
values ('ss-s22ul-5.jpg','SS09')
insert into HinhSP
values ('ss-s22ul-6.jpg','SS09')



insert into HinhSP
values ('ss-S23-1.png','SS10')
insert into HinhSP
values ('ss-S23-2.png','SS10')
insert into HinhSP
values ('ss-S23-3.png','SS10')
insert into HinhSP
values ('ss-S23-4.jpg','SS10')
insert into HinhSP
values ('ss-S23-5.png','SS10')
insert into HinhSP
values ('ss-S23-6.png','SS10')

insert into HinhSP
values ('ss-zFlip-1.jpg','SS11')
insert into HinhSP
values ('ss-zFlip-2.jpg','SS11')
insert into HinhSP
values ('ss-zFlip-3.jpg','SS11')
insert into HinhSP
values ('ss-zFlip-4.jpg','SS11')
insert into HinhSP
values ('ss-zFlip-5.jpg','SS11')
insert into HinhSP
values ('ss-zFlip-6.jpg','SS11')

insert into HinhSP
values ('ss-zFold3-1.png','SS12')
insert into HinhSP
values ('ss-zFold3-2.jpg','SS12')
insert into HinhSP
values ('ss-zFold3-3.jpg','SS12')
insert into HinhSP
values ('ss-zFold3-4.jpg','SS12')
insert into HinhSP
values ('ss-zFold3-5.jpg','SS12')
insert into HinhSP
values ('ss-zFold3-6.jpg','SS12')
-------------chi gtiet san pham-----------

-------huawei--------

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP001','HW01','M01','DL01','8600000','4')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP002','HW01','M01','DL02','8600000','5')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP003','HW01','M02','DL01','8600000','7')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP004','HW01','M02','DL02','8600000','3')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP005','HW02','M11','DL01','10000000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP006','HW02','M11','DL02','10000000','6')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP007','HW02','M08','DL01','10000000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP008','HW02','M08','DL02','10000000','6')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP009','HW02','M07','DL01','10000000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP010','HW02','M07','DL02','10000000','6')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP011','HW04','M02','DL02','9400000','5')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP012','HW04','M11','DL02','9400000','4')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP013','HW04','M04','DL02','9400000','10')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP014','HW04','M10','DL02','9400000','8')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP015','HW05','M04','DL02','10600000','6')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP016','HW05','M02','DL02','10600000','7')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP017','HW06','M07','DL01','11400000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP018','HW06','M07','DL02','11400000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP019','HW06','M08','DL01','11400000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP020','HW06','M08','DL02','11400000','8')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP021','HW07','M04','DL02','11400000','7')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP022','HW07','M04','DL02','11400000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP023','HW07','M02','DL01','11400000','9')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP024','HW07','M02','DL01','11400000','8')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP025','HW08','M09','DL01','7400000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP026','HW08','M09','DL02','7400000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP027','HW08','M01','DL01','7400000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP028','HW08','M01','DL02','7400000','8')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP029','HW09','M01','DL01','8700000','9')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP030','HW09','M01','DL02','8700000','9')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP032','HW09','M11','DL01','8700000','9')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP033','HW09','M11','DL02','8700000','9')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP034','HW10','M04','DL01','9800000','6')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP035','HW10','M04','DL02','9800000','6')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP036','HW10','M09','DL01','9800000','6')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP037','HW10','M09','DL02','9800000','6')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP038','HW11','M05','DL02','11800000','6')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP039','HW11','M05','DL02','11800000','6')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP040','HW11','M01','DL02','11800000','6')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP041','HW11','M01','DL02','11800000','6')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP042','HW11','M02','DL02','11800000','6')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP043','HW11','M02','DL02','11800000','6')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP044','HW12','M04','DL04','12800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP045','HW12','M02','DL04','12800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP046','HW12','M05','DL04','12800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP047','HW12','M10','DL04','12800000','8')
------------SAM SUNG-------------
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP048','SS01','M01','DL01','7800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP049','SS01','M09','DL01','7800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP050','SS01','M02','DL01','7800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP051','SS01','M11','DL01','7800000','8')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP052','SS02','M08','DL02','9800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP053','SS02','M08','DL01','9800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP054','SS02','M09','DL02','9800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP055','SS02','M09','DL01','9800000','8')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP056','SS03','M01','DL02','8800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP057','SS03','M02','DL02','8800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP058','SS03','M04','DL02','8800000','8')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP059','SS04','M09','DL02','9500000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP060','SS04','M04','DL02','9500000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP061','SS04','M05','DL02','9500000','8')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP062','SS05','M09','DL02','11500000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP063','SS05','M01','DL02','11500000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP064','SS05','M02','DL02','11500000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP065','SS05','M10','DL02','11500000','8')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP066','SS06','M01','DL01','7600000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP067','SS06','M02','DL01','7600000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP068','SS06','M04','DL01','7600000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP069','SS06','M09','DL01','7600000','8')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP070','SS07','M08','DL01','8400000','9')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP071','SS07','M09','DL01','8400000','9')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP072','SS07','M01','DL01','8400000','9')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP073','SS07','M07','DL01','8400000','9')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP074','SS08','M07','DL01','7600000','9')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP075','SS08','M09','DL01','7600000','9')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP076','SS08','M05','DL01','7600000','9')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP077','SS08','M02','DL01','7600000','9')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP078','SS08','M01','DL01','7600000','9')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP079','SS09','M10','DL01','9600000','5')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP080','SS09','M08','DL01','9600000','5')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP081','SS09','M01','DL01','9600000','5')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP082','SS09','M02','DL01','9600000','5')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP083','SS10','M10','DL02','11600000','5')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP084','SS10','M08','DL02','11600000','5')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP085','SS10','M01','DL02','11600000','5')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP086','SS10','M02','DL02','11600000','5')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP087','SS11','M02','DL01','6600000','7')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP088','SS11','M02','DL02','6600000','7')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP089','SS12','M01','DL02','9300000','7')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP090','SS12','M02','DL02','9300000','7')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP091','SS12','M08','DL02','9300000','7')

select * from ChiTietSP
-----------IPHONE
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP092','IP01','M01','DL06','15300000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP093','IP01','M02','DL06','15300000','8')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP094','IP02','M03','DL06','20300000','6')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP095','IP02','M04','DL06','20300000','8')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP096','IP03','M03','DL06','20300000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP097','IP03','M03','DL01','20300000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP098','IP03','M09','DL06','20300000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP099','IP03','M09','DL01','20300000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP100','IP03','M03','DL02','20300000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP101','IP03','M09','DL02','20300000','8')


insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP102','IP04','M01','DL06','19800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP103','IP04','M02','DL06','19800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP104','IP04','M08','DL06','19800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP105','IP04','M09','DL06','19800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP106','IP04','M01','DL01','19800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP107','IP04','M02','DL01','19800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP108','IP04','M08','DL01','19800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP109','IP04','M09','DL01','19800000','8')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP110','IP05','M03','DL01','19800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP111','IP05','M05','DL01','19800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP112','IP05','M04','DL01','19800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP113','IP05','M09','DL01','19800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP114','IP05','M03','DL02','19800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP115','IP05','M05','DL02','19800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP116','IP05','M04','DL02','19800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP117','IP05','M09','DL02','19800000','8')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP118','IP06','M03','DL01','20800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP119','IP06','M05','DL01','20800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP120','IP06','M04','DL01','20800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP121','IP06','M09','DL01','20800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP122','IP06','M03','DL02','20800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP123','IP06','M05','DL02','20800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP124','IP06','M04','DL02','20800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP125','IP06','M09','DL02','20800000','8')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP126','IP07','M01','DL02','20800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP127','IP07','M09','DL02','20800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP128','IP07','M10','DL02','20800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP129','IP07','M06','DL02','20800000','8')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP130','IP07','M08','DL02','20800000','8')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP131','IP08','M09','DL04','24800000','6')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP132','IP08','M05','DL04','24800000','6')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP133','IP08','M01','DL04','24800000','6')


insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP134','IP09','M01','DL02','30500000','6')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP135','IP09','M01','DL02','30500000','6')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP136','IP10','M01','DL02','35300000','6')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP137','IP10','M07','DL02','35300000','6')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP138','IP10','M09','DL02','35300000','6')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP139','IP11','M07','DL04','35300000','6')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP140','IP11','M04','DL04','35300000','6')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP141','IP11','M05','DL04','35300000','6')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP142','IP11','M02','DL04','35300000','6')

insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP143','IP12','M07','DL04','40100000','6')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP144','IP12','M04','DL04','40100000','6')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP145','IP12','M05','DL04','40100000','6')
insert into ChiTietSP(MaCTSP,MaSP,MaMau,MaDL,Gia,SoLuongKho)
values('CTSP146','IP12','M02','DL04','40100000','6')

----------LOAI KHACH HANG----------
-----------------------------------
---------------------------------

insert into LoaiKH(MaLoaiKH,TenLoaiKH,ChiecKhau)
values ('LKH01',N'Đồng','0')
insert into LoaiKH(MaLoaiKH,TenLoaiKH,ChiecKhau)
values ('LKH02',N'Bạc','0.10')
insert into LoaiKH(MaLoaiKH,TenLoaiKH,ChiecKhau)
values ('LKH03',N'Vàng','0.15')
insert into LoaiKH(MaLoaiKH,TenLoaiKH,ChiecKhau)
values ('LKH04',N'Kim Cương','0.20')

-----------KHACH HANG------------

insert into KhachHang
values('KH01',N'Nguyễn Văn Khải','0377270755',N'288 Sư Vạn Hạnh Phường 13 Quận 10 HCM ','Nam','5/23/2000','12345678','abc@gmail.com','LKH01')
insert into KhachHang
values('KH02',N'Nguyễn Thị Lan','0123456789',N'300 Sư Vạn Hạnh Phường 13 Quận 10 HCM ',N'Nữ','1/24/1990','abcd1234','lan123@gmail.com','LKH02')
insert into KhachHang
values('KH03',N'Nguyễn Thanh Tân','0366234567',N'235 Minh Phụng 10 Quận 11 HCM ','Nam','5/23/2000','1234abab','tannt@gmail.com','LKH03')

select * from SanPham
go
create or alter proc xoasp @masp char(4)
as
begin
	delete BinhLuan where MaSP=@masp
	delete HinhSP where MaSP=@masp
	delete ChiTietSP where MaSP=@masp
	delete GiamGiaSP where MaSP=@masp
	delete TSKTSP where MaSP=@masp
	delete SanPham where MaSP=@masp
end
select * from TSKTSP