// Nosson Cotlar
// Copyright 2019

Theme theme;
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
    //background(backColor);
    theme.update();
  } else {
    if (!stop) {
      updateInfoDisplay();
      stop = true;
    }
  }

  updateCheck();
  println(mouseX, ' ', mouseY);
}
