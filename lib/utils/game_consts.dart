// Tamaño fijo del tablero
const int BOARD_SIZE = 5;
const int MIN_MINES = 7;
const int MAX_MINES = 16; // Máximo de minas permitidas

// Función para validar el número de minas
bool isValidMineCount(int mines) {
  return mines >= MIN_MINES && mines <= MAX_MINES;
}
