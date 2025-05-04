# **Naming Conventions**

Este documento estipula la manera en que los nombres serán establecidos para los esquemas, tablas, vistas, columnas y otro tipo de objetos en la "data warehouse". 

## **Table of Contents**

1. [Generalidades](#generalidades)
2. [Nombres de tablas](#nombres-de-tablas)
   - [Reglas de la capa de Bronce](#reglas-de-la-capa-de-bronce)
   - [Reglas de la capa de Plata](#reglas-de-la-capa-de-plata)
   - [Reglas de la capa de Oro](#reglas-de-la-capa-de-oro)
3. [Nombramiento de columnas](#nombramiento-de-columnas)
   - [Llaves sustitutas](#llaves-sustitutas)
   - [Columnas técnicas](#columnas-técnicas)
4. [Procedimientos almacenados](#procedimientos-almacenados)
---

## **Generalidades**

- **Acuerdos de nombramientos**: Usar "snake_case", con letras minúsculas y giones bajos (`_`) para separar las palabras.
- **Lenguaje**: Se va a utilizar Inglés para nombrar las variables.
- **Evitar palabras reservadas**: No se pueden utilizar palabras reservadas de SQL para nombrar objetos.

## **Nombres de tablas**

### **Reglas de la capa de Bronce**
- Debido a que solo tenemos una fuente de origen los nombres no deben ser modificados.
- `<entidad>`: El nombre de la tabla debe ser idéntico al original.  
- Por ejemplo: `actor` → Información del actor.

### **Reglas de la capa de Plata**
- Los nombres de las entidades de la capa anterior no deben ser modificados.
- `<entidad>`: El nombre de la tabla debe ser idéntico al original.  
- Por ejemplo: `actor` → Información del actor.

### **Reglas de la capa de Oro**
- Todos los nombres deben ser significativos empezando con el prefijo de la categoría. Así mismo, los nombres de las tablas deben estar alineadas con el negocio.
- **`<categoria>_<entidad>`**  
  - `<categoria>`: Describe el rol de la tabla, como `dim` (dimension table) o `fact` (fact table).  
  - `<entidad>`: Nombre descriptivo de la tabla alineada al negocio (e.g., `films`, `customer`, `sales`).  
  - Examples:
    - `dim_customers` → "Dimension table" para los clientes.
    - `fact_sales` → "Fact table" que contiene los registros de las ventas.  

#### **Glosario de categorías**

| Prefijo     | Significado                      | Ejemplo(s)                              |
|-------------|----------------------------------|-----------------------------------------|
| `dim_`      | Dimension table                  | `dim_customer`, `dim_product`           |
| `fact_`     | Fact table                       | `fact_sales`                            |
| `report_`   | Report table                     | `report_customers`, `report_sales_monthly`   |

## **Nombramiento de columnas**

### **Llaves sustitutas**  
- Todas las llaves primarias en "Dimension tables" deberán tener el sufijo `_key`.
- **`<nombre_de_tabla>_key`**  
  - `<table_name>`: Hace referencia el nombre de la tabla o entidad a la que pertenece la llave.  
  - `_key`: El sufijo que indica que la columna es una llave sustituta.
  - Ejemplo: `customer_key` → Es la llave sustituta de la tabla `dim_customers`.
  
### **Columnas técnicas**
- Todas las columnas técnicas deben iniciar con el prefijo `dwh_`, seguido con un nombre descriptivo que indique el propósito de la columna
- **`dwh_<nombre_de_columna>`**  
  - `dwh`: Prefijo exclusivo para el metadata generado por los ingenieros y/o analistas de datos.  
  - `<column_name>`: Nombre descriptivo que indique el propósito de la columna.
  - Ejemplo: `dwh_load_date` → Columna generada artificialmente para almacenar la información de cuando el registro fue cargado.
 
## **Procedimientos almacenados**

- Todos los Procedimientos almacenados deberán tener el siguiente formato:
- **`load_<capa>`**.  
  - `<layer>`: Representa la capa a la que fue cargado, como `bronze`, `silver`, o `gold`.
  - Ejemplo: 
    - `load_bronze` → Procedimiento almacenado para la ingesta de data en la capa de Bronce.
    - `load_silver` → Procedimiento almacenado para la ingesta de data en la capa de Plata.
