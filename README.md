# 🛒 Sistema de E-commerce — Projeto SQL + Python

## 📘 Descrição Geral

Este projeto implementa um **sistema de e-commerce** que gerencia clientes, vendedores, produtos e vendas utilizando **MySQL** como banco de dados e **Python** como interface de interação.

O sistema armazena informações sobre clientes (incluindo clientes especiais com cashback), vendedores, produtos e transportadoras.
Também possui funcionalidades de **gatilhos (triggers)**, **funções**, **usuários com permissões diferentes** e um **menu em Python** para interagir com o banco.

---

## 🧩 Estrutura do Banco de Dados

O modelo do banco segue o seguinte mini-mundo:

* Armazena dados dos **clientes**: `id`, `nome`, `idade`, `sexo`, `dataNascimento`
* Armazena **clientes especiais**, com as mesmas informações mais o **cashback disponível**
* Armazena dados dos **vendedores**: `id`, `nome`, `causaSocial`, `tipo`, `notaMedia`
* Armazena **produtos**: `id`, `nome`, `descricao`, `quantidadeEstoque`, `valor`, `observacoes`
* Cada **vendedor** pode ofertar vários produtos (relação 1:N)
* Cada **cliente** pode comprar vários produtos e cada produto pode ser vendido para vários clientes (relação N:N)
* Cada **venda** registra: data, hora, cliente, vendedor, produto e transportadora associada
* Armazena **transportadoras**: `id`, `nome`, `cidade`
* Cada venda tem endereço de destino e valor de transporte

---

## ⚙️ Funcionalidades Implementadas

### 🧱 Banco de Dados

* Criação completa do banco `ecommerce`
* Tabelas:

  * `Cliente`
  * `ClienteEspecial`
  * `Vendedor`
  * `Produto`
  * `CompraVenda`
  * `Transportadora`
* Inserção automática de **20 produtos**, **5 cargos** e **100 clientes nativos**

### 🔄 Triggers

1. Quando um **vendedor vender mais de R$ 1000,00**, ele é movido para a tabela de funcionários especiais e recebe um **bônus de 5%** do valor vendido.
2. Quando um **cliente comprar mais de R$ 500,00**, ele é adicionado à tabela de clientes especiais com **cashback de 2%** do valor gasto.
3. Quando o **cashback** de um cliente especial chegar a **zero**, ele é removido da tabela de clientes especiais.

### 🧮 Funções

* `arrecadado(dataHoje, idVendedor)` — retorna o total arrecadado por um vendedor em determinada data.

### 👥 Usuários do Banco

* **Administrador:** todas as permissões (`ALL PRIVILEGES`)
* **Gerente:** pode consultar, editar e apagar registros
* **Funcionário:** pode inserir novas vendas e consultar registros

---

## 🖥️ Sistema em Python

O script `menu_ecommerce.py` fornece uma interface de linha de comando que permite:

* Destruir o banco de dados (`DROP DATABASE`)
* Cadastrar produtos
* Cadastrar clientes
* (Opcional) Criar o banco e inserir os dados iniciais

### Exemplo de menu:

```
=== MENU DE OPÇÕES ===
0 - Sair
1 - Destruir banco de dados
2 - Cadastrar produto
3 - Cadastrar cliente
```

---

## 🧰 Requisitos

* **Python 3.10+**
* **MySQL 8+**
* Biblioteca:

  ```bash
  pip install mysql-connector-python
  ```

---

## ▶️ Execução

1. Abra o MySQL Workbench e crie o banco com o script `ecommerce.sql`
2. Execute o menu em Python:

   ```bash
   python menu_ecommerce.py
   ```
3. Escolha as opções no menu para cadastrar e manipular dados.

---

