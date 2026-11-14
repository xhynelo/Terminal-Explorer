# # desenhar
# gerar_barra_divisora_cima() {
#     local colunas_totais=$(tput cols)
#     # Repete o caractere '─' de acordo com a largura da janela
#     echo -en ${AMARELO}'╔'${SEM_COR}
#     printf ${AMARELO}'═%.0s'${SEM_COR} $(seq 1 $(( "$colunas_totais" - 2 )))
#     echo -en ${AMARELO}'╗'${SEM_COR}
#     echo -e ""
# }

# gerar_barra_divisora_baixo() {
#     local colunas_totais=$(tput cols)
#     # Repete o caractere '─' de acordo com a largura da janela
#     echo -en ${AMARELO}'╚'${SEM_COR}
#     printf ${AMARELO}'═%.0s'${SEM_COR} $(seq 1 $(( "$colunas_totais" - 2 )))
#     echo -en ${AMARELO}'╝'${SEM_COR}
#     echo -e ""
# }

# gerar_linha() {
#     local alinhamento="$1" # esquerda, centro, direita
#     local formatacao="$2" # negrito, sublinhado, normal
#     declare -n texto="$3"
#     local colunas_totais="$COLUNAS_TOTAIS"
#     local tamanho_texto=$(printf "$formatacao" "${texto[@]}" | sed 's/\x1b\[[0-9;]*m//g' | wc -L)
#     printf "${AMARELO}║${SEM_COR}"
#     printf "${AMARELO}%*s║${SEM_COR}" $(( colunas_totais - 2 ))
#     case "$alinhamento" in
#         "centro")
#             local centro_linha=$(( (colunas_totais) / 2 ))
#             local meio_texto=$(( tamanho_texto / 2 ))
#             tput cub "$centro_linha"
#             tput cub "$meio_texto"
#             printf "$formatacao" "${texto[@]}"
#         ;;
#         "esquerda")
#             local inicio_texto=$(( colunas_totais - 2 ))
#             tput cub "$inicio_texto"
#             printf "$formatacao" "${texto[@]}"
#         ;;
#         "direita")
#             local fim_texto=$(( colunas_totais - tamanho_texto - 2 ))
#             tput cub "$fim_texto"
#             printf "$formatacao" "${texto[@]}"
#         ;;
#         *)

#         ;;
#     esac
#     echo -e ""
# }

# quebra_linha() {
#     local itens_por_linha="$1"
#     local total_itens="$2"
#     local indice="$3"
#     if (( indice % itens_por_linha == 0  ||  indice  == total_itens )); then
#             echo -e ""
#     fi
# }

# truncar() {
#     local nome="$1"
#     local limite="$2"
    
#     if [ ${#nome} -gt $limite ]; then
#         # Corta o texto e exibe com os três pontinhos
#         echo "${nome:0:$((limite - 3))}..."
#     else
#         # Exibe o nome original intacto
#         echo "$nome"
#     fi
# }
                                              
# # divisorias                                            
# cabecalho() {
#     local name="$1"
#     local colunas_totais="$COLUNAS_TOTAIS"
#     local titolo=("📂" " $name " "📂")
#     local subtitulo=("📍" " Diretório atual " "📍")
#     local caminho_atual="$(pwd)"
#     gerar_barra_divisora_cima
#     gerar_linha centro "${AMARELO}%s%s%s${SEM_COR}" "titolo" 
#     gerar_linha centro "${AMARELO}%s%s%s${SEM_COR}" "subtitulo"
#     gerar_linha centro "${AZUL}%s${SEM_COR}" "caminho_atual"
#     gerar_barra_divisora_baixo
# }

# entrada_valida() {
#     declare -n palavras_permitidas="$1" # Usa o nome do array passado como argumento
#     local entrada="$2"
#     local total_opcoes="$3"
#     local total_acoes="$4"

#     local regex_palavras
#     regex_palavras="^($(local IFS="|"; echo "${palavras_permitidas[*]}"))$"
#     # 1. Verifica se a palavra está no vetor (O "in" do Python)
#     if [[ "$entrada" =~ $regex_palavras ]]; then
#         return 0 # Palavra permitida!
#     fi

#     # Aceita números negativos, positivos e barra o que for maior que o total
#     #  [[ ! "$escolha" =~ ^-?[0-9]+$ ]] || [ "$escolha" -lt -2 ] || [ "$escolha" -gt "${#opcoes[@]}" ];
#     if [[ ! "$entrada" =~ ^-?[0-9]+$ ]] || [ "$entrada" -lt $((-1 * (total_acoes - 1))) ] || [ "$entrada" -gt "$total_opcoes" ]; then
#         return 1 # Código de erro (inválido)
#     fi
#     return 0 # Código de sucesso (válido)
# }

# opcao_escolhida() {
#     declare -n local_acoes="$1" # Usa o nome do array passado como argumento
#     declare -n local_pastas="$2" # Usa o nome do array passado como argumento
#     local escolha="$3"
#     if [[ ! "$escolha" =~ ^-?[0-9]+$ ]]; then
#         echo "$escolha"
#         return
#     fi

#     if (( "$escolha" < 1 )); then
#         indice=$((escolha * -1))
#         opcao_selecionada="${local_acoes[$indice]}"
#     else
#         indice=$((escolha - 1))
#         opcao_selecionada="${local_pastas[$indice]}"
#     fi
#     echo "$opcao_selecionada"
# }

# acha_pastas() {
#     PASTAS_DO_DIRETORIO=()
#     for pasta in */; do
#         # Verifica se existem pastas (evita erro se o diretório estiver vazio)
#         if [ -d "$pasta" ]; then
#             PASTAS_DO_DIRETORIO+=("${pasta%/}") # Remove a barra '/' do final do nome para exibir mais limpo
#         fi
#     done
# }

# acha_arquivos() {
#     ARQUIVOS_DO_DIRETORIO=()
#     for arquivo in *; do
#         # O teste -f garante que é um arquivo (e ignora pastas)
#         if [ -f "$arquivo" ]; then
#             ARQUIVOS_DO_DIRETORIO+=("$arquivo")
#         fi
#     done
# }

# acoes() {
#     declare -n local_acoes="$1" # Usa o nome do array passado como argumento
#     local itens_por_linha=${2:-"${#local_acoes[@]}"} # Quebra a linha a cada X itens para não quebrar o layout
#     local colunas_totais="$COLUNAS_TOTAIS"
#     local tam_nomes=$(( (colunas_totais / itens_por_linha) - 10 )) # Ajusta o tamanho do nome para caber na tela
#     local formatacao=""
#     local linhas=()
#     gerar_barra_divisora_cima
#     for i in "${!local_acoes[@]}"; do
#         icone=$(obter_icone "${local_acoes[$i]}")
#         num=$((i * -1))
#         nome_opcao="${local_acoes[$i]}"
#         nome_opcao=$(truncar "$nome_opcao" "$tam_nomes")
#         formatacao+=" [${MAPA_COR[$nome_opcao]}%2d${SEM_COR}] %s ${MAPA_COR[$nome_opcao]}%-${tam_nomes}.${tam_nomes}s${SEM_COR}"
#         linhas+=("$num" "$icone" "$nome_opcao")
#         if (( (i + 1) % itens_por_linha == 0 )); then
#             gerar_linha esquerda "$formatacao" "linhas"
#             linhas=() # Limpa o array para a próxima linha
#             formatacao=""
#         fi
#     done
#     if (( ${#linhas[@]} > 0 )); then
#         gerar_linha esquerda "$formatacao" "linhas"
#         linhas=() # Limpa o array para a próxima linha
#         formatacao=""
#     fi
#     gerar_barra_divisora_baixo
# }

# pastas() {
#     declare -n local_pastas="$1" # Usa o nome do array passado como argumento
#     local itens_por_linha="$2" # Quebra a linha a cada X itens para não quebrar o layout
#     local colunas_totais="$COLUNAS_TOTAIS"
#     local tam_nomes="$LARGURA_COLUNA"
#     local icone="${MAPA_ICON[diretorio]}"

#     local formatacao_individual=" [${AZUL}%2d${SEM_COR}] %s ${CINZA}%-${tam_nomes}.${tam_nomes}s${SEM_COR}"
#     local formatacao=""
#     local linhas=()
#     gerar_barra_divisora_cima
#     for i in "${!local_pastas[@]}"; do
#         num=$((i + 1))
#         nome_opcao="${local_pastas[$i]}"
#         nome_opcao=$(truncar "$nome_opcao" "$tam_nomes")
#         formatacao+="$formatacao_individual"
#         linhas+=("$num" "$icone" "$nome_opcao")
#         if (( (i + 1) % itens_por_linha == 0 )); then
#             gerar_linha esquerda "$formatacao" "linhas"
#             linhas=() # Limpa o array para a próxima linha
#             formatacao=""
#         fi
#         # quebra_linha "$itens_por_linha" "${#local_pastas[@]}" "$num"
#     done
#     if (( ${#linhas[@]} > 0 )); then
#         gerar_linha esquerda "$formatacao" "linhas"
#         linhas=() # Limpa o array para a próxima linha
#         formatacao=""
#     fi
#     gerar_barra_divisora_baixo
# }

# arquivos() {
#     declare -n local_arquivos="$1" # Usa o nome do array passado como argumento
#     local itens_por_linha="$2"
#     local listagem="$3"
#     local tam_nomes="$LARGURA_COLUNA"

#     # 2. Varre o diretório e adiciona APENAS arquivos regulares no array
#     # for arquivo in *; do
#     #     # O teste -f garante que é um arquivo (e ignora pastas)
#     #     if [ -f "$arquivo" ]; then
#     #         local_arquivos+=("$arquivo")
#     #     fi
#     # done
#     # 3. Formata a saída para exibir os arquivos
#     local form_ind_idx=" [${AZUL}%2d${SEM_COR}] %s ${CINZA}%-${tam_nomes}.${tam_nomes}s${SEM_COR}"
#     local form_ind_no_idx=" %s ${CINZA}%-${tam_nomes}.${tam_nomes}s${SEM_COR}"
#     local formatacao=""
#     local linhas=()
#     gerar_barra_divisora_cima
#     for i in "${!local_arquivos[@]}"; do
#         nome_arquivo="${local_arquivos[$i]}"
#         nome_arquivo=$(truncar "$nome_arquivo" "$tam_nomes")

#         icone=$(obter_icone "$nome_arquivo")
#         if [ "$listagem" == "sim" ]; then
#             num=$((i + 1))
#             formatacao+="$form_ind_idx"
#             linhas+=("$num" "$icone" "$nome_arquivo")
#         else
#             formatacao+="$form_ind_no_idx"
#             linhas+=("$icone" "$nome_arquivo")
#         fi
#         if (( (i + 1) % itens_por_linha == 0 )); then
#             gerar_linha esquerda "$formatacao" "linhas"
#             linhas=() # Limpa o array para a próxima linha
#             formatacao=""
#         fi
#     done
#     if (( ${#linhas[@]} > 0 )); then
#         gerar_linha esquerda "$formatacao" "linhas"
#         linhas=() # Limpa o array para a próxima linha
#         formatacao=""
#     fi
#     gerar_barra_divisora_baixo
# }

# capturar_entrada() {
#     local -n _retorno_texto=$1 # Devolve o texto para a sua variável do lado de fora
#     local entrada_acumulada=""
#     local entrada_parcial=""

#     # Limpa a tela de entrada antes de começar
#     _retorno_texto=""

#     # Executa o loop continuamente
#     while true; do
#         read -r -t 0.1 entrada_parcial
#         local status_read=$?

#         # SE O STATUS FOR 0: Significa que o usuário apertou ENTER!
#         if [ $status_read -eq 0 ]; then
#             # Junta o último pedaço digitado e sai do loop
#             entrada_acumulada="${entrada_acumulada}${entrada_parcial}"
#             break
#         fi

#         # SE O STATUS FOR MAIOR QUE 128: Significa que deu TIMEOUT (0.1s passou)
#         # Mas o usuário pode já ter digitado metade da palavra antes do timeout!
#         if [ $status_read -gt 128 ]; then
#             # Se ele digitou algo nessa janela de 0.1s, nós guardamos no acumulador
#             if [ -n "$entrada_parcial" ]; then
#                 entrada_acumulada="${entrada_acumulada}${entrada_parcial}"
#             fi
#             # O loop dá a volta e abre espaço para o 'trap SIGWINCH' agir na tela!
#         fi
#     done

#     # Grava o texto final completo na sua variável externa
#     _retorno_texto="$entrada_acumulada"
# }

# escolher(){
#     declare -n local_opcoes="$1" # Usa o nome do array passado como argumento
#     # local -n _escolha="$2" # Variável para armazenar a escolha do usuário
#     # 3. Ler a escolha do usuário
#     printf "${AMARELO}👉 Escolha uma opção [1-${#local_opcoes[@]}]: ${SEM_COR}" >&2
#     # read -r escolha
#     local escolha=""
#     capturar_entrada escolha
#     # _escolha="$escolha"
#     echo "$escolha"
#     # echo -e "Escolha _escolha: $_escolha"
# }

# processar_input_interface() {
#     # 1. Criamos referências diretas (links) para os arrays passados por nome
#     local -n _lista_ref="$1"
#     local -n _acoes_ref="$2"
#     # local _fallback_func="$3"
#     local _palavras_chave_ref=("${PALAVRAS_CHAVE_DO_MODE[@]}") # Usa o nome do array passado como argumento

#     # 2. Roda a captura (adaptado do seu código)
#     escolha=$(escolher "_lista_ref")
#     # local escolha=""
#     # escolher "_lista_ref" "escolha"
#     # echo -e "$escolha"
#     # read -r
#     # 3. Valida a entrada usando as referências locais
#     if ! entrada_valida "_palavras_chave_ref" "$escolha" "${#_lista_ref[@]}" "${#_acoes_ref[@]}"; then
#         echo -e "\n${VERMELHO}[X] Opção inválida! Pressione ENTER para tentar novamente.${SEM_COR}" >&2
#         read -r
#         return 0
#     fi

#     # 4. Converte a escolha para a opção selecionada
#     # Passamos o nome real do array ($1) para manter a compatibilidade com a sua função antiga
#     opcao_selecionada=$(opcao_escolhida "_acoes_ref" "_lista_ref" "$escolha")
    
#     # # Tratamento seguro do ponto que configuramos antes
#     # if [ "$opcao_selecionada" = "." ]; then
#     #     opcao_selecionada="ponto"
#     # fi

#     # 5. Tenta executar a ação do botão
#     if ! executar_acao_botao "${MODE}_${opcao_selecionada}"; then
#         # Se falhar, executa a função de fallback dinamicamente via eval
#         eval "fallback_$MODE"
#     fi
# }