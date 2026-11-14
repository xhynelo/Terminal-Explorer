# menu_renderer.sh

calcula_tamanho() {
    local formatacao="$1"
    shift
    local texto_entrada
    texto_entrada=$(printf "$formatacao" "$@")

    # Remove cores ANSI
    texto_sem_cores="${texto_entrada//$'\e['*([0-9;])m/}"


    # Tamanho que o Bash acha que o texto_sem_cores tem
    local tamanho_texto=${#texto_sem_cores}

    # Remove apenas os emojis que o Bash conta mal
    local texto_sem_emotes="${texto_sem_cores//[$EMOJI_TAM_1]/}"

    local tamanho_sem_emotes=${#texto_sem_emotes}

    local tamanho_final=$((tamanho_texto + (tamanho_texto - tamanho_sem_emotes)))

    # O tamanho visual real será o tamanho base + 1 espaço extra para cada emoji ruim
    echo $(( tamanho_final ))
}



criar_item() {
    local indice="$ITENS_INDEX"

    local nome_item="ITEM_${indice}"

    declare -g -a "$nome_item"
    local -n item="$nome_item"

    item=("$@")

    ITENS_CONTEUDO["$indice"]="$nome_item"
    ITENS_CRIADOS+=("$nome_item")
}

adicionar_item() {
    local -n formatacao_="$1"
    local -n conteudo_="$2"
    local indice="$ITENS_INDEX"
    local tamanho_texto_=$(calcula_tamanho "$formatacao_" "${conteudo_[@]}")
    # local tamanho_texto_=$(printf "$formatacao_" "${conteudo_[@]}" | sed 's/\x1b\[[0-9;]*m//g' | wc -L)
    criar_item "${conteudo_[@]}" 
    ITENS_FORMATACAO["$indice"]="$formatacao_"
    ITENS_TAMANHO+=("$tamanho_texto_")
    ((ITENS_INDEX++))
}

adicionar_contexto() {
    local momento="$1"
    local contexto="$2"

    local conteudo_contexto_=("${momento}" "${contexto}")
    local contexto_="CONTEXTO"
    adicionar_item "contexto_" "conteudo_contexto_"
}

adicionar_alinhamento() {
    local tipo="$1"
    lista_alinhamentos=(esquerda centro direita)
    if ! elemento_esta_no_array "$tipo" "${lista_alinhamentos[@]}"; then
        printf 'Alinhamento inválido: %s\n' "$tipo" >&2
        return 1
    fi
    alinhamento="ALINHAMENTO"
    adicionar_item "alinhamento" "tipo"
}

adicionar_max_Itens_por_linha() {
    local valor="$1"
    max_itens="MAX_ITENS"
    adicionar_item "max_itens" "valor"
}

deletar_itens() {
    for i in "${!ITENS_CRIADOS[@]}"; do
        unset -v "${ITENS_CRIADOS[$i]}"
    done
    ITENS_CRIADOS=()
    ITENS_CONTEUDO=()
    ITENS_FORMATACAO=()
    ITENS_INDEX=0

    TELA_CONTEXTO=()
    ITENS_TAMANHO=()

    LINHAS_TAMANHO=()
    LINHAS_FORMATACAO=()
    LINHAS_CONTEUDO=()
    LINHAS_ALINHAMENTO=()
}

adicionar_linha_a_tela() {
    local -n tamanho_="$1"
    local -n alinhamento_="$2"
    local -n formatacao_="$3"
    local -n conteudo_="$4"
    local -n indices_="$5"
    LINHAS_TAMANHO["$indices_"]="$tamanho_"
    LINHAS_ALINHAMENTO["$indices_"]="$alinhamento_"
    LINHAS_FORMATACAO["$indices_"]="$formatacao_"
    LINHAS_CONTEUDO["$indices_"]="$conteudo_"
    indices_=$((indices_ + 1))
    tamanho_=0
    formatacao_=""
    conteudo_=()
}


# tela_formatacao: tamanho_linha, alinhamento, formatacao, indices_de_itens
formatar_tela() {
    local colunas_totais=$(tput cols)
    local max_itens=10
    local -i itens_adicionados=0
    local tamanho_texto=0
    local alinhamento="esquerda"
    local formatacao=""
    local conteudo=""
    
    local -i indice_tela=0
    for ((i=0; i<ITENS_INDEX; i++)); do
        local tam_item="${ITENS_TAMANHO[$i]}"
        local form_item="${ITENS_FORMATACAO[$i]}"
        case "$form_item" in
            "CONTEXTO")
                local -n contextos=${ITENS_CONTEUDO[$i]}
                if [[ "${contextos[0]}" == "inicio" ]]; then
                    formatacao="INICIO_de_contexto"
                    adicionar_linha_a_tela "tamanho_texto" "alinhamento" "formatacao" "conteudo" "indice_tela"
                elif [[ "${contextos[0]}" == "fim" ]]; then
                    if (( tamanho_texto > 0 )); then
                        adicionar_linha_a_tela "tamanho_texto" "alinhamento" "formatacao" "conteudo" "indice_tela"
                        itens_adicionados=0
                    fi
                    formatacao="FIM_de_contexto"
                    adicionar_linha_a_tela "tamanho_texto" "alinhamento" "formatacao" "conteudo" "indice_tela"
                    alinhamento="esquerda"
                    max_itens=10
                fi
            ;;
            "ALINHAMENTO")
                local -n item_alinhamento=${ITENS_CONTEUDO[$i]}
                alinhamento="${item_alinhamento[0]}"
            ;;
            "MAX_ITENS")
                local -n item_max_itens=${ITENS_CONTEUDO[$i]}
                max_itens="${item_max_itens[0]}"
            ;;
            *)  
                if (( i < ITENS_INDEX )); then
                    local next_tam="${ITENS_TAMANHO[$((i+1))]}"
                fi
                if [[ -z "$formatacao" ]]; then
                    formatacao="$form_item"
                    tamanho_texto=$((tamanho_texto + tam_item))
                else
                    formatacao+=" $form_item"
                    tamanho_texto=$((tamanho_texto + tam_item + 1)) # +1 para o espaço entre os itens
                fi
                conteudo+=" ${ITENS_CONTEUDO[$i]}"
                itens_adicionados=$((itens_adicionados + 1))
                if (( (itens_adicionados) % max_itens == 0 )) || (((tamanho_texto + next_tam) >= (colunas_totais-5))); then
                    adicionar_linha_a_tela "tamanho_texto" "alinhamento" "formatacao" "conteudo" "indice_tela"
                    itens_adicionados=0
                fi
            ;;
        esac
    done
}


adicionar_cabecalho() {
    local titulo_texto="$1"
    local titulo_form="${AMARELO}%s %s %s${SEM_COR}"
    local titulo=("📂" "$titulo_texto" "📂")
    local subtitulo_form="${AMARELO}%s %s %s${SEM_COR}"
    local subtitulo=("📍" "Diretório atual" "📍")
    local caminho_atual_form="${AZUL}%s${SEM_COR}"
    local caminho_atual="$(pwd)"

    adicionar_contexto "inicio" "cabeçalho"
    adicionar_alinhamento "centro"
    adicionar_max_Itens_por_linha "1"
    adicionar_item "titulo_form" "titulo"
    adicionar_item "subtitulo_form" "subtitulo"
    adicionar_item "caminho_atual_form" "caminho_atual"
    adicionar_contexto "fim" "cabeçalho"
}

adicionar_lista_numerada() {
    local -n lista_="$1"
    local contexto="$2"
    local max_itens_por_linha=${3:-"10"}
    local formatacao_aln="[${AZUL}%2d${SEM_COR}] %s ${CINZA}%-${LARGURA_COLUNA}.${LARGURA_COLUNA}s${SEM_COR}"

    adicionar_contexto "inicio" "$contexto"
    adicionar_max_Itens_por_linha "$max_itens_por_linha"
    for i in "${!lista_[@]}"; do
        # if ((i >= 20)); then
        #     break
        # fi
        local nome_="${lista_[$i]}"
        local icone=$(obter_icone "$nome_")
        local num=$((i + 1))
        nome_=$(truncar_texto "$nome_" "$LARGURA_COLUNA")
        local conteudo_linha=("$num" "$icone" "$nome_")
        adicionar_item "formatacao_aln" "conteudo_linha"
    done
    adicionar_contexto "fim" "$contexto"

}

adicionar_lista_nao_numerada() {
    local -n lista_="$1"
    local contexto="$3"
    local max_itens_por_linha=${3:-"10"}
    local formatacao_alnn="%s ${CINZA}%-${LARGURA_COLUNA}.${LARGURA_COLUNA}s${SEM_COR}"

    adicionar_contexto "inicio" "$contexto"
    adicionar_max_Itens_por_linha "$max_itens_por_linha"
    for i in "${!lista_[@]}"; do
        # if ((i >= 20)); then
        #     break
        # fi
        local nome_="${lista_[$i]}"
        local icone=$(obter_icone "$nome_")
        nome_=$(truncar_texto "$nome_" "$LARGURA_COLUNA")
        local conteudo_linha=("$icone" "$nome_")
        adicionar_item "formatacao_alnn" "conteudo_linha"
    done
    adicionar_contexto "fim" "$contexto"
}

adicionar_lista_acoes() {
    local -n lista_="$1"

    adicionar_contexto "inicio" "acoes"
    for i in "${!lista_acoes[@]}"; do
        local nome_="${lista_acoes[$i]}"
        local icone=$(obter_icone "${lista_acoes[$i]}")
        local num=$((i * -1))
        nome_=$(truncar_texto "$nome_" "$LARGURA_COLUNA")
        local formatacao_ala="[${MAPA_COR[$nome_]}%2d${SEM_COR}] %s ${MAPA_COR[$nome_]}%-${LARGURA_COLUNA}.${LARGURA_COLUNA}s${SEM_COR}"
        local conteudo_linha=("$num" "$icone" "$nome_")
        adicionar_item "formatacao_ala" "conteudo_linha"
    done
    adicionar_contexto "fim" "acoes"
}