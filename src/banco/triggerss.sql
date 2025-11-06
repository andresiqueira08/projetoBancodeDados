USE ecommerce;

--Triggers

DELIMITER $$
CREATE TRIGGER trg_vendedor_especial
AFTER INSERT ON CompraVenda
FOR EACH ROW
BEGIN
   DECLARE total_vendas DOUBLE;
   DECLARE bonus_total DOUBLE;
   DECLARE mensagem VARCHAR(255);
   SELECT SUM(p.valor)
   INTO total_vendas
   FROM CompraVenda cv
   INNER JOIN Produto p ON cv.idProduto = p.id
   WHERE cv.idVendedor = NEW.idVendedor;
   IF total_vendas > 1000 THEN
       INSERT INTO FuncionarioEspecial (idVendedor, bonus)
       VALUES (NEW.idVendedor, total_vendas * 0.05)
       ON DUPLICATE KEY UPDATE bonus = total_vendas * 0.05;
       SELECT SUM(bonus) INTO bonus_total FROM FuncionarioEspecial;
       SET mensagem = CONCAT('Total de bônus necessário: R$ ', ROUND(IFNULL(bonus_total, 0), 2));
       INSERT INTO Notificacao (mensagem) VALUES (mensagem);
   END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER trg_cliente_especial
AFTER INSERT ON CompraVenda
FOR EACH ROW
BEGIN
   DECLARE total_compras DOUBLE;
   DECLARE cashback_total DOUBLE;
   DECLARE mensagem VARCHAR(255);
   SELECT SUM(p.valor)
   INTO total_compras
   FROM CompraVenda cv
   INNER JOIN Produto p ON cv.idProduto = p.id
   WHERE cv.idCliente = NEW.idCliente;
   IF total_compras > 500 THEN
       INSERT INTO ClienteEspecial (id, cashBack)
       VALUES (NEW.idCliente, total_compras * 0.02)
       ON DUPLICATE KEY UPDATE cashBack = total_compras * 0.02;
       SELECT SUM(cashBack) INTO cashback_total FROM ClienteEspecial;
       SET mensagem = CONCAT('Total de cashback necessário: R$ ', ROUND(IFNULL(cashback_total, 0), 2));
       INSERT INTO Notificacao (mensagem) VALUES (mensagem);
   END IF;
END$$
DELIMITER ;


DROP TRIGGER IF EXISTS trg_remove_cliente_especial;
DELIMITER $$
CREATE TRIGGER trg_remove_cliente_especial
AFTER DELETE ON ClienteEspecial
FOR EACH ROW
BEGIN
   INSERT INTO Notificacao (mensagem)
   VALUES (CONCAT('ClienteEspecial removido id=', OLD.id, ' por cashback = 0'));
END$$
DELIMITER ;