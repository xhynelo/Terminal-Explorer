BOTOES[navegacao]="Abrir|Voltar|Fechar|Diretorio"
PALAVRAS_CHAVE[navegacao]="code|Diretorio"

ACOES[navegacao_Abrir]="navegacao_abrir"
ACOES[navegacao_Voltar]="navegacao_voltar"
ACOES[navegacao_Fechar]="MODE='fechar'"
ACOES[navegacao_code]="MODE='code'"
ACOES[navegacao_Diretorio]="MODE='diretorio'"

interface_navegacao() {
    local lista_pastas=("${PASTAS_DO_DIRETORIO[@]}")
    local lista_arquivos=("${ARQUIVOS_DO_DIRETORIO[@]}")
    local lista_acoes=("${BOTOES_DO_MODE[@]}")
    

    adicionar_cabecalho "NAVEGADOR DE PASTAS"
    adicionar_lista_numerada "lista_pastas" "navegacao_diretorio"
    adicionar_lista_nao_numerada "lista_arquivos" "navegacao_arquivos"
    adicionar_lista_acoes "lista_acoes"


    ITENS_DA_TELA=("${lista_pastas[@]}")
    ACOES_DA_TELA=("${lista_acoes[@]}")

}
