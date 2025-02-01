# Nombre del ejecutable
TARGET = chat-ui

# Directorios
SRC_DIR = src
OBJ_DIR = obj
BUILD_DIR = build

# Archivos fuente y objetos
SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))

# Flags de compilación
CFLAGS = $(shell pkg-config --cflags gtk4) -Wall -g
LDFLAGS = $(shell pkg-config --libs gtk4)

# Regla principal
all: $(BUILD_DIR)/$(TARGET)

# Regla para compilar el ejecutable dentro de build/
$(BUILD_DIR)/$(TARGET): $(OBJS) | $(BUILD_DIR)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)

# Regla para compilar archivos .c a .o en obj/
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Crear directorios si no existen
$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Limpiar archivos compilados
clean:
	rm -rf $(OBJ_DIR) $(BUILD_DIR)

# Ejecutar el programa
run: all
	./$(BUILD_DIR)/$(TARGET)
