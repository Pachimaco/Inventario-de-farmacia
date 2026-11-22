use farmacia;

create role if not exists 'rol_administrador';
create role if not exists 'rol_encaralmacen';

grant select, insert, update, delete on farmacia.medicamentos to 'rol_administrador';
grant select, insert, update, delete on farmacia.proveedores to 'rol_administrador';
grant select, insert, update, delete on farmacia.personal to 'rol_administrador';
grant select, insert, update, delete on farmacia.inventario to 'rol_administrador';
grant select, insert, update, delete on farmacia.medicamento_proveedor to 'rol_administrador';
grant select, insert, update, delete on farmacia.entradas to 'rol_administrador';
grant select, insert, update, delete on farmacia.salidas to 'rol_administrador';

grant select, insert, update, delete on farmacia.entradas to 'rol_encaralmacen';
grant select, insert, update, delete on farmacia.salidas to 'rol_encaralmacen';

create user if not exists 'admin'@'localhost' identified by 'admin';
create user if not exists 'almacen'@'localhost' identified by 'almacen';

grant 'rol_administrador' to 'admin'@'localhost';
grant 'rol_encaralmacen' to 'almacen'@'localhost';

set default role all to 'admin'@'localhost';
set default role all to 'almacen'@'localhost';

flush privileges;
