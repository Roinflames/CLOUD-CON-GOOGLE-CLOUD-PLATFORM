# 🟦 Taller 1: Introducción y Puesta en Marcha con Cloud Spanner
## 🎯 Objetivo del Taller

Que el estudiante sea capaz de:

Crear una instancia y base de datos en Cloud Spanner.

Definir un esquema básico (tablas y claves).

Insertar, consultar y actualizar datos.

Comprender cómo Spanner maneja consistencia y escalabilidad.

# 📝 Parte 1: Preparación del Entorno
## 1. Habilitar la API de Spanner

En Google Cloud Console:
APIs & Services → Enable APIs → Cloud Spanner API

## 2. Crear una instancia

Ir a: Spanner → Instances → Create Instance

Nombre: instancia-taller1

ID: instancia-taller1

Config: Regional (us-central1)

Processing units: 100 (o 1 node si la cuenta lo permite)

# 🧱 Parte 2: Crear la Base de Datos
Crear base de datos:

Nombre: taller_cloud_spanner

Esquema inicial:
CREATE TABLE Customers (
  CustomerID STRING(36) NOT NULL,
  Name STRING(100),
  Email STRING(100),
) PRIMARY KEY (CustomerID);

CREATE TABLE Orders (
  OrderID STRING(36) NOT NULL,
  CustomerID STRING(36) NOT NULL,
  TotalAmount FLOAT64,
  CreatedAt TIMESTAMP OPTIONS (allow_commit_timestamp = true),
) PRIMARY KEY (OrderID),
INTERLEAVE IN PARENT Customers ON DELETE CASCADE;

# 📥 Parte 3: Insertar Datos (DML)
Insertar clientes
INSERT INTO Customers (CustomerID, Name, Email)
VALUES ("CUST-001", "Juan Pérez", "juan@example.com"),
       ("CUST-002", "Ana Gómez", "ana@example.com");

Insertar órdenes
INSERT INTO Orders (OrderID, CustomerID, TotalAmount, CreatedAt)
VALUES ("ORD-1001", "CUST-001", 12500, PENDING_COMMIT_TIMESTAMP()),
       ("ORD-1002", "CUST-002", 8400, PENDING_COMMIT_TIMESTAMP());

# 🔍 Parte 4: Consultas
## 1. Obtener todos los clientes:
SELECT * FROM Customers;

## 2. Obtener las órdenes de un cliente:
SELECT c.Name, o.OrderID, o.TotalAmount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.CustomerID = "CUST-001";

## 3. Total general de ventas:
SELECT SUM(TotalAmount) AS TotalVentas FROM Orders;

## ✏️ Parte 5: Actualizar Datos

Modificar correo de un cliente:

UPDATE Customers
SET Email = "juanperez@example.com"
WHERE CustomerID = "CUST-001";

## 🗑️ Parte 6: Eliminar Registros
DELETE FROM Customers
WHERE CustomerID = "CUST-002";


(Se eliminarán automáticamente sus Orders gracias a INTERLEAVE + ON DELETE CASCADE)

# 💡 Preguntas de Reflexión (para entregar o discutir)

¿Qué ventaja tiene INTERLEAVE en Cloud Spanner?

¿Por qué Spanner usa claves primarias basadas en ordenamiento lexicográfico?

¿Qué diferencia a Spanner de MySQL/SQL Server en cuanto a consistencia distribuida?

Explica qué hace PENDING_COMMIT_TIMESTAMP().

# 📦 Entrega del Taller

Formato recomendado (puede dejarse como instrucción al estudiante):

Archivo PDF o Word con:

Capturas de instancia

Código SQL utilizado

Resultados de consultas

Respuestas a preguntas de reflexión