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

CREATE FUNCTION soma_fretes(p_destino VARCHAR(100))
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
   DECLARE total DECIMAL(12,2);
   SELECT SUM(valorFrete) INTO total FROM CompraVenda WHERE destino = p_destino;
   RETURN IFNULL(total, 0);
END$$

CREATE FUNCTION arrecadado(p_data DATE, p_idVendedor INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
   DECLARE total DECIMAL(12,2);
   SELECT SUM(valorTotal) INTO total
   FROM CompraVenda
   WHERE idVendedor = p_idVendedor AND data = p_data;
   RETURN IFNULL(total, 0);
END$$

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
    DECLARE valor_voucher DECIMAL(10,2);

    SELECT id INTO cliente_id
    FROM Cliente
    ORDER BY RAND()
    LIMIT 1;

    IF EXISTS (SELECT 1 FROM ClienteEspecial WHERE id = cliente_id) THEN
        SET valor_voucher = 200;
    ELSE
        SET valor_voucher = 100;
    END IF;

    INSERT INTO Notificacao (mensagem)
    VALUES (CONCAT('Cliente sorteado (ID ', cliente_id, ') recebeu um voucher de R$ ', valor_voucher));
END //

CREATE PROCEDURE registrar_venda(IN p_id INT, IN p_data DATE, IN p_hora TIME, IN p_idCliente INT, IN p_idVendedor INT, IN p_idProduto INT, IN p_idTransportadora INT, IN p_quantidade INT, IN p_valorFrete DECIMAL(10,2))
BEGIN
    -- insere venda (id auto_increment se p_id for NULL ou 0, aqui o script recebe id manualmente; se preferir AUTO_INCREMENT, chame com p_id = NULL e adapte)
    INSERT INTO CompraVenda (data, hora, idCliente, idVendedor, idProduto, idTransportadora, destino, quantidade, valorFrete)
    VALUES (p_data, p_hora, p_idCliente, p_idVendedor, p_idProduto, p_idTransportadora, '', p_quantidade, p_valorFrete);

    -- atualiza estoque
    UPDATE Produto
    SET quantidadeEstoque = quantidadeEstoque - p_quantidade
    WHERE id = p_idProduto;

    INSERT INTO Notificacao (mensagem)
    VALUES (CONCAT('Venda registrada - Produto ID ', p_idProduto, ' Qtd: ', p_quantidade));
END //

CREATE PROCEDURE estatisticas()
BEGIN
    SELECT 
        p.nome AS produto,
        v.nome AS vendedor,
        SUM(cv.quantidade) AS total_itens_vendidos,
        SUM(cv.valorTotal) AS valor_total_vendido,
        MONTH(cv.data) AS mes
    FROM CompraVenda cv
    JOIN Produto p ON cv.idProduto = p.id
    JOIN Vendedor v ON cv.idVendedor = v.id
    GROUP BY p.id, mes
    ORDER BY valor_total_vendido DESC;
END //

DELIMITER ;
