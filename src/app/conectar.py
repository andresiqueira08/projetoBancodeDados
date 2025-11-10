import mysql.connector
from datetime import datetime, date

# Função de conexão
def conectar(usuario, senha):
    try:
        conexao = mysql.connector.connect(
            host="localhost",
            user=usuario,
            password=senha,
            database="ecommerce"
        )
        print(f"Conectado como {usuario}")
        return conexao
    except mysql.connector.Error as err:
        print(f"Erro ao conectar: {err}")
        return None

# Criar banco de dados COMPLETO com todas as tabelas
def criar_banco(conexao):
    cursor = conexao.cursor()
    try:
        # Primeiro criar o banco se não existir
        cursor.execute("CREATE DATABASE IF NOT EXISTS ecommerce;")
        cursor.execute("USE ecommerce;")
        print("Banco de dados criado com sucesso!")
        
        # Agora criar todas as tabelas conforme seu schema
        tabelas = [
            """
            CREATE TABLE IF NOT EXISTS Cliente (
               id INT AUTO_INCREMENT PRIMARY KEY,
               nome VARCHAR(30),
               idade INT,
               sexo CHAR(1) CHECK (sexo = 'm' OR sexo = 'f' OR sexo = 'o'),
               dataNascimento DATE
            );
            """,
            """
            CREATE TABLE IF NOT EXISTS ClienteEspecial (
               id INT PRIMARY KEY,
               cashBack DOUBLE,
               FOREIGN KEY (id) REFERENCES Cliente(id)
            );
            """,
            """
            CREATE TABLE IF NOT EXISTS Vendedor (
               id INT AUTO_INCREMENT PRIMARY KEY,
               nome VARCHAR(50),
               causa VARCHAR(50),
               tipo VARCHAR(20),
               nota DOUBLE
            );
            """,
            """
            CREATE TABLE IF NOT EXISTS FuncionarioEspecial (
               idVendedor INT PRIMARY KEY,
               bonus DOUBLE,
               FOREIGN KEY (idVendedor) REFERENCES Vendedor(id)
            );
            """,
            """
            CREATE TABLE IF NOT EXISTS Transportadora (
               id INT AUTO_INCREMENT PRIMARY KEY,
               nome VARCHAR(50),
               cidade VARCHAR(50)
            );
            """,
            """
            CREATE TABLE IF NOT EXISTS Produto (
               id INT AUTO_INCREMENT PRIMARY KEY,
               nome VARCHAR(50),
               descricao VARCHAR(100),
               valor DOUBLE,
               quatidadeEstoque INT,
               obs TEXT
            );
            """,
            """
            CREATE TABLE IF NOT EXISTS CompraVenda (
               id INT AUTO_INCREMENT PRIMARY KEY,
               data DATE,
               hora TIME,
               idCliente INT,
               idVendedor INT,
               idProduto INT,
               idTransporte INT,
               destino VARCHAR(50),
               valorFrete DOUBLE,
               FOREIGN KEY (idCliente) REFERENCES Cliente(id),
               FOREIGN KEY (idVendedor) REFERENCES Vendedor(id),
               FOREIGN KEY (idProduto) REFERENCES Produto(id),
               FOREIGN KEY (idTransporte) REFERENCES Transportadora(id)
            );
            """,
            """
            CREATE TABLE IF NOT EXISTS Notificacao (
               id INT AUTO_INCREMENT PRIMARY KEY,
               mensagem VARCHAR(255),
               datahora DATETIME DEFAULT CURRENT_TIMESTAMP
            );
            """,
            """
            CREATE TABLE IF NOT EXISTS Cargo(
                id INT AUTO_INCREMENT PRIMARY KEY,
                nome VARCHAR(50) NOT NULL CHECK(nome = 'Gerente' OR nome = 'CEO' OR nome = 'vendedor')
            );
            """
        ]
        
        for tabela in tabelas:
            cursor.execute(tabela)
        
        print("Todas as tabelas criadas com sucesso!")
        
    except mysql.connector.Error as err:
        print(f"Erro ao criar banco/tabelas: {err}")
    finally:
        cursor.close()

# Destruir banco de dados
def destruir_banco(conexao):
    cursor = conexao.cursor()
    try:
        cursor.execute("DROP DATABASE IF EXISTS ecommerce;")
        print("Banco de dados destruído com sucesso!")
    except mysql.connector.Error as err:
        print(f"Erro ao destruir banco: {err}")
    finally:
        cursor.close()

# Cadastrar produto CORRIGIDO
def cadastrar_produto(conexao):
    cursor = conexao.cursor()
    try:
        nome = input("Digite o nome do produto: ")
        valor = float(input("Digite o valor do produto: "))
        descricao = input("Digite a descrição do produto: ")
        quantidade = int(input("Digite a quantidade em estoque: "))
        obs = input("Digite observações adicionais: ")

        cursor.execute("""
            INSERT INTO Produto (nome, valor, descricao, quatidadeEstoque, obs)
            VALUES (%s, %s, %s, %s, %s);
        """, (nome, valor, descricao, quantidade, obs))
        conexao.commit()
        print("Produto cadastrado com sucesso!")
    except ValueError:
        print("Erro: Valor e quantidade devem ser números válidos!")
    except mysql.connector.Error as err:
        print(f"Erro ao cadastrar produto: {err}")
    finally:
        cursor.close()

# Cadastrar cliente CORRIGIDO
def cadastrar_cliente(conexao):
    cursor = conexao.cursor()
    try:
        nome = input("Digite o nome do cliente: ")
        idade = int(input("Digite a idade do cliente: "))
        sexo = input("Digite o sexo do cliente (M/F/O): ").lower()  # Converter para minúsculo
        
        # Validar sexo conforme CHECK constraint
        if sexo not in ['m', 'f', 'o']:
            print("Erro: Sexo deve ser M, F ou O")
            return
        
        # Calcular data de nascimento baseada na idade (mais realista que CURDATE())
        ano_nascimento = datetime.now().year - idade
        data_nascimento = date(ano_nascimento, 1, 1)  # 1º de janeiro do ano calculado

        cursor.execute("""
            INSERT INTO Cliente (nome, idade, sexo, dataNascimento)
            VALUES (%s, %s, %s, %s);
        """, (nome, idade, sexo, data_nascimento))
        conexao.commit()
        print("Cliente cadastrado com sucesso!")
    except ValueError:
        print("Erro: Idade deve ser um número inteiro!")
    except mysql.connector.Error as err:
        print(f"Erro ao cadastrar cliente: {err}")
    finally:
        cursor.close()
