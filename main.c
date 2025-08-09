#include "raylib.h"

#define WINDOW_WIDTH 1600
#define WINDOW_HEIGHT 900

void init() {
  InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "Trash Sorter");
  SetTargetFPS(60);
}

void update() {}

void render() {
  BeginDrawing();

  ClearBackground(RAYWHITE);

  DrawText("Super! Shit is alive!", 190, 200, 20, LIGHTGRAY);

  EndDrawing();
}

void deinit() { CloseWindow(); }

int main(void) {
  init();

  while (!WindowShouldClose()) {
    update();
    render();
  }

  deinit();

  return 0;
}
