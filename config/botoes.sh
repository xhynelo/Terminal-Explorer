# botoes.sh
# configuracao de botoes por interface

declare -g -A BOTOES

obter_botoes() {
    local antigo_ifs="$IFS"
    IFS='|' 
    # Alimenta o array de destino diretamente
    BOTOES_DO_MODE=(${BOTOES[$MODE]})
    IFS="$antigo_ifs"
}