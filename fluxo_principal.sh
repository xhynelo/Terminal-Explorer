ACOES[navegacao]="interface_navegacao"
ACOES[code]="interface_code"
ACOES[fechar]="interface_fechar"
ACOES[diretorio]="interface_diretorio"

main() {
    listar_elementos
    # listar_diretorios
    # listar_arquivos
    local mode_atual="inicio"
    while true; do
        clear # Limpa a tela a cada pasta para o menu ficar fixo no topo
        if [[ "$CAMINHO_ANTIGO" != "$(pwd)" ]]; then
            CAMINHO_ANTIGO=$(pwd)
            listar_elementos
            # listar_diretorios
            # listar_arquivos
        fi
        COLUNAS_TOTAIS=$(tput cols)
        ITENS_POR_LINHA=$(( COLUNAS_TOTAIS / (LARGURA_COLUNA + 10) ))
        if (( ITENS_POR_LINHA < 1 )); then ITENS_POR_LINHA=1; fi
        
        # echo -e "${CINZA}Largura da tela: ${AMARELO}$COLUNAS_TOTAIS${SEM_COR} | Itens por linha: ${AMARELO}$ITENS_POR_LINHA${SEM_COR}"
        # echo -e "${CINZA}Diretório atual: ${AMARELO}$(pwd)${SEM_COR}"
        # echo -e "${CINZA}Modo atual: ${AMARELO}$MODE${SEM_COR}"
        # echo -e "${CINZA}Ações disponíveis: ${AMARELO}${BOTOES[$MODE]}${SEM_COR}"
        # echo -e "${CINZA}Ações disponíveis (debug): ${AMARELO}${ACOES[$MODE]}${SEM_COR}"
        # echo -e "${CINZA}Ações disponíveis (debug): ${AMARELO}$OLD_COLUNAS_TOTAIS${SEM_COR}"

        if (( "$COLUNAS_TOTAIS" != "$OLD_COLUNAS_TOTAIS" )); then
            OLD_COLUNAS_TOTAIS=$COLUNAS_TOTAIS
            continue # Reinicia o loop para recalcular a largura da tela
        fi

        obter_botoes
        obter_palavras_chave

        if ! executar_acao_botao "$MODE"; then
            echo -e "\n${VERMELHO}[X] Modo desconhecido! Pressione ENTER para fechar.${SEM_COR}" >&2
            read -r
            break
        fi

        formatar_tela
        desenhar_tela

        processar_escolha_interface ITENS_DA_TELA ACOES_DA_TELA

        deletar_itens
        
        if [ "$DEVE_FECHAR" = true ]; then
            deletar_itens
            break
        fi
    done
}