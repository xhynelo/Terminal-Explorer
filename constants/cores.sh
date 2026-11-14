# cores.sh
# configuração de cores para o terminal
VERDE='\033[0;32m'
VERMELHO='\033[0;31m'
AZUL='\033[1;34m'
AMARELO='\033[0;33m'
CINZA='\033[0;90m'
SEM_COR='\033[0m'

declare -g -A MAPA_COR



MAPA_COR[Escolher]="$VERDE"
MAPA_COR[Abrir]="$VERDE"
MAPA_COR[Voltar]="$AMARELO"
MAPA_COR[Arquivo]="$AZUL"
MAPA_COR[Sair]="$VERMELHO"
MAPA_COR[Fechar]="$VERMELHO"
MAPA_COR[Diretorio]="$CINZA"