from conectar import destruir_banco, cadastrar_produto, cadastrar_cliente

while True:
    print("\n=== MENU DE OPÇÕES ===")
    print("0 - Sair")
    print("1 - Destruir banco de dados")
    print("2 - Cadastrar produto")
    print("3 - Cadastrar cliente")

    opcao = int(input("Escolha a opção desejada: "))

    if opcao == 0:
        print("Saindo do sistema...")
        break
    elif opcao == 1:
        destruir_banco()
    elif opcao == 2:
        cadastrar_produto()
    elif opcao == 3:
        cadastrar_cliente()
    else:
        print("Opção inválida! Tente novamente.")