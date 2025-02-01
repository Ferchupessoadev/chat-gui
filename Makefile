# Spanish: Nombre del ejecutable
# English: Executable name
TARGET = chat-ui

# Spanish: Directorios
# English: Directories
SRC_DIR = src
OBJ_DIR = obj
BUILD_DIR = build

# Spanish: Archivos fuente y objetos
# English: Source files and objects
SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))

# Spanish: Flags de compilación
# English: Compilation flags
CFLAGS = $(shell pkg-config --cflags gtk4) -Wall -g
LDFLAGS = $(shell pkg-config --libs gtk4)

# Spanish: Regla principal
# English: Main rule
all: $(BUILD_DIR)/$(TARGET)

# Spanish: Regla para compilar el ejecutable dentro de build/
# English: Rule to compile the executable inside build/
$(BUILD_DIR)/$(TARGET): $(OBJS) | $(BUILD_DIR)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)

# Spanish: Regla para compilar archivos .c a .o en obj/
# English: Rule to compile .c files to .o files in obj/
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Spanish: Crear directorios si no existen
# English: Create directories if they don't exist
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Spanish: Limpiar archivos compilados
# English: Clean compiled files
clean:
	rm -rf $(OBJ_DIR) $(BUILD_DIR)

# Spanish: Ejecutar el programa
# English: Run the program
run: all
	./$(BUILD_DIR)/$(TARGET)
