# interface_controller.sh

processar_escolha_interface() {
    # 1. Criamos referências diretas (links) para os arrays passados por nome
    local -n _lista_ref="$1"
    local -n _acoes_ref="$2"
    # local _fallback_func="$3"
    local _palavras_chave_ref=("${PALAVRAS_CHAVE_DO_MODE[@]}") # Usa o nome do array passado como argumento

    # 2. Roda a captura (adaptado do seu código)
    escolha=$(solicitar_escolha "_lista_ref")
    # local escolha=""
    # escolher "_lista_ref" "escolha"
    # echo -e "$escolha"
    # read -r
    # 3. Valida a entrada usando as referências locais
    if ! validar_entrada "_palavras_chave_ref" "$escolha" "${#_lista_ref[@]}" "${#_acoes_ref[@]}"; then
        echo -e "\n${VERMELHO}[X] Opção inválida! Pressione ENTER para tentar novamente.${SEM_COR}" >&2
        read -r
        return 0
    fi

    # 4. Converte a escolha para a opção selecionada
    # Passamos o nome real do array ($1) para manter a compatibilidade com a sua função antiga
    opcao_selecionada=$(resolver_opcao_selecionada "_acoes_ref" "_lista_ref" "$escolha")
    
    # Tratamento seguro do ponto que configuramos antes
    # if [ "$opcao_selecionada" = "." ]; then
    #     opcao_selecionada="ponto"
    # fi

    # 5. Tenta executar a ação do botão
    if ! executar_acao_botao "${MODE}_${opcao_selecionada}"; then
        # Se falhar, executa a função de fallback dinamicamente via eval
        eval "fallback_$MODE"
    fi
}