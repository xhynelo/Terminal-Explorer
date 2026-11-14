# icones.sh
# CONFIGURAÇÃO DE ÍCONES POR EXTENSÃO

# 1. Ícone padrão caso a extensão não seja reconhecida
ICONE_PADRAO="📄"
declare -g -A MAPA_ICON
# Emojis que ocupam 2 espaços na tela, mas que o Bash conta como 1:
LISTA_GERAL_DE_ICONES=("✅" "↩️" "❌" "📄" "📁" "⚡" "💻" "📝" "📕" "🖼️" "🎵" "🎬" "📦")
EMOJI_TAM_1=""
EMOJI_TAM_2=""

# 1. Opções Gerais do Sistema e Diretórios
MAPA_ICON[escolher]="✅"
MAPA_ICON[voltar]="↩️"
MAPA_ICON[sair]="❌"
MAPA_ICON[arquivo]="📄"
MAPA_ICON[fechar]="❌"

MAPA_ICON[diretorio]="📁"  # Ícone para qualquer pasta

# 2. Extensões de Arquivos comuns
MAPA_ICON[exe]="⚡"
MAPA_ICON[bat]="⚡"
MAPA_ICON[msi]="⚡"
MAPA_ICON[sh]="💻"
MAPA_ICON[py]="💻"
MAPA_ICON[txt]="📝"
MAPA_ICON[md]="📝"
MAPA_ICON[log]="📝"
MAPA_ICON[pdf]="📕"
MAPA_ICON[png]="🖼️"
MAPA_ICON[jpg]="🖼️"
MAPA_ICON[jpeg]="🖼️"
MAPA_ICON[mp3]="🎵"
MAPA_ICON[wav]="🎵"
MAPA_ICON[mp4]="🎬"
MAPA_ICON[mkv]="🎬"
MAPA_ICON[zip]="📦"
MAPA_ICON[rar]="📦"
MAPA_ICON[gz]="📦"

obter_icone() {
    local alvo="$1"

    # PASSO A: É uma palavra de controle do sistema? (Escolher, Voltar, Sair...)
    # Se a chave existir no mapa, devolve o ícone dela direto
    if [ -n "${MAPA_ICON[$alvo]}" ]; then
        echo "${MAPA_ICON[$alvo]}"
        return 0
    fi

    # 1. Se for um diretório (pasta), devolve o ícone de pasta direto
    if [ -d "$alvo" ]; then
        echo "${MAPA_ICON[diretorio]}"
        return 0
    fi

    # 2. Se for arquivo, extrai a extensão
    local ext="${alvo##*.}"
    ext="${ext,,}"

    # 3. Validação contra arquivos sem extensão ou com espaços
    if [ "$ext" = "$alvo" ] || [[ "$ext" =~ \  ]] || [ -z "$ext" ]; then
        echo "$ICONE_PADRAO"
        return 0
    fi

    # 4. Busca no dicionário e resolve o padrão
    local icone="${MAPA_ICON[$ext]}"
    echo "${icone:-$ICONE_PADRAO}" # Se estiver vazio, exibe o padrão
}

mapear_emojis_do_sistema() {
    local -n string_todos_emojis="LISTA_GERAL_DE_ICONES"
    for icone in "${string_todos_emojis[@]}"; do
        local tam_emoji=${#icone}
        if (( tam_emoji == 1 )); then
            EMOJI_TAM_1+="$icone"
        elif (( tam_emoji == 2 )); then
            EMOJI_TAM_2+="$icone"
        fi
    done
}