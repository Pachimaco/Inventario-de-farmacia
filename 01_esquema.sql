create database farmacia;
use farmacia;

create table medicamentos (
    id_medicamento int auto_increment primary key,
    nombre varchar(80) not null,
    descripcion varchar(100),
    presentacion varchar(50) not null,
    precio decimal(10,2) not null,
    categoria varchar(50)
);

create table proveedores (
    id_proveedor int auto_increment primary key,
    nombre varchar(80) not null,
    telefono varchar(20),
    correo varchar(80) unique,
    direccion varchar(100)
);

create table personal (
    id_personal int auto_increment primary key,
    nombre varchar(50) not null,
    apellido varchar(50) not null,
    puesto varchar(40) not null,
    usuario varchar(30) not null unique,
    password varchar(100) not null,
    rol varchar(20) not null,
    activo boolean not null default true,
    constraint chk_rol check (rol in ('Administrador', 'Encargado'))
);

create table inventario (
    id_inventario int auto_increment primary key,
    id_medicamento int not null,
    lote varchar(50) not null,
    existencia int not null default 0,
    fecha_caducidad date not null,
    foreign key (id_medicamento)
        references medicamentos(id_medicamento)
        on delete restrict
        on update cascade
);

-- tabla N:M
create table medicamento_proveedor (
    id_medicamento int not null,
    id_proveedor int not null,
    precio_compra decimal(10,2) not null,
    primary key (id_medicamento, id_proveedor),
    foreign key (id_medicamento)
        references medicamentos(id_medicamento)
        on delete restrict
        on update cascade,
    foreign key (id_proveedor)
        references proveedores(id_proveedor)
        on delete restrict
        on update cascade
);



create table entradas (
    id_entrada int auto_increment primary key,
    id_inventario int not null,
    id_proveedor int not null,
    id_personal int not null,
    cantidad int not null,
    fecha_entrada datetime default current_timestamp,
    ubicacion_estanteria varchar(20) not null,
    foreign key (id_inventario)
        references inventario(id_inventario)
        on delete restrict
        on update cascade,
    foreign key (id_proveedor)
        references proveedores(id_proveedor)
        on delete restrict
        on update cascade,
    foreign key (id_personal)
        references personal(id_personal)
        on delete restrict
        on update cascade
);

create table salidas (
    id_salida int auto_increment primary key,
    id_inventario int not null,
    id_personal int not null,
    cantidad int not null,
    fecha_salida datetime default current_timestamp,
    justificacion varchar(100),
    tipo_salida varchar(30),
    foreign key (id_inventario)
        references inventario(id_inventario)
        on delete restrict
        on update cascade,
    foreign key (id_personal)
        references personal(id_personal)
        on delete restrict
        on update cascade
);

alter table salidas add constraint chk_tipo_salida
check (tipo_salida in (
    'Venta',
    'Caducidad',
    'Daño',
    'Consumo interno',
    'Devolucion'
));

alter table inventario
add constraint chk_existencia
check (existencia >= 0);

alter table personal
drop check chk_rol;

alter table personal
add constraint chk_rol
check (rol in ('Administrador', 'Encargado', 'Consulta'));

alter table personal
add constraint chk_puesto
check (puesto in (
    'Administrador',
    'Encargado',
    'Vendedor',
    'Farmaceutico',
    'Auxiliar'
));

