CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

DROP USER IF EXISTS 'admin'@'%';
DROP USER IF EXISTS 'gerente'@'%';
DROP USER IF EXISTS 'funcionario'@'%';

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin123';
CREATE USER 'gerente'@'%' IDENTIFIED BY 'gerente123';
CREATE USER 'funcionario'@'%' IDENTIFIED BY 'func123';

GRANT ALL PRIVILEGES ON ecommerce.* TO 'admin'@'host' WITH GRANT OPTION;

-- gerente pode ler/escrever em tabelas principais
GRANT SELECT, INSERT, UPDATE, DELETE ON ecommerce.* TO 'gerente'@'%';

-- funcionário: pode inserir vendas e consultar tabelas; também permitir inserir cliente se desejar
GRANT INSERT ON ecommerce.CompraVenda TO 'funcionario'@'%';
GRANT SELECT ON ecommerce.* TO 'funcionario'@'%';
GRANT INSERT ON ecommerce.Cliente TO 'funcionario'@'%';

FLUSH PRIVILEGES;
