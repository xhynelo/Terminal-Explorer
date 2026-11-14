# text_formatting.sh

truncar_texto() {
    local nome="$1"
    local limite="$2"
    
    if [ ${#nome} -gt $limite ]; then
        # Corta o texto e exibe com os três pontinhos
        echo "${nome:0:$((limite - 3))}..."
    else
        # Exibe o nome original intacto
        echo "$nome"
    fi
}

imprimir_quebra_de_linha() {
    local itens_por_linha="$1"
    local total_itens="$2"
    local indice="$3"
    if (( indice % itens_por_linha == 0  ||  indice  == total_itens )); then
            echo -e ""
    fi
}