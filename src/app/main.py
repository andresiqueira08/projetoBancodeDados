from conectar import conectar, criar_banco_completo, destruir_banco, cadastrar_produto, cadastrar_cliente

print("=== LOGIN NO SISTEMA ===")
usuario = input("Usuário (admin, gerente, funcionario): ")
senha = input("Senha: ")

# Para criar banco, precisa conectar sem database primeiro
if usuario == "admin":
    conexao = conectar(usuario, senha, criar_db=True)
else:
    conexao = conectar(usuario, senha)

if not conexao:
    exit()

while True:
    print("\n=== MENU DE OPÇÕES ===")
    print("0 - Sair")
    if usuario == "admin":
        print("1 - Criar banco de dados completo")
        print("2 - Destruir banco de dados")
    if usuario in ("admin", "gerente"):
        print("3 - Cadastrar produto")
    if usuario in ("admin", "gerente", "funcionario"):
        print("4 - Cadastrar cliente")

    try:
        opcao = int(input("Escolha a opção desejada: "))
    except ValueError:
        print("Erro: Digite um número válido!")
        continue

    if opcao == 0:
        print("Saindo do sistema...")
        break
    elif opcao == 1 and usuario == "admin":
        criar_banco_completo(conexao)
    elif opcao == 2 and usuario == "admin":
        destruir_banco(conexao)
    elif opcao == 3 and usuario in ("admin", "gerente"):
        cadastrar_produto(conexao)
    elif opcao == 4 and usuario in ("admin", "gerente", "funcionario"):
        cadastrar_cliente(conexao)
    else:
        print("⚠️ Acesso negado ou opção inválida!")

conexao.close()
