use farmacia;

-- consultas con filtros
select id_medicamento, nombre, presentacion, precio, categoria
from medicamentos
where (nombre like concat('%', @texto, '%')
    or descripcion like concat('%', @texto, '%'))
  and categoria in ('analgésicos', 'antiinflamatorios', 'antibióticos');

select id_inventario, id_medicamento, lote, existencia, fecha_caducidad
from inventario
where existencia > @min_existencia
  and fecha_caducidad between @fecha_inicio and @fecha_fin;


-- reporte de salidas
select
    upper(tipo_salida) as tipo_salida,
    date_format(fecha_salida, '%y-%m') as mes_operacion,
    count(id_salida) as total_movimientos,
    sum(cantidad) as unidades_totales,
    cast(avg(cantidad) as decimal(10,2)) as promedio_por_movimiento
from salidas
group by tipo_salida, date_format(fecha_salida, '%y-%m')
having sum(cantidad) >= 10
order by unidades_totales desc, mes_operacion asc;


-- joins
-- aquí serían como las existencias de medicamentos jeje
select
    i.id_inventario,
    m.nombre as medicamento,
    m.presentacion,
    m.categoria,
    i.lote,
    i.existencia,
    i.fecha_caducidad,
    m.precio
from inventario i
inner join medicamentos m
    on i.id_medicamento = m.id_medicamento;


-- historial de las entradas al almacen (tipo bitacora mas o menos)
select
    e.id_entrada,
    e.fecha_entrada,
    m.nombre as medicamento,
    i.lote,
    e.cantidad,
    e.ubicacion_estanteria,
    p.nombre as proveedor,
    concat(per.nombre, ' ', per.apellido) as recibido_por
from entradas e
inner join inventario i
    on e.id_inventario = i.id_inventario
inner join medicamentos m
    on i.id_medicamento = m.id_medicamento
inner join proveedores p
    on e.id_proveedor = p.id_proveedor
inner join personal per
    on e.id_personal = per.id_personal;


-- salidas de farmacia (igual q lo de arriba pero ahora las salidas)
select
    s.id_salida,
    s.fecha_salida,
    m.nombre as medicamento,
    i.lote,
    s.cantidad,
    (s.cantidad * m.precio) as monto_estimado,
    s.justificacion,
    s.tipo_salida,
    concat(per.nombre, ' ', per.apellido) as atendido_por
from salidas s
inner join inventario i
    on s.id_inventario = i.id_inventario
inner join medicamentos m
    on i.id_medicamento = m.id_medicamento
inner join personal per
    on s.id_personal = per.id_personal;


-- empleados y salidas registradas
select
    per.id_personal,
    concat(per.nombre, ' ', per.apellido) as empleado,
    per.puesto,
    count(s.id_salida) as operaciones_realizadas,
    coalesce(sum(s.cantidad), 0) as piezas_despachadas
from personal per
left join salidas s
    on per.id_personal = s.id_personal
group by per.id_personal, per.nombre, per.apellido, per.puesto
order by piezas_despachadas desc;


-- subconsultas
-- medicamentos con precio superior al promedio
select id_medicamento, nombre, categoria, precio
from medicamentos
where precio > (
    select avg(precio)
    from medicamentos
)
order by precio desc;


-- lotes con existencia menor al promedio de sus salidas
select
    i.id_inventario,
    m.nombre as medicamento,
    i.lote,
    i.existencia
from inventario i
inner join medicamentos m
    on i.id_medicamento = m.id_medicamento
where i.existencia < (
    select coalesce(avg(s.cantidad), 0)
    from salidas s
    where s.id_inventario = i.id_inventario
);


-- vistas
create or replace view vw_estado_inventario as
select
    i.id_inventario,
    m.nombre as medicamento,
    m.categoria,
    i.lote,
    i.existencia,
    m.precio as precio_unitario,
    (i.existencia * m.precio) as valor_total_lote,
    i.fecha_caducidad,
    datediff(i.fecha_caducidad, curdate()) as dias_para_caducar
from inventario i
inner join medicamentos m
    on i.id_medicamento = m.id_medicamento;


create or replace view vw_resumen_proveedores as
select
    p.id_proveedor,
    p.nombre as proveedor,
    p.telefono,
    count(e.id_entrada) as total_entregas,
    coalesce(sum(e.cantidad), 0) as total_unidades_surtidas,
    max(e.fecha_entrada) as ultima_entrega
from proveedores p
left join entradas e
    on p.id_proveedor = e.id_proveedor
group by p.id_proveedor, p.nombre, p.telefono;


create or replace view vw_reporte_mermas as
select
    s.id_salida,
    s.fecha_salida,
    m.nombre as medicamento,
    i.lote,
    s.cantidad as unidades_perdidas,
    (s.cantidad * m.precio) as perdida_economica,
    s.tipo_salida,
    s.justificacion,
    concat(per.nombre, ' ', per.apellido) as responsable_registro
from salidas s
inner join inventario i
    on s.id_inventario = i.id_inventario
inner join medicamentos m
    on i.id_medicamento = m.id_medicamento
inner join personal per
    on s.id_personal = per.id_personal
where s.tipo_salida in ('caducidad', 'daño');
