# input_reader.sh

ler_entrada_interativa() {
    local -n _retorno_texto=$1 # Devolve o texto para a sua variável do lado de fora
    local entrada_acumulada=""
    local entrada_parcial=""

    # Limpa a tela de entrada antes de começar
    _retorno_texto=""

    # Executa o loop continuamente
    while true; do
        read -r -t 0.1 entrada_parcial
        local status_read=$?

        # SE O STATUS FOR 0: Significa que o usuário apertou ENTER!
        if [ $status_read -eq 0 ]; then
            # Junta o último pedaço digitado e sai do loop
            entrada_acumulada="${entrada_acumulada}${entrada_parcial}"
            break
        fi

        # SE O STATUS FOR MAIOR QUE 128: Significa que deu TIMEOUT (0.1s passou)
        # Mas o usuário pode já ter digitado metade da palavra antes do timeout!
        if [ $status_read -gt 128 ]; then
            # Se ele digitou algo nessa janela de 0.1s, nós guardamos no acumulador
            if [ -n "$entrada_parcial" ]; then
                entrada_acumulada="${entrada_acumulada}${entrada_parcial}"
            fi
            # O loop dá a volta e abre espaço para o 'trap SIGWINCH' agir na tela!
        fi
    done

    # Grava o texto final completo na sua variável externa
    _retorno_texto="$entrada_acumulada"
}

solicitar_escolha(){
    declare -n local_opcoes="$1" # Usa o nome do array passado como argumento
    # local -n _escolha="$2" # Variável para armazenar a escolha do usuário
    # 3. Ler a escolha do usuário
    printf "${AMARELO}👉 Escolha uma opção [1-${#local_opcoes[@]}]: ${SEM_COR}" >&2
    # read -r escolha
    local escolha=""
    ler_entrada_interativa escolha
    # _escolha="$escolha"
    echo "$escolha"
    # echo -e "Escolha _escolha: $_escolha"
}