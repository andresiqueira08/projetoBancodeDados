USE ecommerce;

-- View 1: Vendas por Vendedor e Produto
CREATE OR REPLACE VIEW viewVendasPorVendedorProduto AS
SELECT 
    v.nome AS vendedor,
    p.nome AS produto,
    COUNT(cv.id) AS total_vendas,
    SUM(p.quantidadeEstoque) AS total_itens_vendidos,  -- ajustado para existir no seu schema
    SUM(p.preco) AS valor_total_vendas,
    AVG(p.preco) AS valor_medio_venda
FROM CompraVenda cv
JOIN Vendedor v ON cv.idVendedor = v.id
JOIN Produto p ON cv.idProduto = p.id
GROUP BY v.id, v.nome, p.id, p.nome
ORDER BY valor_total_vendas DESC;


-- View 2: Clientes Especiais e suas Compras
CREATE OR REPLACE VIEW viewClientesEspeciaisCompras AS
SELECT 
    c.nome AS cliente,
    ce.cashBack,
    COUNT(cv.id) AS total_compras,
    SUM(p.preco) AS valor_total_gasto,
    MAX(cv.data) AS ultima_compra
FROM Cliente c
JOIN ClienteEspecial ce ON c.id = ce.id
LEFT JOIN CompraVenda cv ON c.id = cv.idCliente
LEFT JOIN Produto p ON cv.idProduto = p.id
GROUP BY c.id, c.nome, ce.cashBack
ORDER BY valor_total_gasto DESC;


-- View 3: Produtos mais vendidos
CREATE OR REPLACE VIEW viewProdutosMaisVendidos AS
SELECT 
    p.id AS idProduto,
    p.nome AS produto,
    p.preco AS valor_unitario,
    COUNT(cv.id) AS total_vendas,
    SUM(p.preco) AS valor_total_vendido,
    MAX(cv.data) AS ultima_venda
FROM Produto p
LEFT JOIN CompraVenda cv ON p.id = cv.idProduto
GROUP BY p.id, p.nome, p.preco
ORDER BY total_vendas DESC, valor_total_vendido DESC;
