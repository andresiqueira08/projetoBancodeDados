import mysql.connector

def conectar():
    user = input("Usuário do MySQL: ")
    senha = input("Senha do MySQL: ")

    try:
        conexao = mysql.connector.connect(
            host="localhost",
            user=user,
            password=senha,
            database="ecommerce"
        )
        print(f"Conectado ao banco como {user}.")
        return conexao
    except mysql.connector.Error as err:
        print(f"Erro ao conectar: {err}")
        return None


def criar_banco(conexao):
    cursor = conexao.cursor()
    cursor.execute("DROP DATABASE IF EXISTS ecommerce;")
    cursor.execute("CREATE DATABASE ecommerce;")
    cursor.execute("USE ecommerce;")
    print("Banco criado. Agora rode o script SQL no Workbench para criar tabelas, functions e triggers.")
    cursor.close()


def destruir_banco(conexao):
    cursor = conexao.cursor()
    cursor.execute("DROP DATABASE IF EXISTS ecommerce;")
    print("Banco destruído.")
    cursor.close()


def cadastrar_produto(conexao):
    cursor = conexao.cursor()
    idp = int(input("ID do produto: "))
    nome = input("Nome: ")
    descricao = input("Descrição: ")
    valor = float(input("Preço: "))
    obs = input("Observações: ")

    cursor.execute("""
        INSERT INTO Produto (id, nome, descricao, valor, obs)
        VALUES (%s, %s, %s, %s, %s);
    """, (idp, nome, descricao, valor, obs))
    conexao.commit()
    print("Produto cadastrado.")
    cursor.close()


def cadastrar_cliente(conexao):
    cursor = conexao.cursor()
    idc = int(input("ID do cliente: "))
    nome = input("Nome: ")
    idade = int(input("Idade: "))
    sexo = input("Sexo (m/f/o): ").lower()
    nascimento = input("Data de nascimento (YYYY-MM-DD): ")

    cursor.execute("""
        INSERT INTO Cliente (id, nome, idade, sexo, dataNascimento)
        VALUES (%s, %s, %s, %s, %s);
    """, (idc, nome, idade, sexo, nascimento))
    conexao.commit()
    print("Cliente cadastrado.")
    cursor.close()


def cadastrar_vendedor(conexao):
    cursor = conexao.cursor()
    idv = int(input("ID do vendedor: "))
    nome = input("Nome: ")
    causa = input("Causa social: ")
    tipo = input("Tipo (ex: PF, PJ): ")
    nota = float(input("Nota: "))

    cursor.execute("""
        INSERT INTO Vendedor (id, nome, causa, tipo, nota)
        VALUES (%s, %s, %s, %s, %s);
    """, (idv, nome, causa, tipo, nota))
    conexao.commit()
    print("Vendedor cadastrado.")
    cursor.close()


def cadastrar_transportadora(conexao):
    cursor = conexao.cursor()
    idt = int(input("ID da transportadora: "))
    nome = input("Nome: ")
    cidade = input("Cidade: ")

    cursor.execute("""
        INSERT INTO Transportadora (id, nome, cidade)
        VALUES (%s, %s, %s);
    """, (idt, nome, cidade))
    conexao.commit()
    print("Transportadora cadastrada.")
    cursor.close()


def registrar_venda(conexao):
    cursor = conexao.cursor()
    idvenda = int(input("ID da venda (ou 0 para auto): "))
    data = input("Data (YYYY-MM-DD): ")
    hora = input("Hora (HH:MM:SS): ")
    idc = int(input("ID do cliente: "))
    idvend = int(input("ID do vendedor: "))
    idp = int(input("ID do produto: "))
    idt = int(input("ID da transportadora: "))
    destino = input("Destino: ")
    qtd = int(input("Quantidade: "))
    frete = float(input("Valor do frete: "))

    # se quiser usar id auto_increment, pode passar NULL; aqui vamos inserir sem id (auto)
    cursor.execute("""
        INSERT INTO CompraVenda (data, hora, idCliente, idVendedor, idProduto, idTransportadora, destino, quantidade, valorFrete)
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s);
    """, (data, hora, idc, idvend, idp, idt, destino, qtd, frete))
    conexao.commit()
    print("Venda registrada.")
    cursor.close()


def calcular_idade(conexao):
    cursor = conexao.cursor()
    idc = int(input("ID do cliente: "))
    cursor.execute("SELECT calcula_idade(%s)", (idc,))
    result = cursor.fetchone()
    print("Idade:", result[0] if result else "N/A")
    cursor.close()


def soma_fretes(conexao):
    cursor = conexao.cursor()
    destino = input("Destino: ")
    cursor.execute("SELECT soma_fretes(%s)", (destino,))
    result = cursor.fetchone()
    print("Total de fretes:", result[0] if result else 0)
    cursor.close()


def arrecadado(conexao):
    cursor = conexao.cursor()
    data = input("Data (YYYY-MM-DD): ")
    idv = int(input("ID do vendedor: "))
    cursor.execute("SELECT arrecadado(%s, %s)", (data, idv))
    result = cursor.fetchone()
    print("Total arrecadado:", result[0] if result else 0)
    cursor.close()


def listar_notificacoes(conexao):
    cursor = conexao.cursor()
    cursor.execute("SELECT mensagem, datahora FROM Notificacao ORDER BY id DESC;")
    for (msg, dt) in cursor.fetchall():
        print(f"[{dt}] {msg}")
    cursor.close()

