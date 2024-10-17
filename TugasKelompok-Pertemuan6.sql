CREATE DATABASE SIP_Oracle; -- Membuat basis data

USE SIP_Oracle; -- Menggunakan Basis data

-- Tabel untuk data siswa
CREATE TABLE Siswa (
    id_siswa INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100),
    ktp VARCHAR(20) UNIQUE,
    tanggal_lahir DATE,
    nomor_pendaftaran VARCHAR(20),
    status_pembayaran ENUM('Belum', 'Bayar')
);

-- Tabel untuk data pembayaran siswa
CREATE TABLE Bank (
    id_pembayaran INT PRIMARY KEY AUTO_INCREMENT,
    id_siswa INT,
    status_pembayaran ENUM('Belum', 'Bayar'),
    tanggal_pembayaran DATE,
    FOREIGN KEY (id_siswa) REFERENCES Siswa(id_siswa)
);

-- Tabel untuk hasil test seleksi siswa
CREATE TABLE TestSeleksi (
    id_test INT PRIMARY KEY AUTO_INCREMENT,
    id_siswa INT,
    nilai_test DECIMAL(5, 2),
    tanggal_test DATE,
    FOREIGN KEY (id_siswa) REFERENCES Siswa(id_siswa)
);

-- Tabel untuk laporan pembayaran
CREATE TABLE Pembayaran (
    id_kwitansi INT PRIMARY KEY AUTO_INCREMENT,
    id_siswa INT,
    jumlah_bayar DECIMAL(10, 2),
    tanggal_bayar DATE,
    FOREIGN KEY (id_siswa) REFERENCES Siswa(id_siswa)
);

-- Tabel untuk laporan umum
CREATE TABLE Laporan (
    id_laporan INT PRIMARY KEY AUTO_INCREMENT,
    id_siswa INT,
    tipe_laporan VARCHAR(50),
    tanggal_laporan DATE,
    FOREIGN KEY (id_siswa) REFERENCES Siswa(id_siswa)
);

-- Cek data siswa apakah sudah pernah mendaftar
SELECT * FROM Siswa
WHERE ktp = '3674052312050007' OR (nama = 'Zahid Rizky Fakhri' AND tanggal_lahir = '2005-12-23');

-- Laporan pembayaran berdasarkan periode tertentu
SELECT * FROM Pembayaran
WHERE tanggal_bayar BETWEEN '2023-07-01' AND '2023-08-31';

-- Simpan data siswa baru
INSERT INTO Siswa (nama, ktp, tanggal_lahir, nomor_pendaftaran, status_pembayaran)
VALUES ('Zahid Rizky Fakhri', '3674052312050007', '2005-12-23', 'A001', 'Belum');

-- Update status pembayaran siswa
UPDATE Siswa
SET status_pembayaran = 'Bayar'
WHERE id_siswa = '1';

-- Menyimpan hasil test siswa
INSERT INTO TestSeleksi (id_siswa, nilai_test, tanggal_test)
VALUES ('1', '95.90', '2023-09-17');

-- Prosedur untuk cek pendaftaran siswa
DELIMITER //
CREATE PROCEDURE CekPendaftaranSiswa (IN ktp_param VARCHAR(20), IN nama_param VARCHAR(100), IN tgl_lahir_param DATE)
BEGIN
    SELECT * FROM Siswa
    WHERE ktp = ktp_param OR (nama = nama_param AND tanggal_lahir = tgl_lahir_param);
END //
DELIMITER ;

-- Prosedur untuk menambahkan pembayaran:
DELIMITER //
CREATE PROCEDURE TambahPembayaran (IN id_siswa_param INT, IN jumlah_bayar_param DECIMAL(10,2), IN tanggal_bayar_param DATE)
BEGIN
    INSERT INTO Pembayaran (id_siswa, jumlah_bayar, tanggal_bayar)
    VALUES (id_siswa_param, jumlah_bayar_param, tanggal_bayar_param);

    UPDATE Siswa
    SET status_pembayaran = 'Bayar'
    WHERE id_siswa = id_siswa_param;
END //
DELIMITER ;

-- Gambar DFD Level 2

-- Menyimpan data pembayaran dari bank
INSERT INTO Pembayaran (id_siswa, jumlah_bayar, tanggal_bayar)
VALUES ('1', '100.00', '2023-07-21');

-- Mengecek apakah data siswa sudah lengkap dan valid
UPDATE Siswa
SET data_valid = TRUE
WHERE id_siswa = '1';

-- Mencari status pembayaran siswa berdasarkan nomor pendaftaran:
SELECT status_pembayaran
FROM Siswa
WHERE nomor_pendaftaran = '1';

-- Melihat data siswa yang terdaftar di bagian akademik
SELECT * 
FROM Siswa
WHERE status_pembayaran = 'Bayar';

-- Melihat informasi pembayaran dari bank berdasarkan nomor pendaftaran
SELECT * 
FROM Pembayaran
WHERE id_siswa = (SELECT id_siswa FROM Siswa WHERE nomor_pendaftaran = '1');

-- Stored Procedure untuk Menambah Siswa setelah Pembayaran
DELIMITER //
CREATE PROCEDURE TambahSiswa(
    IN nama_param VARCHAR(100),
    IN ktp_param VARCHAR(20),
    IN tgl_lahir_param DATE,
    IN nomor_pendaftaran_param VARCHAR(20),
    IN status_pembayaran_param ENUM('Belum', 'Bayar')
)
BEGIN
    INSERT INTO Siswa (nama, ktp, tanggal_lahir, nomor_pendaftaran, status_pembayaran)
    VALUES (nama_param, ktp_param, tgl_lahir_param, nomor_pendaftaran_param, status_pembayaran_param);
END //
DELIMITER ;

-- Stored Procedure untuk Mengupdate Status Pembayaran
DELIMITER //
CREATE PROCEDURE UpdateStatusPembayaran(
    IN nomor_pendaftaran_param VARCHAR(20)
)
BEGIN
    UPDATE Siswa
    SET status_pembayaran = 'Bayar'
    WHERE nomor_pendaftaran = nomor_pendaftaran_param;
END //
DELIMITER ;

-- Stored Procedure untuk Melihat Status Pembayaran Siswa
DELIMITER //
CREATE PROCEDURE CekStatusPembayaran(
    IN nomor_pendaftaran_param VARCHAR(20)
)
BEGIN
    SELECT status_pembayaran
    FROM Siswa
    WHERE nomor_pendaftaran = nomor_pendaftaran_param;
END //
DELIMITER ;

-- Stored Procedure untuk Melihat Data Pembayaran dari Bank
DELIMITER //
CREATE PROCEDURE LihatDataPembayaran(
    IN nomor_pendaftaran_param VARCHAR(20)
)
BEGIN
    SELECT * 
    FROM Pembayaran
    WHERE id_siswa = (SELECT id_siswa FROM Siswa WHERE nomor_pendaftaran = nomor_pendaftaran_param);
END //
DELIMITER ;
