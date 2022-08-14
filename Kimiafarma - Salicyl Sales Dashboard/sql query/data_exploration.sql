-- Data Exploration

SHOW TABLES;

SELECT * FROM pelanggan p 
WHERE SUBSTR(nama, 1, 3) = "apo";


SELECT * FROM pelanggan p 
WHERE nama LIKE  "apo%";

DESC penjualan;

SELECT COUNT(*) FROM penjualan p;

SELECT COUNT(DISTINCT id_invoice)  FROM penjualan p ;

SELECT COUNT(DISTINCT id_customer)  FROM penjualan p ;

-- 

DESC pelanggan ;

SELECT COUNT(*)  FROM pelanggan p ;

SELECT COUNT(DISTINCT id_customer)  FROM pelanggan p ;

--

SELECT * FROM penjualan p;

SELECT
	p.id_invoice, p.tanggal,
	bd.nama_barang ,
	p.jumlah_barang_rounded jumlah_barang , 
	p.harga, bd.harga,
	p.unit, bd.kemasan 
FROM penjualan p
LEFT JOIN barang_ds bd 
ON p.id_barang = bd.kode_barang ;

SELECT
	p.id_invoice, DATE(p.tanggal) date,
	DAYOFWEEK(p.tanggal) dow, WEEK(p.tanggal) week,
	MONTH(p.tanggal) month, YEAR(p.tanggal) year,
	bd.nama_barang ,
	ROUND(p.jumlah_barang) jumlah_barang , 
	ROUND(p.harga) p_harga, bd.harga bd_harga,
	p.unit, bd.kemasan 
FROM penjualan p
LEFT JOIN barang_ds bd 
ON p.id_barang = bd.kode_barang ;


SELECT * FROM penjualan p ;

ALTER TABLE penjualan
	ADD jumlah_barang_rounded INT(5) AFTER id_barang ;

ALTER TABLE penjualan
	DROP IF EXISTS jumlah_barang_rounded ;

UPDATE penjualan 
SET jumlah_barang_rounded = ROUND(jumlah_barang);

DESC penjualan ;

--

SELECT * FROM barang b
LEFT JOIN barang_ds bd
USING(kode_barang);

DESC barang_ds ;


--

SELECT * FROM pelanggan p ;


























