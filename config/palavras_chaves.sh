# palavras_chaves.sh
# dicionário de palavras-chave para cada tela

declare -g -A PALAVRAS_CHAVE

obter_palavras_chave() {    
    local antigo_ifs="$IFS"
    IFS='|' 
    # Alimenta o array de destino diretamente
    PALAVRAS_CHAVE_DO_MODE=(${PALAVRAS_CHAVE[$MODE]})
    IFS="$antigo_ifs"
}