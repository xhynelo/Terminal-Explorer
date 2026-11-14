# helper_code.sh
# Funções auxiliares para a interface do comando "code" reacionado ao VS Code

code_Sair() {
    # echo -e "\n${VERMELHO}Saindo do modo code. deseja voltar à navegação?${SEM_COR} (s/n)"
    # read -r resposta
    # if [ "$resposta" = "s" ] || [ "$resposta" = "S" ]; then
    MODE="navegacao"
    # fi
}

# code_ponto() {
#     code .
#     MODE="navegacao"
# }

fallback_code() {
    code "$opcao_selecionada" || {
        echo -e "\n${VERMELHO}[X] Erro ao entrar na pasta. Pressione ENTER.${SEM_COR}"
        read -r
    }
    MODE="navegacao"
}