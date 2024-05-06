-- Active: 1713956067589@@localhost@3306@jadwal_perkuliahan2

-- Praktikum 01 --

CREATE TABLE dosen (
    kode_dosen VARCHAR(4) NOT NULL,
    nama_dosen VARCHAR(100) DEFAULT NULL
);

CREATE TABLE hari (
    kode_hari VARCHAR(3) NOT NULL,
    nama_hari VARCHAR(100) DEFAULT NULL
);

CREATE TABLE jadwal (
    kode_jadwal INT(10) NOT NULL,
    kode_kelas VARCHAR(10) DEFAULT NULL,
    kode_dosen VARCHAR(4) DEFAULT NULL,
    kode_mk VARCHAR(5) DEFAULT NULL,
    kode_ruang VARCHAR(5) DEFAULT NULL,
    kode_hari VARCHAR(3) DEFAULT NULL,
    jp_mulai INT(3) DEFAULT NULL,
    jp_selesai INT(3) DEFAULT NULL
);

CREATE TABLE jp (
    kode_jp INT(3) NOT NULL,
    jp_mulai TIME DEFAULT NULL,
    jp_selesai TIME DEFAULT NULL
);

CREATE Table kelas (
    kode_kelas VARCHAR(10) NOT NULL,
    kode_prodi VARCHAR(3) DEFAULT NULL,
    nama_kelas VARCHAR(5) DEFAULT NULL
);

CREATE TABLE mk (
    kode_mk VARCHAR(5) NOT NULL,
    nama_mk VARCHAR(100) NOT NULL
);

CREATE TABLE prodi (
    kode_prodi VARCHAR(3) NOT NULL,
    nama_prodi VARCHAR(100) DEFAULT NULL
);

CREATE TABLE ruang (
    kode_ruang VARCHAR(5) NOT NULL,
    nama_ruang VARCHAR(20) DEFAULT NULL,
    deskripsi_ruang VARCHAR(100) DEFAULT NULL
);

CREATE TABLE mahasiswa (
    NIM VARCHAR(10) NOT NULL,
    nama_mahasiswa VARCHAR(50) NOT NULL,
    kode_kelas VARCHAR(10) NOT NULL,
    PRIMARY KEY (NIM),
    FOREIGN KEY (kode_kelas) REFERENCES kelas(kode_kelas)
);


ALTER Table dosen
    ADD PRIMARY KEY (kode_dosen);
ALTER Table hari
    ADD PRIMARY KEY (kode_hari);
ALTER Table jadwal
    ADD PRIMARY KEY (kode_jadwal); 
ALTER Table jp
    ADD PRIMARY KEY (kode_jp);
ALTER Table kelas
    ADD PRIMARY KEY (kode_kelas);
ALTER Table mk
    ADD PRIMARY KEY (kode_mk);
ALTER Table prodi
    ADD PRIMARY KEY (kode_prodi);
ALTER Table ruang
    ADD PRIMARY KEY (kode_ruang);

ALTER TABLE jadwal
    MODIFY kode_jadwal INT(10) NOT NULL AUTO_INCREMENT;

ALTER TABLE jadwal
    ADD FOREIGN KEY (kode_dosen) REFERENCES dosen (kode_dosen),
    ADD FOREIGN KEY (kode_mk) REFERENCES mk (kode_mk),
    ADD FOREIGN KEY (kode_ruang) REFERENCES ruang (kode_ruang),
    ADD FOREIGN KEY (kode_hari) REFERENCES hari (kode_hari),
    ADD FOREIGN KEY (jp_mulai) REFERENCES jp (kode_jp),
    ADD FOREIGN KEY (jp_selesai) REFERENCES jp (kode_jp),
    ADD FOREIGN KEY (kode_kelas) REFERENCES kelas (kode_kelas);

ALTER TABLE kelas
    ADD FOREIGN KEY (kode_prodi) REFERENCES prodi (kode_prodi);

-- Praktikum 02 --

SELECT deskripsi_ruang
FROM ruang
WHERE nama_ruang = 'LKJ1';

SELECT DISTINCT kode_hari
FROM jadwal;

SELECT *
FROM ruang
WHERE nama_ruang IN ('RT01', 'RT10');

SELECT * 
FROM ruang
WHERE kode_ruang
BETWEEN '0501' AND '0508';

SELECT *
FROM dosen
WHERE nama_dosen like 'E%';

SELECT kode_dosen, kode_mk, kode_ruang, kode_hari
FROM jadwal
GROUP BY kode_hari;

SELECT kode_jp, jp_mulai
FROM jp
ORDER BY jp_mulai;

SELECT *
FROM jadwal
WHERE kode_hari = '001' AND jp_mulai = 1;

SELECT kode_hari
FROM hari
UNION
SELECT kode_hari FROM jadwal;

SELECT kode_hari
FROM hari
UNION ALL
SELECT kode_hari FROM jadwal;

-- Praktikum 03 --

SELECT kode_dosen, kode_mk, kode_hari, jp_mulai, jp_selesai
FROM jadwal
WHERE jp_selesai
IN (SELECT MAX(jp_selesai) FROM jadwal);

SELECT kode_dosen, kode_mk, kode_hari, jp_mulai, jp_selesai
FROM jadwal
WHERE jp_selesai < ALL
(SELECT jp_selesai FROM jadwal WHERE jp_selesai = 6);

-- Praktikum 04

SELECT AVG(jp_selesai - jp_mulai)
FROM jadwal;

SELECT MAX(jp_mulai)
FROM jadwal;

SELECT MIN(jp_selesai)
FROM jadwal;

SELECT SUM(jp_selesai - jp_mulai)
FROM jadwal
WHERE kode_dosen = 'D001';

SELECT * FROM jadwal WHERE kode_dosen = 'D001';

SELECT COUNT(kode_ruang)
FROM ruang;

-- Tugas --

SELECT *
FROM jadwal
WHERE kode_hari = (SELECT kode_hari FROM hari WHERE nama_hari = 'Kamis')
AND jp_mulai = (SELECT kode_jp FROM jp WHERE jp_mulai = '08:40:00');

SELECT COUNT(DISTINCT kode_dosen)
FROM jadwal
WHERE kode_hari = (SELECT kode_hari FROM hari WHERE nama_hari = 'Selasa');

SELECT DISTINCT hari.nama_hari, dosen.kode_dosen, dosen.nama_dosen
FROM dosen, hari, jadwal j
WHERE j.kode_hari = hari.kode_hari
    AND hari.nama_hari = 'Kamis'
    AND j.kode_dosen = dosen.kode_dosen
    AND dosen.nama_dosen LIKE 'A%';

SELECT  hari.nama_hari, ruang.kode_ruang, ruang.nama_ruang, ruang.deskripsi_ruang, jp.jp_mulai
FROM ruang, jadwal j, hari, jp
WHERE j.kode_hari = hari.kode_hari
    AND hari.nama_hari = 'Jumat'
    AND j.kode_ruang = ruang.kode_ruang
    AND j.jp_mulai = jp.kode_jp
ORDER BY jp.jp_mulai ASC;

/* Output */

SELECT * FROM jadwal;
SELECT * FROM prodi;
SELECT * FROM kelas;
SELECT * FROM ruang;
SELECT * FROM hari;
SELECT * FROM dosen;
SELECT * FROM mk;
SELECT * FROM jp;