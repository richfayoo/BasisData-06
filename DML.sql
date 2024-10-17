INSERT INTO Calon_Siswa (nama, alamat, tanggal_lahir, no_telepon, email)
VALUES ('Adi', 'Jl. Mawar 123', '2005-07-22', '08123456789', 'adi@example.com');

INSERT INTO Formulir_Pendaftaran (id_siswa, tanggal_pendaftaran)
VALUES (1, CURDATE());

UPDATE Bank_Pembayaran
SET status_pembayaran = 'Sudah Bayar'
WHERE id_pembayaran = 1;