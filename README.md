
# Inventario de Farmacia - FarmaBase 

FarmaBase es un sistema de gestión de inventario para una farmacia. Permite administrar medicamentos, proveedores, personal, entradas, salidas y consultar reportes del inventario.

Este documento explica los requisitos y los pasos necesarios para crear la base de datos y ejecutar la aplicación.

## Requerimientos y herramientas utilizadas

Esta aplicación fue creada con las siguientes herramientas:

Sistema gestor de base de datos: MySQL

Conector de base de datos: MySql.Data (ADO.NET)

Administrador de base de datos: MySQL Workbench

Entorno de desarrollo: Microsoft Visual Studio Community

Marco de destino en MVSC: .NET 8.0

Lenguaje de programación: C#.

Interfaz gráfica: Windows Forms

### Pasos para crear la base de datos

- Abrir MySQL Workbench

- Conectarse al servidor local de MySQL

- Abrir y ejecutar los siguientes scripts en el orden indicado:


#### Paso 1

    01_esquemas.sql

Este sql es el que crea la base de datos farmacia y sus tablas, relaciones y sus respectivas restricciones

#### Paso 2

    02_datos.sql

Inserta los datos iniciales (15 registros para cada una) de medicamentos, proveedores, personal e inventario

#### Paso 3

    04_procedimientos.sql

Crea las funciones, procedimientos y triggers

#### Paso 4

    05_consultas.sql

Ejecuta consultas de ejemplo y crea las vistas utilizadas por los reportes

#### Paso 5

    03_seguridad.sql

Crea los roles, usuarios y permisos de acceso a la base de datos.

*Nota: Es necesario respetar este orden porque los permisos del script de seguridad dependen de los procedimientos y las vistas creados anteriormente*

Puede usar los siguientes comandos en otro query para confirmar que todo este bien

#### Uso general
use farmacia; \
show tables;

#### Esto ya es más para revisar que los permisos de los roles se hayan creado correctamente
select current_user(), current_role();

show grants;

show grants for 'rol_administrador';

call sp_login('leyla');

show procedure status \
where db = 'farmacia' \
and name = 'sp_registrar_entrada';


## Configurar la aplicación

Abrir el archivo FarmaciaApp.sln desde Microsoft Visual Studio.

Verificar que el proyecto utilice .NET 8.0

Comprobar que esté instalado el paquete NuGet MySql.Data. (IMPORTANTE PORQUE ES LO QUE PERMITE AL .NET CONECTARSE CON MYSQL)

Abrir el archivo App.config y verificar que las cadenas de conexión correspondan al servidor MySQL local:

    <?xml version="1.0" encoding="utf-8" ?>
    <configuration>
        <connectionStrings>
            <add name="Administrador"
                connectionString="server=localhost;database=farmacia;uid=admin;pwd=admin;CheckParameters=false;" />

            <add name="Encargado"
                connectionString="server=localhost;database=farmacia;uid=almacen;pwd=almacen;CheckParameters=false;" />

            <add name="Consulta"
                connectionString="server=localhost;database=farmacia;uid=auditor;pwd=auditor;CheckParameters=false;" />
        </connectionStrings>
    </configuration>

↑↑↑↑↑↑↑ Así se debe ver, sin errores ↑↑↑↑↑↑↑

Por último, ver que el servidor MySQL esté iniciado

## Ejecutar la aplicación

Abrir la solución FarmaciaApp.sln en Visual Studio.

Seleccionar el  como proyecto de inicio.

Ejecutar la aplicación e iniciar sesión con una cuenta registrada en la base de datos, como este es un proyecto pues tomamos 3 de los registros para las pruebas:

- PERFIL CON ROL ADMINISTRADOR (TODOS LOS PERMISOS): Usuario: leyla, Contraseña: leyla123

- PERFIL CON ROL ENCARGADO (PERMISOS DE LECTURA EN MEDICAMENTOS, PERSONAL, PROVEEDORES, INVENTARIO): Usuario: ramon, Contraseña: ramon123

- PERFIL CON ROL CONSULTA (PERMISO SOLO DE LECTURA EN EL APARTADO DE REPORTES (que es donde esta todo lo del 05_consultas)): Usuario: maria, Contraseña: maria123

Una vez iniciada la sesión, se mostrará el menú principal con las opciones disponibles según el rol del usuario (las que no esten disponibles estarán desactivadas)

## Script de transacciones

Por último, el 06_transacciones.sql es el que tiene los ejercicios para probar los niveles de aislamiento, las transacciones, COMMIT y ROLLBACK.

Este script es independiente de la instalación de la aplicación y puede ejecutarse por separado para realizar las pruebas correspondientes, además, se debe considerar que modifica el contenido de algunas tablas.

# FIN
