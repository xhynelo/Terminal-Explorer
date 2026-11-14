# terminal_layout.sh


desenhar_borda_superior() {
    local colunas_totais=$(tput cols)
    # Repete o caractere '─' de acordo com a largura da janela
    echo -en ${AMARELO}'╔'${SEM_COR}
    printf ${AMARELO}'═%.0s'${SEM_COR} $(seq 1 $(( "$colunas_totais" - 2 )))
    echo -en ${AMARELO}'╗'${SEM_COR}
    echo -e ""
}

desenhar_borda_inferior() {
    local colunas_totais=$(tput cols)
    # Repete o caractere '─' de acordo com a largura da janela
    echo -en ${AMARELO}'╚'${SEM_COR}
    printf ${AMARELO}'═%.0s'${SEM_COR} $(seq 1 $(( "$colunas_totais" - 2 )))
    echo -en ${AMARELO}'╝'${SEM_COR}
    echo -e ""
}

desenhar_linha_formatada() {
    local alinhamento="$1" # esquerda, centro, direita
    local formatacao="$2" # negrito, sublinhado, normal
    declare -n texto="$3"
    local colunas_totais="$COLUNAS_TOTAIS"
    local tamanho_texto=$(printf "$formatacao" "${texto[@]}" | sed 's/\x1b\[[0-9;]*m//g' | wc -L)
    printf "${AMARELO}║${SEM_COR}"
    printf "${AMARELO}%*s║${SEM_COR}" $(( colunas_totais - 2 ))
    case "$alinhamento" in
        "centro")
            local centro_linha=$(( (colunas_totais) / 2 ))
            local meio_texto=$(( tamanho_texto / 2 ))
            tput cub "$centro_linha"
            tput cub "$meio_texto"
            printf "$formatacao" "${texto[@]}"
        ;;
        "esquerda")
            local inicio_texto=$(( colunas_totais - 2 ))
            tput cub "$inicio_texto"
            printf "$formatacao" "${texto[@]}"
        ;;
        "direita")
            local fim_texto=$(( colunas_totais - tamanho_texto - 2 ))
            tput cub "$fim_texto"
            printf "$formatacao" "${texto[@]}"
        ;;
        *)

        ;;
    esac
    echo -e ""
}

desenhar_linha_formatada_() {
    local alinhamento="$1" formatacao="$2" tamanho_texto="$4" colunas_totais_="$5"
    local -n conteudo_="$3"
    # echo -e "\n${CINZA}Desenhando linha: alinhamento=$alinhamento, tamanho=$tamanho_texto, formatacao=$formatacao, conteudo=${conteudo_[@]}$, colunas_totais=$colunas_totais_${SEM_COR}"
    printf "${AMARELO}║${SEM_COR}"
    printf "${AMARELO}%*s║${SEM_COR}" $(( colunas_totais_ - 2 ))
    case "$alinhamento" in
        "centro")
            local centro_linha=$(( colunas_totais_ / 2 ))
            local meio_texto=$(( tamanho_texto / 2 ))
            tput cub "$centro_linha"
            tput cub "$meio_texto"
            printf "$formatacao" "${conteudo_[@]}"
        ;;
        "esquerda")
            local inicio_texto=$(( colunas_totais_ - 3 ))
            tput cub "$inicio_texto"
            printf "$formatacao" "${conteudo_[@]}"
        ;;
        "direita")
            local fim_texto=$(( tamanho_texto + 1 ))
            tput cub "$fim_texto"
            printf "$formatacao" "${conteudo_[@]}"
        ;;
        *)

        ;;
    esac
    echo -e ""
}

desenhar_cabecalho() {
    local name="$1"
    local colunas_totais="$COLUNAS_TOTAIS"
    local titolo=("📂" " $name " "📂")
    local subtitulo=("📍" " Diretório atual " "📍")
    local caminho_atual="$(pwd)"
    desenhar_borda_superior
    desenhar_linha_formatada centro "${AMARELO}%s%s%s${SEM_COR}" "titolo" 
    desenhar_linha_formatada centro "${AMARELO}%s%s%s${SEM_COR}" "subtitulo"
    desenhar_linha_formatada centro "${AZUL}%s${SEM_COR}" "caminho_atual"
    desenhar_borda_inferior
}

desenhar_tela() {
    local colunas_totais=$(tput cols)
    # quantidade_de_colunas colunas_totais
    for i in ${!LINHAS_FORMATACAO[@]}; do
        local a_item="${LINHAS_ALINHAMENTO[$i]}"
        local f_item="${LINHAS_FORMATACAO[$i]}"
        local c_item=("${LINHAS_CONTEUDO[$i]}")
        local t_item="${LINHAS_TAMANHO[$i]}"
        # echo -e "\n${CINZA}Linha $i: alinhamento=$a_item, tamanho=$t_item, formatacao=$f_item, conteudo=${c_item[@]}${SEM_COR}"
        if [[ "$f_item" == "INICIO_de_contexto" ]]; then
            desenhar_borda_superior
        elif [[ "$f_item" == "FIM_de_contexto" ]]; then
            desenhar_borda_inferior
        else
            local valores=()
            local itens=("${LINHAS_CONTEUDO[$i]}")
            for item in ${itens[@]}; do
                local -n item_nome="$item"
                valores+=("${item_nome[@]}")
            done
            # desenhar_linha_formatada "$a_item" "$f_item" "valores"
            desenhar_linha_formatada_ "$a_item" "$f_item" "valores" "$t_item" "$colunas_totais"
        fi
    done
}