USE ecommerce;

--Procedimentos e funções

DELIMITER $$
CREATE FUNCTION calcula_idade(p_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
   DECLARE v_dataNasc DATE;
   SELECT dataNascimento INTO v_dataNasc FROM Cliente WHERE id = p_id;
   RETURN TIMESTAMPDIFF(YEAR, v_dataNasc, CURDATE());
END$$
DELIMITER ;
DELIMITER $$
CREATE FUNCTION soma_fretes(p_destino VARCHAR(50))
RETURNS DOUBLE
DETERMINISTIC
BEGIN
   DECLARE total DOUBLE;
   SELECT SUM(valorFrete) INTO total FROM CompraVenda WHERE destino = p_destino;
   RETURN IFNULL(total, 0);
END$$
DELIMITER ;
DELIMITER $$
CREATE FUNCTION arrecadado(p_data DATE, p_idVendedor INT)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
   DECLARE total DOUBLE;
   SELECT SUM(p.valor) INTO total
   FROM CompraVenda cv
   INNER JOIN Produto p ON cv.idProduto = p.id
   WHERE cv.idVendedor = p_idVendedor AND cv.data = p_data;
   RETURN IFNULL(total, 0);
END$$
DELIMITER ;
-- TRIGGER - VENDEDOR ESPECIAL --------------------------------
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
