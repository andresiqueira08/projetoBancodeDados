USE ecommerce;

CREATE VIEW viewVendasPorVendedorProduto AS
SELECT 
    v.nome AS vendedor,
    p.nome AS produto,
    COUNT(cv.idCompraVenda) AS total_vendas,
    SUM(cv.quantidade) AS total_itens_vendidos,
    SUM(cv.valorTotal) AS valor_total_vendas,
    AVG(cv.valorTotal) AS valor_medio_venda
FROM CompraVenda cv
JOIN Vendedor v ON cv.idVendedor = v.idVendedor
JOIN Produto p ON cv.idProduto = p.idProduto
GROUP BY v.idVendedor, v.nome, p.idProduto, p.nome
ORDER BY valor_total_vendas DESC;

CREATE VIEW viewClientesEspeciaisCompras AS
SELECT 
    c.nome AS cliente,
    ce.cashBack,
    ce.nivel,
    COUNT(cv.idCompraVenda) AS total_compras,
    SUM(cv.valorTotal) AS valor_total_gasto,
    MAX(cv.data) AS ultima_compra
FROM Cliente c
JOIN ClienteEspecial ce ON c.idCliente = ce.idCliente
LEFT JOIN CompraVenda cv ON c.idCliente = cv.idCliente
GROUP BY c.idCliente, c.nome, c.email, ce.cashBack, ce.nivel
ORDER BY valor_total_gasto DESC;