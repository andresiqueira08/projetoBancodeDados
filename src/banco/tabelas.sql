CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

CREATE TABLE Cliente (
    id INT PRIMARY KEY,
    nome VARCHAR(30),
    idade INT,
    sexo CHAR(1)
);

CREATE TABLE ClienteEspecial (
    id INT PRIMARY KEY,
    cashBack DOUBLE,
    FOREIGN KEY (id) REFERENCES Cliente(id)
);

CREATE TABLE Vendedor (
    id INT PRIMARY KEY,
    nome VARCHAR(50),
    causa VARCHAR(50),
    tipo VARCHAR(20),
    nota DOUBLE
);

CREATE TABLE Transportadora (
    id INT PRIMARY KEY,
    nome VARCHAR(50),
    cidade VARCHAR(50)
);

CREATE TABLE Produto (
    id INT PRIMARY KEY,
    nome VARCHAR(50),
    descricao VARCHAR(100),
    valor DOUBLE,
    obs TEXT
);

CREATE TABLE CompraVenda (
    id INT PRIMARY KEY,
    data DATE,
    hora TIME,
    idCliente INT,
    idVendedor INT,
    idProduto INT,
    idTransporte INT,
    FOREIGN KEY (idCliente) REFERENCES Cliente(id),
    FOREIGN KEY (idVendedor) REFERENCES Vendedor(id),
    FOREIGN KEY (idProduto) REFERENCES Produto(id),
    FOREIGN KEY (idTransporte) REFERENCES Transportadora(id)
);