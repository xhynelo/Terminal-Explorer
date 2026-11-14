# Navegar

Uma interface interativa de terminal para navegar pelos diretórios e arquivos do
computador usando Bash.

## Requisitos

- Bash 4 ou superior
- Terminal com suporte a `tput`, cores ANSI e emojis

## Como executar

Na raiz do projeto, dê permissão de execução ao script e inicie a aplicação:

```bash
chmod +x navegar.sh
./navegar.sh
```

O programa começa no diretório definido por `BASE_DIR` em `globals.sh`
(por padrão, o diretório inicial do usuário).

## Organização

- `navegar.sh`: ponto de entrada e carregamento dos módulos.
- `globals.sh`: variáveis globais, cores e estado da aplicação.
- `fluxo_principal.sh`: fluxo principal da interface.
- `config/`: configurações de ações, botões e palavras-chave.
- `constants/`: cores e ícones.
- `helper/`: funções auxiliares de navegação, código e fechamento.
- `interface/`: leitura de entrada, validação e controle da interface.
- `tui/`: renderização da interface de terminal.

## Desenvolvimento

Os arquivos são carregados automaticamente por `navegar.sh`. Para adicionar um
módulo, coloque o arquivo `.sh` no diretório correspondente ou registre-o nas
importações do ponto de entrada.

## Licença

Este projeto está licenciado sob a [GNU General Public License](LICENSE),
versão 3 ou posterior (GPLv3+).
