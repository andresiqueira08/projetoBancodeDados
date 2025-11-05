USE ecommerce;


DELIMITER $$

CREATE FUNCTION calcular_idade(idUsuario INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE dataNasc DATE;
    DECLARE idadeCalculada INT;

    SELECT dataNascimento INTO dataNasc
    FROM Cliente
    WHERE id = idUsuario;

    SET idadeCalculada = TIMESTAMPDIFF(YEAR, dataNasc, CURDATE());

    RETURN idadeCalculada;
END $$

DELIMITER ;

CREATE FUNCTION arrecadado(dataHoje DATE, idVendedor INT)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
	DECLARE total DOUBLE;
    SELECT SUM(p.valor)
    INTO total
    FROM CompraVenda cv
    JOIN produto p ON cv.idProduto = p.id
		WHERE cv.idVendedor = idVend
        AND cv.dataCompra = dataHoje;
	RETURN IFNULL(total, 0);
END $$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION somaFrete(destino VARCHAR(30))
RETURNS DOUBLE
DETERMINISTIC
BEGIN
	DECLARE TOTAL DOUBLE;
	SELECT SUM(p.valor)
    INTO total 
    FROM CompraVenda cv
    JOIN Produto p ON cv.idProduto = p.id
    JOIN Transportadora t ON cv.idTransporte = t.id
		WHERE t.cidade = destino;
	RETURN IFNULL(total, 0);
END $$

DELIMITER ;
    