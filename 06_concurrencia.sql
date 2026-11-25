use farmacia;

--  Configura read committed e inicia transacción de lectura (sesion a)
set session transaction isolation level read committed;
start transaction;
select id_inventario, lote, existencia from inventario where id_inventario = 1;


-- En otra pestaña, actualiza y confirma el cambio mientras Sesión A sigue abierta jeje (sesion b)
start transaction;
update inventario set existencia = existencia - 10 where id_inventario = 1;
commit;

-- Vuelve a leer el mismo registro dentro de la misma transacción (sesion a)
select id_inventario, lote, existencia from inventario where id_inventario = 1;
commit;

-- Configura serializable y lee el lote 2 (sesion a)
set session transaction isolation level serializable;
start transaction;
select id_inventario, lote, existencia from inventario where id_inventario = 2;

-- la sesion b Intenta modificar el lote 2 mientras sesion a no hace commit 
-- Esta sentencia estara bloqueada esperando a que sesion a termine o provocara Lock wait timeout asi que wachen eso
update inventario set existencia = existencia - 5 where id_inventario = 2;
-- (sesion a)
commit;

-- Transaccion exitosa con commit
start transaction;
insert into salidas (id_inventario, id_personal, cantidad, justificacion, tipo_salida)
values (1, 3, 5, 'Venta demostrativa commit', 'Venta');
select id_inventario, lote, existencia from inventario where id_inventario = 1;
commit;

-- Transaccion con rollback explicito 
start transaction;
insert into salidas (id_inventario, id_personal, cantidad, justificacion, tipo_salida)
values (1, 3, 20, 'Venta cancelada por cliente', 'Venta');
select id_inventario, lote, existencia from inventario where id_inventario = 1;
rollback;
select id_inventario, lote, existencia from inventario where id_inventario = 1;
-- Si todo salio bien en existencia debe de quedar 135


-- Transaccion de varias tablas con rollback automatico por error
-- sp_alta_medicamento inserta en medicamentos, inventario y medicamento_proveedor.
-- Aqui el proveedor 999 no existe -> falla la FK en el 3er insert -> el handler hace rollback
-- y el medicamento y el lote que ya se habian insertado se deshacen.
call sp_alta_medicamento('Cetirizina', 'Antihistaminico', 'Caja con 10 tabletas 10mg',
     40.00, 'Antialérgicos', 'LOTE-CET-16', '2028-03-01', 999, 22.00, @id_nuevo);
-- (marca error 1452 de FK, es lo esperado)
select count(*) as debe_ser_cero from medicamentos where nombre = 'Cetirizina';

-- La misma operacion con un proveedor valido si hace commit en las 3 tablas
call sp_alta_medicamento('Cetirizina', 'Antihistaminico', 'Caja con 10 tabletas 10mg',
     40.00, 'Antialérgicos', 'LOTE-CET-16', '2028-03-01', 4, 22.00, @id_nuevo);
select @id_nuevo as id_medicamento_nuevo;
select * from inventario where id_medicamento = @id_nuevo;
select * from medicamento_proveedor where id_medicamento = @id_nuevo;
