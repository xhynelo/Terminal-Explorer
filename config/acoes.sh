# acoes.sh
# dicionário de ações para cada tela

declare -g -A ACOES

executar_acao_botao() {
    local botao="$1"
    # echo -e "\n${CINZA}Executando ação para o botão: ${AMARELO}$botao${SEM_COR}"
    # Verifica se existe uma ação cadastrada para esse botão específico
    if [[ -n "${ACOES[$botao]}" ]]; then
        # eval executa o texto guardado na variável como código Bash real
        eval "${ACOES[$botao]}"
        return 0 # Sucesso: era um botão com ação mapeada
    fi

    return 1 # Não era um botão mapeado (provavelmente é um arquivo/pasta)
}
