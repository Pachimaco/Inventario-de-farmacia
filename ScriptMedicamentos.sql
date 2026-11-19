use farmacia;

-- Registro de medicamentos
insert into medicamentos (nombre, descripcion, presentacion, precio, categoria) values
('Paracetamol', 'Analgésico y antipirético', 'Caja con 20 tabletas 500mg', 45.50, 'Analgésicos'),
('Ibuprofeno', 'Antiinflamatorio no esteroideo', 'Caja con 30 cápsulas 400mg', 68.00, 'Antiinflamatorios'),
('Amoxicilina', 'Antibiótico de amplio espectro', 'Frasco con suspensión 250mg/5ml', 120.00, 'Antibióticos'),
('Loratadina', 'Antihistamínico para alergias', 'Caja con 10 tabletas 10mg', 35.00, 'Antialérgicos'),
('Omeprazol', 'Inhibidor de la bomba de protones', 'Caja con 14 cápsulas 20mg', 85.50, 'Gastrointestinal'),
('Metformina', 'Control de glucosa en sangre', 'Caja con 30 tabletas 850mg', 55.00, 'Diabetes'),
('Losartán', 'Control de la presión arterial', 'Caja con 30 tabletas 50mg', 92.00, 'Cardiovascular'),
('Salbutamol', 'Broncodilatador para asma', 'Inhalador en aerosol 200 dosis', 145.00, 'Respiratorio'),
('Diclofenaco', 'Relajante muscular y antiinflamatorio', 'Caja con 20 tabletas 100mg', 50.00, 'Antiinflamatorios'),
('Naproxeno', 'Alivio del dolor e inflamación', 'Caja con 12 tabletas 250mg', 62.50, 'Antiinflamatorios'),
('Azitromicina', 'Antibiótico macrólido', 'Caja con 3 tabletas 500mg', 180.00, 'Antibióticos'),
('Ketorolaco', 'Analgésico potente para dolor agudo', 'Caja con 10 tabletas 10mg', 75.00, 'Analgésicos'),
('Butilhioscina', 'Espasmolítico abdominal', 'Caja con 10 comprimidos 10mg', 64.00, 'Gastrointestinal'),
('Ácido Acetilsalicílico', 'Anticoagulante y analgésico', 'Caja con 40 tabletas 500mg', 30.00, 'Analgésicos'),
('Vitamina C', 'Suplemento alimenticio inmunoestimulante', 'Frasco con 60 tabletas masticables', 110.00, 'Vitaminas');

-- Registros iniciales de inventario
insert into inventario (id_medicamento, lote, existencia, fecha_caducidad) values
(1, 'LOTE-PAR-01', 150, '2027-06-30'),
(2, 'LOTE-IBU-02', 85, '2026-12-15'),
(3, 'LOTE-AMX-03', 40, '2026-09-10'),
(4, 'LOTE-LOR-04', 120, '2028-01-20'),
(5, 'LOTE-OME-05', 95, '2027-03-12'),
(6, 'LOTE-MET-06', 200, '2028-05-18'),
(7, 'LOTE-LOS-07', 60, '2027-11-22'),
(8, 'LOTE-SAL-08', 30, '2026-10-05'),
(9, 'LOTE-DIC-09', 110, '2027-08-14'),
(10, 'LOTE-NAP-10', 75, '2027-04-28'),
(11, 'LOTE-AZI-11', 25, '2026-07-19'),
(12, 'LOTE-KET-12', 50, '2027-12-01'),
(13, 'LOTE-BUT-13', 90, '2028-02-14'),
(14, 'LOTE-ASA-14', 180, '2028-06-10'),
(15, 'LOTE-VIT-15', 130, '2029-01-01');