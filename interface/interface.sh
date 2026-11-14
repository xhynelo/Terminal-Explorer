# interface.sh

BASE_INTERFACE_DIR="$(dirname "${BASH_SOURCE[0]}")"

source "$BASE_INTERFACE_DIR/terminal_layout.sh"
source "$BASE_INTERFACE_DIR/text_formatting.sh"
source "$BASE_INTERFACE_DIR/directory_scanner.sh"
source "$BASE_INTERFACE_DIR/menu_renderer.sh"
source "$BASE_INTERFACE_DIR/input_reader.sh"
source "$BASE_INTERFACE_DIR/input_validator.sh"
source "$BASE_INTERFACE_DIR/interface_controller.sh"