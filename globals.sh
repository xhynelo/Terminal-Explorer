BASE_DIR="$HOME"

# 2. Entra na pasta base temporariamente para listar as opções
cd "$BASE_DIR" || return
MODE="navegacao"
DEVE_FECHAR=false

# Definição das cores
VERDE='\033[0;32m'
VERMELHO='\033[0;31m'
AZUL='\033[1;34m'
AMARELO='\033[0;33m'
CINZA='\033[0;90m'
SEM_COR='\033[0m'

ESCOLHER="Escolher"
VOLTAR="Voltar"
SAIR="Sair"
ARQUIVO="Arquivo"
FECHAR="Fechar"
ABRIR="Abrir"

COLUNAS_TOTAIS=$(tput cols)
OLD_COLUNAS_TOTAIS=$COLUNAS_TOTAIS
LARGURA_COLUNA=20
ITENS_POR_LINHA=5

PASTAS_DO_DIRETORIO=()
ARQUIVOS_DO_DIRETORIO=()
BOTOES_DO_MODE=()
PALAVRAS_CHAVE_DO_MODE=()
CAMINHO_ANTIGO=$(pwd)

ITENS_DA_TELA=()
ACOES_DA_TELA=()

declare -a TELA_FORMATACAO=()

declare -A LINHAS_ALINHAMENTO=()
declare -A LINHAS_TAMANHO=()
declare -A LINHAS_FORMATACAO=()
declare -A LINHAS_CONTEUDO=()

declare -a ITENS_TAMANHO=()
declare -a ITENS_CRIADOS=()
declare -A TELA_CONTEXTO=()
declare -A ITENS_FORMATACAO=()
declare -A ITENS_CONTEUDO=()
declare -i ITENS_INDEX=0

BARRA=$(printf ${AMARELO}'%122s'${SEM_COR} | tr ' ' '─')

elemento_esta_no_array() {
    local procurado="$1"
    shift
    local item

    for item in "$@"; do
        if [[ "$item" == "$procurado" ]]; then
            return 0
        fi
    done

    return 1
}

quantidade_de_colunas() {
    local -n colunas_="$1"
    local colunas_totais=$(tput cols)
    colunas_="$colunas_totais"
}