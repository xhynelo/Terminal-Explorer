# helper_fechar.sh
# Funções auxiliares para a interface de fechamento

fechar_abrir() {
    echo -e "\n${VERDE}Entrando no diretório...${SEM_COR} ${AZUL}$(pwd)${SEM_COR}"
    DEVE_FECHAR=true
}

fechar_fechar() {
    echo -e "\n${VERDE}Voltando ao diretório...${SEM_COR} ${AZUL}($BASE_DIR)${SEM_COR}"
    cd "$BASE_DIR"
    DEVE_FECHAR=true
}

fechar_cancelar() {
    MODE="navegacao"
    DEVE_FECHAR=false
}

fallback_fechar() {
    echo -e "\n${VERMELHO}[X] Opção desconhecida! Pressione ENTER para tentar novamente.${SEM_COR}" >&2
    read -r
}