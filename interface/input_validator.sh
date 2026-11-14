# input_validator.sh

validar_entrada() {
    declare -n palavras_permitidas="$1" # Usa o nome do array passado como argumento
    local entrada="$2"
    local total_opcoes="$3"
    local total_acoes="$4"

    local regex_palavras
    regex_palavras="^($(local IFS="|"; echo "${palavras_permitidas[*]}"))$"
    # 1. Verifica se a palavra está no vetor (O "in" do Python)
    if [[ "$entrada" =~ $regex_palavras ]]; then
        return 0 # Palavra permitida!
    fi

    # Aceita números negativos, positivos e barra o que for maior que o total
    #  [[ ! "$escolha" =~ ^-?[0-9]+$ ]] || [ "$escolha" -lt -2 ] || [ "$escolha" -gt "${#opcoes[@]}" ];
    if [[ ! "$entrada" =~ ^-?[0-9]+$ ]] || [ "$entrada" -lt $((-1 * (total_acoes - 1))) ] || [ "$entrada" -gt "$total_opcoes" ]; then
        return 1 # Código de erro (inválido)
    fi
    return 0 # Código de sucesso (válido)
}

resolver_opcao_selecionada() {
    declare -n local_acoes="$1" # Usa o nome do array passado como argumento
    declare -n local_pastas="$2" # Usa o nome do array passado como argumento
    local escolha="$3"
    if [[ ! "$escolha" =~ ^-?[0-9]+$ ]]; then
        echo "$escolha"
        return
    fi

    if (( "$escolha" < 1 )); then
        indice=$((escolha * -1))
        opcao_selecionada="${local_acoes[$indice]}"
    else
        indice=$((escolha - 1))
        opcao_selecionada="${local_pastas[$indice]}"
    fi
    echo "$opcao_selecionada"
}