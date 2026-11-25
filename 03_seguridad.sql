use farmacia;

create role if not exists 'rol_administrador';
create role if not exists 'rol_encaralmacen';
-- añadi otro rol por la modalidad n = 3 jeje wololo 
create role if not exists 'rol_consulta';

grant select, insert, update, delete on farmacia.medicamentos to 'rol_administrador';
grant select, insert, update, delete on farmacia.proveedores to 'rol_administrador';
grant select, insert, update, delete on farmacia.personal to 'rol_administrador';
grant select, insert, update, delete on farmacia.inventario to 'rol_administrador';
grant select, insert, update, delete on farmacia.medicamento_proveedor to 'rol_administrador';
grant select, insert, update, delete on farmacia.entradas to 'rol_administrador';
grant select, insert, update, delete on farmacia.salidas to 'rol_administrador';

grant select on farmacia.medicamentos to 'rol_encaralmacen';
grant select on farmacia.proveedores to 'rol_encaralmacen';
grant select on farmacia.personal to 'rol_encaralmacen';
grant select on farmacia.inventario to 'rol_encaralmacen';
-- ejecutar luego (de consultas y procedural )
-- es rol es para tener las vista de reportes sin darle acceso directo para leer ni modificar 
grant select on farmacia.vw_estado_inventario to 'rol_consulta';
grant select on farmacia.vw_resumen_proveedores to 'rol_consulta';
grant select on farmacia.vw_reporte_mermas to 'rol_consulta';
-- este rol es para el login con el C#
grant execute on procedure farmacia.sp_login to 'rol_consulta';

grant select, insert, update on farmacia.entradas to 'rol_encaralmacen';
grant select, insert, update on farmacia.salidas to 'rol_encaralmacen';

create user if not exists 'admin'@'localhost' identified by 'admin';
create user if not exists 'almacen'@'localhost' identified by 'almacen';
create user if not exists 'auditor'@'localhost' identified by 'auditor';

alter user 'admin'@'localhost' identified by 'admin';
alter user 'almacen'@'localhost' identified by 'almacen';
alter user 'auditor'@'localhost' identified by 'auditor';

grant 'rol_administrador' to 'admin'@'localhost';
grant 'rol_encaralmacen' to 'almacen'@'localhost';
grant 'rol_consulta' to 'auditor'@'localhost';

set default role all to 'admin'@'localhost';
set default role all to 'almacen'@'localhost';
set default role all to 'auditor'@'localhost';

-- sin este grant el rol de admin seria rechazado por el sistema cuando intente registrar EoS
grant execute on procedure farmacia.sp_login to 'rol_administrador', 'rol_encaralmacen';
grant execute on procedure farmacia.sp_registrar_entrada to 'rol_administrador', 'rol_encaralmacen';
grant execute on procedure farmacia.sp_registrar_salida to 'rol_administrador', 'rol_encaralmacen';
grant execute on procedure farmacia.sp_consultar_existencia to 'rol_administrador', 'rol_encaralmacen';
grant select on farmacia.vw_estado_inventario to 'rol_administrador', 'rol_encaralmacen';
grant select on farmacia.vw_resumen_proveedores to 'rol_administrador', 'rol_encaralmacen';
grant select on farmacia.vw_reporte_mermas to 'rol_administrador', 'rol_encaralmacen';
grant select, insert, update, delete on farmacia.medicamento_proveedor to 'rol_administrador'@'%';

flush privileges;
