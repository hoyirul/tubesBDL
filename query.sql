use db_klican;

--
-- Table structure for table users
--

CREATE TABLE users (
  uid varchar(3) PRIMARY KEY NOT NULL,
  email varchar(50) NOT NULL,
  password varchar(255) NOT NULL,
  token varchar(255) NOT NULL,
  joined date NOT NULL
);

--
-- Table structure for table dokter
--

CREATE TABLE dokter (
  dokter_id varchar(10) PRIMARY KEY NOT NULL,
  uid varchar(3) NOT NULL,
  nama varchar(50) NOT NULL,
  jk varchar(2) NOT NULL,
  no_telp varchar(16) NOT NULL,
  alamat text DEFAULT NULL,
  tanggal_lahir date NOT NULL,
  spesialis varchar(50) NOT NULL,
  status varchar(10) NOT NULL,
  FOREIGN KEY (uid) REFERENCES users(uid)
);

--
-- Table structure for table pegawai
--

CREATE TABLE pegawai (
  pegawai_id varchar(10) PRIMARY KEY NOT NULL,
  uid varchar(3) NOT NULL,
  nama varchar(50) NOT NULL,
  jk varchar(2) NOT NULL,
  no_telp varchar(16) NOT NULL,
  alamat text DEFAULT NULL,
  tanggal_lahir date NOT NULL,
  status varchar(10) NOT NULL,
  FOREIGN KEY (uid) REFERENCES users(uid)
);

--
-- Table structure for table pelanggan
--

CREATE TABLE pelanggan (
  pelanggan_id varchar(10) PRIMARY KEY NOT NULL,
  uid varchar(3) NOT NULL,
  nama varchar(50) NOT NULL,
  jk varchar(2) NOT NULL,
  no_telp varchar(16) NOT NULL,
  alamat text DEFAULT NULL,
  tanggal_lahir date NOT NULL,
  status varchar(10) NOT NULL, 
  FOREIGN KEY (uid) REFERENCES users(uid)
);

--
-- Table structure for table pemilik
--

CREATE TABLE pemilik (
  pemilik_id varchar(10) PRIMARY KEY NOT NULL,
  uid varchar(3) NOT NULL,
  nama varchar(50) NOT NULL,
  jk varchar(2) NOT NULL,
  no_telp varchar(16) NOT NULL,
  alamat text DEFAULT NULL,
  tanggal_lahir date DEFAULT NULL,
  status varchar(10) NOT NULL, 
  FOREIGN KEY (uid) REFERENCES users(uid)
);


--
-- Table structure for table paket
--

CREATE TABLE paket (
  paket_id varchar(10) PRIMARY KEY NOT NULL,
  nama_paket varchar(50) NOT NULL,
  deskripsi text DEFAULT NULL,
  harga float NOT NULL
);

--
-- Table structure for table detail_paket
--

CREATE TABLE detail_paket (
  detail_id int IDENTITY PRIMARY KEY NOT NULL,
  paket_id varchar(10) NOT NULL,
  fitur varchar(100) NOT NULL, 
  FOREIGN KEY (paket_id) REFERENCES paket(paket_id)
);

--
-- Table structure for table orders
--

CREATE TABLE orders (
  oid varchar(6) PRIMARY KEY NOT NULL,
  pelanggan_id varchar(10) NOT NULL,
  pegawai_id varchar(10) NOT NULL,
  paket_id varchar(10) NOT NULL,
  tanggal date NOT NULL,
  total_bayar float NOT NULL,
  FOREIGN KEY (pelanggan_id) REFERENCES pelanggan(pelanggan_id),
  FOREIGN KEY (pegawai_id) REFERENCES pegawai(pegawai_id),
  FOREIGN KEY (paket_id) REFERENCES paket(paket_id)
);

--
-- Table structure for table payments
--

CREATE TABLE payments (
  pay_id varchar(8) PRIMARY KEY NOT NULL,
  oid varchar(6) NOT NULL,
  metode varchar(20) NOT NULL,
  bank varchar(10) NOT NULL,
  no_rek varchar(20) NOT NULL,
  total float NOT NULL,
  bayar float NOT NULL,
  status varchar(10) NOT NULL,
  FOREIGN KEY (oid) REFERENCES orders(oid)
);

--
-- Table structure for table perawatan
--

CREATE TABLE perawatan (
  rawat_id varchar(8) PRIMARY KEY NOT NULL,
  oid varchar(6) NOT NULL,
  dokter_id varchar(10) NOT NULL,
  hasil varchar(100) NOT NULL,
  solusi text NOT NULL,
  tanggal_rawat date NOT NULL, 
  FOREIGN KEY (oid) REFERENCES orders(oid),
  FOREIGN KEY (dokter_id) REFERENCES dokter(dokter_id)
);

--
-- Dumping data for table users
--

INSERT INTO users VALUES
('U01', 'hoy35@gmail.com', 'hoyirullah35', '012d73e0fab8d26e0f4d65e360775111', '2021-07-01'),
('U02', 'dherisma@gmail.com', 'dherisma10', '012d73e0fab8d26e0f4d65e360775112', '2021-04-15'),
('U03', 'faiza10@gmail.com', 'fzh12345', '012d73e0fab8d26e0f4d65e360775113', '2021-07-03'),
('U04', 'aida14@gmail.com', 'aidaMillati', '012d73e0fab8d26e0f4d65e360775114', '2021-07-09'),
('U05', 'cintya44@gmail.com', 'cicin44', '012d73e0fab8d26e0f4d65e360775115', '2021-05-05'),
('U06', 'fattah11@gmail.com', 'ftthul11', '012d73e0fab8d26e0f4d65e360775116', '2021-11-17'),
('U07', 'donaLorensa@gmail.com', 'lorenzadona', '012d73e0fab8d26e0f4d65e360775117', '2021-07-07'),
('U08', 'tasyaamalia@gmail.com', 'annastasya02', '012d73e0fab8d26e0f4d65e360775118', '2021-07-08'),
('U09', 'rafly2akbar@gmail.com', 'raflykipli', '012d73e0fab8d26e0f4d65e360775119', '2021-11-15'),
('U10', 'valenciaNugroho@gmail.com', 'valenciashafira', '012d73e0fab8d26e0f4d65e360775120', '2021-07-10'),
('U11', 'kuncarabakti@gmail.com', 'baktikun', '012d73e0fab8d26e0f4d65e360775121', '2021-07-11'),
('U12', 'auliagusti01@gmail.com', 'auliagst12', '012d73e0fab8d26e0f4d65e360775122', '2021-07-12'),
('U13', 'diltafebi@gmail.com', 'dilta0210', '012d73e0fab8d26e0f4d65e360775123', '2021-07-04'),
('U14', 'gustaniameisi99@gmail.com', 'gustaniameisi99', '012d73e0fab8d26e0f4d65e360775124', '2021-07-14'),
('U15', 'dewilailatu@gmail.com', 'dewilai12345', '012d73e0fab8d26e0f4d65e360775125', '2021-07-15'),
('U16', 'dekifirmansyah13@gmail.com', 'dekifrmnsyh13', '012d73e0fab8d26e0f4d65e360775126', '2021-07-16'),
('U17', 'safira123@gmail.com', 'safiradjn123', '012d73e0fab8d26e0f4d65e360775127', '2021-05-03'),
('U18', 'satrya29rfq@gmail.com', 'satryarfq29', '012d73e0fab8d26e0f4d65e360775128', '2021-07-18'),
('U19', 'melicapek@gmail.com', 'meliusa4321', '012d73e0fab8d26e0f4d65e360775129', '2021-05-07'),
('U20', 'iftitahhidaya32@gmail.com', 'iftitahhidaya354', '012d73e0fab8d26e0f4d65e360775130', '2021-05-08'),
('U21', 'yasminealiya@gmail.com', 'aliyasmine', '012d73e0fab8d26e0f4d65e360775131', '2021-05-09'),
('U22', 'dealina10@gmail.com', 'dealina1001', '012d73e0fab8d26e0f4d65e360775132', '2021-05-10'),
('U23', 'ainiqudusi@gmail.com', 'ainiqids45', '012d73e0fab8d26e0f4d65e360775133', '2021-05-11'),
('U24', 'catherine14@gmail.com', 'catherine345', '012d73e0fab8d26e0f4d65e360775134', '2021-07-24'),
('U25', 'abithaputri@gmail.com', 'abithasaputri', '012d73e0fab8d26e0f4d65e360775135', '2021-05-04'),
('U26', 'wuripribadi11@gmail.com', 'wurianggraini', '012d73e0fab8d26e0f4d65e360775136', '2021-07-26'),
('U27', 'rarandani@gmail.com', 'rarandani', '012d73e0fab8d26e0f4d65e360775137', '2021-07-27'),
('U28', 'nabiel09@gmail.com', '123nabiel', '012d73e0fab8d26e0f4d65e360775138', '2021-07-28'),
('U29', 'desinovita04@gmail.com', 'novitasarides42', '012d73e0fab8d26e0f4d65e360775139', '2021-07-29'),
('U30', 'sherlytadinda89@gmail.com', 'umikzher13', '012d73e0fab8d26e0f4d65e360775140', '2021-05-08'),
('U31', 'danielputra10@gmail.com', 'danielputra111', '012d73e0fab8d26e0f4d65e360775141', '2021-05-09'),
('U32', 'danianjar@gmail.com', '99danianjar', '012d73e0fab8d26e0f4d65e360775142', '2021-05-10'),
('U33', 'ginanjar12@gmail.com', 'giginanjar12', '012d73e0fab8d26e0f4d65e360775143', '2021-07-21'),
('U34', 'auliyayak@gmail.com', 'sulthonauliyayak', '012d73e0fab8d26e0f4d65e360775144', '2021-07-22'),
('U35', 'rizaldarmawan@gmail.com', 'rzldmwn13', '012d73e0fab8d26e0f4d65e360775145', '2021-07-23'),
('U36', 'fajarkurniawan@gmail.com', 'fajarhadi67', '012d73e0fab8d26e0f4d65e360775146', '2021-07-24'),
('U37', 'usamabintang1@gmail.com', 'uusbintang1', '012d73e0fab8d26e0f4d65e360775147', '2021-07-25'),
('U38', 'rohmanardianto@gmail.com', 'rohmanardianto', '012d73e0fab8d26e0f4d65e360775148', '2021-07-26'),
('U39', 'zakariayhy@gmail.com', 'zakariyahya', '012d73e0fab8d26e0f4d65e360775149', '2021-07-27'),
('U40', 'ezrasaputa01@gmail.com', 'ezrasaputra1', '012d73e0fab8d26e0f4d65e360775150', '2021-07-28');

-- --------------------------------------------------------

--
-- Dumping data for table dokter
--

INSERT INTO dokter VALUES
('DC01', 'U31', 'Daniel', 'L', '08763746752', 'Bondowoso', '1990-09-20', 'kecantikan', 'active'),
('DC02', 'U32', 'Daniel', 'L', '08763747464', 'Jember', '1980-09-21', 'kecantikan', 'active'),
('DC03', 'U33', 'Gigin', 'L', '08763746947', 'Probolinggo', '1970-11-22', 'kecantikan', 'unactive'),
('DC04', 'U34', 'Yayak', 'L', '08762146736', 'Malang', '1983-12-23', 'kecantikan', 'active'),
('DC05', 'U35', 'Rizal', 'L', '08647388283', 'Situbondo', '1994-08-24', 'kecantikan', 'unactive'),
('DC06', 'U36', 'Fajar', 'L', '08126357487', 'Bandung', '1993-11-25', 'kecantikan', 'active'),
('DC07', 'U37', 'Usama', 'L', '08029388730', 'Sidoarjo', '1998-12-26', 'kecantikan', 'active'),
('DC08', 'U38', 'Rohman', 'L', '08657387784', 'Lumajang', '1992-01-27', 'kecantikan', 'active'),
('DC09', 'U39', 'Zakari', 'L', '08562376346', 'Solo', '1984-09-28', 'kecantikan', 'unactive'),
('DC10', 'U40', 'Ezra', 'L', '08645537488', 'Surabaya', '1987-04-29', 'kecantikan', 'active');

-- --------------------------------------------------------

--
-- Dumping data for table pegawai
--

INSERT INTO pegawai VALUES
('P01', 'U01', 'Mochammad Hairullah', 'L', '8521234', 'Bondowoso', '1999-07-23', 'active'),
('P02', 'U02', 'Dherisma Hanindita', 'P', '8523521', 'Jember', '2000-07-11', 'active'),
('P03', 'U03', 'Faiza Kurnia', 'P', '8527890', 'Probolinggo', '1990-07-10', 'active'),
('P04', 'U04', 'Aida Millati', 'P', '8125725', 'Malang', '1999-12-04', 'unactive'),
('P05', 'U05', 'Cintya Aprila', 'P', '8541245', 'Situbondo', '1992-02-09', 'unactive'),
('P06', 'U06', 'Fattahul Ulum', 'L', '8169310', 'Bandung', '1989-01-06', 'unactive'),
('P07', 'U07', 'Lorensa Rohmatir', 'P', '8234679', 'Sidoarjo', '1998-01-17', 'active'),
('P08', 'U08', 'Annastasya Ammali', 'P', '8871028', 'Lumajang', '1991-11-08', 'active'),
('P09', 'U09', 'Rafly Akbar', 'L', '8766182', 'Solo', '1999-07-02', 'unactive'),
('P10', 'U10', 'Valencia Nugroho', 'P', '8876412', 'Surabaya', '1989-04-22', 'active');

-- --------------------------------------------------------

--
-- Dumping data for table pelanggan
--

INSERT INTO pelanggan VALUES
('C01', 'U21', 'Yasmine', 'P', '08763746372', 'Bandung', '1999-09-03', 'pelanggan'),
('C02', 'U22', 'Dea', 'P', '08763746746', 'Malang', '1999-12-04', 'guest'),
('C03', 'U23', 'Aini', 'P', '08763746652', 'Jakarta', '2003-03-29', 'guest'),
('C04', 'U24', 'Catherin', 'P', '08762146372', 'Madura', '2000-02-03', 'pelanggan'),
('C05', 'U25', 'Abitha', 'P', '08237483889', 'Malang', '1999-09-06', 'pelanggan'),
('C06', 'U26', 'Wuri', 'P', '08126356478', 'Malang', '2001-08-02', 'pelanggan'),
('C07', 'U27', 'Rara', 'P', '08029300499', 'Malang', '1999-09-08', 'pelanggan'),
('C08', 'U28', 'Nabiel', 'P', '08657388273', 'Surabaya', '1999-09-09', 'guest'),
('C09', 'U29', 'Desi', 'P', '08562377283', 'Jember', '1997-05-17', 'guest'),
('C10', 'U30', 'Sherlyta', 'P', '08645533625', 'Surabaya', '1999-07-02', 'pelanggan');

-- --------------------------------------------------------

--
-- Dumping data for table pemilik
--

INSERT INTO pemilik VALUES
('D01', 'U11', 'Kuncara', 'L', '08464733', 'Malang', '1999-09-11', 'active'),
('D02', 'U12', 'Gusti', 'L', '08674663', 'Malang', '1998-04-02', 'unactive'),
('D03', 'U13', 'Dilta', 'P', '08657388', 'Lumajang', '2001-02-18', 'unactive'),
('D04', 'U14', 'Gusta', 'P', '08756737', 'Probolinggo', '1999-12-01', 'unactive'),
('D05', 'U15', 'Dewi', 'P', '08948847', 'Lumajang', '1999-04-18', 'active'),
('D06', 'U16', 'Deki', 'L', '08988472', 'Malang', '1998-06-10', 'unactive'),
('D07', 'U17', 'Safira', 'P', '08174774', 'Malang', '2000-09-07', 'active'),
('D08', 'U18', 'Satrya', 'L', '08874663', 'Malang', '2002-11-11', 'active'),
('D09', 'U19', 'Meliusa', 'P', '08998373', 'Malang', '2000-02-10', 'active'),
('D10', 'U20', 'Iftitah', 'P', '08876773', 'Malang', '1999-05-25', 'active');

-- --------------------------------------------------------

--
-- Dumping data for table paket
--

INSERT INTO paket VALUES
('PC01', 'facial', 'facial merupakan metode perawatan yang efektif untuk meremajakan kulit wajah ', 100000),
('PC02', 'chemical peeling', 'chemical peeling adalah perawatan yang dilakukan untuk mengatasi berbagai masalah kulit seperti kulit kusam, berjerawat, bekas luka, keriput, hingga garis-garis halus di wajah.', 160000),
('PC03', 'microneedling', 'terapi ini bertujuan untuk memperbaiki tekstur kulit dengan merangsang produksi kolagen.', 600000),
('PC04', 'laser', 'perawatan ini digunakan untuk meremajakan kulitwajah, laser menghilangkan lapisan kult mati menggunakan sinar', 850000),
('PC05', 'botox', 'Suntik Botox adalah perawatan Anti-Wrinkle Injection atau biasa disebut Botox (Botox adalah nama brand bukan sebuah treatment) menjadi perawatan wajah populer.', 1250000);

-- --------------------------------------------------------

--
-- Dumping data for table detail_paket

INSERT INTO detail_paket VALUES
('PC01', 'deep cleansing'),
('PC01', 'penguapan wajah'),
('PC01', 'eksfoliasi'),
('PC01', 'clean komedo'),
('PC01', 'masker wajah'),
('PC01', 'astringen'),
('PC02', 'cleansing'),
('PC02', 'pengoleskan cairan kimia '),
('PC03', 'facial'),
('PC03', 'anestasi krim'),
('PC03', 'dilukai dengan dermarolle'),
('PC03', 'dioles serum'),
('PC04', 'cream'),
('PC04', 'facial wash'),
('PC04', 'laser wajah'),
('PC05', 'suntikan protein'),
('PC05', 'cleasing');
-- --------------------------------------------------------

--
-- Dumping data for table orders
--

INSERT INTO orders VALUES
('OD001', 'C09', 'P01', 'PC05', '2021-09-02', 1250000),
('OD002', 'C01', 'P04', 'PC04', '2021-09-14', 850000),
('OD003', 'C10', 'P05', 'PC03', '2021-09-17', 600000),
('OD004', 'C04', 'P09', 'PC05', '2021-09-29', 1250000),
('OD005', 'C09', 'P05', 'PC05', '2021-10-01', 1250000),
('OD006', 'C06', 'P02', 'PC01', '2021-10-04', 100000),
('OD007', 'C07', 'P01', 'PC05', '2021-10-14', 1250000),
('OD008', 'C08', 'P08', 'PC04', '2021-10-18', 850000),
('OD009', 'C04', 'P09', 'PC01', '2021-10-20', 100000),
('OD010', 'C02', 'P06', 'PC02', '2021-10-20', 160000),
('OD011', 'C06', 'P03', 'PC01', '2021-10-26', 100000),
('OD012', 'C09', 'P10', 'PC05', '2021-10-30', 1250000),
('OD013', 'C01', 'P07', 'PC03', '2021-10-31', 600000),
('OD014', 'C01', 'P02', 'PC04', '2021-11-14', 850000),
('OD015', 'C05', 'P03', 'PC01', '2021-11-20', 100000),
('OD016', 'C09', 'P01', 'PC05', '2021-11-25', 1250000),
('OD017', 'C04', 'P06', 'PC03', '2021-11-29', 600000),
('OD018', 'C08', 'P10', 'PC01', '2021-12-21', 100000),
('OD019', 'C10', 'P05', 'PC02', '2021-12-25', 160000),
('OD020', 'C05', 'P07', 'PC02', '2021-12-25', 160000);
-- --------------------------------------------------------

--
-- Dumping data for table payments
--

INSERT INTO payments VALUES
('PAY0001', 'OD001', 'cash', '-', '-', 1250000, 1250000, 'pending'),
('PAY0002', 'OD002', 'debit', 'BCA', '14039488', 850000, 850000, 'process'),
('PAY0003', 'OD003', 'debit', '-', '', 600000, 600000, 'success'),
('PAY0004', 'OD004', 'cash', '-', '', 1250000, 1250000, 'pending'),
('PAY0005', 'OD005', 'debit', 'BCA', '14062352', 1250000, 1250000, 'process'),
('PAY0006', 'OD006', 'cash', '-', '', 100000, 100000, 'success'),
('PAY0007', 'OD007', 'debit', 'BNI', '00952532', 1250000, 1250000, 'pending'),
('PAY0008', 'OD008', 'debit', 'BCA', '14052352', 850000, 850000, 'process'),
('PAY0009', 'OD009', 'debit', 'BRI', '00273352', 100000, 100000, 'success'),
('PAY0010', 'OD010', 'debit', 'BNI', '00955325', 160000, 160000, 'success'),
('PAY0011', 'OD011', 'cash', '-', '', 100000, 100000, 'pending'),
('PAY0012', 'OD012', 'cash', '-', '', 1250000, 1250000, 'process'),
('PAY0013', 'OD013', 'cash', '-', '', 600000, 600000, 'success'),
('PAY0014', 'OD014', 'debit', 'BRI', '00277346', 850000, 850000, 'success'),
('PAY0015', 'OD015', 'debit', 'BRI', '00278497', 100000, 100000, 'success'),
('PAY0016', 'OD016', 'cash', '-', '', 1250000, 1250000, 'pending'),
('PAY0017', 'OD017', 'debit', 'BCA', '14039488', 600000, 600000, 'success'),
('PAY0018', 'OD018', 'cash', '-', '', 100000, 100000, 'success'),
('PAY0019', 'OD019', 'cash', '-', '', 160000, 160000, 'process'),
('PAY0020', 'OD020', 'debit', 'BCA', '14025325', 160000, 160000, 'process');
-- --------------------------------------------------------

--
-- Dumping data for table perawatan
--

INSERT INTO perawatan VALUES
('R001', 'OD012', 'DC01', 'Kulit tampak kusam', 'Facial', '2021-09-02'),
('R002', 'OD008', 'DC01', 'Jerawat', 'Facial', '2021-09-14'),
('R003', 'OD011', 'DC06', 'Kulit kusam', 'Exfoliate', '2021-09-17'),
('R004', 'OD002', 'DC04', 'Kulit gelap', 'Suntik Putih', '2021-09-29'),
('R005', 'OD013', 'DC02', 'Komedo Berlebihan', 'Clean komedo', '2021-10-01'),
('R006', 'OD004', 'DC05', 'Pasang Bulu mata', 'Eyelash extension', '2021-10-04'),
('R007', 'OD005', 'DC03', 'Lapisan Kulit terlalu tipis', 'Laser', '2021-10-04'),
('R008', 'OD020', 'DC07', 'Bibir gelap', 'Sulam bibir', '2021-10-14'),
('R009', 'OD007', 'DC10', 'Kulit tampak kusam', 'Facial', '2021-10-18'),
('R010', 'OD001', 'DC02', 'Kulit gelap', 'Suntik Putih', '2021-10-20'),
('R011', 'OD009', 'DC08', 'Jerawat', 'Facial', '2021-10-20'),
('R012', 'OD017', 'DC07', 'Pasang Bulu mata', 'Eyelash extension', '2021-10-26'),
('R013', 'OD003', 'DC09', 'Kulit kering', 'Moisturizer', '2021-10-30'),
('R014', 'OD018', 'DC06', 'Memutihkan Badan', 'Suntik DNA salmon', '2021-10-31'),
('R015', 'OD014', 'DC08', 'Kulit kering', 'Moisturizer', '2021-11-20'),
('R016', 'OD019', 'DC09', 'Bibir gelap', 'Sulam bibir', '2021-11-25'),
('R017', 'OD006', 'DC05', 'Kulit kering', 'Moisturizer', '2021-11-29'),
('R018', 'OD010', 'DC06', 'Jerawat', 'Facial', '2021-12-21'),
('R019', 'OD016', 'DC10', 'Flek Hitam', 'Microdermabrasi', '2021-12-25'),
('R020', 'OD015', 'DC04', 'Pasang Bulu mata', 'Eyelash extension', '2021-12-25');