CREATE TABLE LSNV (
    Id Varchar(10) FOREIGN KEY REFERENCES Nhanvien(Id),
    MaNV VARCHAR(20),
    HoTen NVARCHAR(100),
    NgayThayDoi DATETIME,
    NoiDung NVARCHAR(MAX)
);

CREATE PROCEDURE ImportNhanVienToLSNV
	@NoiDung NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO LSNV (ID, MaNV, HoTen, NgayThayDoi, NoiDung)
    SELECT Id, MaNV, TenNV, GETDATE(), @NoiDung
    FROM NhanVien;
END;

EXEC ImportNhanVienToLSNV 'Cap nhat du lieu lan 3'

CREATE TRIGGER UpdateLSNVwhenNhanVienUpdate
ON NhanVien
AFTER UPDATE
AS
BEGIN
    IF UPDATE(TenNV)
    BEGIN
        UPDATE LSNV
        SET HoTen = inserted.TenNV, NgayThayDoi = GETDATE(), NoiDung = N'Cap nhat ten nhan vien'
        FROM LSNV
        INNER JOIN inserted ON LSNV.Id = inserted.Id;
    END;
END;

EXEC UpdateNhanVien NV28, '28', 'Nguyen Van A', '1-1-2000', 'Hanoi', 'Nhanvien', 'VH', 'QL2'