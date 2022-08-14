-- Designing Data Mart

-- DDL
-- Prepare required dimension and fact table(s)

SHOW TABLES;

DROP TABLE IF EXISTS waktu_dim;
DROP TABLE IF EXISTS pelanggan_dim;
DROP TABLE IF EXISTS barang_dim;
DROP TABLE IF EXISTS unit_dim;
DROP TABLE IF EXISTS mata_uang_dim ;
DROP TABLE IF EXISTS penjualan_fact;

CREATE TABLE IF NOT EXISTS `waktu_dim` (
	`id_waktu` INT AUTO_INCREMENT PRIMARY KEY
	, `tanggal` DATE
	, `hari` INT(1)
	, `minggu` INT(2)
	, `bulan` INT(2)
	, `tahun` YEAR
);

CREATE TABLE IF NOT EXISTS `pelanggan_dim` (
	`id_pelanggan` VARCHAR(9) PRIMARY KEY 
	, `level` VARCHAR(10)
	, `nama` VARCHAR(30)
	, `cabang_sales` VARCHAR(10)
	, `group` VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS `barang_dim` (
	`id_barang` VARCHAR(9) PRIMARY KEY 
	, `nama_barang` VARCHAR(50)
	, `sektor` VARCHAR(1)
	, `tipe` VARCHAR(11)
	, `brand` VARCHAR(10)
	, `kemasan` VARCHAR(6)
	, `harga` INT
);

CREATE TABLE IF NOT EXISTS `unit_dim` (
	`id_unit` INT AUTO_INCREMENT PRIMARY KEY
	, `unit` VARCHAR(9)
);

CREATE TABLE IF NOT EXISTS `mata_uang_dim` (
	`id_mata_uang` INT AUTO_INCREMENT PRIMARY KEY
	, `mata_uang` VARCHAR(3)
);

CREATE TABLE IF NOT EXISTS `penjualan_fact` (
	`id_waktu` INT
	, `id_pelanggan` VARCHAR(9)
	, `id_barang` VARCHAR(9)
	, `id_unit` INT
	, `id_mata_uang` INT
	, `id_distributor` VARCHAR(3)
	, `id_cabang` VARCHAR(5)
	, `id_brand` VARCHAR(7)
	, `jumlah_barang` 
	, `harga` INT
);

-- DML
-- Data Extraction, Transformation, and Loading

INSERT INTO waktu_dim (
	tanggal, hari, minggu, bulan, tahun
)
SELECT DISTINCT
	DATE(tanggal)
	, DAYOFWEEK(tanggal)
	, WEEK(tanggal) 
	, MONTH(tanggal) 
	, YEAR(tanggal)
FROM penjualan;

SELECT * FROM waktu_dim ;


INSERT INTO pelanggan_dim
SELECT DISTINCT 
	`id_customer`
	, `level`
	, `nama`
	, `cabang_sales` 
	, `group` 
FROM pelanggan ;

SELECT * FROM pelanggan_dim  ;


INSERT INTO barang_dim 
SELECT DISTINCT 
	b.kode_barang
	, b.nama_barang 
	, b.sektor 
	, b.nama_tipe 
	, b.lini 
	, b.kemasan 
	, bd.harga 
FROM barang b
JOIN barang_ds bd 
USING(kode_barang)

SELECT * FROM barang_dim  ;


INSERT INTO unit_dim (unit)
SELECT DISTINCT  unit
FROM penjualan

SELECT * FROM unit_dim;


INSERT INTO mata_uang_dim (mata_uang)
SELECT DISTINCT  mata_uang 
FROM penjualan

SELECT * FROM mata_uang_dim;


INSERT INTO penjualan_fact 
SELECT
	wd.id_waktu
	,	pd.id_pelanggan 
	, bd.id_barang 
	,	ud.id_unit
	, mud.id_mata_uang 
	, id_distributor 
	, id_cabang 
	, brand_id 
	, jumlah_barang
	, p.harga
FROM penjualan p 
JOIN waktu_dim wd
	ON (DATE(p.tanggal) = wd.tanggal)
JOIN pelanggan_dim pd
	ON (p.id_customer = pd.id_pelanggan)
JOIN barang_dim bd
	ON (p.id_barang = bd.id_barang)
JOIN unit_dim ud
	ON (p.unit = ud.unit)
JOIN mata_uang_dim mud 
	ON (p.mata_uang = mud.mata_uang);


SHOW TABLES;

DESC waktu_dim;
DESC pelanggan_dim;
DESC barang_dim;
DESC unit_dim;
DESC mata_uang_dim;
DESC penjualan_fact;

SELECT * FROM barang_dim bd  ;

























