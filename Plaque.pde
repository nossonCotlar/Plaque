// Nosson Cotlar
// Copyright 2019

boolean stop = false;

void setup() {
  fullScreen();
  frameRate(60); 
  rectMode(CORNER);
  noStroke();

  initFont();
  thread("init");
}

void draw() {
  if (theme != null) {
    theme.update();
  } else {
    if (!stop) {
      updateInfoDisplay();
      stop = true;
    }
  }

  updateCheck();
  //println(mouseX, ' ', mouseY);
}
