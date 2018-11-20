Create database QuanLyVatTu
use QuanLyVatTu

set dateformat dmy

----Tao bang -----
create table VatTu(MaVT char(20),MaLoaiVT char(20), TenVT nvarchar (50),SoLuong int, DonVi nvarchar(10),
primary key (MaVT))

create table LoaiVatTu(TenLoaiVT Nvarchar(20),MaLoaiVT char(20),
primary key (MaLoaiVT))

create table CungUng(MaNCC char(20),MaVT char(20)
primary key (MaNCC,MaVT))

create table ChiTietPhieuXuat(MaPhieu char(20),MaVT char(20),SoLuong int
primary key (MaPhieu,MaVT))

create table ChiTietPhieuNhap(MaPhieu char(20),MaVT char(20),SoLuong int
primary key (MaPhieu,MaVT))

create table PhieuXuat(MaPhieu char(20),MaNguoiDung char(20),NgayLap datetime, SoVT int, DiaChi nvarchar(100)
primary key (MaPhieu))

create table NCC(MaNCC char(20),TenNCC nvarchar(50),DienThoai char(11),DiaChi nvarchar(100)
primary key (MaNCC))

create table NguoiDung (MaNguoiDung char(20),MatKhau char(10),Ten nvarchar(50),Quyen char(10)
primary key (MaNguoiDung))

create table PhieuNhap (MaPhieu char(20),MaNguoiDung char(20),NgayLap datetime, SoLoaiVT int
primary key (MaPhieu))


----Tao Khoa ngoai-----

alter table VatTu add constraint fk_LoaiVT_VatTu foreign key (MaLoaiVT) references LoaiVatTu(MaLoaiVT)

alter table CungUng add constraint fk_CungUng_VatTu foreign key (MaVT) references VatTu(MaVT)

alter table ChiTietPhieuNhap add constraint fk_CTPhieuNhap_VatTu foreign key (MaVT) references VatTu(MaVT)

alter table ChiTietPhieuXuat add constraint fk_CTPhieuXuat_VatTu foreign key (MaVT) references VatTu(MaVT)

alter table ChiTietPhieuNhap add constraint fk_CTPhieuNhap_PhieuXuat foreign key (MaPhieu) references PhieuXuat(MaPhieu)

alter table ChiTietPhieuXuat add constraint fk_CTPhieuXuat_PhieuNhap foreign key (MaPhieu) references PhieuNhap(MaPhieu)

alter table CungUng add constraint fk_CungUng_NCC foreign key (MaNCC) references NCC(MaNCC)

alter table PhieuXuat add constraint fk_PhieuXuat_NguoiDung foreign key (MaNguoiDung) references NguoiDung(MaNguoiDung)

alter table PhieuNhap add constraint fk_PhieuNhap_NguoiDung foreign key (MaNguoiDung) references NguoiDung(MaNguoiDung)


Alter table ChiTietPhieuXuat drop constraint

fk_CTPhieuXuat_PhieuNhap

-- tao store Cungung 
create proc sp_ThemCungUng(@MaNCC char(20),@MaVT char(20))
as
insert into CungUng(MaNCC,MaVT)
values (@MaNCC,@MaVT)

create proc sp_XoaCungUng(@MaNCC char(20))
as 
delete from CungUng
where MaNCC = @MaNCC

create proc sp_SuaCungUng(@MaNCC char(20),@MaVT char(20))
as
update CungUng
set MaVT = MaVT
where MaNCC = @MaNCC

create proc sp_LayDSCungUng
as
select * from Cungung


--thuc thi
exec sp_ThemCungUng '001','111'
exec sp_LayDSCungUng
exec sp_SuaCungUng '002','112'
exec sp_XoaCungUng '001'

--tao store Nguoi cung cap

create proc sp_ThemNCC(@MaNCC char(20),@TenNCC nvarchar(50),@DienThoai char(11),@Diachi nvarchar(100))
as
insert into NCC(MaNCC,TenNCC,DienThoai,DiaChi)
values (@MaNCC,@TenNCC,@DienThoai,@Diachi)

create proc sp_XoaNCC(@MaNCC char(20))
as 
delete from NCC
where MaNCC = @MaNCC

create proc sp_SuaNCC(@MaNCC char(20),@TenNCC nvarchar(50),@DienThoai char(11),@Diachi nvarchar(100))
as
update NCC
set TenNCC= @TenNCC,
DienThoai = @DienThoai,
DiaChi = @DiaChi
where MaNCC = @MaNCC

create proc sp_LayDSNCC
as
select * from NCC


--thuc thi
exec sp_ThemNCC '002',N'haha','015155',N'tphcm1'
exec sp_LayDSNCC
exec sp_SuaNCC '001',N'hahaaqaa','0551155',N'tphcm'
exec sp_XoaNCC '001' 

--tao store Nguoi Dung

create proc sp_ThemNguoiDung(@MaNguoiDung char(20),@MatKhau char(20),@Ten nvarchar(50),@Quyen char(10))
as
 insert into NguoiDung(MaNguoiDung,MatKhau,Ten,Quyen)
values (@MaNguoiDung,@MatKhau,@Ten,@Quyen)

create proc sp_XoaNguoiDung(@MaNguoiDung char(20))
as 
delete from NguoiDung
where MaNguoiDung = @MaNguoiDung

create proc sp_SuaNguoiDung(@MaNguoiDung char(20),@MatKhau char(20),@Ten nvarchar(50),@Quyen char(10))
as
update NguoiDung
set MatKhau = @MatKhau,
Ten = @Ten,
Quyen = @Quyen
where MaNguoiDung = @MaNguoiDung

create proc sp_LayDSNguoiDung
as
select * from NguoiDung


--thuc thi
exec sp_ThemNguoiDung '0011','1111',N'hha','xem'
exec sp_LayDSNguoiDung
exec sp_SuaNguoiDung '0011','1212',N'df','sua'
exec sp_XoaNguoiDung'0011'



-- tao store Chi Tiet Phieu Nhap
create proc sp_ThemChiTietPhieuNhap(@MaPhieu char(20),@MaVT char(20),@SoLuong int)
as
insert into ChiTietPhieuNhap(MaPhieu,MaVT,SoLuong)
values (@MaPhieu,@MaVT,@SoLuong)

create proc sp_XoaChiTietPhieuNhap(@MaPhieu char(20))
as 
delete from ChiTietPhieuNhap
where MaPhieu = @MaPhieu

create proc sp_SuaChiTietPhieuNhap(@MaPhieu char(20),@MaVT char(20),@SoLuong int)
as
update ChiTietPhieuNhap
set SoLuong = @SoLuong
where MaPhieu= @MaPhieu

create proc sp_LayDSChiTietPhieuNhap
as
select * from ChiTietPhieuNhap


--thuc thi
exec sp_ThemChiTietPhieuNhap '001','111','20'
exec sp_LayDSChiTietPhieuNhap
exec sp_SuaChiTietPhieuNhap '001','112','30'
exec sp_XoaChiTietPhieuNhap '001'


-- tao store Loai vat tu
create proc sp_ThemLoaiVatTu(@MaLoaiVT char(20),@TenLoaiVT nvarchar(20))
as
insert into LoaiVatTu(MaLoaiVT,TenLoaiVT)
values (@MaLoaiVT,@TenLoaiVT)

create proc sp_XoaLoaiVatTu(@MaLoaiVT char(20))
as 
delete from LoaiVatTu
where MaLoaiVT = @MaLoaiVT

create proc sp_SuaLoaiVatTu(@MaLoaiVT char(20),@TenLoaiVT nvarchar(20))
as
update LoaiVatTu
set TenLoaiVT = @TenLoaiVT
where MaLoaiVT = @MaLoaiVT

create proc sp_LayDSLoaiVatTu
as
select * from LoaiVatTu


--thuc thi
exec sp_ThemLoaiVatTu '001','111'
exec sp_LayDSLoaiVatTu
exec sp_SuaLoaiVatTu '001','112'
exec sp_XoaLoaiVatTu '001'


-- tao store vat tu
create proc sp_ThemVatTu(@MaVT char(10),@MaLoaiVT char(20),@TenVT nvarchar(20),@SoLuong int,@DonVi nvarchar(10))
as
insert into VatTu(MaVT,MaLoaiVT,TenVT,SoLuong,DonVi)
values (@MaVT,@MaLoaiVT,@TenVT,@SoLuong,@DonVi)

create proc sp_XoaVatTu(@MaVT char(10))
as 
delete from VatTu
where MaVT = @MaVT

create proc sp_SuaVatTu(@MaVT char(10),@TenVT nvarchar(20),@SoLuong int,@DonVi nvarchar(10))
as
update VatTu
set TenVT = @TenVT,SoLuong = @SoLuong, DonVi = @DonVi
where MaVT = @MaVT

create proc sp_LayDSVatTu
as
select * from VatTu


--thuc thi
exec sp_ThemVatTu '001','111',N'ong kem','2',N'cai'
exec sp_LayDSVatTu
exec sp_SuaVatTu '001',N'ong kem1','23',N'cai'
exec sp_XoaVatTu '001'


-- tao store Chi Tiet Phieu Xuat
create proc sp_ThemChiTietPhieuXuat(@MaPhieu char(20),@MaVT char(20),@SoLuong int)
as
insert into ChiTietPhieuXuat(MaPhieu,MaVT,SoLuong)
values (@MaPhieu,@MaVT,@SoLuong)

create proc sp_XoaChiTietPhieuXuat(@MaPhieu char(20))
as 
delete from ChiTietPhieuXuat
where MaPhieu = @MaPhieu

create proc sp_SuaChiTietPhieuXuat(@MaPhieu char(20),@MaVT char(20),@SoLuong int)
as
update ChiTietPhieuXuat
set SoLuong = @SoLuong
where MaPhieu= @MaPhieu

create proc sp_LayDSChiTietPhieuXuat
as
select * from ChiTietPhieuXuat


--thuc thi
exec sp_ThemChiTietPhieuXuat '001','111','20'
exec sp_LayDSChiTietPhieuXuat
exec sp_SuaChiTietPhieuXuat '001','112','30'
exec sp_XoaChiTietPhieuXuat '001'

-- tao store Phieu Xuat
set dateformat dmy
create proc sp_ThemPhieuXuat(@MaPhieu char(20),@MaNguoiLap char(20),@NgayLap datetime, @SoVT int,@DiaChi nvarchar(100))
as
insert into PhieuXuat(MaPhieu,MaNguoiLap,NgayLap,SoVT,DiaChi)
values (@MaPhieu,@MaNguoiLap,@NgayLap,@SoVT,@DiaChi)

create proc sp_XoaPhieuXuat(@MaPhieu char(20))
as 
delete from PhieuXuat
where MaPhieu = @MaPhieu

create proc sp_SuaPhieuXuat(@MaPhieu char(20),@NgayLap datetime, @SoVT int,@DiaChi nvarchar (100))
as
update PhieuXuat
set NgayLap = @NgayLap,SoVT = @SoVT,DiaChi = @DiaChi
where MaPhieu= @MaPhieu

create proc sp_LayDSPhieuXuat
as
select * from PhieuXuat


--thuc thi
exec sp_ThemPhieuXuat '004','111','2/1/2010','3',N'Tphcm'
exec sp_LayDSPhieuXuat
exec sp_SuaPhieuXuat '001','2/2/2010','30',N'Tphcm'
exec sp_XoaPhieuXuat '004'

-- tao store Phieu Nhap

create proc sp_ThemPhieuNhap(@MaPhieu char(20),@MaNguoiLap char(20),@NgayLap datetime, @SoLoaiVT int)
as
insert into PhieuNhap(MaPhieu,MaNguoiLap,NgayLap,SoLoaiVT)
values (@MaPhieu,@MaNguoiLap,@NgayLap,@SoLoaiVT)

create proc sp_XoaPhieuNhap(@MaPhieu char(20))
as 
delete from PhieuNhap
where MaPhieu = @MaPhieu

create proc sp_SuaPhieuNhap(@MaPhieu char(20),@NgayLap datetime, @SoLoaiVT int)
as
update PhieuNhap
set NgayLap = @NgayLap,SoLoaiVT = @SoLoaiVT
where MaPhieu= @MaPhieu

create proc sp_LayDSPhieuNhap
as
select * from PhieuNhap


--thuc thi
exec sp_ThemPhieuNhap '004','111','2/1/2010','3'
exec sp_LayDSPhieuNhap
exec sp_SuaPhieuNhap '001','2/2/2010','30'
exec sp_XoaPhieuNhap '004'