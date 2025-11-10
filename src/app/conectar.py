import mysql.connector

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

# Criar banco de dados
def criar_banco(conexao):
    cursor = conexao.cursor()
    try:
        cursor.execute("CREATE DATABASE IF NOT EXISTS ecommerce;")
        print("Banco de dados criado com sucesso!")
    except mysql.connector.Error as err:
        print(f"Erro ao criar banco: {err}")
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

# Cadastrar produto
def cadastrar_produto(conexao):
    cursor = conexao.cursor()
    try:
        nome = input("Digite o nome do produto: ")
        valor = float(input("Digite o valor do produto: "))
        descricao = input("Digite a descrição do produto: ")
        obs = input("Digite observações adicionais: ")

        cursor.execute("""
            INSERT INTO Produto (nome, valor, descricao, obs)
            VALUES (%s, %s, %s, %s);
        """, (nome, valor, descricao, obs))
        conexao.commit()
        print("Produto cadastrado com sucesso!")
    except mysql.connector.Error as err:
        print(f"Erro ao cadastrar produto: {err}")
    finally:
        cursor.close()

# Cadastrar cliente
def cadastrar_cliente(conexao):
    cursor = conexao.cursor()
    try:
        nome = input("Digite o nome do cliente: ")
        idade = int(input("Digite a idade do cliente: "))
        sexo = input("Digite o sexo do cliente (M/F): ")

        cursor.execute("""
            INSERT INTO Cliente (nome, idade, sexo, dataNascimento)
            VALUES (%s, %s, %s, CURDATE());
        """, (nome, idade, sexo))
        conexao.commit()
        print("Cliente cadastrado com sucesso!")
    except mysql.connector.Error as err:
        print(f"Erro ao cadastrar cliente: {err}")
    finally:
        cursor.close()
