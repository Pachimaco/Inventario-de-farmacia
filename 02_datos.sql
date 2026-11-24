use farmacia;

-- Proveedores
insert into proveedores
(nombre, telefono, correo, direccion)
values
('Farmaceutica del Norte', '6441234567', 'contacto@farmnorte.com', 'Calle Morelos 120'),
('Distribuidora Medica', '6442345678', 'ventas@distmedica.com', 'Av. Guerrero 245'),
('Medicamentos del Yaqui', '6443456789', 'info@medyaqui.com', 'Calle Hidalgo 310'),
('Farmacia Central', '6444567890', 'proveedores@farmcentral.com', 'Av. Nainari 450'),
('Salud y Vida', '6445678901', 'contacto@saludyvida.com', 'Calle 5 de Febrero 210'),
('Distribuidora San Jose', '6446789012', 'ventas@sanjose.com', 'Calle California 180'),
('FarmaPlus', '6447890123', 'info@farmaplus.com', 'Av. Jalisco 520'),
('MedSupply', '6448901234', 'contacto@medsupply.com', 'Calle Chihuahua 115'),
('Productos Médicos del Pacifico', '6449012345', 'ventas@pmedpacifico.com', 'Av. Sinaloa 340'),
('Suministros Hospitalarios', '6440123456', 'info@suministros.com', 'Calle Sonora 275'),
('BioMedic', '6441122334', 'contacto@biomedic.com', 'Av. Hidalgo 190'),
('Farmacéutica Nacional', '6442233445', 'ventas@farnacional.com', 'Calle Veracruz 410'),
('Distribuciones del Sur', '6443344556', 'info@delsur.com', 'Av. Quintana Roo 225'),
('MediCorp', '6444455667', 'contacto@medicorp.com', 'Calle Allende 160'),
('Proveedora San Rafael', '6445566778', 'ventas@sanrafael.com', 'Av. Miguel Aleman 380');

-- Personal
insert into personal (nombre, apellido, puesto, usuario, password, rol, activo) values
('Leyla Rodriguez', 'Soto', 'Administrador', 'leyla', 'leyla123', 'Administrador', true),
('Ramon Arturo', 'Caballero Muñoz', 'Encargado', 'ramon', 'ramon123', 'Encargado', true),
('Victor Abraham', 'Reyna Cantua', 'Farmaceutico', 'victor', 'victor123', 'Encargado', true),
('Maria Fernanda', 'Valenzuela Pacheco', 'Farmaceutico', 'maria', 'maria123', 'Encargado', true),
('Diego', 'Perez', 'Farmaceutico', 'diego', 'diego123', 'Encargado', true),
('Ana', 'Chavez', 'Farmaceutico', 'ana', 'ana123', 'Encargado', true),
('Sol', 'Minjarez', 'Farmaceutico', 'sol', 'sol123', 'Encargado', true),
('Daniel', 'Quintana', 'Farmaceutico', 'daniel', 'daniel123', 'Encargado', true),
('Luis', 'Valenzuela', 'Farmaceutico', 'luis', 'luis123', 'Encargado', true),
('Pedro', 'Armendariz', 'Farmaceutico', 'pedro', 'pedro123', 'Encargado', true),
('Miguel', 'Lopez', 'Farmaceutico', 'miguel', 'miguel123', 'Encargado', true),
('Gabriela', 'Torres', 'Farmaceutico', 'gabriela', 'gaby123', 'Encargado', true),
('Eduardo', 'Navarro', 'Farmaceutico', 'eduardo', 'eduardo123', 'Encargado', true),
('Fernanda', 'Jimenez', 'Farmaceutico', 'fernanda', 'fer123', 'Encargado', true),
('Ricardo', 'Sanchez', 'Farmaceutico', 'ricardo', 'ricardo123', 'Encargado', true);

-- Medicamentos
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


-- Inventarios
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

-- Entradas
insert into entradas (id_inventario, id_proveedor, id_personal, cantidad, fecha_entrada, ubicacion_estanteria) VALUES
(1,  1,  1, 50, '2026-10-01 08:30:00', 'EST-A1'), 
(2,  2,  2, 30, '2026-10-02 09:15:00', 'EST-A2'),
(3,  3,  3, 40, '2026-10-03 10:00:00', 'EST-B1'),
(4,  4,  4, 60, '2026-10-04 11:20:00', 'EST-B2'), 
(5,  5,  7, 45, '2026-10-05 12:10:00', 'EST-C1'), 
(6,  6,  1, 80, '2026-10-06 13:45:00', 'EST-C2'), 
(7,  7,  2, 35, '2026-10-07 14:30:00', 'EST-D1'), 
(8,  8,  13, 20, '2026-10-08 15:00:00', 'EST-D2'), 
(9,  9,  3, 55, '2026-10-09 16:15:00', 'EST-A3'), 
(10, 10, 4, 40, '2026-10-10 08:50:00', 'EST-B3'), 
(11, 11, 7, 15, '2026-10-11 09:40:00', 'EST-E1'), 
(12, 12, 1, 25, '2026-10-12 10:25:00', 'EST-E2'), 
(13, 13, 2, 45, '2026-10-13 11:55:00', 'EST-C3'), 
(14, 14, 13, 90, '2026-10-14 13:10:00', 'EST-A4'), 
(15, 15, 3, 65, '2026-10-15 16:40:00', 'EST-F1');

-- Salidas
insert into salidas (id_inventario, id_personal, cantidad, fecha_salida, justificacion, tipo_salida) VALUES
(1,  3, 12, '2026-10-16 09:10:00', 'Venta en mostrador', 'Venta'),
(2,  4, 8,  '2026-10-16 10:30:00', 'Venta en mostrador', 'Venta'),
(3,  5, 5,  '2026-10-17 11:45:00', 'Venta con receta medica', 'Venta'),
(4,  6, 15, '2026-10-17 13:00:00', 'Venta en mostrador', 'Venta'),
(5,  9, 10, '2026-10-18 14:20:00', 'Venta en mostrador', 'Venta'),
(6,  11, 20, '2026-10-18 15:40:00', 'Venta con receta medica', 'Venta'),
(7,  14, 7,  '2026-10-19 16:15:00', 'Venta con receta medica', 'Venta'),
(8,  3, 4,  '2026-10-20 09:50:00', 'Merma por valvula danada', 'Daño'),
(9,  4, 11, '2026-10-20 11:25:00', 'Venta en mostrador', 'Venta'),
(10, 8, 6,  '2026-10-21 12:40:00', 'Venta en mostrador', 'Venta'),
(11, 10, 3,  '2026-10-22 14:05:00', 'Merma por lote caducado', 'Caducidad'),
(12, 12, 9,  '2026-10-23 15:30:00', 'Venta con receta medica', 'Venta'),
(13, 15, 8,  '2026-10-24 16:50:00', 'Venta en mostrador', 'Venta'),
(14, 3, 25, '2026-10-25 17:15:00', 'Venta en mostrador', 'Venta'),
(15, 4, 14, '2026-10-26 18:10:00', 'Venta en mostrador', 'Venta');

-- Medicamento_proveedor o sea la tabla muchos a muchos
insert into medicamento_proveedor
(id_medicamento, id_proveedor, precio_compra)
values
(1, 1, 28.00),
(2, 2, 42.00),
(3, 3, 85.00),
(4, 4, 20.00),
(5, 5, 60.00),
(6, 6, 38.00),
(7, 7, 65.00),
(8, 8, 105.00),
(9, 9, 32.00),
(10, 10, 40.00),
(11, 11, 130.00),
(12, 12, 50.00),
(13, 13, 43.00),
(14, 14, 18.00),
(15, 15, 75.00);
