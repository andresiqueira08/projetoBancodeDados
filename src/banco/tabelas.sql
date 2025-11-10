DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;

--Tabelas

CREATE TABLE Cliente (
   id INT PRIMARY KEY,
   nome VARCHAR(30),
   idade INT,
   sexo CHAR(1) CHECK (sexo = 'm' OR sexo = 'f' OR sexo = 'o'),
   dataNascimento DATE
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

CREATE TABLE FuncionarioEspecial (
   idVendedor INT PRIMARY KEY,
   bonus DOUBLE,
   FOREIGN KEY (idVendedor) REFERENCES Vendedor(id)
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
   quatidadeEstoque INT,
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
   destino VARCHAR(50),
   valorFrete DOUBLE,
   FOREIGN KEY (idCliente) REFERENCES Cliente(id),
   FOREIGN KEY (idVendedor) REFERENCES Vendedor(id),
   FOREIGN KEY (idProduto) REFERENCES Produto(id),
   FOREIGN KEY (idTransporte) REFERENCES Transportadora(id)
);

--A tabela Notificacao serve para registrar mensagens importantes geradas automaticamente pelos gatilhos (triggers).
CREATE TABLE Notificacao (
   id INT AUTO_INCREMENT PRIMARY KEY,
   mensagem VARCHAR(255),
   datahora DATETIME DEFAULT CURRENT_TIMESTAMP
);

--Papel interno
CREATE TABLE Cargo(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL CHECK(nome = 'Gerente' OR nome = 'CEO' OR nome = 'vendedor')
);