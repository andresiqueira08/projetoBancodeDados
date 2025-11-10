from conectar import destruir_banco, cadastrar_produto, cadastrar_cliente, criar_banco


while True:
    print("\n=== MENU DE OPÇÕES ===")
    print("0 - Sair")
    print("1 - Criar banco de dados")
    print("2 - Destruir banco de dados")
    print("3 - Cadastrar produto")
    print("4 - Cadastrar cliente")

    opcao = int(input("Escolha a opção desejada: "))

    if opcao == 0:
        print("Saindo do sistema...")
        break
    elif opcao == 1:
        criar_banco()
    elif opcao == 2:
        destruir_banco()
    elif opcao == 3:
        cadastrar_produto()
    elif opcao == 4:
        cadastrar_cliente()
    else:
        print("Opção inválida! Tente novamente.")