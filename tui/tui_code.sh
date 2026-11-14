BOTOES[code]="Sair"
PALAVRAS_CHAVE[code]=""

ACOES[code_Sair]="code_Sair"
# ACOES[code_ponto]="code_ponto"

interface_code() {
    local lista_pastas=()
    local lista_arquivos=("." "${ARQUIVOS_DO_DIRETORIO[@]}") 
    local lista_acoes=("${BOTOES_DO_MODE[@]}")

    adicionar_cabecalho "CODE"
    adicionar_lista_numerada "lista_arquivos" "code"
    adicionar_lista_acoes "lista_acoes"

    ITENS_DA_TELA=("${lista_arquivos[@]}")
    ACOES_DA_TELA=("${lista_acoes[@]}")

    # processar_input_interface "lista_arquivos" "lista_acoes"
}
