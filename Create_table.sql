USE [master]
GO
/****** Object:  Database [TTN_QLNS]    Script Date: 22/02/2017 7:36:33 CH ******/
CREATE DATABASE [TTN_QLNS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TTN_QLNS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\TTN_QLNS.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TTN_QLNS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\TTN_QLNS_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TTN_QLNS] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TTN_QLNS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TTN_QLNS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TTN_QLNS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TTN_QLNS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TTN_QLNS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TTN_QLNS] SET ARITHABORT OFF 
GO
ALTER DATABASE [TTN_QLNS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TTN_QLNS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TTN_QLNS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TTN_QLNS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TTN_QLNS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TTN_QLNS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TTN_QLNS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TTN_QLNS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TTN_QLNS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TTN_QLNS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TTN_QLNS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TTN_QLNS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TTN_QLNS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TTN_QLNS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TTN_QLNS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TTN_QLNS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TTN_QLNS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TTN_QLNS] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TTN_QLNS] SET  MULTI_USER 
GO
ALTER DATABASE [TTN_QLNS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TTN_QLNS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TTN_QLNS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TTN_QLNS] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [TTN_QLNS] SET DELAYED_DURABILITY = DISABLED 
GO
USE [TTN_QLNS]
GO
/****** Object:  UserDefinedFunction [dbo].[auto_ma_chucvu]    Script Date: 22/02/2017 7:36:33 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--1.	--mã tự động tăng khi insert vào bảng chức vụ
create function [dbo].[auto_ma_chucvu]() returns varchar(6)
as
begin
	declare @ma varchar(50)
	if(select count(ma) from ChucVu)=0
	set @ma='0'
	else 
		select @ma=max(right(ma,4)) from ChucVu
		set @ma=case
		when
		@ma>=0 and @ma<9 then 'DK000'+CONVERT(char,CONVERT(int,@ma)+1)
		when @ma>=9 and @ma<99then 'DK00'+CONVERT(char,CONVERT(int,@ma)+1)
		when @ma>=99 and @ma<999then 'DK0'+CONVERT(char,CONVERT(int,@ma)+1)
		end
		return @ma
end

GO
/****** Object:  UserDefinedFunction [dbo].[auto_ma_luong]    Script Date: 22/02/2017 7:36:33 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--1.	--mã tự động tăng khi insert vào bảng Lương
create function [dbo].[auto_ma_luong]() returns varchar(6)
as
begin
	declare @ma varchar(50)
	if(select count(ma) from Luong)=0
	set @ma='0'
	else 
		select @ma=max(right(ma,4)) from Luong
		set @ma=case
		when
		@ma>=0 and @ma<9 then 'DK000'+CONVERT(char,CONVERT(int,@ma)+1)
		when @ma>=9 and @ma<99then 'DK00'+CONVERT(char,CONVERT(int,@ma)+1)
		when @ma>=99 and @ma<999then 'DK0'+CONVERT(char,CONVERT(int,@ma)+1)
		end
		return @ma
end
GO
/****** Object:  UserDefinedFunction [dbo].[auto_ma_TDHV]    Script Date: 22/02/2017 7:36:33 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--1.	--mã tự động tăng khi insert vào bảng trình độ học vấn
CREATE function [dbo].[auto_ma_TDHV]() returns varchar(6)
as
begin
	declare @ma varchar(50)
	if(select count(ma) from TrinhDoHocVan)=0
	set @ma='0'
	else 
		select @ma=max(right(ma,4)) from TrinhDoHocVan
		set @ma=case
		when
		@ma>=0 and @ma<9 then 'DK000'+CONVERT(char,CONVERT(int,@ma)+1)
		when @ma>=9 and @ma<99then 'DK00'+CONVERT(char,CONVERT(int,@ma)+1)
		when @ma>=99 and @ma<999then 'DK0'+CONVERT(char,CONVERT(int,@ma)+1)
		end
		return @ma
end

GO
/****** Object:  Table [dbo].[ChucVu]    Script Date: 22/02/2017 7:36:33 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ChucVu](
	[ma] [varchar](10) NOT NULL,
	[ten] [nvarchar](50) NULL,
	[phuCap] [varchar](10) NULL,
	[ghiChu] [nvarchar](200) NULL,
 CONSTRAINT [PK_ChucVu] PRIMARY KEY CLUSTERED 
(
	[ma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Luong]    Script Date: 22/02/2017 7:36:33 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Luong](
	[ma] [varchar](10) NOT NULL,
	[hesoluong] [float] NULL DEFAULT ((0)),
	[luongcoban] [float] NULL DEFAULT ((0)),
	[hesophucap] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[ma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 22/02/2017 7:36:33 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NhanVien](
	[ma] [varchar](10) NULL,
	[ten] [nvarchar](50) NULL,
	[ngaysinh] [date] NULL,
	[gioitinh] [bit] NULL,
	[diachi] [nvarchar](200) NULL,
	[socmnd] [varchar](15) NULL,
	[dienthoai] [varchar](10) NULL,
	[email] [nvarchar](50) NULL,
	[maChucVu] [varchar](10) NULL,
	[maluong] [varchar](10) NULL,
	[maphongban] [varchar](10) NULL,
	[maTDHV] [varchar](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PhongBan]    Script Date: 22/02/2017 7:36:33 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PhongBan](
	[ma] [varchar](10) NOT NULL,
	[ten] [nvarchar](50) NULL,
	[dienthoai] [varchar](10) NULL,
	[diachi] [nvarchar](50) NULL,
 CONSTRAINT [PK_PhongBan] PRIMARY KEY CLUSTERED 
(
	[ma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TrinhDoHocVan]    Script Date: 22/02/2017 7:36:33 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TrinhDoHocVan](
	[ma] [varchar](10) NOT NULL,
	[ten] [nvarchar](50) NULL,
 CONSTRAINT [PK_TrinhDoHocVan] PRIMARY KEY CLUSTERED 
(
	[ma] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[ChucVu] ([ma], [ten], [phuCap], [ghiChu]) VALUES (N'CV0001', N'Tổng giám đốc', N'0.5', N'')
INSERT [dbo].[ChucVu] ([ma], [ten], [phuCap], [ghiChu]) VALUES (N'CV0002', N'Chủ tịch hội đồng quản trị', N'0.47', N'')
INSERT [dbo].[ChucVu] ([ma], [ten], [phuCap], [ghiChu]) VALUES (N'CV0003', N'Phó tổng giám đốc', N'0.45', N'')
INSERT [dbo].[ChucVu] ([ma], [ten], [phuCap], [ghiChu]) VALUES (N'CV0004', N'Giám đốc', N'0.43', N'')
INSERT [dbo].[ChucVu] ([ma], [ten], [phuCap], [ghiChu]) VALUES (N'CV0005', N'Phó giám đốc', N'0.4', N'')
INSERT [dbo].[ChucVu] ([ma], [ten], [phuCap], [ghiChu]) VALUES (N'CV0006', N'Trưởng phòng', N'0.37', N'')
INSERT [dbo].[ChucVu] ([ma], [ten], [phuCap], [ghiChu]) VALUES (N'CV0007', N'Phó phòng', N'0.35', N'')
INSERT [dbo].[ChucVu] ([ma], [ten], [phuCap], [ghiChu]) VALUES (N'CV0008', N'Tổ trưởng', N'0.33', N'')
INSERT [dbo].[ChucVu] ([ma], [ten], [phuCap], [ghiChu]) VALUES (N'CV0009', N'Tổ phó', N'0.3', N'')
INSERT [dbo].[ChucVu] ([ma], [ten], [phuCap], [ghiChu]) VALUES (N'CV0010', N'Nhân viên', N'0.25', N'')
INSERT [dbo].[ChucVu] ([ma], [ten], [phuCap], [ghiChu]) VALUES (N'CV0011', N'Giám đốc khu vực', N'0.4', N'')
INSERT [dbo].[ChucVu] ([ma], [ten], [phuCap], [ghiChu]) VALUES (N'CV0012', N'Tổng điều hành', N'0.45', N'')
INSERT [dbo].[Luong] ([ma], [hesoluong], [luongcoban], [hesophucap]) VALUES (N'L0001', 1, 1000000, 0)
INSERT [dbo].[Luong] ([ma], [hesoluong], [luongcoban], [hesophucap]) VALUES (N'L0002', 1.1, 1000000, 0)
INSERT [dbo].[Luong] ([ma], [hesoluong], [luongcoban], [hesophucap]) VALUES (N'L0003', 1.2, 1300000, 0)
INSERT [dbo].[Luong] ([ma], [hesoluong], [luongcoban], [hesophucap]) VALUES (N'L0004', 1.3, 1500000, 0)
INSERT [dbo].[Luong] ([ma], [hesoluong], [luongcoban], [hesophucap]) VALUES (N'L0005', 1.5, 1500000, 0)
INSERT [dbo].[NhanVien] ([ma], [ten], [ngaysinh], [gioitinh], [diachi], [socmnd], [dienthoai], [email], [maChucVu], [maluong], [maphongban], [maTDHV]) VALUES (N'NV0001', N'Nguyễn Văn Nam', CAST(N'1990-01-01' AS Date), 1, N'Hà Nội', N'164562799', N'098765431', N'namnv@gmail.com', N'CV0001', N'L0001', N'PB0001', N'TDHV0003')
INSERT [dbo].[NhanVien] ([ma], [ten], [ngaysinh], [gioitinh], [diachi], [socmnd], [dienthoai], [email], [maChucVu], [maluong], [maphongban], [maTDHV]) VALUES (N'NV0002', N'Hà Thanh Hằng', NULL, NULL, N'Hà Nội', NULL, NULL, N'hanght@gmail.com', N'CV0001', N'L0002', N'PB0001', N'TDHV0004')
INSERT [dbo].[NhanVien] ([ma], [ten], [ngaysinh], [gioitinh], [diachi], [socmnd], [dienthoai], [email], [maChucVu], [maluong], [maphongban], [maTDHV]) VALUES (N'NV0010', N'Bùi Quốc Trung', NULL, NULL, N'Hà Nội', NULL, NULL, N'trungbq@gmail.com', N'CV0009', N'L0003', N'PB0005', N'TDHV0004')
INSERT [dbo].[NhanVien] ([ma], [ten], [ngaysinh], [gioitinh], [diachi], [socmnd], [dienthoai], [email], [maChucVu], [maluong], [maphongban], [maTDHV]) VALUES (N'NV0003', N'Tạ Tương Hải', NULL, NULL, N'Ninh Bình', NULL, NULL, N'haitt@gmail.com', N'CV0002', N'L0002', N'PB0001', N'TDHV0004')
INSERT [dbo].[NhanVien] ([ma], [ten], [ngaysinh], [gioitinh], [diachi], [socmnd], [dienthoai], [email], [maChucVu], [maluong], [maphongban], [maTDHV]) VALUES (N'NV0004', N'Phan Nhật Anh', NULL, NULL, N'Nam Định', NULL, NULL, N'anhpn@gmail.com', N'CV0003', N'L0002', N'PB0002', N'TDHV0004')
INSERT [dbo].[NhanVien] ([ma], [ten], [ngaysinh], [gioitinh], [diachi], [socmnd], [dienthoai], [email], [maChucVu], [maluong], [maphongban], [maTDHV]) VALUES (N'NV0005', N'Lê Thu Hà', NULL, NULL, N'Hà Nam', NULL, NULL, N'halt@gmail.com', N'CV0004', N'L0002', N'PB0002', N'TDHV0004')
INSERT [dbo].[NhanVien] ([ma], [ten], [ngaysinh], [gioitinh], [diachi], [socmnd], [dienthoai], [email], [maChucVu], [maluong], [maphongban], [maTDHV]) VALUES (N'NV0006', N'Phạm Thu Thảo', NULL, NULL, N'Thanh Hóa', NULL, NULL, N'thaopt@gmail.com', N'CV0005', N'L0003', N'PB0002', N'TDHV0004')
INSERT [dbo].[NhanVien] ([ma], [ten], [ngaysinh], [gioitinh], [diachi], [socmnd], [dienthoai], [email], [maChucVu], [maluong], [maphongban], [maTDHV]) VALUES (N'NV0007', N'Nguyễn Thị Hiền', NULL, NULL, N'Bắc Giang', NULL, NULL, N'hiennt@gmail.com', N'CV0006', N'L0003', N'PB0003', N'TDHV0004')
INSERT [dbo].[NhanVien] ([ma], [ten], [ngaysinh], [gioitinh], [diachi], [socmnd], [dienthoai], [email], [maChucVu], [maluong], [maphongban], [maTDHV]) VALUES (N'NV0008', N'Đỗ Cao Phong', NULL, NULL, N'Ninh Bình', NULL, NULL, N'phongdc@gmail.com', N'CV0007', N'L0003', N'PB0003', N'TDHV0004')
INSERT [dbo].[NhanVien] ([ma], [ten], [ngaysinh], [gioitinh], [diachi], [socmnd], [dienthoai], [email], [maChucVu], [maluong], [maphongban], [maTDHV]) VALUES (N'NV0009', N'Phan Duy Hùng', NULL, NULL, N'Hải Phòng', NULL, NULL, N'hungpd@gmail.com', N'CV0008', N'L0003', N'PB0004', N'TDHV0004')
INSERT [dbo].[PhongBan] ([ma], [ten], [dienthoai], [diachi]) VALUES (N'PB0001', N'Phòng giám đốc', N'0123456789', N'S11501')
INSERT [dbo].[PhongBan] ([ma], [ten], [dienthoai], [diachi]) VALUES (N'PB0002', N'Phòng phó giám đốc', N'0123456788', N'S11502')
INSERT [dbo].[PhongBan] ([ma], [ten], [dienthoai], [diachi]) VALUES (N'PB0003', N'Phòng ý tưởng', N'0123456787', N'S11503')
INSERT [dbo].[PhongBan] ([ma], [ten], [dienthoai], [diachi]) VALUES (N'PB0004', N'Phòng kế toán', N'0123456786', N'S11401')
INSERT [dbo].[PhongBan] ([ma], [ten], [dienthoai], [diachi]) VALUES (N'PB0005', N'Phòng thiết kế', N'0123456785', N'S11402')
INSERT [dbo].[PhongBan] ([ma], [ten], [dienthoai], [diachi]) VALUES (N'PB0006', N'Phòng nhân sự', N'0123456784', N'S11403')
INSERT [dbo].[PhongBan] ([ma], [ten], [dienthoai], [diachi]) VALUES (N'PB0007', N'Phòng kinh doanh', N'0123456783', N'S11001')
INSERT [dbo].[PhongBan] ([ma], [ten], [dienthoai], [diachi]) VALUES (N'PB0008', N'Phòng ngoại giao', N'0123456782', N'S11002')
INSERT [dbo].[PhongBan] ([ma], [ten], [dienthoai], [diachi]) VALUES (N'PB0009', N'Phòng lễ tân', N'0123456781', N'S11003')
INSERT [dbo].[TrinhDoHocVan] ([ma], [ten]) VALUES (N'TDHV0001', N'5/12')
INSERT [dbo].[TrinhDoHocVan] ([ma], [ten]) VALUES (N'TDHV0002', N'9/12')
INSERT [dbo].[TrinhDoHocVan] ([ma], [ten]) VALUES (N'TDHV0003', N'12/12')
INSERT [dbo].[TrinhDoHocVan] ([ma], [ten]) VALUES (N'TDHV0004', N'Cử nhân')
INSERT [dbo].[TrinhDoHocVan] ([ma], [ten]) VALUES (N'TDHV0005', N'Kỹ sư')
INSERT [dbo].[TrinhDoHocVan] ([ma], [ten]) VALUES (N'TDHV0006', N'Thạc sỹ')
INSERT [dbo].[TrinhDoHocVan] ([ma], [ten]) VALUES (N'TDHV0007', N'Tiến sỹ')
INSERT [dbo].[TrinhDoHocVan] ([ma], [ten]) VALUES (N'TDHV0008', N'Giáo sư')
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD FOREIGN KEY([maChucVu])
REFERENCES [dbo].[ChucVu] ([ma])
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD FOREIGN KEY([maluong])
REFERENCES [dbo].[Luong] ([ma])
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD FOREIGN KEY([maphongban])
REFERENCES [dbo].[PhongBan] ([ma])
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD FOREIGN KEY([maTDHV])
REFERENCES [dbo].[TrinhDoHocVan] ([ma])
GO
USE [master]
GO
ALTER DATABASE [TTN_QLNS] SET  READ_WRITE 
GO
