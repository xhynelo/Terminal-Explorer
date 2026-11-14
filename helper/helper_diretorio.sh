# helper_diretorio.sh

diretorio_Sair() {
    # echo -e "\n${VERMELHO}Saindo do modo code. deseja voltar à navegação?${SEM_COR} (s/n)"
    # read -r resposta
    # if [ "$resposta" = "s" ] || [ "$resposta" = "S" ]; then
    MODE="navegacao"
    # fi
}

fallback_navegacao() {
    MODE="navegacao"
}