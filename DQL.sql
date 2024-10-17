-- Menampilkan seluruh data dari tabel Calon_Siswa
SELECT * FROM Calon_Siswa;

-- Menampilkan seluruh data dari tabel Formulir_Pendaftaran
SELECT * FROM Formulir_Pendaftaran;

-- Menampilkan seluruh data dari tabel Bank_Pembayaran
SELECT * FROM Bank_Pembayaran;

-- Menampilkan seluruh data dari tabel Laporan_Pendaftaran
SELECT * FROM Laporan_Pendaftaran;

-- Menampilkan seluruh data dari tabel Kepala_Sekolah
SELECT * FROM Kepala_Sekolah;

-- Menampilkan seluruh data dari tabel Ketua_Yayasan
SELECT * FROM Ketua_Yayasan;

-- Menampilkan data siswa yang formulirnya diterima
SELECT 
    cs.id_siswa, 
    cs.nama, 
    cs.alamat, 
    cs.no_telepon, 
    cs.email,
    fp.tanggal_pendaftaran,
    fp.status_formulir
FROM 
    Calon_Siswa cs
JOIN 
    Formulir_Pendaftaran fp ON cs.id_siswa = fp.id_siswa
WHERE 
    fp.status_formulir = 'Diterima';

-- Menampilkan data siswa yang pembayaran telah terkonfirmasi
SELECT 
    cs.id_siswa, 
    cs.nama, 
    cs.alamat, 
    cs.no_telepon, 
    cs.email,
    bp.tanggal_pembayaran,
    bp.jumlah,
    bp.status_pembayaran
FROM 
    Calon_Siswa cs
JOIN 
    Bank_Pembayaran bp ON cs.id_siswa = bp.id_siswa
WHERE 
    bp.status_pembayaran = 'Terkonfirmasi';

-- Menampilkan data dari tabel MV_Siswa_Terkonfirmasi (Simulasi Materialized View)
SELECT * FROM MV_Siswa_Terkonfirmasi;