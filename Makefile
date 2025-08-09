CC = gcc
PROJ_NAME = game
BUILD_DIR = build

SRCS = $(wildcard *.c)
OBJS = $(patsubst %.c,$(BUILD_DIR)/%.o,$(SRCS))

CFLAGS = -Wall -Wextra -std=c99 -I.
LDFLAGS =

TARGET = $(BUILD_DIR)/$(PROJ_NAME)

ifeq ($(OS),Windows_NT)
    TARGET := $(TARGET).exe
    LDFLAGS += -lraylib -lopengl32 -lgdi32 -lwinmm
    MKDIR_P = if not exist $(subst /,\,$(1)) mkdir $(subst /,\,$(1))
    CLEAN_CMD = if exist $(subst /,\,$(BUILD_DIR)) rmdir /s /q $(subst /,\,$(BUILD_DIR))
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Linux)
        LDFLAGS += -lraylib -lGL -lm -lpthread -ldl -lrt -lX11
    endif
    ifeq ($(UNAME_S),Darwin)
        LDFLAGS += -lraylib -framework OpenGL -framework Cocoa -framework IOKit -framework CoreVideo
    endif
    MKDIR_P = mkdir -p $(1)
    CLEAN_CMD = rm -rf
endif

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(OBJS) -o $(TARGET) $(LDFLAGS)
	@echo "Kompilacja zakończona sukcesem! Utworzono plik: $(TARGET)"

$(BUILD_DIR)/%.o: %.c
	$(call MKDIR_P,$(@D))
	$(CC) $(CFLAGS) -c $< -o $@

run: all
	@echo "Uruchamianie gry..."
	./$(TARGET)

clean:
	@echo "Czyszczenie plików projektu..."
	$(CLEAN_CMD) $(BUILD_DIR)

.PHONY: all clean run

