c_create() {

mkdir tests && touch ./tests/.gitinclude
mkdir src && touch ./src/.gitinclude
mkdir tools && touch ./tools/.gitinclude
mkdir assets && touch ./assets/.gitinclude
mkdir docs && touch ./docs/.gitinclude
mkdir ignore && touch ./ignore/.gitinclude
mkdir bin && touch ./bin/.gitinclude
mkdir build && touch ./build/.gitinclude
mkdir dependencies && touch ./dependencies/.gitinclude
mkdir include && touch ./include/.gitinclude


cat <<'EOF' >> Makefile
CXX = gcc
CXXFLAGS = -Wall -Wextra -std=gnu99 -O2 -Iinclude
LDFLAGS =# -lciul1

# Project structure
SRC_DIR = src
OBJ_DIR = build
BIN_DIR = bin

# Source and object files
SRCS := $(wildcard $(SRC_DIR)/*.c*)
OBJS := $(patsubst $(SRC_DIR)/%.c*, $(OBJ_DIR)/%.o, $(SRCS))

# Output binary
TARGET = $(BIN_DIR)/out


# Default rule
all: $(TARGET)

# Link the final binary
$(TARGET): $(OBJS)
	@mkdir -p $(BIN_DIR)
	$(CXX) $(CXXFLAGS) $^ -o $@ $(LDFLAGS)

# Compile source files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Clean build artifacts
clean:
	-rm -r $(OBJ_DIR)/* $(BIN_DIR)/*
	touch $(OBJ_DIR)/.gitinclude $(BIN_DIR)/.gitinclude

# Run the program
run: $(TARGET)
	./$(TARGET)

valgrind-full: $(TARGET)
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./$(TARGET) $(MCAST_IP) $(MCAST_PORT) $(INTER_IP)

valgrind: $(TARGET)
	valgrind --leak-check=full ./$(TARGET) $(MCAST_IP) $(MCAST_PORT) $(INTER_IP)

tidy: $(SRCS)
	clang-tidy $^ -- $(CXXFLAGS)

format: $(SRCS)
	clang-format -i $^
# Phony targets
.PHONY: all clean run valgrind-full valgrind tidy format
EOF

}

py_create() {

mkdir tests && touch ./tests/.gitinclude
mkdir src && touch ./src/.gitinclude
mkdir tools && touch ./tools/.gitinclude
mkdir docs && touch ./docs/.gitinclude
mkdir ignore && touch ./ignore/.gitinclude

touch requirements.txt

cat <<'EOF' >> Makefile
TARGET = src/main.py

install: requirements.txt
	python3 -m venv ./.venv
	./.venv/bin/python3 -m pip install -r requirements.txt

lint:
	@echo "\nLinting python code...\n"
	@\
	. ./.venv/bin/activate; \
	python3 -m pip install ruff; \
	ruff check .; \

run:
	@\
	. ./.venv/bin/activate; \
    python3 $(TARGET); \
EOF

}

docker_create() {

mkdir -p deploy/docker && touch ./deploy/docker/.gitinclude

touch Dockerfile
touch .env

cat <<'EOF' >> Makefile
#include ./.env

PROJECT = 
SOURCES = $(wildcard ./src/*)

all: up

up: build
	PROJECT=$(PROJECT) docker compose -f ./deploy/docker/docker-compose.yml -p $(PROJECT) up -d

build: $(SOURCES) Dockerfile
	PROJECT=$(PROJECT) docker build -f Dockerfile -t jdolakk/$(PROJECT)-image .

down:
	PROJECT=$(PROJECT) docker compose -f ./deploy/docker/docker-compose.yml -p $(PROJECT) down

run:
	PROJECT=$(PROJECT) docker compose -f ./deploy/docker/docker-compose.yml -p $(PROJECT) up -d
EOF
}

IFS=','

read -ra args <<< "$CREATE"

for arg in "${args[@]}"; do
    case $arg in
        c)
            c_create
            ;;
        py)
           py_create
            ;;
        docker)
           docker_create
            ;;
    esac

done

touch README.md

cat <<EOF >> .gitignore
**/.DS_Store
**/.vscode
**/bin/*
**/ignore/*
**/.env
**/.venv
!**/.gitinclude
EOF
