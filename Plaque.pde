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

  
  if(initFont()) updateInfoDisplay();
  thread("init");
}

void draw() {
  detectSecondChanged();
  if (offline) displayOffline();
  
  if (theme == null) return;
  theme.update();
  if (second() % 2 == 0) displayLicenseWatermark();
  updateCheck();
  displayUpdateAvailable();
}

void mousePressed() {
  if (mouseX != 0) println(width / float(mouseX) + " " + height / float(mouseY) + " : " + mouseX + " " + mouseY);
}
