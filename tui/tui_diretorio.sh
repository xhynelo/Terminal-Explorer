# interface_diretorio.sh
# Interface para configuração de caminhos para navegação direta ao diretório desejado

BOTOES[diretorio]="Sair"

ACOES[diretorio_Sair]="diretorio_Sair"

interface_diretorio() {
    local lista_pastas=("${PASTAS_DO_DIRETORIO[@]}")
    local lista_arquivos=("${ARQUIVOS_DO_DIRETORIO[@]}")
    local lista_acoes=("${BOTOES_DO_MODE[@]}")

    adicionar_cabecalho "Diretório"
    local temp_tamanho_texto="$LARGURA_COLUNA"
    LARGURA_COLUNA=$((COLUNAS_TOTAIS - 7))
    adicionar_lista_nao_numerada "lista_pastas" "diretorio" "1"
    adicionar_lista_nao_numerada "lista_arquivos" "arquivos" "1"
    LARGURA_COLUNA=$temp_tamanho_texto
    adicionar_lista_acoes "lista_acoes"

    ITENS_DA_TELA=()
    ACOES_DA_TELA=("${lista_acoes[@]}")
}
