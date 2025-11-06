USE ecommerce;

--Implementação de 3 usuários

CREATE USER 'admin'@'%' IDENTIFIED BY 'admin123';
CREATE USER 'gerente'@'%' IDENTIFIED BY 'gerente123';
CREATE USER 'funcionario'@'%' IDENTIFIED BY 'func123';


GRANT ALL PRIVILEGES ON ecommerce.* TO 'admin'@'%';

GRANT SELECT, UPDATE, DELETE ON ecommerce.* TO 'gerente'@'%';
GRANT INSERT, SELECT ON ecommerce.CompraVenda TO 'funcionario'@'%';
GRANT SELECT ON ecommerce.Produto TO 'funcionario'@'%';
GRANT SELECT ON ecommerce.Cliente TO 'funcionario'@'%';
GRANT SELECT ON ecommerce.Vendedor TO 'funcionario'@'%';
FLUSH PRIVILEGES;