BOTOES[fechar]="abrir|fechar|cancelar"
PALAVRAS_CHAVE[fechar]=""

ACOES[fechar_abrir]="fechar_abrir"
ACOES[fechar_fechar]="fechar_fechar"
ACOES[fechar_cancelar]="fechar_cancelar"

interface_fechar() {
    local tamanho_texto=$(printf "%s" "Fechar navegador e entrar no diretório"  | wc -L)
    local fechar_form="[${AZUL}%d${SEM_COR}] ${AMARELO}%-${tamanho_texto}.${tamanho_texto}s${SEM_COR}"
    local textos=("Fechar navegador e entrar no diretório" 
                  "Fechar e voltar à origem" 
                  "Cancelar operação")

    adicionar_cabecalho "Fechar Navegador"
    adicionar_contexto "inicio" "Fechar Navegador"
    adicionar_alinhamento "centro"
    adicionar_max_Itens_por_linha "1"
    for i in "${!textos[@]}"; do
        local texto_fechar=($((i + 1)) "${textos[$i]}")
        adicionar_item "fechar_form" "texto_fechar"
    done
    adicionar_contexto "fim" "Fechar Navegador"

    local opcoes_fechar=("abrir" "fechar" "cancelar")
    local acoes_fechar=()

    ITENS_DA_TELA=("${opcoes_fechar[@]}")
    ACOES_DA_TELA=("${acoes_fechar[@]}")

}