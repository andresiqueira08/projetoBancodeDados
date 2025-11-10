from conectar import conectar, criar_banco, destruir_banco, cadastrar_produto, cadastrar_cliente

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
    if usuario in ("admin", "gerente", "funcionario"):
        print("4 - Cadastrar cliente")

    opcao = int(input("Escolha a opção desejada: "))

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
    else:
        print("⚠️ Acesso negado ou opção inválida!")

conexao.close()
