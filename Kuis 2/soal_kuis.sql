-- Active: 1713956067589@@localhost@3306@soal_kuis

/* Bu Hesti memiliki usaha baby spa yang melayani perawatan bayi. Beliau memiliki 2 outlet, di Kota M dan di Kota K.
beliau ingin memiliki system informasi untuk menangani usaha tersebut. kebutuhan dari bu Hesti adalah:

1.     Memiliki data pegawai yang memiliki peran (Terapis, Kasir, Manajer)
dengan data pegawai minimal memiliki nama, alamat, no ktp, tanggal lahir, jenis kelamin dan tanggal mulai kerja

2.     Layanan memiliki data nama layanan, jenis layanan, Harga layanan.
setiap Cabang memiliki Harga layanan yang berbeda

3.     dapat melihat data transaksi yang memuat tanggal transaksi, nominal, jenis pembayaran,
admin yang menginput data serta dapat melihat detail layanan apa saja yang ada pada transaksi tersebut serta terapis yang melayani.

4.     Aplikasi memungkinkan untuk menampilkan karyawan di masing-masing cabang
Buatlah table dari skema yang dijelaskan diatas sesuai dengan kebutuhan bu Hesti. Boleh menambahkan atribut jika memang dirasa perlu. */

CREATE TABLE pegawai (
    idPegawai INT(3) NOT NULL,
    nama_pegawai VARCHAR(100) NOT NULL,
    jobdesk VARCHAR (100) NOT NULL,
    alamat VARCHAR(100) NOT NULL,
    no_ktp VARCHAR(16) NOT NULL,
    tanggal_lahir DATE NOT NULL,
    jenis_kelamin ENUM('L', 'P') NOT NULL,
    mulai_kerja DATE NOT NULL,
    idOutlet INT(3) NOT NULL,
    PRIMARY KEY (idPegawai),
    FOREIGN KEY (idOutlet) REFERENCES outlet(idOutlet)
);

CREATE TABLE outlet (
    idOutlet INT (3) NOT NULL,
    nama_cabang VARCHAR (100) NOT NULL,
    alamat_cabang VARCHAR (100) NOT NULL,
    PRIMARY KEY (idOutlet)
);

CREATE TABLE layanan (
    idLayanan INT(3) NOT NULL,
    nama_layanan VARCHAR(100) NOT NULL,
    jenis_layanan VARCHAR(100) NOT NULL,
    harga_layanan DOUBLE(10,2) NOT NULL,
    PRIMARY KEY (idLayanan)
);

CREATE TABLE transaksi (
    nama_pelanggan VARCHAR (100) NOT NULL,
    idLayanan INT (3) NOT NULL,
    tanggal DATE NOT NULL,
    jenis_pembayaran VARCHAR (100) NOT NULL,
    idPegawai INT (3) NOT NULL,
    idOutlet INT (3) NOT NULL,
    Foreign Key (idLayanan) REFERENCES layanan(idLayanan),
    Foreign Key (idPegawai) REFERENCES pegawai(idPegawai),
    Foreign Key (idOutlet) REFERENCES outlet(idOutlet)
);

DROP Table layanan;

INSERT INTO layanan (idLayanan, nama_layanan, jenis_layanan, harga_layanan) 
VALUES
(101, 'Perawatan', 'Potong Rambut', 500000.00),
(102, 'Perawatan', 'Potong Kuku', 750000.00),
(201, 'Bermain', 'Aqua Swim', 1000000.00);

INSERT INTO outlet (idOutlet, nama_cabang, alamat_cabang)
VALUES
(001, 'Malang', 'Jl. Soekarno Hatta'),
(002, 'Surabaya', 'Jl. Imam Bonjol');

INSERT INTO pegawai (idPegawai, nama_pegawai, jobdesk, alamat, no_ktp, tanggal_lahir, jenis_kelamin, mulai_kerja, idOutlet) 
VALUES
(101, 'John Doe', 'Terapis', 'Jl. Merdeka 123', '1234567890123', '1990-05-15', 'L', '2020-01-10', 001),
(102, 'Jane Smith', 'Terapis', 'Jl. Majapahit 45', '9876543210987', '1985-09-20', 'P', '2019-08-03', 001),
(103, 'Mike Johnson', 'Pelatih', 'Jl. Diponegoro 6', '4567890123456', '1988-11-30', 'L', '2021-03-25', 001),
(105, 'James Brown', 'Terapis', 'Jl. Gatot Subroto 123', '3210987654321', '1992-08-22', 'L', '2018-06-05', 001),
(201, 'Emily Wang', 'Terapis', 'Jl. Asia Afrika 56', '6543210987654', '1991-03-18', 'P', '2017-11-20', 001),
(202, 'David Kim', 'Terapis', 'Jl. Sudirman 78', '2345678901234', '1993-12-07', 'L', '2019-09-30', 002);

INSERT INTO transaksi (nama_pelanggan, idLayanan, tanggal, jenis_pembayaran, idPegawai, idOutlet)
VALUES
('Budi Setiawan', 101, '2024-05-01', 'Kartu Kredit', 101, 001),
('Ani Rahayu', 102, '2024-05-02', 'Tunai', 102, 001),
('Hadi Pratama', 102, '2024-05-03', 'Kartu Debit', 102, 001),
('Siti Nurhayati', 201, '2024-05-04', 'Tunai', 103, 001),
('Ahmad Yusuf', 102, '2024-05-05', 'Kartu Kredit', 102, 001),
('Lina Sari', 101, '2024-05-06', 'Tunai', 201, 002),
('Dewi Wulandari', 102, '2024-05-07', 'Kartu Kredit', 202, 002),
('Fajar Ramadhan', 102, '2024-05-08', 'Kartu Debit', 202, 002),
('Nina Fitriani', 201, '2024-05-09', 'Tunai', 103, 001),
('Rudi Santoso', 101, '2024-05-10', 'Kartu Kredit', 201, 002),
('Ika Susanti', 102, '2024-05-11', 'Tunai', 101, 001),
('Andi Wijaya', 102, '2024-05-12', 'Kartu Debit', 202, 002),
('Dini Cahyani', 201, '2024-05-13', 'Kartu Kredit', 103, 001),
('Rina Permata', 101, '2024-05-14', 'Tunai', 102, 001),
('Eko Saputra', 102, '2024-05-15', 'Kartu Debit', 201, 002);

-- Menampilkan nama cabang pada tabel pegawai;

SELECT idPegawai, nama_pegawai, jobdesk, alamat, no_ktp, tanggal_lahir, jenis_kelamin, mulai_kerja, pegawai.idOutlet, o.nama_cabang
FROM pegawai, outlet o
WHERE pegawai.idOutlet = o.idOutlet;

-- memmindahkan John Doe ke surabaya

UPDATE pegawai
SET idOutlet = 2 
WHERE nama_pegawai = 'John Doe'

-- Menampilkan Omset Masing-masing terapis

SELECT 
    p.nama_pegawai AS 'Nama Pegawai',
    SUM(l.harga_layanan) AS 'Penghasilan'
FROM 
    pegawai p
JOIN 
    transaksi t ON p.idPegawai = t.idPegawai
JOIN 
    layanan l ON t.idLayanan = l.idLayanan
GROUP BY 
    p.nama_pegawai;

-- Menampilkan Detail Transaksi

SELECT 
    t.nama_pelanggan,
    l.nama_layanan,
    l.jenis_layanan,
    l.harga_layanan,
    t.tanggal,
    t.jenis_pembayaran,
    t.idPegawai,
    t.idOutlet,
    p.nama_pegawai
FROM 
    transaksi t
JOIN 
    layanan l ON t.idLayanan = l.idLayanan
JOIN pegawai p ON t.idPegawai = p.idPegawai;

-- Menampilkan Karyawan Masing-masing Cabang

SELECT *
FROM pegawai
WHERE idOutlet = 2;

-- Menampilkan Pegawai Paling Terakhir Masuk

SELECT *
FROM pegawai
ORDER BY mulai_kerja DESC
LIMIT 1;

-- Menampilkan Pegawai Paling Tua

SELECT * FROM pegawai
ORDER BY tanggal_lahir ASC
LIMIT 1;

-- Menampilkan Jumlah Layanan Pada Tiap Cabang

SELECT DISTINCT
    o.nama_cabang,
    l.nama_layanan,
    l.jenis_layanan,
    l.harga_layanan
FROM 
    layanan l
JOIN 
    transaksi t ON l.idLayanan = t.idLayanan
JOIN 
    outlet o ON t.idOutlet = o.idOutlet;
WHERE o.idOutlet = 2;

SELECT 
    o.nama_cabang AS 'Nama Cabang',
    COUNT(DISTINCT l.jenis_layanan) AS 'Jumlah Layanan'
FROM 
    layanan l
JOIN 
    transaksi t ON l.idLayanan = t.idLayanan
JOIN 
    outlet o ON t.idOutlet = o.idOutlet
WHERE 
    o.idOutlet = 001
GROUP BY 
    o.nama_cabang;

-- Menampilkan Berapa Kali Pegawai Melayani Pelanggan

SELECT 
    p.nama_pegawai AS 'Nama Pegawai',
    p.jobdesk AS 'Jobdesk',
    COUNT(t.nama_pelanggan) AS 'Jumlah Pelayanan'
FROM 
    pegawai p
JOIN 
    transaksi t ON p.idPegawai = t.idPegawai
GROUP BY 
    p.nama_pegawai

SHOW TABLES;

DELETE from pegawai;