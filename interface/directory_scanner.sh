# directory_scanner.sh

# listar_diretorios() {
#     PASTAS_DO_DIRETORIO=()
#     for pasta in */; do
#         # Verifica se existem pastas (evita erro se o diretório estiver vazio)
#         if [ -d "$pasta" ]; then
#             PASTAS_DO_DIRETORIO+=("${pasta%/}") # Remove a barra '/' do final do nome para exibir mais limpo
#         fi
#     done
# }

# listar_arquivos() {
#     ARQUIVOS_DO_DIRETORIO=()
#     for arquivo in *; do
#         # O teste -f garante que é um arquivo (e ignora pastas)
#         if [ -f "$arquivo" ]; then
#             ARQUIVOS_DO_DIRETORIO+=("$arquivo")
#         fi
#     done
# }



listar_elementos() {
    PASTAS_DO_DIRETORIO=()
    ARQUIVOS_DO_DIRETORIO=()

    local elemento

    for elemento in *; do
        if [ -d "$elemento" ]; then
            PASTAS_DO_DIRETORIO+=("$elemento")
        elif [ -f "$elemento" ]; then
            ARQUIVOS_DO_DIRETORIO+=("$elemento")
        fi
    done
}