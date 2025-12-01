CREATE TABLE Clientes (
  CustomerID STRING(36) NOT NULL,
  Name STRING(100),
  Email STRING(100)
) PRIMARY KEY (CustomerID);

CREATE TABLE Ordenes (
  OrderID STRING(36) NOT NULL,
  CustomerID STRING(36) NOT NULL,
  TotalAmount FLOAT64,
  CreatedAt TIMESTAMP OPTIONS (allow_commit_timestamp = true)
) PRIMARY KEY (OrderID);

ALTER TABLE Ordenes
ADD CONSTRAINT FK_Ordenes_Clientes
FOREIGN KEY (CustomerID) REFERENCES Clientes (CustomerID);
