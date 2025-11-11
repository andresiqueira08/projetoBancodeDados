USE ecommerce;


DELIMITER $$

CREATE FUNCTION calcula_idade(p_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
   DECLARE v_dataNasc DATE;
   SELECT dataNascimento INTO v_dataNasc FROM Cliente WHERE id = p_id;
   RETURN TIMESTAMPDIFF(YEAR, v_dataNasc, CURDATE());
END$$

CREATE FUNCTION soma_fretes(p_destino VARCHAR(50))
RETURNS DOUBLE
DETERMINISTIC
BEGIN
   DECLARE total DOUBLE;
   SELECT SUM(valorFrete) INTO total FROM CompraVenda WHERE destino = p_destino;
   RETURN IFNULL(total, 0);
END$$

CREATE FUNCTION arrecadado(p_data DATE, p_idVendedor INT)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
   DECLARE total DOUBLE;
   SELECT SUM(p.preco) INTO total
   FROM CompraVenda cv
   INNER JOIN Produto p ON cv.idProduto = p.id
   WHERE cv.idVendedor = p_idVendedor AND cv.data = p_data;
   RETURN IFNULL(total, 0);
END$$

DELIMITER ;


DELIMITER //

CREATE PROCEDURE reajuste_salario(IN percentual DOUBLE, IN categoria VARCHAR(50))
BEGIN
    UPDATE Vendedor v
    JOIN Cargo c ON v.idCargo = c.id
    SET v.salario = v.salario + (v.salario * (percentual / 100))
    WHERE c.nome = categoria;

    INSERT INTO Notificacao (mensagem)
    VALUES (CONCAT('Reajuste de ', percentual, '% aplicado à categoria ', categoria));
END //
  
CREATE PROCEDURE sorteio_cliente()
BEGIN
    DECLARE cliente_id INT;
    DECLARE valor_voucher DOUBLE DEFAULT 100;

    SELECT id INTO cliente_id
    FROM Cliente
    ORDER BY RAND()
    LIMIT 1;

    INSERT INTO Notificacao (mensagem)
    VALUES (CONCAT('Cliente sorteado (ID ', cliente_id, ') recebeu um voucher de R$ ', valor_voucher));
END //
  
CREATE PROCEDURE registrar_venda(IN id_produto INT, IN id_cliente INT, IN id_vendedor INT, IN destino VARCHAR(50), IN valorFrete DOUBLE)
BEGIN
    -- Registra a venda
    INSERT INTO CompraVenda (idProduto, idCliente, idVendedor, data, destino, valorFrete)
    VALUES (id_produto, id_cliente, id_vendedor, CURDATE(), destino, valorFrete);

    -- Atualiza o estoque do produto
    UPDATE Produto
    SET quantidade = quantidade - 1
    WHERE id = id_produto;

    INSERT INTO Notificacao (mensagem)
    VALUES (CONCAT('Venda registrada - Produto ID ', id_produto, ' teve estoque reduzido.'));
END //

CREATE PROCEDURE estatisticas()
BEGIN
    SELECT 
        p.nome AS produto,
        v.nome AS vendedor,
        COUNT(cv.idProduto) AS total_vendido,
        SUM(p.preco) AS valor_total,
        MONTH(cv.data) AS mes
    FROM CompraVenda cv
    JOIN Produto p ON cv.idProduto = p.id
    JOIN Vendedor v ON cv.idVendedor = v.id
    GROUP BY p.id, mes
    ORDER BY total_vendido DESC;
END //

DELIMITER ;

