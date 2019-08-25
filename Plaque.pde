// Nosson Cotlar - Rood Systems
// Copyright 2019

void setup() {
  fullScreen();
  //size(1920, 1080);

  frameRate(30); 
  rectMode(CORNER);
  noStroke();

  startingInits();
}

void draw() {
  detectSecondChanged();

  if (theme == null) return;
  theme.update();
  if (second() % 2 == 0) displayLicenseWatermark();
  if (secondChanged) updateCheck();
  displayUpdateAvailable();
}

void mousePressed() {
  if (mouseX != 0) println(width / float(mouseX) + " " + height / float(mouseY) + " : " + mouseX + " " + mouseY);
}
