# helper_navegacao.sh
# Funções auxiliares para interfaces de navegação

navegacao_abrir() {
    # Função para abrir o diretório atual no explorador de arquivos
    local diretorio_atual
    local sistema

    diretorio_atual=$(pwd -P) || {
        echo -e "\n${VERMELHO}[X] Não foi possível obter o diretório atual.${SEM_COR}"
        read -r
        return 1
    }

    echo -e "\n${VERDE}Abrindo diretório: ${AZUL}${diretorio_atual}${SEM_COR}"
    sistema=$(uname -s)

    case "$sistema" in
        MINGW*|MSYS*|CYGWIN*)
            if command -v explorer.exe >/dev/null 2>&1; then
                explorer.exe "$diretorio_atual"
                return
            fi
            ;;
        Darwin)
            if command -v open >/dev/null 2>&1; then
                open "$diretorio_atual"
                return
            fi
            ;;
        Linux)
            # No WSL, o explorador do Windows pode abrir o caminho Linux atual.
            if grep -qi microsoft /proc/version 2>/dev/null &&
                command -v explorer.exe >/dev/null 2>&1; then
                explorer.exe .
                return
            fi

            if command -v xdg-open >/dev/null 2>&1; then
                xdg-open "$diretorio_atual" >/dev/null 2>&1 &
                return
            elif command -v gio >/dev/null 2>&1; then
                gio open "$diretorio_atual" >/dev/null 2>&1 &
                return
            fi
            ;;
    esac

    echo -e "\n${VERMELHO}[X] Não foi encontrado um explorador compatível com o sistema.${SEM_COR}"
    read -r
    return 1
}

navegacao_voltar() {
    # Função para voltar um diretório
    cd .. || {
        echo -e "\n${VERMELHO}[X] Erro ao voltar para o diretório anterior. Pressione ENTER.${SEM_COR}"
        read -r
    }
}

fallback_navegacao() {
    cd "$opcao_selecionada" || {
        echo -e "\n${VERMELHO}[X] Erro ao acessar. Pressione ENTER.${SEM_COR}"
        read -r
    }
}