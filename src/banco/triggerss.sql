USE ecommerce;

DROP TRIGGER IF EXISTS vendedor_especial;
DROP TRIGGER IF EXISTS cliente_especial;
DROP TRIGGER IF EXISTS remove_cliente_especial;

DELIMITER $$

CREATE TRIGGER vendedor_especial
AFTER INSERT ON CompraVenda
FOR EACH ROW
BEGIN
   DECLARE total_vendas DECIMAL(12,2);
   DECLARE bonus_total DECIMAL(12,2);
   DECLARE mensagem VARCHAR(255);

   SELECT SUM(valorTotal) INTO total_vendas
   FROM CompraVenda
   WHERE idVendedor = NEW.idVendedor;

   IF total_vendas > 1000 THEN
       INSERT INTO FuncionarioEspecial (idVendedor, bonus)
       VALUES (NEW.idVendedor, total_vendas * 0.05)
       ON DUPLICATE KEY UPDATE bonus = total_vendas * 0.05;

       SELECT SUM(bonus) INTO bonus_total FROM FuncionarioEspecial;
       SET mensagem = CONCAT('Total de bônus necessário: R$ ', ROUND(IFNULL(bonus_total,0),2));
       INSERT INTO Notificacao (mensagem) VALUES (mensagem);
   END IF;
END$$

CREATE TRIGGER cliente_especial
AFTER INSERT ON CompraVenda
FOR EACH ROW
BEGIN
   DECLARE total_compras DECIMAL(12,2);
   DECLARE cashback_total DECIMAL(12,2);
   DECLARE mensagem VARCHAR(255);

   SELECT SUM(valorTotal) INTO total_compras
   FROM CompraVenda
   WHERE idCliente = NEW.idCliente;

   IF total_compras > 500 THEN
       INSERT INTO ClienteEspecial (id, cashBack)
       VALUES (NEW.idCliente, total_compras * 0.02)
       ON DUPLICATE KEY UPDATE cashBack = total_compras * 0.02;

       SELECT SUM(cashBack) INTO cashback_total FROM ClienteEspecial;
       SET mensagem = CONCAT('Total de cashback necessário: R$ ', ROUND(IFNULL(cashback_total,0),2));
       INSERT INTO Notificacao (mensagem) VALUES (mensagem);
   END IF;
END$$

CREATE TRIGGER remove_cliente_especial
AFTER DELETE ON ClienteEspecial
FOR EACH ROW
BEGIN
   INSERT INTO Notificacao (mensagem)
   VALUES (CONCAT('ClienteEspecial removido (ID ', OLD.id, ') foi excluído do programa de cashback.'));
END$$

DELIMITER ;
