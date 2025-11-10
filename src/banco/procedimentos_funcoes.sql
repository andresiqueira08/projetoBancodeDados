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

