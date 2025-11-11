DELIMITER $$

USE ecommerce $$

-- 5 cargos
INSERT INTO Cargo (nome) VALUES
('Gerente'),
('Vendedor'),
('Caixa'),
('Estoquista'),
('Supervisor') $$

-- 20 produtos
INSERT INTO Produto (nome, preco) VALUES
('Mouse', 59.90),
('Teclado', 129.90),
('Monitor', 899.00),
('Notebook', 3499.00),
('Cadeira Gamer', 999.00),
('Headset', 249.00),
('Webcam', 199.00),
('HD Externo', 399.00),
('Pendrive 64GB', 79.90),
('Smartphone', 2599.00),
('Carregador', 89.90),
('Cabo HDMI', 49.90),
('SSD 1TB', 499.00),
('Fonte 500W', 279.00),
('Placa de Vídeo', 1899.00),
('Teclado Mecânico', 349.00),
('Mousepad', 69.90),
('Controle USB', 149.00),
('Roteador Wi-Fi', 299.00),
('Microfone USB', 229.00) $$

-- 100 clientes nativos (gerados automaticamente)
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 100 DO
        INSERT INTO Cliente (nome, email)
        VALUES (
            CONCAT('Cliente ', i),
            CONCAT('cliente', i, '@exemplo.com')
        );
        SET i = i + 1;
    END WHILE;
END $$

DELIMITER ;
