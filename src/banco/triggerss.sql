DELIMITER $$
CREATE TRIGGER bonus_vendedor
AFTER INSERT
ON CompraVenda
FOR EACH ROW
BEGIN
    DECLARE total_vendas DOUBLE;
    DECLARE MESSAGE_TEXT TEXT;

    -- Soma tudo que o vendedor já vendeu
    SELECT SUM(p.valor)
    INTO total_vendas
    FROM CompraVenda cv
    JOIN Produto p ON cv.idProduto = p.id
    WHERE cv.idVendedor = NEW.idVendedor;

    -- Se passou de 1000, adiciona à tabela de funcionário especial
    IF total_vendas > 1000 THEN
        INSERT INTO FuncionarioEspecial (idVendedor, bonus)
        VALUES (NEW.idVendedor, total_vendas * 0.05);
	-- Um "Print" em SQL
        SIGNAL SQLSTATE '01000';
        SET MESSAGE_TEXT = CONCAT('Bônus total de R$', total_vendas * 0.05, ' será necessário para custear.');
    END IF;
END $$

CREATE TRIGGER cashBackCliente
AFTER INSERT
ON CompraVenda
FOR EACH ROW
BEGIN
	DECLARE totalCompras DOUBLE;
    DECLARE cashback DOUBLE;
    DECLARE message TEXT;
    
    SELECT SUM(p.compras)
    INTO totalCompras
    FROM CompraVenda cv
    JOIN Produto p ON cv.idProduto = p.id
    WHERE cv.idCliente = NEW.idCliente;
    
    IF totalCompras > 500 THEN
		SET cashback = totalCompras * 0.02;
        
		INSERT INTO ClienteEspecial(id, cashback)
        VALUES(NEW.idCliente, cashback)
        ON DUPLICATE KEY UPDATE cashback = cashback;
        
        SIGNAL SQLSTATE '01000';
        SET message = CONCAT('Valor de cashback total: R$', cashback);
        
        END IF;
	END $$
    
  DELIMITER $$

CREATE TRIGGER remove_cliente_especial
BEFORE UPDATE
ON ClienteEspecial
FOR EACH ROW
BEGIN
    IF NEW.cashBack <= 0 THEN
        DELETE FROM ClienteEspecial WHERE id = OLD.id;
        SIGNAL SQLSTATE '01000'
        SET MESSAGE_TEXT = 'Cliente removido da tabela de clientes especiais (cashback zerado).';
    END IF;
END $$

DELIMITER ;