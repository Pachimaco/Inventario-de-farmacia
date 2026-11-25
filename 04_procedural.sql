use farmacia;

delimiter $$

-- Funciones
drop function if exists fn_estado_caducidad$$
create function fn_estado_caducidad(p_fecha date)
returns varchar(20)
not deterministic -- ps aqui es not deterministic y no sql porque con el curdate cambia a cada rato y el no sql ps porque no hace consultas ni edita tablas
no sql
begin
    if p_fecha < curdate() then
        return 'CADUCADO';
    elseif p_fecha <= date_add(curdate(), interval 90 day) then -- aca el interval checa si se aproxima la fecha de caducidad
        return 'POR CADUCAR';
    end if;
    return 'VIGENTE';
end$$

-- funcion del total de inventario de un med
drop function if exists fn_existencia_total$$
create function fn_existencia_total(p_id_medicamento int)
returns int
reads sql data -- consulta la tabla pero no realiza cambios directos y usamos esto pq nomas comprueba la existencia de los medicamentos
begin
    declare v_total int;

    select coalesce(sum(existencia), 0)
    into v_total
    from inventario
    where id_medicamento = p_id_medicamento;

    return v_total;
end$$

-- funcion del valor de un med
drop function if exists fn_valor_inventario$$
create function fn_valor_inventario(p_id_medicamento int)
returns decimal(12,2)
reads sql data -- ps igual q la funcion de arriba pero esta más bien calcula el valor $$$ del med seleccionado
begin
    declare v_valor decimal(12,2);

    select coalesce(sum(i.existencia * m.precio), 0)
    into v_valorsp_login
    from inventario i
    inner join medicamentos m
        on i.id_medicamento = m.id_medicamento
    where i.id_medicamento = p_id_medicamento;

    return v_valor;
end$$

-- procedimientos insanos
  
-- Consulta de usuario para el login
drop procedure if exists sp_login$$

create procedure sp_login(
    in p_usuario varchar(30)
)
begin
    select id_personal, nombre, apellido, puesto,
           usuario, password, rol
    from personal
    where usuario = p_usuario
      and activo = true; -- ps en resumen busca al personal por su nombre de usuario y comprueba que su cuenta esté activa
end$$


-- Registro de entrada
drop procedure if exists sp_registrar_entrada$$

create procedure sp_registrar_entrada(
    in p_id_inventario int,
    in p_id_proveedor int,
    in p_id_personal int,
    in p_cantidad int,
    in p_ubicacion varchar(20)
)
begin
    declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;

    start transaction;

    insert into entradas
    (id_inventario, id_proveedor, id_personal,
     cantidad, ubicacion_estanteria)
    values
    (p_id_inventario, p_id_proveedor, p_id_personal,
     p_cantidad, p_ubicacion);

    commit;
end$$


-- Registro de salida
drop procedure if exists sp_registrar_salida$$

create procedure sp_registrar_salida(
    in p_id_inventario int,
    in p_id_personal int,
    in p_cantidad int,
    in p_tipo varchar(30),
    in p_justificacion varchar(100)
)
begin
    declare exit handler for sqlexception
    begin
        rollback;
        resignal;
    end;

    start transaction;

    insert into salidas
    (id_inventario, id_personal, cantidad,
     tipo_salida, justificacion)
    values
    (p_id_inventario, p_id_personal, p_cantidad,
     p_tipo, p_justificacion);

    commit;
end$$


-- Consulta de existencia de un lote
drop procedure if exists sp_consultar_existencia$$

create procedure sp_consultar_existencia(
    in p_id_inventario int,
    out p_existencia int
)
begin
    select existencia
    into p_existencia
    from inventario
    where id_inventario = p_id_inventario;
end$$

  
-- triggers
-- Validar entradas
drop trigger if exists trg_validar_entrada$$

create trigger trg_validar_entrada
before insert on entradas
for each row
begin
    if new.cantidad <= 0 then -- basicamente si se inserta una entrada aqui checa que no sean numeros negativos
        signal sqlstate '45000'
        set message_text = 'la cantidad de entrada debe ser mayor a cero';
    end if;

    if not exists (
        select 1 
        from inventario
        where id_inventario = new.id_inventario
    ) then
        signal sqlstate '45000' -- aca es pa comprobar que el lote que se este introduciendo tenga coherencia con el inventario 
        set message_text = 'el lote de inventario no existe';
    end if;
end$$


-- Actualizar inventario después de una entrada
drop trigger if exists trg_actualizar_entrada$$
create trigger trg_actualizar_entrada
after insert on entradas
for each row
begin
    update inventario
    set existencia = existencia + new.cantidad
    where id_inventario = new.id_inventario;
end$$


-- Validar y actualizar inventario después de una salida
drop trigger if exists trg_actualizar_salida$$
create trigger trg_actualizar_salida
before insert on salidas
for each row
begin
    declare v_existencia int;

    if new.cantidad <= 0 then
        signal sqlstate '45000'
        set message_text = 'la cantidad de salida debe ser mayor a cero';
    end if;

    select existencia
    into v_existencia
    from inventario
    where id_inventario = new.id_inventario
    for update;

    if v_existencia < new.cantidad then
        signal sqlstate '45000'
        set message_text = 'existencia insuficiente para realizar la salida';
    end if;

    update inventario
    set existencia = existencia - new.cantidad
    where id_inventario = new.id_inventario;
end$$

delimiter ;
