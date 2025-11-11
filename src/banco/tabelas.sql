DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE Cliente (
   id INT AUTO_INCREMENT PRIMARY KEY,
   nome VARCHAR(50) NOT NULL,
   idade INT,
   sexo CHAR(1) CHECK (sexo IN ('m', 'f', 'o')),
   dataNascimento DATE
);

CREATE TABLE ClienteEspecial (
   id INT PRIMARY KEY,
   cashBack DECIMAL(10,2) DEFAULT 0,
   FOREIGN KEY (id) REFERENCES Cliente(id) ON DELETE CASCADE
);

CREATE TABLE Cargo (
   id INT AUTO_INCREMENT PRIMARY KEY,
   nome VARCHAR(50) NOT NULL
);

CREATE TABLE Vendedor (
   id INT AUTO_INCREMENT PRIMARY KEY,
   nome VARCHAR(50) NOT NULL,
   salario DECIMAL(10,2) DEFAULT 0,
   idCargo INT,
   nota DECIMAL(5,2) DEFAULT 0,
   FOREIGN KEY (idCargo) REFERENCES Cargo(id)
);

CREATE TABLE FuncionarioEspecial (
   idVendedor INT PRIMARY KEY,
   bonus DECIMAL(10,2) DEFAULT 0,
   FOREIGN KEY (idVendedor) REFERENCES Vendedor(id)
);

CREATE TABLE Transportadora (
   id INT AUTO_INCREMENT PRIMARY KEY,
   nome VARCHAR(50) NOT NULL,
   cidade VARCHAR(50)
);

CREATE TABLE Produto (
   id INT AUTO_INCREMENT PRIMARY KEY,
   nome VARCHAR(50) NOT NULL,
   descricao VARCHAR(255),
   valor DOUBLE NOT NULL,
   quantidadeEstoque INT DEFAULT 0,
   obs TEXT
);

CREATE TABLE CompraVenda (
   id INT AUTO_INCREMENT PRIMARY KEY,
   data DATE DEFAULT CURDATE(),
   hora TIME DEFAULT CURTIME(),
   idCliente INT,
   idVendedor INT,
   idProduto INT,
   idTransportadora INT,
   destino VARCHAR(100),
   quantidade INT DEFAULT 1,
   valorFrete DECIMAL(10,2) DEFAULT 0,
   valorTotal DECIMAL(12,2) AS (quantidade * (SELECT preco FROM Produto WHERE Produto.id = CompraVenda.idProduto)) STORED,
   FOREIGN KEY (idCliente) REFERENCES Cliente(id),
   FOREIGN KEY (idVendedor) REFERENCES Vendedor(id),
   FOREIGN KEY (idProduto) REFERENCES Produto(id),
   FOREIGN KEY (idTransportadora) REFERENCES Transportadora(id)
);

CREATE TABLE Notificacao (
   id INT AUTO_INCREMENT PRIMARY KEY,
   mensagem VARCHAR(255),
   datahora DATETIME DEFAULT CURRENT_TIMESTAMP
);
