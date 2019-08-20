// Nosson Cotlar - Rood Systems
// Copyright 2019

void setup() {
  fullScreen();
  //size(1920, 1080);

  frameRate(30); 
  rectMode(CORNER);
  noStroke();

  auth = loadJSONObject("auth.json");
  config = loadJSONObject("config.json");

  try {
    initFont();
    init();
  } 
  catch (RuntimeException e) {
    generalMessage(e.getMessage());
  }
}

void draw() {
  detectSecondChanged();

  if (theme == null) return;
  theme.update();
  if (second() % 2 == 0) displayLicenseWatermark();
  updateCheck();
  displayUpdateAvailable();
}

void mousePressed() {
  if (mouseX != 0) println(width / float(mouseX) + " " + height / float(mouseY) + " : " + mouseX + " " + mouseY);
}
