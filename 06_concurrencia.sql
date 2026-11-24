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
-- luego agrego mas comentacion para saber como funciona o preguntenle a chajepete