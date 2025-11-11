import mysql.connector
from conectar import (
    conectar,
    criar_banco,
    destruir_banco,
    cadastrar_produto,
    cadastrar_cliente,
    cadastrar_vendedor,
    cadastrar_transportadora,
    registrar_venda,
    calcular_idade,
    soma_fretes,
    arrecadado,
    listar_notificacoes
)

print("=== LOGIN NO SISTEMA ===")
usuario = input("Usuário (admin, gerente, funcionario): ")
senha = input("Senha: ")

conexao = conectar(usuario, senha)
if not conexao:
    exit()

while True:
    print("\n=== MENU DE OPÇÕES ===")
    print("0 - Sair")

    if usuario == "admin":
        print("1 - Criar banco de dados")
        print("2 - Destruir banco de dados")

    if usuario in ("admin", "gerente"):
        print("3 - Cadastrar produto")
        print("4 - Cadastrar cliente")
        print("5 - Cadastrar vendedor")
        print("6 - Cadastrar transportadora")

    if usuario in ("admin", "gerente", "funcionario"):
        print("7 - Registrar venda")
        print("8 - calcular_idade()")
        print("9 - soma_fretes()")
        print("10 - arrecadado()")
        print("11 - Ver notificações")

    try:
        opcao = int(input("Escolha a opção desejada: ").strip())
    except ValueError:
        print("⚠ Entrada inválida! Digite um número.")
        continue

    if opcao == 0:
        print("Saindo do sistema...")
        break

    elif opcao == 1 and usuario == "admin":
        criar_banco(conexao)

    elif opcao == 2 and usuario == "admin":
        destruir_banco(conexao)

    elif opcao == 3 and usuario in ("admin", "gerente"):
        cadastrar_produto(conexao)

    elif opcao == 4 and usuario in ("admin", "gerente", "funcionario"):
        cadastrar_cliente(conexao)

    elif opcao == 5 and usuario in ("admin", "gerente"):
        cadastrar_vendedor(conexao)

    elif opcao == 6 and usuario in ("admin", "gerente"):
        cadastrar_transportadora(conexao)

    elif opcao == 7 and usuario in ("admin", "gerente", "funcionario"):
        registrar_venda(conexao)

    elif opcao == 8:
        calcular_idade(conexao)

    elif opcao == 9:
        soma_fretes(conexao)

    elif opcao == 10:
        arrecadado(conexao)

    elif opcao == 11:
        listar_notificacoes(conexao)

    else:
        print("⚠ Acesso negado ou opção inválida!")

conexao.close()
