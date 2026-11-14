#!/bin/bash

shopt -s nullglob extglob

# 1. Descobre a pasta onde os scripts estão guardados
PASTA_DO_SCRIPT=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# 2. FUNÇÃO AUXILIAR PARA IMPORTAR COM SEGURANÇA
importar_arquivo() {
    local arquivo="$PASTA_DO_SCRIPT/$1"
    if [ -f "$arquivo" ]; then
        . "$arquivo"
    else
        echo "❌ ERRO: Não foi possível importar '$1' de: $PASTA_DO_SCRIPT"
        return 1 2>/dev/null || exit 1
    fi
}

importar_arquivos_por_pasta() {
    local pasta="$PASTA_DO_SCRIPT/$1"

    # Verifica se a pasta informada realmente existe antes de continuar
    if [ -d "$pasta" ]; then
        # Varre todos os arquivos .sh dentro daquela pasta
        for arquivo_sh in "$pasta/"*.sh; do
            # O -f garante que é um arquivo real (e não uma subpasta ou atalho)
            if [ -f "$arquivo_sh" ]; then
                . "$arquivo_sh"
            fi
        done
    else
        echo "❌ ERRO: A pasta '$1' não existe em: $PASTA_DO_SCRIPT"
        return 1
    fi
}

# 3. FAÇA AS SUAS IMPORTAÇÕES AQUI (Uma por linha)
importar_arquivo "globals.sh"

importar_arquivos_por_pasta "constants"
importar_arquivos_por_pasta "config"

importar_arquivo "interface/interface.sh"
# importar_arquivo "interface.sh"

importar_arquivos_por_pasta "helper"
importar_arquivos_por_pasta "tui"
importar_arquivo "fluxo_principal.sh"


MUDOU_TAMANHO=false
# Roda a varredura automática logo no início
mapear_emojis_do_sistema
# reajustar_janela_dinamico() {
#     MUDOU_TAMANHO=true
# }

# trap 'reajustar_janela_dinamico' SIGWINCH

main
