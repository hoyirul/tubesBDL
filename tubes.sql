-- FITUR --
-- Pelanggan : Login, pemesanan treatment, Kategori paket, konsultasi, transaksi, track record perawatan, logout
-- Pemilik   : Login, Kategori paket, data konsultasi, transaksi, data pelanggan, laporan pasien, laporan transaksi logout
-- dokter    : Login, isi konsultasi, track record perawatan, logout
-- pegawai   : Login, data kategori paket, data konsultasi, laporan, transaksi, data pelangan, logout

use db_klican;

-- Function Login
GO
    ALTER FUNCTION auth(@email varchar(50), @password varchar(255))
    RETURNS TABLE 
    AS
    RETURN (
        select * from users u where u.email = @email and u.password = @password
    )
GO
-- End Function Login

-- View Pelanggan
GO
    ALTER VIEW getPelanggan AS
    SELECT 
        pl.pelanggan_id, pl.nama, pl.jk, pl.no_telp, 
        pl.alamat, pl.tanggal_lahir, pl.status, 
        u.email, u.password, u.token, u.joined
    FROM pelanggan pl
    INNER JOIN users u ON u.uid = pl.uid
GO
-- End View Pelanggan

-- View Pemilik
GO
    ALTER VIEW getPemilik AS
    SELECT 
        pm.pemilik_id, pm.nama, pm.jk, pm.no_telp, 
        pm.alamat, pm.tanggal_lahir, pm.status, 
        u.email, u.password, u.token, u.joined
    FROM pemilik pm
    INNER JOIN users u ON u.uid = pm.uid
GO
-- End View Pemilik

-- View Dokter
GO
    ALTER VIEW getDokter AS
    SELECT 
        dk.dokter_id, dk.nama, dk.jk, dk.no_telp, 
        dk.alamat, dk.tanggal_lahir, dk.status, 
        u.email, u.password, u.token, u.joined
    FROM dokter dk
    INNER JOIN users u ON u.uid = dk.uid
GO
-- End View Dokter

-- View Pegawai
GO
    ALTER VIEW getPegawai AS
    SELECT 
        pg.pegawai_id, pg.nama, pg.jk, pg.no_telp, 
        pg.alamat, pg.tanggal_lahir, pg.status, 
        u.email, u.password, u.token, u.joined
    FROM pegawai pg
    INNER JOIN users u ON u.uid = pg.uid
GO
-- End View Pegawai

-- Login 
DECLARE @email varchar(50) = 'hoy35@gmail.com'
DECLARE @password varchar(255) = 'hoyirullah35'
select * from auth(@email, @password)


-- NO 1 (pelanggan baru akan didata dulu oleh pegawai)
-- Prosedure Tambah Pelanggan oleh pegawai
-- NB : Pegawai harus login terlebih dahulu
GO
    CREATE PROCEDURE masterPelanggan(
        @email varchar(50),
        @password varchar(255),
        @nama varchar(50),
        @jk varchar(2),
        @no_telp varchar(16),
        @alamat text,
        @tanggal_lahir date,
        @status varchar(10),
        @decision varchar(10) 
    )
    as
    BEGIN
        declare @userID int = (SELECT count(uid) + 1 as id FROM users)
        declare @pelangganID int = (SELECT count(pelanggan_id) + 1 as id FROM pelanggan)
        declare @uid VARCHAR(6) = cast(@userID as varchar(6))
        declare @pelanggan_id VARCHAR(6) = cast(@pelangganID as varchar(6))
        declare @msg VARCHAR(50) = 'Insert Success'
        IF @pelangganID < 10 and @userID < 10
            BEGIN
                SET @pelanggan_id = CONCAT('C0', @pelanggan_id)
                SET @uid = CONCAT('U0', @uid)
            END
        IF @pelangganID >= 10 and @userID >= 10
            BEGIN
                SET @pelanggan_id = CONCAT('C', @pelanggan_id)
                SET @uid = CONCAT('U', @uid)
            END
        
        Declare @token VARCHAR(255) = (select SUBSTRING(sys.fn_sqlvarbasetostr(HASHBYTES('MD5', @email)),3,32))
        IF @decision = 'insert'
            BEGIN
                insert into users values(@uid, @email, @password, @token, GETDATE())
                IF @uid IS NOT NULL
                    BEGIN
                        insert into pelanggan values(@pelanggan_id, @uid, @nama, @jk, @no_telp, @alamat, @tanggal_lahir, @status)
                        select @msg as message
                    END
            END
    END
GO
-- End Prosedure

EXEC masterPelanggan @email = 'newuser@gmail.com', @password = 'newuser123', @nama = 'Hairullah', @jk = 'L', @no_telp = '08756647362', @alamat = 'Lorem Ipsum', @tanggal_lahir = '2000-10-01', @status = 'pelanggan', @decision = 'insert'

-- NO 2 (pelanggan bisa memesan paket kecantikan dan hari/tanggal perawatan kecantikan)

-- Procedure OrderPaket
GO
    CREATE PROCEDURE orderPaket(
        @pelanggan_id VARCHAR(10),
        @pegawai_id VARCHAR(10),
        @paket_id VARCHAR(10),
        @dokter_id VARCHAR(10),
        @tanggal_rawat DATE
    )
    AS
    BEGIN
        declare @orderID int = (SELECT count(oid) + 1 as id FROM orders)
        declare @rawatID int = (SELECT count(rawat_id) + 1 as id FROM perawatan)
        declare @payID int = (SELECT count(pay_id) + 1 as id FROM payments)
        declare @oid VARCHAR(6) = cast(@orderID as varchar(6))
        declare @pay_id VARCHAR(8) = cast(@payID as varchar(6))
        declare @rawat_id VARCHAR(8) = cast(@rawatID as varchar(6))
        declare @msg VARCHAR(100) = ''

        IF @orderID < 10 and @rawatID < 10
            BEGIN
                SET @rawat_id = CONCAT('R00', @rawat_id)
                SET @oid = CONCAT('OD00', @oid)
                SET @pay_id = CONCAT('PAY000', @pay_id)
            END
        IF @orderID >= 10 and @rawatID >= 10
            BEGIN
                SET @rawat_id = CONCAT('R0', @rawat_id)
                SET @oid = CONCAT('OD0', @oid)
                SET @pay_id = CONCAT('PAY00', @pay_id)
            END
        
        declare @checkPelanggan VARCHAR(10) = (select pelanggan_id from pelanggan WHERE pelanggan_id=@pelanggan_id)
        declare @checkPegawai VARCHAR(10) = (select pegawai_id from pegawai WHERE pegawai_id=@pegawai_id)
        declare @checkPaket VARCHAR(10) = (select paket_id from paket WHERE paket_id=@paket_id)
        declare @checkDokter VARCHAR(10) = (select dokter_id from dokter WHERE dokter_id=@dokter_id)

        IF @pelanggan_id = @checkPelanggan and @pegawai_id = @checkPegawai and @paket_id = @checkPaket
            BEGIN
                declare @total float = (select harga from paket where paket_id=@paket_id)
                insert into orders values(@oid, @pelanggan_id, @pegawai_id, @paket_id, GETDATE(), @total)
                IF @oid IS NOT NULL and @dokter_id = @checkDokter
                    BEGIN
                        insert into perawatan values(@rawat_id, @oid, @dokter_id, '', '', @tanggal_rawat)
                        insert into payments values(@pay_id, @oid, '-', '-', '-', @total, '0', 'pending')
                        SET @msg = 'Success, Order Berhasil. Silahkan melakukan pembayaran!'
                        SELECT @msg as message
                    END
            END
        ELSE
            BEGIN 
                SET @msg = 'Error, mungkin data yang anda inputkan belum ada silahkan cek kembali data anda'
                SELECT @msg as message
            END
    END
GO
-- End Procedure OrderPaket

-- Pegawai melakukan insert order yang diminta oleh pelanggan
EXEC orderPaket @pelanggan_id = 'C01', @pegawai_id = 'P01', @paket_id = 'PC01', @dokter_id = 'DC04', @tanggal_rawat = '2021-12-12'

-- Prosedure Pembayaran
GO
    CREATE PROCEDURE paymentOrder(
        @oid VARCHAR(6),
        @metode varchar(20),
        @bank varchar(10),
        @no_rek varchar(20),
        @bayar float
    )
    AS
    BEGIN
        declare @total FLOAT = (select total from payments where oid=@oid)
        declare @msg VARCHAR(100) = ''
        IF @bayar = @total
            BEGIN
                UPDATE payments SET metode=@metode, bank=@bank, no_rek=@no_rek, bayar=@bayar, [status]='success' where oid=@oid
                SELECT * FROM payments WHERE oid=@oid
            END
        ELSE
            BEGIN
                SET @msg = 'Error, Uang anda kurang, Uang harus pas dengan total bayar!'
                SELECT @msg as message
            END
    END
GO
-- End Procedure

-- Melakukan Payment
-- Jika Uang kurang
EXEC paymentOrder @oid = 'OD021', @metode = 'cash', @bank = '-', @no_rek = '-', @bayar = 90000
-- Jika uang pas
EXEC paymentOrder @oid = 'OD021', @metode = 'cash', @bank = '-', @no_rek = '-', @bayar = 90000


-- NO 3 (pelanggan yang sudah berstatus pelanggan tetap dapat mengakses paket premium)

-- Procedure PremiumPaket
GO
    CREATE PROCEDURE premiumPaket(@pelanggan_id VARCHAR(10))
    AS
    BEGIN
        declare @checkStatus varchar(10) = (select [status] from pelanggan where pelanggan_id=@pelanggan_id)
        declare @msg VARCHAR(100) = ''
        IF @checkStatus = 'pelanggan' or @checkStatus = 'guest'
            BEGIN
                SELECT * FROM paket
            END
        ELSE
            BEGIN
                SET @msg = 'ID Pelanggan tidak terdaftar'
                SELECT @msg as message
            END
    END
GO
-- End Procedure

-- Akses Paket Premium
EXEC premiumPaket @pelanggan_id = 'C01'


-- NO 4 (pegawai dan pemilik klinik bisa memeriksa pembayaran pelanggan)

-- View v_pembayaran
GO
    CREATE VIEW v_pembayaran AS
    SELECT 
        p.pay_id, o.oid, c.nama, c.alamat, c.[status] as statusPelanggan, 
        o.tanggal as tanggalOrder, o.total_bayar,  
        pk.nama_paket, p.metode, p.bank, p.no_rek, p.bayar, p.[status] as statusPay
    FROM payments p
    INNER JOIN orders o ON o.oid = p.oid
    INNER JOIN pelanggan c ON c.pelanggan_id = o.pelanggan_id
    INNER JOIN pegawai pg ON pg.pegawai_id = o.pegawai_id  
    INNER JOIN paket pk ON pk.paket_id = o.paket_id
GO
-- End View

-- Menggunakan stored procedure
-- Procedure checkPayment
GO
    CREATE PROCEDURE checkPayments(@id VARCHAR(10))
    AS
    BEGIN
        declare @checkPemilik VARCHAR(10) = (select pemilik_id from pemilik where pemilik_id=@id)
        declare @checkPegawai VARCHAR(10) = (select pegawai_id from pegawai where pegawai_id=@id)
        declare @msg VARCHAR(100) = ''
        IF @id = @checkPegawai or @id = @checkPemilik
            BEGIN
                select * from v_pembayaran
            END
        ELSE
            BEGIN
                SET @msg = 'ID Pemilik / ID Pegawai tidak terdaftar'
                SELECT @msg as message
            END
    END
GO
-- End Procedure

-- Pemilik
EXEC checkPayments @id = 'D10'

-- Pegawai
EXEC checkPayments @id = 'P01'


-- NO 5 (setiap pelanggan mempunyai track record perawatan yang dapat diakses oleh dokter klinik dan pemilik klinik)
-- view v_track_record
GO
    CREATE VIEW v_track_record AS
    SELECT 
        c.nama, c.alamat, dk.nama as dokter,
        pr.hasil, pr.solusi, pr.tanggal_rawat,
        pk.nama_paket, c.[status] as statusPelanggan
    FROM perawatan pr
    INNER JOIN orders o ON o.oid = pr.oid
    INNER JOIN pelanggan c ON c.pelanggan_id = o.pelanggan_id
    INNER JOIN dokter dk ON dk.dokter_id = pr.dokter_id
    INNER JOIN paket pk ON pk.paket_id = o.paket_id
GO
-- End View

-- Menggunakan stored procedure
-- Procedure checkTrackRecord
GO
    CREATE PROCEDURE checkTrackRecord(@id VARCHAR(10))
    AS
    BEGIN
        declare @checkPemilik VARCHAR(10) = (select pemilik_id from pemilik where pemilik_id=@id)
        declare @checkDokter VARCHAR(10) = (select dokter_id from dokter where dokter_id=@id)
        declare @msg VARCHAR(100) = ''
        IF @id = @checkDokter or @id = @checkPemilik
            BEGIN
                select * from v_track_record
            END
        ELSE
            BEGIN
                SET @msg = 'ID Pemilik / ID Dokter tidak terdaftar'
                SELECT @msg as message
            END
    END
GO
-- End Procedure

-- Pemilik
EXEC checkTrackRecord @id = 'D01'

-- Dokter
EXEC checkTrackRecord @id = 'DC01'


-- NO 6 (dokter klinik  bisa menentukan paket2 kecantikan apa saja yang dapat diakses dan dipesan pelanggan)
-- Menggunakan Procedure
GO
    CREATE PROCEDURE checkPaket(@id VARCHAR(10))
    AS
    BEGIN
        declare @checkPemilik VARCHAR(10) = (select pemilik_id from pemilik where pemilik_id=@id)
        declare @checkDokter VARCHAR(10) = (select dokter_id from dokter where dokter_id=@id)
        declare @msg VARCHAR(100) = ''
        IF @id = @checkDokter or @id = @checkPemilik
            BEGIN
                select * from paket
            END
        ELSE
            BEGIN
                SET @msg = 'ID Dokter tidak terdaftar'
                SELECT @msg as message
            END
    END
GO
-- End Procedure

-- Dokter
EXEC checkPaket @id = 'DC01'

-- NO 7 (pemilik klinik bisa menentukan seluruh paket-paket kecantikan yang ada)
EXEC checkPaket @id = 'D01'

-- NO 8 (pemilik klinik bisa melihat rekap kunjungan pelanggan perbulan)

-- Rekap Perbulan Procedure
GO
    CREATE PROCEDURE rekapKunjungan(@id VARCHAR(10), @fromDate date, @toDate date)
    AS
    BEGIN
        declare @checkPemilik VARCHAR(10) = (select pemilik_id from pemilik where pemilik_id=@id)
        declare @msg VARCHAR(100) = ''
        IF @id = @checkPemilik
            BEGIN
                SELECT 
                    o.oid, c.nama, c.alamat, c.no_telp,
                    o.tanggal as tanggalKunjung, pk.nama_paket as paketYangDiPesan,
                    pr.tanggal_rawat, c.[status] as statusPelanggan
                FROM orders o
                INNER JOIN pelanggan c ON c.pelanggan_id = o.pelanggan_id
                INNER JOIN pegawai pg ON pg.pegawai_id = o.pegawai_id  
                INNER JOIN paket pk ON pk.paket_id = o.paket_id
                INNER JOIN perawatan pr ON pr.oid = o.oid
                WHERE o.tanggal >= @fromDate and o.tanggal <= @toDate
            END
        ELSE
            BEGIN
                SET @msg = 'ID Pemilik tidak terdaftar'
                SELECT @msg as message
            END
    END
GO
-- End Procedure

-- Pemilik Merekap /bulan
EXEC rekapKunjungan @id = 'D01', @fromDate = '2021-09-01', @toDate = '2021-09-30'

-- additional Fitur
GO
    CREATE PROCEDURE getDataByID(@id VARCHAR(10), @decision VARCHAR(50))
    AS
    BEGIN
        IF @decision = 'pemilik'
            BEGIN
                select * from pemilik where pemilik_id=@id
            END
        IF @decision = 'pegawai'
            BEGIN
                select * from pegawai where pegawai_id=@id
            END
        IF @decision = 'dokter'
            BEGIN
                select * from dokter where dokter_id=@id
            END
        IF @decision = 'pelanggan'
            BEGIN
                select * from pelanggan where pelanggan_id=@id
            END
    END
GO


-- Menampilkan data Pegawai
select * from getPegawai
-- Menampilkan data Dokter
select * from getDokter
-- Menampilkan data Pemilik
select * from getPemilik
-- Menampilkan data Pelanggan
select * from getPelanggan


-- Menampilkan data berdasarkan id
EXEC getDataByID @id = 'C01', @decision = 'pelanggan'