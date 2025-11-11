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

conexao = conectar()
if not conexao:
    exit()

while True:
    print("\nMENU PRINCIPAL")
    print("0 - Sair")
    print("1 - Criar banco")
    print("2 - Destruir banco")
    print("3 - Cadastrar produto")
    print("4 - Cadastrar cliente")
    print("5 - Cadastrar vendedor")
    print("6 - Cadastrar transportadora")
    print("7 - Registrar venda")
    print("8 - calcular_idade()")
    print("9 - soma_fretes()")
    print("10 - arrecadado()")
    print("11 - Ver notificações")

    opcao = input("Opção: ")

    if opcao == "0":
        break
    elif opcao == "1":
        criar_banco(conexao)
    elif opcao == "2":
        destruir_banco(conexao)
    elif opcao == "3":
        cadastrar_produto(conexao)
    elif opcao == "4":
        cadastrar_cliente(conexao)
    elif opcao == "5":
        cadastrar_vendedor(conexao)
    elif opcao == "6":
        cadastrar_transportadora(conexao)
    elif opcao == "7":
        registrar_venda(conexao)
    elif opcao == "8":
        calcular_idade(conexao)
    elif opcao == "9":
        soma_fretes(conexao)
    elif opcao == "10":
        arrecadado(conexao)
    elif opcao == "11":
        listar_notificacoes(conexao)
    else:
        print("Opção inválida.")

conexao.close()
print("Conexão encerrada.")
