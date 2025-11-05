import mysql.connector

def conectar():
    return mysql.connector.connect(
        host="localhost",        # ou 127.0.0.1
        user="root",             # seu usuário do MySQL
        password="SENHA_AQUI"    # substitui pela tua senha
    )

def destruir_banco():
    conexao = conectar()
    cursor = conexao.cursor()
    cursor.execute("DROP DATABASE IF EXISTS ecommerce;")
    conexao.commit()
    print("Banco de dados destruído com sucesso!")
    cursor.close()
    conexao.close()

def cadastrar_produto():
    conexao = conectar()
    cursor = conexao.cursor()
    cursor.execute("USE ecommerce;")
    nome = input("Digite o nome do produto: ")
    valor = float(input("Digite o valor do produto: "))
    descricao = input("Digite a descrição do produto: ")
    obs = input("Digite observações adicionais: ")
    cursor.execute("INSERT INTO Produto (nome, valor, descricao, obs) VALUES (%s, %s, %s, %s);", (nome, valor, descricao, obs))
    conexao.commit()
    print("Produto cadastrado com sucesso!")
    cursor.close()
    conexao.close()

def cadastrar_cliente():
    conexao = conectar()
    cursor = conexao.cursor()
    cursor.execute("USE ecommerce;")
    nome = input("Digite o nome do cliente: ")
    idade = int(input("Digite a idade do cliente: "))
    sexo = input("Digite o sexo do cliente (M/F): ")
    cursor.execute("INSERT INTO Cliente (nome, idade, sexo) VALUES (%s, %s, %s);", (nome, idade, sexo))
    conexao.commit()
    print("Cliente cadastrado com sucesso!")
    cursor.close()
    conexao.close()

